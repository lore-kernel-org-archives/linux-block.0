Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CDACA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F52089C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="gutmCZkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUJnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:43:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42724 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:43:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id s20so3495246edq.9
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/byl0SYhYrdPaoamUUY4+B2kL6hq17tmokkxCC6BFHk=;
        b=gutmCZkmtndbXcakjwEr9E/MmpBKG3MTsByjck+DIoDXwepNYNIBOIuiJ1a6QoGWtR
         /0i73DI9esLYYTfgjtkEqJGoNvR2MqUyt09V1gpX9z2Kh/mM4n8ozpnLJqJA1SKjHBYP
         IdqOYtWpih/AgVeVUA4qvDcY3i8rBrwTqspSc0y+1yIeFfAvGq0YgeE5Q8g5yPotpaCb
         6MquxGSNMlGQWep5R8mPT9OcCbW5wP1A+/qgUuNpUISbwJcaP0W48iMHcxs/Vaad98lJ
         F5T3kAZ+b7DpLPdMGn2o57mQoDFL+B25Gts3W8TyXerF10GuDaKn9KoM9SikBF0O95U5
         MdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/byl0SYhYrdPaoamUUY4+B2kL6hq17tmokkxCC6BFHk=;
        b=QZkCf5hjiBDiIkuOon6GiXhB/4IDM0LlPjrRXyDeNctKiAISnSuyf6Npbd+SmUZjb+
         9paijE9NynsIG8l6CihoHNFukzRtNC7x746inqmtJuhcA7KuyesNLP+WeueBePnGSoP0
         0dwb3rluPpJXO3uB/r6zaiTp3zXz1MPseYZWIZYIs+UI1x0AeHm1T0dIAOGJ8ioccmov
         W7geguxxanrZBcygZbn2bgLkb8q9HZHQak48qYeoNrtH4+OjiT4n3aWD761ukKYcDeaW
         vLJAmCshqWMrdZ+oU9Mp9/0LGisvMC+4KiZ4o9szejtmcNMquWDGrrWZgghM4ITWoDVo
         eISw==
X-Gm-Message-State: APjAAAXpkYcKTRfYGX2pM7EVrYeQBKJSeCda+U0bM2Jk8Jfb0zxLcx3i
        gkmYWZA35W6jJdJ3HDGfgnrUArw0RZpTyg==
X-Google-Smtp-Source: APXvYqytlJmAG3bCExQtszMo8j6s8p4l5YapiaKUKgUiXWZgsW4U5wSB+KdhUa7AeeQVMgoJshmxZg==
X-Received: by 2002:a17:906:4a0d:: with SMTP id w13mr9038116eju.89.1571650985039;
        Mon, 21 Oct 2019 02:43:05 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2920:f165:80aa:e780? ([2001:1438:4010:2540:2920:f165:80aa:e780])
        by smtp.gmail.com with ESMTPSA id p4sm104555edb.67.2019.10.21.02.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 02:43:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] bdev: Refresh bdev size for disks without
 partitioning
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-2-jack@suse.cz>
 <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
 <20191021091256.GB17810@quack2.suse.cz>
 <f77bed8f-16a7-dc96-d006-41c34e86eff0@cloud.ionos.com>
 <20191021094016.GD17810@quack2.suse.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <5d3ea6b2-61c1-fd79-39e9-0b294b8b2358@cloud.ionos.com>
Date:   Mon, 21 Oct 2019 11:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021094016.GD17810@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/21/19 11:40 AM, Jan Kara wrote:
> On Mon 21-10-19 11:27:36, Guoqing Jiang wrote:
>>
>> On 10/21/19 11:12 AM, Jan Kara wrote:
>>> On Mon 21-10-19 10:49:54, Guoqing Jiang wrote:
>>>> On 10/21/19 10:38 AM, Jan Kara wrote:
>>>>> Currently, block device size in not updated on second and further open
>>>>> for block devices where partition scan is disabled. This is particularly
>>>>> annoying for example for DVD drives as that means block device size does
>>>>> not get updated once the media is inserted into a drive if the device is
>>>>> already open when inserting the media. This is actually always the case
>>>>> for example when pktcdvd is in use.
>>>>>
>>>>> Fix the problem by revalidating block device size on every open even for
>>>>> devices with partition scan disabled.
>>>>>
>>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>>> ---
>>>>>     fs/block_dev.c | 19 ++++++++++---------
>>>>>     1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>>>> index 88c6d35ec71d..d612468ee66b 100644
>>>>> --- a/fs/block_dev.c
>>>>> +++ b/fs/block_dev.c
>>>>> @@ -1403,11 +1403,7 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
>>>>>     		       "resized disk %s\n",
>>>>>     		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
>>>>>     	}
>>>>> -
>>>>> -	if (!bdev->bd_disk)
>>>>> -		return;
>>>>> -	if (disk_part_scan_enabled(bdev->bd_disk))
>>>>> -		bdev->bd_invalidated = 1;
>>>>> +	bdev->bd_invalidated = 1;
>>>>>     }
>>>>>     /**
>>>>> @@ -1514,10 +1510,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>>>>>     static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>>>>>     {
>>>>> -	if (invalidate)
>>>>> -		invalidate_partitions(bdev->bd_disk, bdev);
>>>>> -	else
>>>>> -		rescan_partitions(bdev->bd_disk, bdev);
>>>>> +	if (disk_part_scan_enabled(bdev->bd_disk)) {
>>>>> +		if (invalidate)
>>>>> +			invalidate_partitions(bdev->bd_disk, bdev);
>>>>> +		else
>>>>> +			rescan_partitions(bdev->bd_disk, bdev);
>>>> Maybe use the new common helper to replace above.
>>> What do you mean exactly? Because there's only this place that has the code
>>> pattern here...
>> The above looks same as the new function.
>>
>> +static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>> +{
>> +	if (invalidate)
>> +		invalidate_partitions(bdev->bd_disk, bdev);
>> +	else
>> +		rescan_partitions(bdev->bd_disk, bdev);
>> +}
>>
>> So maybe just call it in the 'if' branch, am I misunderstand something?
> I think you misparsed the diff ;) The code that you mention as duplicated
> just gets reindented by the patch.
>
>> static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>> {
>> 	if (disk_part_scan_enabled(bdev->bd_disk))	
>> 		bdev_disk_changed(bdev, invalidate)
>> 	else {
>> 		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
>> 		bdev->bd_invalidated = 0;
>> 	}
>> }
> This has infinite recursion in it - you call bdev_disk_changed() from
> bdev_disk_changed().

Right :-[, I need some coffee to refresh, sorry for the noise.

BRs,
Guoqing
