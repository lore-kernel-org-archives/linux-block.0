Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D67DC678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 07:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGHAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 02:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCGG73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 01:59:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358EB89F1C
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 22:58:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6FA41FE0B;
        Tue,  7 Mar 2023 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678172274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njmAjD4/wA/qxp+y/ZXavLyFRJVt5+i382k3D7fPCVY=;
        b=KL5nBsLqCRIuS+vNn3TT3SDOY54vre52jIi8ptTgwo8JEHtOd9Y5uRC8egFWzEiUGERIAz
        vPvaX1bPS2IthgWX99H0CrYuWXWFYBT4FeDYOOFbL3gN7J8Kj2Kh7x15Rm/98LifCxcmG3
        ixiNlR/f7tzFFVqonhkz0c+vPQZabok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678172274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njmAjD4/wA/qxp+y/ZXavLyFRJVt5+i382k3D7fPCVY=;
        b=1HbugSWywqjxwRvuQoZMeHgxT89KqLdulGq7aV/xVocaow9PsimKFureJnfDQV4oMSzvUD
        XA9Ch07wpOKzjGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C54D13440;
        Tue,  7 Mar 2023 06:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LRmoHXLgBmQBZQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Mar 2023 06:57:54 +0000
Message-ID: <6362a59c-d580-89f5-fe13-155065131477@suse.de>
Date:   Tue, 7 Mar 2023 07:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] brd: limit maximal block size to 32M
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-5-hare@suse.de>
 <ZAYqbUEdGAD6rsp4@kbusch-mbp.dhcp.thefacebook.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAYqbUEdGAD6rsp4@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/23 19:01, Keith Busch wrote:
> On Mon, Mar 06, 2023 at 01:01:26PM +0100, Hannes Reinecke wrote:
>> Use an arbitrary limit of 32M for the maximal blocksize so as not
>> to overflow the page cache.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/block/brd.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index 11bac3c3f1b6..1ed114cd5cb0 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -348,6 +348,7 @@ static int max_part = 1;
>>   module_param(max_part, int, 0444);
>>   MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>>   
>> +#define RD_MAX_SECTOR_SIZE 65536
>>   static unsigned int rd_blksize = PAGE_SIZE;
>>   module_param(rd_blksize, uint, 0444);
>>   MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
>> @@ -410,15 +411,14 @@ static int brd_alloc(int i)
>>   	disk->private_data	= brd;
>>   	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
>>   	set_capacity(disk, rd_size * 2);
>> -	
>> -	/*
>> -	 * This is so fdisk will align partitions on 4k, because of
>> -	 * direct_access API needing 4k alignment, returning a PFN
>> -	 * (This is only a problem on very small devices <= 4M,
>> -	 *  otherwise fdisk will align on 1M. Regardless this call
>> -	 *  is harmless)
>> -	 */
>> +
>> +	if (rd_blksize > RD_MAX_SECTOR_SIZE) {
> 
> rd_blkside is in bytes, but the above is ccomapring it to something in units of
> SECTOR_SIZE.
> 
Ok.

>> +		/* Arbitrary limit maximum block size to 32M */
>> +		err = -EINVAL;
>> +		goto out_cleanup_disk;
>> +	}
> 
> rd_blksize also needs to be >= 512, and a power of 2.
> 
Yes; I'll be adding the checks accordingly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

