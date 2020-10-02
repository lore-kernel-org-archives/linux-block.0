Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12027C35257
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C543A207EA
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601679885;
	bh=Hxs+UUlZqYcE9pxfvWKXNnQhii3RNVADdGIrrHIpgVs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gSPSDFeyz7YEDqou80a415wkaql9/9qN1tf2mLpFbYpn2LE27HXWIC55QVVYpzsxt
	 U2pKqbggxqjJ7/D0CajEDGSsv3h61yB//rhcO/QLo+TalNNZ0cOO7CP8w20xv/NuVn
	 DXeJg4FRscTG695YWWW73sgWEYviWnsduHe7id6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgJBXEp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXEp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 19:04:45 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEF62074B;
        Fri,  2 Oct 2020 23:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601679884;
        bh=Hxs+UUlZqYcE9pxfvWKXNnQhii3RNVADdGIrrHIpgVs=;
        h=Date:From:To:Cc:Subject:From;
        b=WhN3PjeGjsrfrqfWjAKAQXNWfMGz3zMa7nNvHFUle9Yqqn+jc+KkUqvfwuoSQuqAm
         27Po9OvYJLopsqETQL26gfylu8QCX4Z4/GlcNEClDj/hY/tm2dYCJyIMqV6noO/nhM
         zMBedsyab4VBtzIbTHW0AhBOJqT9EvYZX9bUZmuI=
Date:   Fri, 2 Oct 2020 18:10:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element arrays
Message-ID: <20201002231033.GA6273@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element array
with a simple object of type compat_caddr_t: 'compat_caddr_t unused'[2],
once it seems this field is actually never used.

Also, update struct cdrom_generic_command in UAPI by adding an
anonimous union to avoid using the one-element array _reserved_.

[1] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://github.com/KSPP/linux/issues/86

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f76f5d0.qJ4t%2FHWuRzSW7bTa%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 block/scsi_ioctl.c         | 6 +++---
 include/uapi/linux/cdrom.h | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 600e38cb69b2..2dfb699389df 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -643,7 +643,7 @@ struct compat_cdrom_generic_command {
 	unsigned char	data_direction;
 	compat_int_t	quiet;
 	compat_int_t	timeout;
-	compat_caddr_t	reserved[1];
+	compat_caddr_t	unused;
 };
 #endif
 
@@ -665,7 +665,7 @@ static int scsi_get_cdrom_generic_arg(struct cdrom_generic_command *cgc,
 			.data_direction	= cgc32.data_direction,
 			.quiet		= cgc32.quiet,
 			.timeout	= cgc32.timeout,
-			.reserved[0]	= compat_ptr(cgc32.reserved[0]),
+			.unused		= compat_ptr(cgc32.unused),
 		};
 		memcpy(&cgc->cmd, &cgc32.cmd, CDROM_PACKET_SIZE);
 		return 0;
@@ -690,7 +690,7 @@ static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
 			.data_direction	= cgc->data_direction,
 			.quiet		= cgc->quiet,
 			.timeout	= cgc->timeout,
-			.reserved[0]	= (uintptr_t)(cgc->reserved[0]),
+			.unused		= (uintptr_t)(cgc->unused),
 		};
 		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
 
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 2817230148fd..6c34f6e2f1f7 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -289,7 +289,10 @@ struct cdrom_generic_command
 	unsigned char		data_direction;
 	int			quiet;
 	int			timeout;
-	void			__user *reserved[1];	/* unused, actually */
+	union {
+		void		__user *reserved[1];	/* unused, actually */
+		void            __user *unused;
+	};
 };
 
 /*
-- 
2.27.0

