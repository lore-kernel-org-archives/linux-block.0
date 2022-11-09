Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B68C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 08:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKII0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKII0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 03:26:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D313D33
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 00:26:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5473D68AFE; Wed,  9 Nov 2022 09:26:45 +0100 (CET)
Date:   Wed, 9 Nov 2022 09:26:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/7] dm: track per-add_disk holder relations in DM
Message-ID: <20221109082645.GA14093@lst.de>
References: <20221030153120.1045101-1-hch@lst.de> <20221030153120.1045101-6-hch@lst.de> <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 09, 2022 at 10:08:14AM +0800, Yu Kuai wrote:
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index 2917700b1e15c..7b0d6dc957549 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -751,9 +751,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
>>   		goto out_free_td;
>>   	}
>>   -	r = bd_link_disk_holder(bdev, dm_disk(md));
>> -	if (r)
>> -		goto out_blkdev_put;
>> +	/*
>> +	 * We can be called before the dm disk is added.  In that case we can't
>> +	 * register the holder relation here.  It will be done once add_disk was
>> +	 * called.
>> +	 */
>> +	if (md->disk->slave_dir) {
> If device_add_disk() or del_gendisk() can concurrent with this, It seems
> to me that using 'slave_dir' is not safe.
>
> I'm not quite familiar with dm, can we guarantee that they can't
> concurrent?

I assumed dm would not get itself into territory were creating /
deleting the device could race with adding component devices, but
digging deeper I can't find anything.  This could be done
by holding table_devices_lock around add_disk/del_gendisk, but
I'm not that familar with the dm code.

Mike, can you help out on this?
