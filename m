Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6DD204EA
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgEOFJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 01:09:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgEOFJv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 01:09:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE9B6AE5A;
        Fri, 15 May 2020 05:09:52 +0000 (UTC)
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200514162643.11880-1-johannes.thumshirn@wdc.com>
 <BY5PR04MB69006DE86D1050620B5EDAA4E7BD0@BY5PR04MB6900.namprd04.prod.outlook.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH] block: deny zone management ioctl on mounted fs
Message-ID: <8bc40310-6d2d-4b2f-ae56-17899fc29d22@suse.de>
Date:   Fri, 15 May 2020 13:09:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB69006DE86D1050620B5EDAA4E7BD0@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/5/15 12:52, Damien Le Moal wrote:
> On 2020/05/15 1:26, Johannes Thumshirn wrote:
>> If a user submits a zone management ioctl from user-space, like a zone
>> reset and a file-system (like zonefs or f2fs) is mounted on the zoned
>> block device, the zone will get reset and the file-system's cached value
>> of the zone's write-pointer becomes invalid.
>>
>> Subsequent writes to this zone from the file-system will result in
>> unaligned writes and the drive will error out.
>>
>> Deny zone management ioctls when a super_block is found on the block
>> device.
> 
> Zone management ioctls can only be executed by users that have SYS_CAP_ADMIN
> capabilities. If these start doing stupid things, the system is probably in for
> a lot of troubles beyond what this patch is trying to prevent.
> 
> In addition, there are so many other ways that a mounted zoned block device can
> be corrupted beyond these ioctls that I am not sure this patch is very useful.
> E.g. any raw block device write in a zone would also cause the FS to see
> unaligned writes, and any other raw block device access is also possible for
> SYS_CAP_ADMIN users. Preventing only these ioctls does not really improve
> anything I think. That may even be harmful has that would prevent things like
> inline file system check utilities to run.
> 
>

The problem I encountered was, after I write 8KB data into seq/0 file, I
want to re-write from offset 0. At that moment I didn't know to use
'truncate -s 0' to reset the write pointer of this zone file, so I use
'blkzone reset' to reset the write pointer of seq zone 0, and I saw the
write pointer was reset to 0. But I still was not able to write data
into seq/0 file on offset 0. Then I decided to reset all the zones by
command 'blkzone reset -o 0 -c <zones number>', then the command hung
for 20+ minutes and not response. From the kernel message I saw quite a
log error message (an example is on pastbin: https://pastebin.com/ZFFNsaE0)

In my mind, there are 2 methods to reset a zone, one is from blkzone,
one is from truncate on zonefs. I guess I am not the first/last one
which thinks the two method should work both, and has no idea when the
above error encountered.

Reject blkzone reset command when the zoned SMR drive is mounted by
zonefs, it is OK to me to avoid confusion and further mistake. IMHO,
This is a solution at least.

Thanks.

Coly Li

>>
>> Reported-by: Coly Li <colyli@suse.de>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>
>> Is there a better way to check for a mounted FS than get_super()/drop_super()?
>>
>>  block/blk-zoned.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 23831fa8701d..6923695ec414 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -325,6 +325,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  			   unsigned int cmd, unsigned long arg)
>>  {
>>  	void __user *argp = (void __user *)arg;
>> +	struct super_block *sb;
>>  	struct request_queue *q;
>>  	struct blk_zone_range zrange;
>>  	enum req_opf op;
>> @@ -345,6 +346,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  	if (!(mode & FMODE_WRITE))
>>  		return -EBADF;
>>  
>> +	sb = get_super(bdev);
>> +	if (sb) {
>> +		drop_super(sb);
>> +		return -EINVAL;
>> +	}
>> +
>>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
>>  		return -EFAULT;
>>  
>>
> 
> 

