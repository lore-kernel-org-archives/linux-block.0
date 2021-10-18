Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B49F60F11
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhJRRqy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhJRRqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:46:52 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A62C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:44:40 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e144so17281042iof.3
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KdpgJYVNp1S9O0AzSspWOuBraEIV3b2n/gvMw/an9vE=;
        b=hYNSO777/KrXGREFwkDyl+7MhxD9V0T6Kyv1b0oeiW6rihf+oF09F312XpVfERuPz+
         nRVNYSeVKHMaCr98oiFi3tg7Ijhrq+mjrgz+eEY9eIEWgxk6P08WT6esDyDMP/Y+EuEg
         7JgiMNmFYmoL4qYn+2CkOUI+O7XOdIscOqNPc99p4Lusoxi/GlmGdASYVonnrT3PipFR
         kx2jeDpQl/E4AphyCeDPguqkEQbTP2W5HuqT/RLqapb7FsW8RBsfV1qBa6Xdx++2FlO8
         pgQovkDZL0tYA9vYUYeL3BTi4qaqgSeQDj72q83e0uS3vo/Gd8PhPxblw7nwrcBG/fvN
         UuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KdpgJYVNp1S9O0AzSspWOuBraEIV3b2n/gvMw/an9vE=;
        b=eEZ5GHxrsZVoCEIevyqvw7B4e3daxwac/t8tvzzoSLmLD4KwbKxdS6Us88ThJAM1JL
         2Ie3h7BPTRYv6j/ev/pTb22LXrUq4wsYu2B/48roSTcALhYSnuYlktyWyZbLIOINWklo
         BGNUg0sILLUsc734ZHNGVnK4U4kSX3mh3qjHOYQvvvTXlq4QB4siYoTzrQhSsOv8+mXH
         7UOmzoYf1wmdiEoHcfjsydMYGBguToNf2Yv8snCWC/HSyilTsMFZFzJJDzhmj3UlSPwO
         KqvE9kHyX4S04SBfx+TfIqhJZzZDFJ8vnO/3Z90Jbyx/TN7QqMuhhL61FRNRXzj8Apro
         g+Tw==
X-Gm-Message-State: AOAM532DvvCImsPwdUIk53bzfcNDNcEBHxxHS/4VOQSjUAjh83rTCzI3
        5ikUf0KUVWWUE9I1mPrYkz2d9QU0NjOIjw==
X-Google-Smtp-Source: ABdhPJwaMlPyZW7h1d35feHloj6g9lNnkTmaUr6FnbG9qI+6aMaervoQ9BQj9xCMY/c56Vc0U5YLXQ==
X-Received: by 2002:a5e:8c18:: with SMTP id n24mr9382637ioj.211.1634579079982;
        Mon, 18 Oct 2021 10:44:39 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j13sm7106070ilr.47.2021.10.18.10.44.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:44:39 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: move bdev_read_only() into the header
Message-ID: <b737f789-6a1a-19e2-7c1c-6d9d24447af1@kernel.dk>
Date:   Mon, 18 Oct 2021 11:44:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is called for every write in the fast path, move it inline next
to get_disk_ro() which is called internally.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/genhd.c b/block/genhd.c
index 53495e3391e3..000e344265ca 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1390,12 +1390,6 @@ void set_disk_ro(struct gendisk *disk, bool read_only)
 }
 EXPORT_SYMBOL(set_disk_ro);
 
-int bdev_read_only(struct block_device *bdev)
-{
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
-}
-EXPORT_SYMBOL(bdev_read_only);
-
 void inc_diskseq(struct gendisk *disk)
 {
 	disk->diskseq = atomic64_inc_return(&diskseq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 001f617f82da..d13d0f463b03 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -221,6 +221,11 @@ static inline int get_disk_ro(struct gendisk *disk)
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
+static inline int bdev_read_only(struct block_device *bdev)
+{
+	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+}
+
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);

-- 
Jens Axboe

