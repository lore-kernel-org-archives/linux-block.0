Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1343C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B241D20854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AmTXnvxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfCMRza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMRza (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bZYEHpiX+fSQTgdaxOD2iIw08W2QPbd4moXNC6zu35Q=; b=AmTXnvxmE0JWHHJUg0aa3UjGy3
        ZhxdEz3tMUF7vsknhxmxMJnrCpFlgqRjyjA8ekUqdwb15vRkGHER8OnHWRBfkGHzoFwPb6L48hyNt
        3AU9B3dquH2hI96Cx7qaPUoBcpRQ5kX+mUIwP3785CwuuR/Tdri8CxNT5B0W3mATFooVQTpgzl6YF
        ECYdo9rPJngcHGhVWLAcV0a1iuIEUYxPPQMAKfV/JHtDk3glMhg/8TFIijsQjDv63cwxuyevYv2It
        4Qy3Hm9lgIByhjrxsJ7wJQ0kWH24eo/WrMYcQnj2VgjcY71t0CGo+X2MSDjk9F8sZ+LrCVNvPhMmG
        bNqjkc7g==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486A-0001BQ-M6; Wed, 13 Mar 2019 17:55:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 01/17] nvme: add get-feature to admin cmds tracer
Date:   Wed, 13 Mar 2019 18:54:54 +0100
Message-Id: <20190313175510.20725-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

This will print get-feature cmd in more informative way. For example,
run "nvme get-feature /dev/nvme0 -n 1 -f 0x9 -c 10" will trace:

 nvme-3907  [008] ....  1763.635054: nvme_setup_cmd: nvme0: qid=0, cmdid=6, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_admin_get_features fid=0x9 sel=0x0 cdw11=0xa)
<idle>-0     [001] d.h.  1763.635112: nvme_sq: nvme0: qid=0, head=27, tail=27
<idle>-0     [008] ..s.  1763.635121: nvme_complete_rq: nvme0: qid=0, cmdid=6, res=10, retries=0, flags=0x2, status=0

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/trace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 58456de78bb2..5f24ea7a28eb 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -50,7 +50,19 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_admin_get_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sel = cdw10[1] & 0x7;
+	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+
+	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_putc(p, 0);
 
+	return ret;
+}
 
 static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 {
@@ -101,6 +113,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_create_cq(p, cdw10);
 	case nvme_admin_identify:
 		return nvme_trace_admin_identify(p, cdw10);
+	case nvme_admin_get_features:
+		return nvme_trace_admin_get_features(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
-- 
2.20.1

