Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6976C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05512073B
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 10:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDCK1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:27:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54354 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 06:27:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 5F0DB29854C
Subject: Re: [PATCH v8 2/2] loop: Better discard support for block devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     evgreen@chromium.org, asavery@chromium.org, axboe@kernel.dk,
        bvanassche@acm.org, darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com,
        kernel@collabora.com
References: <20200402170603.19649-1-andrzej.p@collabora.com>
 <20200402170603.19649-3-andrzej.p@collabora.com>
 <20200403063955.GB28875@infradead.org>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <49a20f42-f082-be3a-52f8-a4179ab886c0@collabora.com>
Date:   Fri, 3 Apr 2020 12:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403063955.GB28875@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

W dniu 03.04.2020 o 08:39, Christoph Hellwig pisze:
> On Thu, Apr 02, 2020 at 07:06:03PM +0200, Andrzej Pietrasiewicz wrote:
>> From: Evan Green <evgreen@chromium.org>
>>

<snip>

>> +	struct request_queue *backingq;
>> +
>> +	/*
>> +	 * If the backing device is a block device, mirror its zeroing
>> +	 * capability. Set the discard sectors to the block device's zeroing
>> +	 * capabilities because loop discards result in blkdev_issue_zeroout(),
>> +	 * not blkdev_issue_discard(). This maintains consistent behavior with
>> +	 * file-backed loop devices: discarded regions read back as zero.
>> +	 */
>> +	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
>> +		backingq = bdev_get_queue(inode->i_bdev);
> 
> The backingq could move into this local scope.
> 
>> +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> 
> No need for the inner braces.
> 
> But the actual functionality looks good to me.
> 

Would you A-b or R-b if I corrected the two small issues which you found?

Andrzej
