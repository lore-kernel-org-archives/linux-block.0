Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63657C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50F217D9
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wx9NmuB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBKXLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:11:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40671 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfBKXLn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 18:11:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so283966pfo.7
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 15:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x6/SmSqU26nDIakFLf/iiXHAnCwYPIwhGjuvraCoHDg=;
        b=Wx9NmuB7djSJypxdiTK55LUgi9BOrfyaIBdzCnUNsVHpVllwEXsOhjm8NhMEz3tZbI
         M2pKGAzZfOundVPIv7SpuCQw1Anm764PlpMptxiP5hrvUUTh85cU940Ic2HYZJZzjRgU
         xx19vmEirOGXcPr5c0ZdwGcaJR+mdhlLP+d3hHSDOs5/Ezb8gyPUw4fTmABGdh+lMZHK
         WRUtYtrsRNKeaAOty2B1dgAgporJrPuL1Mdz+oERCMj5Qk4d7z16yACfiurxmTDbAaqg
         zNwtQqvCWFJ4/m1S1RgKveOQ2xVduFrzVUyiLk3zqoSVurdnXBVpk+s07RjiqgKl6QOV
         0VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=x6/SmSqU26nDIakFLf/iiXHAnCwYPIwhGjuvraCoHDg=;
        b=maEPhx7PtUoq53kW4cDuTJsMy+jOesMUYof+Wo2OxXOYlvFxfuLW5f+c0CwzW5W3Lw
         wtW2b2vgVi8w1Qx7Efnnc3DE378oIgNwt/l+H0HzSRPUZK3Wr+boP+ySsRCciXZizEOV
         WP1uKlNANvvjQH3NaKtXSqU2CC8Z8fMuOvF9AsNay9RoV/qdivpgtKUA6vMavc0NvAqO
         2KhbhDKEuFSjhc0hOiPiIPv87AuU3HvwuLCAiffjwaweYN0GvoUj3Dx++/7Th8g6/Sa7
         ZePo5IVG059fsfuO274SJlUIqtkRrUotHvr+DRberxKQkRSBQ0/8fStAQKmWP3tpFstQ
         aPHw==
X-Gm-Message-State: AHQUAuZMqGaApEgx4p0aju8FC7tXNAQuZIL4r0jYz2hhVY6XdPD8i8zz
        tTzoqUkD4LP+uVBZzsokdBxPs+uleM8jfw==
X-Google-Smtp-Source: AHgI3IZT00qy42UehEaJr0VgaZFIVvVwU7aCOI+JuADMRBGN0kdmM/HxAJM+IU/IwUm8OmudT2++Bw==
X-Received: by 2002:a65:4842:: with SMTP id i2mr700292pgs.176.1549926702524;
        Mon, 11 Feb 2019 15:11:42 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm12970822pgh.73.2019.02.11.15.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:11:41 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-flush: fix inverted scheduler check
Message-ID: <d52cf5d9-07a0-b643-e775-48139a4b19b0@kernel.dk>
Date:   Mon, 11 Feb 2019 16:11:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


A previous commit inadvertently inverted a check for whether or not we
have an IO scheduler attached. This is reported to cause a hang with
particular LVM setups.

Fixup the condition.

Reported-by: Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
Fixes: 344e9ffcbd18 ("block: add queue_is_mq() helper")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e0f2d97fc6d..b56f4e5e6359 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -273,7 +273,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * assigned to empty flushes, and we deadlock if we are expecting
 	 * other requests to make progress. Don't defer for that case.
 	 */
-	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
+	if (!list_empty(&fq->flush_data_in_flight) && !q->elevator &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;

-- 
Jens Axboe
