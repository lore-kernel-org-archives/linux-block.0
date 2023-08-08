Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F3C001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjHHSRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjHHSRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:17:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503E1FCAC
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:24:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-349177bf6bcso3998045ab.1
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691515475; x=1692120275;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTNldnivIaxBXBTNvK2PuiUZGj37r4ckmkm6xx/Y7x8=;
        b=3GSyvCix/gNo9aJZpIwuFWfXNoOBpx6kRMT4rbLjQpbgzMyPhWrkT4i5p7lLF+6XLs
         bEpPbJUKIBgRFjRFJsLqEXUZMuj0vPlfewS5rjAmo1axSe8i4vXMY10pwBSDMCzw+yNQ
         06BQQa6YKJbRVQ2c5k4eV/Io+xqmGlYX2uPpAhvMrIgV1UZAbdkMOaKKHSFRz/rdELra
         qDWZsyWgZg6XWJePQCz9st5FUkSbU+YNVwoA3nMOby7gjpPOWmxmTavd6br6873bND/Y
         LTwCd6SrBeUfgm2M2G4s390mWUHZ9I7Zy6W6IUUV8svVKzM9JBcig4/CMSqyKq2RJdo9
         vR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515475; x=1692120275;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTNldnivIaxBXBTNvK2PuiUZGj37r4ckmkm6xx/Y7x8=;
        b=bU6Ln19vlhmMP02JGKUy96SnRAnqsPqMLQU32oM+z/qrjakt4/iy9mEKH1cZ9p1Lfa
         Wc+6guITHNkfBw/EWh15EJ9ulyr+mbf0UJhNXv5+0/sVMn8KXp9+I4ncMxa7xp+gma1f
         JERdwMjG8hgmWmrut2ZV+CtMave18qRYKNwxI3TfHJQ/Uu4asbhblbb4a6QuGjbF6I5Z
         Gu16QwC0fOIgYAGZL/+BcHAs5OWanLn5/o3uAlmEs3CuYox+PGQs/NWlZKoUfALZth2v
         e2MbK5lge/Tue68QTLqd6KV6T2tYtjbQB8dzRW63ZwNJA/pj4VBg46QQ8oCpgA7zgz/F
         WGlQ==
X-Gm-Message-State: AOJu0YyZHpkgianOtJHIAHDFaGEmAeEPScWwg5Sflf1LwcdPhjRF5ayU
        YT3d0SsCh1MYtYs0YUDkABNFwCYiRX6AYsm7l6Y=
X-Google-Smtp-Source: AGHT+IFZ8tzTRlkO1ofUWMO/jWBZs502zP/nIfQQD68dZFdzepkcEvQ05/JAp41/iK7vxrWP7GcIHA==
X-Received: by 2002:a92:d94c:0:b0:345:e438:7381 with SMTP id l12-20020a92d94c000000b00345e4387381mr350727ilq.2.1691515474896;
        Tue, 08 Aug 2023 10:24:34 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s16-20020a02cc90000000b0041a9022c3dasm3130981jap.118.2023.08.08.10.24.33
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:24:33 -0700 (PDT)
Message-ID: <b655aa3a-17f6-d25a-38b1-4a02e87e2c98@kernel.dk>
Date:   Tue, 8 Aug 2023 11:24:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/2] block: don't make REQ_POLLED imply REQ_NOWAIT
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230808171310.112878-1-axboe@kernel.dk>
 <20230808171310.112878-3-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230808171310.112878-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 11:13?AM, Jens Axboe wrote:
> Normally these two flags do go together, as the issuer of polled IO
> generally cannot wait for resources that will get freed as part of IO
> completion. This is because that very task is the one that will complete
> the request and free those resources, hence that would introduce a
> deadlock.
> 
> But it is possible to have someone else issue the polled IO, eg via
> io_uring if the request is punted to io-wq. For that case, it's fine to
> have the task block on IO submission, as it is not the same task that
> will be completing the IO.
> 
> It's completely up to the caller to ask for both polled and nowait IO
> separately! If we don't allow polled IO where IOCB_NOWAIT isn't set in
> the kiocb, then we can run into repeated -EAGAIN submissions and not
> make any progress.
  
Looks like I forgot to update when adding the first half of this...
Here's the full patch 2/2:

commit 50bd4aa84442442c87e669d72d1a6d0b01c332a8
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Aug 8 11:06:17 2023 -0600

    block: don't make REQ_POLLED imply REQ_NOWAIT
    
    Normally these two flags do go together, as the issuer of polled IO
    generally cannot wait for resources that will get freed as part of IO
    completion. This is because that very task is the one that will complete
    the request and free those resources, hence that would introduce a
    deadlock.
    
    But it is possible to have someone else issue the polled IO, eg via
    io_uring if the request is punted to io-wq. For that case, it's fine to
    have the task block on IO submission, as it is not the same task that
    will be completing the IO.
    
    It's completely up to the caller to ask for both polled and nowait IO
    separately! If we don't allow polled IO where IOCB_NOWAIT isn't set in
    the kiocb, then we can run into repeated -EAGAIN submissions and not
    make any progress.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..838ffada5341 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -358,13 +358,14 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+
 	if (iocb->ki_flags & IOCB_HIPRI) {
-		bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
+		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);
 		WRITE_ONCE(iocb->private, bio);
 	} else {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
 		submit_bio(bio);
 	}
 	return -EIOCBQUEUED;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..11984ed29cb8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -791,7 +791,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
 	bio->bi_opf |= REQ_POLLED;
-	if (!is_sync_kiocb(kiocb))
+	if (kiocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 

-- 
Jens Axboe

