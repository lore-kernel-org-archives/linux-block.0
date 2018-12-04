Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97426C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5613520851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lk68qeU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5613520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLDWrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:47:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36459 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:47:49 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so17214817itj.1
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TCrbeDrVH9wkESPT3A6WXniMf6GLqbyoaN8aUFh8jKs=;
        b=lk68qeU73DXESS+FRXybTHO3obV59sjGfSFzpXrI3aeH9bKFDWAE+1rq7UHImVgbWW
         A44UsUDgBhEtkOi9cCCJ5m13B6qJ1rrlBOYeqcp0u1I2lWQ0NoLdos6wIlPhD4AMJdos
         vNhmKZlTAUknBJ1VsTNgZP961bW4oz6is4SvyrIwQ5bls4ZeMkJNBFpFpKjlzRUccmIv
         p1qSgBqktds8yLTBHToe6ATobD8nLQ4Nj4NevfVCja4kGaKax9044JrFj62Xd6IO6Vrl
         7ODQZ2RbDh1yBZsdRL6hORNdCmhFhvSEHoVATNCGXK6Mwswa3YNBQmKy6SdT4nmK5x2O
         tTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TCrbeDrVH9wkESPT3A6WXniMf6GLqbyoaN8aUFh8jKs=;
        b=GBlFpnJX/uSfhxEaS2WmLdu/XeIqYHsTU+WDjjvVmRa8Dzc2YvoWpwqI2/3CrMb7f5
         zX/thT+WAgRnuggu2h1bri62ehAjkVlV4meHWhgWXdxWhekhQimOREfl7jBlzV5T6wrz
         /JqNqLZxTqd1WtlBAgjmW2GXu2M/n9VNXelQ++YBPaorDpdVNl9ljEf4akIKsjgy//4q
         2QvhH8aQobxob4RaBKaD85r8xkPjD0qPdcaE62Qn8NaWMMZPZNmOXhKOZ7I9HXrAi3w1
         Z0TlpC3b9h8LyOp/HYajD0S0LeDbCvEX74+oQ665vYIZbduT//sTMVCB0MS/5N8Px1Ac
         kBNQ==
X-Gm-Message-State: AA+aEWYPQ+yo5GFt4/IfVcfFm2MdlNgDxqhlSMZ4KxRD+b8VyyCvwbVO
        keEy1mY/lL3s33EB+DvZ/zh4WtXPsj4=
X-Google-Smtp-Source: AFSGD/V2cPa7SW/Na32ry2/ooQT+uPZNoSV2Gh5mxXmhZVlt3hOvaqDou8J3Dq1iXgA4sKkB6ODWMw==
X-Received: by 2002:a02:5f9d:: with SMTP id x29mr21335396jad.28.1543963668242;
        Tue, 04 Dec 2018 14:47:48 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h24sm2537630iol.17.2018.12.04.14.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:47:47 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
Date:   Tue, 4 Dec 2018 15:47:46 -0700
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

If we attempt a direct issue to a SCSI device, and it returns BUSY, then
we queue the request up normally. However, the SCSI layer may have
already setup SG tables etc for this particular command. If we later
merge with this request, then the old tables are no longer valid. Once
we issue the IO, we only read/write the original part of the request,
not the new state of it.

This causes data corruption, and is most often noticed with the file
system complaining about the just read data being invalid:

[  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)

because most of it is garbage...

This doesn't happen from the normal issue path, as we will simply defer
the request to the hardware queue dispatch list if we fail. Once it's on
the dispatch list, we never merge with it.

Fix this from the direct issue path by flagging the request as
REQ_NOMERGE so we don't change the size of it before issue.

See also:
  https://bugzilla.kernel.org/show_bug.cgi?id=201685

Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..d8f518c6ea38 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
+		/*
+		 * If direct dispatch fails, we cannot allow any merging on
+		 * this IO. Drivers (like SCSI) may have set up permanent state
+		 * for this request, like SG tables and mappings, and if we
+		 * merge to it later on then we'll still only do IO to the
+		 * original part.
+		 */
+		rq->cmd_flags |= REQ_NOMERGE;
+
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;

-- 
Jens Axboe

