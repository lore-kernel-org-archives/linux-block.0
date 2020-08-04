Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0EC433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AF821744
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgHDOas (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:30:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgHDOaW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 10:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AD7CB58D;
        Tue,  4 Aug 2020 14:30:29 +0000 (UTC)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200804041508.1870113-1-ming.lei@redhat.com>
 <26b64ecb-53ed-9caf-a447-ce795fbba132@suse.de>
 <20200804060108.GA1872155@T590>
 <79b1d428-8897-5dd1-47ca-c61512547045@suse.de>
 <20200804081452.GA1957653@T590>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH] block: loop: set discard granularity and alignment for
 block device backed loop
Message-ID: <6f642b8a-648e-8b59-067f-6c9f4cc32fa6@suse.de>
Date:   Tue, 4 Aug 2020 22:30:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804081452.GA1957653@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/8/4 16:14, Ming Lei wrote:
> On Tue, Aug 04, 2020 at 03:50:32PM +0800, Coly Li wrote:
>> On 2020/8/4 14:01, Ming Lei wrote:
>>> On Tue, Aug 04, 2020 at 12:29:07PM +0800, Coly Li wrote:
>>>> On 2020/8/4 12:15, Ming Lei wrote:
>>>>> In case of block device backend, if the backend supports discard, the
>>>>> loop device will set queue flag of QUEUE_FLAG_DISCARD.
>>>>>
>>>>> However, limits.discard_granularity isn't setup, and this way is wrong,
>>>>> see the following description in Documentation/ABI/testing/sysfs-block:
>>>>>
>>>>> 	A discard_granularity of 0 means that the device does not support
>>>>> 	discard functionality.
>>>>>
>>>>> Especially 9b15d109a6b2 ("block: improve discard bio alignment in
>>>>> __blkdev_issue_discard()") starts to take q->limits.discard_granularity
>>>>> for computing max discard sectors. And zero discard granularity causes
>>>>> kernel oops[1].
>>>>>
>>>>> Fix the issue by set up discard granularity and alignment.
>>>>>

[snipped]

>>>>
>>>> Hi Ming,
>>>>
>>>> I did similar change, it can avoid the panic or 0 length discard bio.
>>>> But yesterday I realize the discard request to loop device should not go
>>>> into __blkdev_issue_discard(). As commit c52abf563049 ("loop: Better
>>>> discard support for block devices") mentioned it should go into
>>>> blkdev_issue_zeroout(), this is why in loop_config_discard() the
>>>> max_discard_sectors is set to backingq->limits.max_write_zeroes_sectors.
>>>
>>> That commit meant REQ_OP_DISCARD on a loop device is translated into
>>> blkdev_issue_zeroout(), because REQ_OP_DISCARD is handled as
>>> file->f_op->fallocate(FALLOC_FL_PUNCH_HOLE), which will cause
>>> "subsequent reads from this range will return zeroes".
>>>
>>>>
>>>> Now I am looking at the problem why discard request on loop device
>>>> doesn't go into blkdev_issue_zeroout().
>>>
>>> No, that is correct behavior, since loop can support discard or zeroout.
>>>
>>> If QUEUE_FLAG_DISCARD is set, either discard_granularity or max discard
>>> sectors shouldn't be zero.
>>>
>>> This patch shouldn't set discard_granularity if limits.max_write_zeroes_sectors
>>> is zero, will fix it in V2.
>>>
>>>>
>>>> With the above change, the discard is very slow on loop device with
>>>> backing device. In my testing, mkfs.xfs on /dev/loop0 does not complete
>>>> in 20 minutes, each discard request is only 4097 sectors.
>>>
>>> I'd suggest you to check the discard related queue limits, and see why
>>> each discard request just sends 4097 sectors.
>>>
>>> Or we need to mirror underlying queue's discard_granularity too? Can you
>>> try the following patch?
>>
>> Can I know the exact command line to reproduce the panic ?
> 
> modprobe scsi_debug delay=0 dev_size_mb=2048 max_queue=1
> 
> losetup -f /dev/sdc --direct-io=on   #suppose /dev/sdc is the scsi_debug LUN
> 
> mkfs.ext4 /dev/loop0				#suppose loop0 is the loop backed by /dev/sdc
> 
> mount /dev/loop0 /mnt
> 
> cd /mnt
> dbench -t 20 -s 64
> 

Thanks for the information. With the above command lines, I also find a
special case that I can see a 0 byte request triggers a similar BUG()
panic --- when the discard LBA is 0, and loop device driver
queue->limits.discard_granularity is 0.

> 
>>
>> I try to use blkdiscard, or dbench -D /mount_point_to_loop0, and see all
>> the discard requests go into blkdev_fallocate()=>blkdev_issue_zeroout().
>> No request goes into __blkdev_issue_discard().
> 
> The issue isn't related with backend queue, and it is triggered on
> loop's request.

Yes it is clear to me now. Beside the loop device driver,
__blkdev_issue_discard() should also be fixed to tolerate the buggy
queue->limits.discard_granularity, in case some other driver does
similar mistake, or a unlucky downstream kernel maintainer missing your
loop device driver fix.

Yes, please post the v2 patch, now I can help to review this patch.

Thanks for your hint :-)

Coly Li
