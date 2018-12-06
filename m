Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51AFC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A911720838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbSEz4Bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A911720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLFQl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45765 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLFQl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so1187367qtr.12
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS4iuAD6sE8maCiA4jBHJmimohyGnKGLtLR2nbbQu/g=;
        b=TbSEz4BgTiPstcqTMLG9oDGKXzhfwvHm6sWD7VyVQEjLqNNlJRmhbDd6htvJXV+JVe
         Iu5TEoTJSjjk8d7YR2Dfk5Uy+tL99kFaYPgRETp323IVm3FGWbgom4ZV9R5Swxt9zRS/
         dGZ8+15zYZXLE9ECUsNwVo9QBCThG36mZXBuzBGycMABvrEJCjR3oro9+14Ter79+qBj
         r8vEjCN1EaB52EzTLMhO8azQBsTmgjDHuG+oXzgOzd3GwO+SHSNl/JTaNbgF3Xw/elwk
         7GSgmHD8tf7LLF6b75zfIDlKwoeeoGZn1nNR8J5cQGkWtxvB79y9HHbUoWE2+bUXd6ai
         bA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VS4iuAD6sE8maCiA4jBHJmimohyGnKGLtLR2nbbQu/g=;
        b=Ku1HSupZPrRruM/lBU+P/bn43jwZmAOTDz0dRbKV897FeHllFXlqN0senbMdHUiJBW
         lXlzcCi0PePOs5rH5urRQyhOlLrckZaWdm9PD/qQTFDRucPq3hz8gg4kmUyM4+lbZgkh
         rW54lHae/eyDSa/HdphSTovwALDFbU7Dh02AuIaLHungOCpJJDJpcM54aTQjNYKPeQFK
         XeHq8MiDW5X2eiB787wfHGHxDEIlQ2vnJpvR9fI86evzGW7L2ZqSE1mivC4NTF5L7RUQ
         gjcIlGC12uJHulqXzl3zCxcXgYcpOklAav2Exi7nm0dyqkZb2ybVVLMqh5hr2x7sGxT0
         dD3g==
X-Gm-Message-State: AA+aEWaFL3lafBUzBGDitxOoP7W14BP/TTicCZv+m0xj80ZSipqSoxkA
        LRu17F0jlopp/qQN3tLTAz8=
X-Google-Smtp-Source: AFSGD/U7OJtFzzyUJYyYgohoXBmchJhF9ty6DRKXPvOs7nbzkiDXBDMJrKu+1GUSlk7NGtAanpCnmw==
X-Received: by 2002:ac8:3a64:: with SMTP id w91mr28264753qte.70.1544114488189;
        Thu, 06 Dec 2018 08:41:28 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y2sm585898qtb.88.2018.12.06.08.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:27 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 1/7] dm: dont rewrite dm_disk(md)->part0.in_flight
Date:   Thu,  6 Dec 2018 11:41:16 -0500
Message-Id: <20181206164122.2166-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

generic_start_io_acct and generic_end_io_acct already update the variable
in_flight using atomic operations, so we don't have to overwrite them
again.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a733e4c920af..a8ae7931bce7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -663,8 +663,7 @@ static void start_io_acct(struct dm_io *io)
 	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
 			      &dm_disk(md)->part0);
 
-	atomic_set(&dm_disk(md)->part0.in_flight[rw],
-		   atomic_inc_return(&md->pending[rw]));
+	atomic_inc(&md->pending[rw]);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
@@ -693,7 +692,6 @@ static void end_io_acct(struct dm_io *io)
 	 * a flush.
 	 */
 	pending = atomic_dec_return(&md->pending[rw]);
-	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
 	pending += atomic_read(&md->pending[rw^0x1]);
 
 	/* nudge anyone waiting on suspend queue */
-- 
2.15.0

