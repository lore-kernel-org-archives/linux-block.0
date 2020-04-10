Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A876AC2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 12:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC720769
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 12:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFATq622"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDJM3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:29:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45999 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJM3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 08:29:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so1226398lfe.12;
        Fri, 10 Apr 2020 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=dyzXmKu6IT/Un75AvtMcFm0MmYMRWfAsrqCi/hItOfE=;
        b=dFATq6225UkB+ndW1q0MUtbxWax/bpYH/lVDUCCZoR/bytXFFKlAvqU0ogKu1vZkRm
         Z6XEBY73WGQruhzmC+P0je0W9srJO1Z6H90Agqn9j/HblTKoTAedwlex9pfEoXdektBt
         3WzuqQc6zlXYYXGFaYsi7xtfRtvltqXZKDzp8FcIldCIcbB1814nLAAkO43RlBgacEEh
         YLisjYAFkDbbqJ6j4J/cYb9EYVLwKzJZxbllMRaYEVwKD6xJvGwHhpm5Juy8lRMlCeeS
         3J6P5l+ycqOcAU+tLO6wBVUi5d+Au10o//CznthQiwSjQOmqC5w0eAyaypyjtstLY78I
         Zv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=dyzXmKu6IT/Un75AvtMcFm0MmYMRWfAsrqCi/hItOfE=;
        b=LlnmE1MnWnoQQYcDlwk7IcqHbEnTSCvylPyhLiQBoqWfnO970g3hDuDyQvB9XP0lPe
         WH8z6AplEnKV3qsW2eGhaLItF08tQ8Y/7+nHn+yhTnr5pLgs2djESpqX/imvLQbaqypt
         iiswSRl6xEgFBjKtxs7ULZ1nptFwLHy8ReC/eH2XR47dnJ/bnEnWiWKiN8Slz/Ciq75w
         wr5LM2k1zildEGt6E676AmhawjfvGd7ZsUunNEFJTvlVimcbXsdLhcY1AMo4UpSbeL59
         6fhBkCqY33USI6vNDggrtrPJbR32QurPGDbZLXLceSZywIN/GIA3qUyem74H9FvisI1H
         ctSg==
X-Gm-Message-State: AGi0Puagx6oFSmgy34G5EpGoWcvbUSM99Bb1uN9Euglz0MTpMCz8ey72
        H67C7Tc2TPOGsRusNOPwRSc=
X-Google-Smtp-Source: APiQypJ59syTnwhr8k42RVJGDg6iEEJkC7GLZ1DlgJlnvdwUdJtTLQ/W3A8JB7VDaL0cqCJ4blofZA==
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr2420626lfp.4.1586521760984;
        Fri, 10 Apr 2020 05:29:20 -0700 (PDT)
Received: from work.bb.dnainternet.fi (dffyyyyyyyyyyyysyd4py-3.rev.dnainternet.fi. [2001:14ba:2100::1e0:1e18])
        by smtp.gmail.com with ESMTPSA id x17sm1012977ljc.33.2020.04.10.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 05:29:20 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     axboe@kernel.dk, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+934037347002901b8d2a@syzkaller.appspotmail.com,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, stable@kernel.org
Subject: [PATCH] nbd: Fix memory leak from krealloc() if another allocation fails
Date:   Fri, 10 Apr 2020 15:29:13 +0300
Message-Id: <20200410122913.14339-1-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzkaller reports a memory leak when injecting allocation failures:

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
...
 kmem_cache_alloc_trace+0x26/0x2c0
 nbd_add_socket+0xa8/0x1e0
 nbd_ioctl+0x175/0x430
...
BUG: memory leak
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    ...

This happens when krealloc() succeeds but the kzalloc() fails:
1040         socks = krealloc(config->socks, (config->num_connections + 1) *
1041                          sizeof(struct nbd_sock *), GFP_KERNEL);
1042         if (!socks) {
1043                 sockfd_put(sock);
1044                 return -ENOMEM;
1045         }
1046
1047         config->socks = socks;
1048
1049         nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
1050         if (!nsock) {
1051                 sockfd_put(sock);
1052                 return -ENOMEM;
1053         }

as then config->num_connections is not incremented and the cleanup code
freeing config->socks is skipped. Just make it run always.

Reported-by: syzbot+934037347002901b8d2a@syzkaller.appspotmail.com
Cc: stable@kernel.org
Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
Compile tested only.
---
 drivers/block/nbd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..f851883ef9f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1199,6 +1199,8 @@ static void nbd_config_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
+		int i;
+
 		nbd_dev_dbg_close(nbd);
 		nbd_size_clear(nbd);
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
@@ -1206,14 +1208,11 @@ static void nbd_config_put(struct nbd_device *nbd)
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
 		nbd_clear_sock(nbd);
-		if (config->num_connections) {
-			int i;
-			for (i = 0; i < config->num_connections; i++) {
-				sockfd_put(config->socks[i]->sock);
-				kfree(config->socks[i]);
-			}
-			kfree(config->socks);
+		for (i = 0; i < config->num_connections; i++) {
+			sockfd_put(config->socks[i]->sock);
+			kfree(config->socks[i]);
 		}
+		kfree(config->socks);
 		kfree(nbd->config);
 		nbd->config = NULL;
 
-- 
2.17.1

