Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF8DC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77520855
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 22:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UBAj190J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE77520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLJWp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:45:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 17:45:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so5945425plz.1
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dKNvozK2xSfQmlVfpwnGnoWDXXv8BZt4SEn4xfoa714=;
        b=UBAj190Ju/XSSJs7u8geITpZqoor4VlaLxZLHbCM9ZdMxTB+9Gs3yZ0F0so1jHvw+V
         TaoUWXz8j1Ls6oUgoCP/kvEgWKgqGGDxvSnLY6wswSA507O4xVWlEhJuudho+DM5/0f4
         qLPDiziJLMJPuMNDsW6LNDUgXsLezZdVE/UjskayvOz7XVGn51x/8DUcpocspEQ2fK88
         0DeSF585EUvGfngkAsPfSmVQNsEAfYia+DYl/TbxxkG/IPecuhU+9JSa3CWOjEVxJhre
         31hIaU+xzsWox8iP6kEkDtBZs4Y7wbgmjNPBBoAHzDMTOM2Oyp5nxNwUCZM8IMpZkiwU
         Jwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dKNvozK2xSfQmlVfpwnGnoWDXXv8BZt4SEn4xfoa714=;
        b=CceGxfzneCLW1/8+mUxOYd1la7uzJHUZnKKUSpcvx55QXP/Xe2dvO6gSK5W1b0OY4c
         w2x+9Zz9/w9A3mHkMasqt1X2OCYZO1AM+rfvnWyg7CMrsENZc40FNnOLOajhpQja66Te
         xQ3GDmxqLPD4iRTQNwj33oYoJLeT4mrPxDBtY/Vq0IlyDhHg53+LcpfylOtvK93iDBkh
         32Qb4vOyYd/N/m2rB5g+7ZCr6E6FVswolAaSoSa+MTbqplc3/20EVsUZF2TneXgZY0et
         9XTYUUq8V15RgGDrGavEfxPtlRn5tzVUB9KqP6y3jEBhnRGnWWSm2n1tZAuYhJlOUk7m
         ANtw==
X-Gm-Message-State: AA+aEWbpx+edKw3uiXdk/ObEgOCGM+YB+TPJPHKGa0V7TPwI1nv+dWte
        uOVEwXgSb3iztQjJPehz7zQWcZz7NUUeVg==
X-Google-Smtp-Source: AFSGD/WXN18W40T/JEWOIOyE0LpLmA3u2tPbpLCB0YmSvWFxWBH9280Yv+68F9OdRcGVj9+GgXNhAA==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr13440512plm.45.1544481956036;
        Mon, 10 Dec 2018 14:45:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k15sm21762197pfb.147.2018.12.10.14.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:45:54 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] dm: fix inflight IO check
Message-ID: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
Date:   Mon, 10 Dec 2018 15:45:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After switching to percpu inflight counters, the inflight check
is totally buggy. It's perfectly valid for some counters to be
non-zero while having a total inflight IO count of 0, that's how
these kinds of counters work (inc on one CPU, dec on another).
Fix the md_in_flight() check to sum all counters before returning
a false positive, potentially.

While at it, remove the inflight read for IO completion. We don't
need it, just wake anyone that's waiting for the IO count to drop
to zero. The caller needs to re-check that value anyway when woken,
which it does.

Fixes: 6f75723190d8 ("dm: remove the pending IO accounting")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 70568f8b6c53..79ad4b3d215c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -650,14 +650,14 @@ static bool md_in_flight(struct mapped_device *md)
 {
 	int cpu;
 	struct hd_struct *part = &dm_disk(md)->part0;
+	long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		if (part_stat_local_read_cpu(part, in_flight[0], cpu) ||
-		    part_stat_local_read_cpu(part, in_flight[1], cpu))
-			return true;
+		sum += part_stat_local_read_cpu(part, in_flight[0], cpu);
+		sum += part_stat_local_read_cpu(part, in_flight[1], cpu);
 	}
 
-	return false;
+	return sum != 0;
 }
 
 static void start_io_acct(struct dm_io *io)
@@ -691,10 +691,8 @@ static void end_io_acct(struct dm_io *io)
 				    true, duration, &io->stats_aux);
 
 	/* nudge anyone waiting on suspend queue */
-	if (unlikely(waitqueue_active(&md->wait))) {
-		if (!md_in_flight(md))
-			wake_up(&md->wait);
-	}
+	if (unlikely(waitqueue_active(&md->wait)))
+		wake_up(&md->wait);
 }
 
 /*

-- 
Jens Axboe

