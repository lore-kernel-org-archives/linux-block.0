Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A9CA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20535214AE
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Bopv2DVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfJUJ1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:27:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45740 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJ1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:27:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id y7so1946416edo.12
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NU+wtJpGon2V0gaEu2h5h0yci39L9937jv3NIX8B4j0=;
        b=Bopv2DVz1CFovdU66LNmx5drr9vfcoLt9mltagpKJBjmNWeH1eJNzo4ungQUAYpiD0
         nJy3nzArgu+A1qMb8YS3gbp/jf3avtvjBTcCiyiIfbjIYpSqrmBjoMQSjBNF56v8Mu+B
         EQsiGpxqHsOtInbPFBlJFhyOe9U6ur9PFHthdL2BsjyjlUtobnJduEHWTDN9RTUVhynu
         mOQ5m93guMGndcHL7NlvHHCp4n1i9LxgjVi4EFrs+74hDbebHAX7Bi8zNmtWy4weBeK4
         A4Hqy5e0opoi4RdLdG0o3AIyxTjaBha2Lvet7FGWP9f8mbOq0tb6bV+N6w8L/g/iclDr
         TqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NU+wtJpGon2V0gaEu2h5h0yci39L9937jv3NIX8B4j0=;
        b=GVnsxChziMuLG4vDC7SRfmrKwqoqv1H+QnwLEq5/AKZwguDf9bLItPh0VTfwyMUo0N
         yXQUjDPq6sp2Ibe9vWJFXhJV71gGMdCPbPoVRdtv842N/8H23CjXbRTIrd1OEnKja74w
         OK1a35H42RNvRGlpgw4wyM4po9qoddBe41h1YTtnvx5v3zSYHVxU2Ic/FTS/pdGqZNqf
         Cv1ERvYbk+FJvmzkcqrEc7N0e1VfR0TnQBKvZZTv/2l6pHe0RFj0HqDUDi3aU1DXjiJV
         XKsdDvzCbkAnQ8n2LqLQHvmyLKkN6mewk0KEoeDy3hg9cUjNBOQ6T4Qvzk3f7Rgdob36
         xAVw==
X-Gm-Message-State: APjAAAVt/pBK0Y3Gjx1K1Zl/0b9LvWN2Qr/DMVW2SqYUjw/DlwVEFmsE
        eBz7thD9fFZgcUG0fw5m4aXP0Tj4Snngog==
X-Google-Smtp-Source: APXvYqw+I3eU388zK7q1qtBw3tVqFeEb8w7rvSZxsKYCDU+Rwf54qHB2LTxXLp83KbbHajNVU0IRpg==
X-Received: by 2002:a17:906:8682:: with SMTP id g2mr2434178ejx.225.1571650058048;
        Mon, 21 Oct 2019 02:27:38 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2920:f165:80aa:e780? ([2001:1438:4010:2540:2920:f165:80aa:e780])
        by smtp.gmail.com with ESMTPSA id l49sm136028edb.3.2019.10.21.02.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 02:27:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] bdev: Refresh bdev size for disks without
 partitioning
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-2-jack@suse.cz>
 <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
 <20191021091256.GB17810@quack2.suse.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f77bed8f-16a7-dc96-d006-41c34e86eff0@cloud.ionos.com>
Date:   Mon, 21 Oct 2019 11:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021091256.GB17810@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/21/19 11:12 AM, Jan Kara wrote:
> On Mon 21-10-19 10:49:54, Guoqing Jiang wrote:
>>
>> On 10/21/19 10:38 AM, Jan Kara wrote:
>>> Currently, block device size in not updated on second and further open
>>> for block devices where partition scan is disabled. This is particularly
>>> annoying for example for DVD drives as that means block device size does
>>> not get updated once the media is inserted into a drive if the device is
>>> already open when inserting the media. This is actually always the case
>>> for example when pktcdvd is in use.
>>>
>>> Fix the problem by revalidating block device size on every open even for
>>> devices with partition scan disabled.
>>>
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>    fs/block_dev.c | 19 ++++++++++---------
>>>    1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index 88c6d35ec71d..d612468ee66b 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -1403,11 +1403,7 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
>>>    		       "resized disk %s\n",
>>>    		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
>>>    	}
>>> -
>>> -	if (!bdev->bd_disk)
>>> -		return;
>>> -	if (disk_part_scan_enabled(bdev->bd_disk))
>>> -		bdev->bd_invalidated = 1;
>>> +	bdev->bd_invalidated = 1;
>>>    }
>>>    /**
>>> @@ -1514,10 +1510,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>>>    static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>>>    {
>>> -	if (invalidate)
>>> -		invalidate_partitions(bdev->bd_disk, bdev);
>>> -	else
>>> -		rescan_partitions(bdev->bd_disk, bdev);
>>> +	if (disk_part_scan_enabled(bdev->bd_disk)) {
>>> +		if (invalidate)
>>> +			invalidate_partitions(bdev->bd_disk, bdev);
>>> +		else
>>> +			rescan_partitions(bdev->bd_disk, bdev);
>> Maybe use the new common helper to replace above.
> What do you mean exactly? Because there's only this place that has the code
> pattern here...

The above looks same as the new function.

+static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
+{
+	if (invalidate)
+		invalidate_partitions(bdev->bd_disk, bdev);
+	else
+		rescan_partitions(bdev->bd_disk, bdev);
+}

So maybe just call it in the 'if' branch, am I misunderstand something?

static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
{
	if (disk_part_scan_enabled(bdev->bd_disk))	
		bdev_disk_changed(bdev, invalidate)
	else {
		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
		bdev->bd_invalidated = 0;
	}
}

Thanks,
Guoqing

