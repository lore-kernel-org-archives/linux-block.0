Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DDC43612
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4521773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeLTQfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:35:04 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50088 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeLTQei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:34:38 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C5CE9103B4DF;
        Thu, 20 Dec 2018 17:23:46 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 06/17] drbd: fix confusing error message during attach
Date:   Thu, 20 Dec 2018 17:23:33 +0100
Message-Id: <20181220162344.8430-7-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we attach a (consistent) backing device,
which knows about a last-agreed effective size,
and that effective size is *larger* than the currently requested size,
we refused to attach with ERR_DISK_TOO_SMALL
  Failure: (111) Low.dev. smaller than requested DRBD-dev. size.
which is confusing to say the least.

This patch changes the error code in that case to ERR_IMPLICIT_SHRINK
  Failure: (170) Implicit device shrinking not allowed. See kernel log.
  additional info from kernel:
  To-be-attached device has last effective > current size, and is consistent
  (9999 > 7777 sectors). Refusing to attach.

It also allows to attach with an explicit size.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d02d38fd1288..e4774f720de5 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -127,6 +127,35 @@ static int drbd_msg_put_info(struct sk_buff *skb, const char *info)
 	return 0;
 }
 
+__printf(2, 3)
+static int drbd_msg_sprintf_info(struct sk_buff *skb, const char *fmt, ...)
+{
+	va_list args;
+	struct nlattr *nla, *txt;
+	int err = -EMSGSIZE;
+	int len;
+
+	nla = nla_nest_start(skb, DRBD_NLA_CFG_REPLY);
+	if (!nla)
+		return err;
+
+	txt = nla_reserve(skb, T_info_text, 256);
+	if (!txt) {
+		nla_nest_cancel(skb, nla);
+		return err;
+	}
+	va_start(args, fmt);
+	len = vscnprintf(nla_data(txt), 256, fmt, args);
+	va_end(args);
+
+	/* maybe: retry with larger reserve, if truncated */
+	txt->nla_len = nla_attr_size(len+1);
+	nlmsg_trim(skb, (char*)txt + NLA_ALIGN(txt->nla_len));
+	nla_nest_end(skb, nla);
+
+	return 0;
+}
+
 /* This would be a good candidate for a "pre_doit" hook,
  * and per-family private info->pointers.
  * But we need to stay compatible with older kernels.
@@ -1947,11 +1976,21 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* Prevent shrinking of consistent devices ! */
-	if (drbd_md_test_flag(nbc, MDF_CONSISTENT) &&
-	    drbd_new_dev_size(device, nbc, nbc->disk_conf->disk_size, 0) < nbc->md.la_size_sect) {
-		drbd_warn(device, "refusing to truncate a consistent device\n");
-		retcode = ERR_DISK_TOO_SMALL;
-		goto force_diskless_dec;
+	{
+	unsigned long long nsz = drbd_new_dev_size(device, nbc, nbc->disk_conf->disk_size, 0);
+	unsigned long long eff = nbc->md.la_size_sect;
+	if (drbd_md_test_flag(nbc, MDF_CONSISTENT) && nsz < eff) {
+		if (nsz == nbc->disk_conf->disk_size) {
+			drbd_warn(device, "truncating a consistent device during attach (%llu < %llu)\n", nsz, eff);
+		} else {
+			drbd_warn(device, "refusing to truncate a consistent device (%llu < %llu)\n", nsz, eff);
+			drbd_msg_sprintf_info(adm_ctx.reply_skb,
+				"To-be-attached device has last effective > current size, and is consistent\n"
+				"(%llu > %llu sectors). Refusing to attach.", eff, nsz);
+			retcode = ERR_IMPLICIT_SHRINK;
+			goto force_diskless_dec;
+		}
+	}
 	}
 
 	lock_all_resources();
-- 
2.17.1

