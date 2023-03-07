Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5994FC678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 11:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCGLKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 06:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCGLKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 06:10:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD023671
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 03:06:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 604811FE18;
        Tue,  7 Mar 2023 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678187208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YbUtisnxxUYD+kIO60HlRHhgexicd7fyRCIkBL6Ifw=;
        b=kiDnFnMGC9M8kCXT69Kl85+8UhvSlBE/oQMlGtN2I2g9AVYIngyVEDNAJ1sjuLfyrTCWPS
        9zBAjqLRMn6pcnCaho5W5tuUTmqqTbI5fniLdifRWl9ikUUkFXa6E69j9AAqJo+N3nc/Hv
        yJ0FDd6BCPhv+PlCJqvgRr1IdStvS3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678187208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YbUtisnxxUYD+kIO60HlRHhgexicd7fyRCIkBL6Ifw=;
        b=/vgMr5NwuXtiqEs4l1Wy1uU1X5Gbrc93Jtq93nVSwHba8p9p7PllaYVjKYeCMRBpnAAtXp
        mpWsj6XGEGVSK0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47F8713440;
        Tue,  7 Mar 2023 11:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IeglEcgaB2RUegAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Mar 2023 11:06:48 +0000
Message-ID: <be09233d-022b-61f0-200c-a5c72a22352b@suse.de>
Date:   Tue, 7 Mar 2023 12:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/5] brd: make logical sector size configurable
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-6-hare@suse.de>
 <CGME20230307090934eucas1p28d92f3fd8c13edcba8e5d3fa7de6bcab@eucas1p2.samsung.com>
 <20230307090056.x3hpaxdwtlpytnf2@blixen>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230307090056.x3hpaxdwtlpytnf2@blixen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/23 10:01, Pankaj Raghav wrote:
>> @@ -57,7 +59,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
>>   {
>>   	pgoff_t idx;
>>   	struct folio *folio;
>> -	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
>> +	unsigned int rd_sector_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
> 
> Could we create a simple macro instead of repeating this everywhere?
> #define RD_SECTOR_SHIFT(brd) (brd->brd_sector_shift - brd->brd_logical_sector_shift)
> 
Yeah, I'm not utterly happy with that one, too; this patchset is 
primarily a mechanical conversion to avoid errors.
Will be changing it.

>>   
>>   	/*
>>   	 * The folio lifetime is protected by the fact that we have opened the
>>   			bio_io_error(bio);
>>   			return;
>>   		}
>> -		sector += len >> SECTOR_SHIFT;
>> +		sector += len >> brd->brd_logical_sector_shift;
>>   	}
>>   
>>   	bio_endio(bio);
>> @@ -353,6 +355,10 @@ static unsigned int rd_blksize = PAGE_SIZE;
>>   module_param(rd_blksize, uint, 0444);
>>   MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
>>   
>> +static unsigned int rd_logical_blksize = SECTOR_SIZE;
>> +module_param(rd_logical_blksize, uint, 0444);
>> +MODULE_PARM_DESC(rd_logical_blksize, "Logical blocksize of each RAM disk in bytes.");
>> +
>>   MODULE_LICENSE("GPL");
>>   MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
>>   MODULE_ALIAS("rd");
>> @@ -391,6 +397,8 @@ static int brd_alloc(int i)
>>   	list_add_tail(&brd->brd_list, &brd_devices);
>>   	brd->brd_sector_shift = ilog2(rd_blksize);
>>   	brd->brd_sector_size = rd_blksize;
>> +	brd->brd_logical_sector_shift = ilog2(rd_logical_blksize);
>> +	brd->brd_logical_sector_size = rd_logical_blksize;
> 
> We should a check here to see if logical block > rd_blksize similar
> to what is done in blk_queue_logical_block_size()?
>  > // physical block size should not be less than the logical block size
> if (rd_blksize < rd_logical_blksize) {
> 	brd->brd_logical_sector_shift = ilog2(rd_blksize);
> 	brd->brd_logical_sector_size = rd_blksize;
>   }
> 
Sure. Keith already complained about it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)

