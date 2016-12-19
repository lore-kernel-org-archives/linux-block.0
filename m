Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754020AbcLSQP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 11:15:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBJGDfjR071115
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2016 11:15:55 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27ee5x21tg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2016 11:15:55 -0500
Received: from localhost
        by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.vnet.ibm.com>;
        Mon, 19 Dec 2016 16:15:53 -0000
From: Stefan Haberland <sth@linux.vnet.ibm.com>
To: hch@infradead.org, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
Subject: Re: [RFC] block: check partition alignment
Date: Mon, 19 Dec 2016 17:15:49 +0100
In-Reply-To: <88308b2d-de52-b97a-2001-96da7e9f5d1f@wdc.com>
References: <88308b2d-de52-b97a-2001-96da7e9f5d1f@wdc.com>
Message-Id: <20161219161550.55414-1-sth@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Am 14.12.2016 um 18:07 schrieb Christoph Hellwig:
>> To prevent partitions that are not aligned to the physical blocksize
>> > of a device check for the alignment in the blkpg_ioctl.
> We'd also need to reject this when reading partitions from disk, right?
>

I am not sure if there is a problem. I was not able to recreate the error
with a partition read from disk. But simply because I was not able to
write a defective partition table to disk. All variants I tried where OK.
So I am at least not aware of a way to break it via the partition
detection code.
I just noticed that the ioctl which can be called by anyone is
able to establish defective partitions.


Am 15.12.2016 um 09:56 schrieb Damien Le Moal:
> On 12/15/16 17:45, Christoph Hellwig wrote:
>> On Thu, Dec 15, 2016 at 10:33:47AM +0900, Damien Le Moal wrote:
>>> For a regular block device, I agree. But in Stephan case, I think that
>>> the check really needs to be against the physical block size, with the
>>> added condition that the bdev is a DASD device (similarly to the zone
>>> alignment check for zoned block devices).
>>
>> Then they need to expose a chunk_size.  physical block size is defined
>> as not having a meaning for the kernel.
>
> Or create the block device with the logical block size set to the
> physical sector size. Which would be even more simple and in fact
> correct in this case since only physically aligned accesses make sense
> for DASD.
>

We already do it this way. So the logical blocksize is fine for DASD.
I just was not aware of the fact that the physical blocksize is a 
best_can_do field. So I changed it this way and also incorporated your 
other feedback regarding the modulo. Here is the second suggestion for
the patch.

Stefan Haberland (1):
  block: check partition alignment

 block/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.8.4

