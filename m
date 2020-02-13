Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69125C352A4
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 00:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4650F206DB
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 00:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgBMAJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:09:57 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:57194 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgBMAJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 19:09:57 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 19:09:57 EST
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 843671C0423;
        Wed, 12 Feb 2020 17:02:44 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Simon Glass <sjg@chromium.org>
From:   Stephen Warren <swarren@wwwdotorg.org>
Subject: dd, close(), sync, and the Linux disk cache
Message-ID: <b7ad1223-4224-da46-4c48-50427360f31c@wwwdotorg.org>
Date:   Wed, 12 Feb 2020 17:02:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens et. al.,

If I dd to an SD card (e.g. via a USB SD card reader), is it required to 
run sync afterward in order to guarantee that all written data is 
written to the SD card? I'm running dd with a simple command-line like 
"dd if=file.img of=/dev/sdc".

In practice on my system, strace shows me that dd completes its write 
operations relatively quickly, since many are buffered in the kernel. 
However, dd's call to close() takes a very long time. I believe this 
delay is due to the kernel flushing all the buffers to disk, and so a 
sync is not required. I found code in the kernel that does appear to do 
this:

https://elixir.bootlin.com/linux/v5.5/source/fs/block_dev.c#L2145
dev_blk_fops.release = blkdev_close
blkdev_close calls blkdev_put
blkdev_put calls __blkdev_put
__blkdev_put calls sync_blockdev if the device open count is 0
sync_blockdev calls __sync_blockdev with the wait flag set
__sync_blockdev calls filemap_write_and_wait

However, Simon finds that when he dd's to an SD card, he needs to 
execute sync afterward to avoid a corrupted SD card. I'm trying to 
understand what the difference is, and whether sync is the correct 
solution for this issue, or just something that happens to take some 
time (e.g. to flush buffers to the sytem's main hard disk) during which 
some other issue is typically resolved.

For reference, I've seen the "no sync required" behaviour on my laptop 
with a built-in PCIe SD reader which shows up as /dev/mmcblkN and on my 
desktop using a USB SD reader which shows up as /dev/sdN. Simon is I 
believe using a USB SD card reader, which is actually a mux device that 
allows switching the SD card between hosts, with the host->host switch 
happening immediately after the dd (or dd+sync) completes.
