Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDFEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 13:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbjFNNCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbjFNNCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 09:02:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AAE1727;
        Wed, 14 Jun 2023 06:02:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 867121FDED;
        Wed, 14 Jun 2023 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686747759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMDeM94d6wWa0bomfv2SniHbOGSKD3bXpgmUgOrpy0Q=;
        b=Ra2dPs3CHtttweb+YiXpsuYj2ox3yU9tI+r8HkXA3bLgKAnLio2PXO6oison6WVCeXHtF4
        9wZWB9CWMAKCG+sfhWrWHpzAmKHPcChCrYG0P6Fjki3HjKO6Yq4Jpp9+6ZCst7JqeUCpKV
        ftumbah5jnpjuvkCswljGQeAuZrghuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686747759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMDeM94d6wWa0bomfv2SniHbOGSKD3bXpgmUgOrpy0Q=;
        b=nHJZuinm4L5vheHZ/w9KqlUZEF/Uyl2VEwzJHPjBzLPrl4bOYLwmEbVeasvpj1hi0KzTEd
        ttekW3/ZijMfPZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72F2B1357F;
        Wed, 14 Jun 2023 13:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qqmcG2+6iWTsTgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 13:02:39 +0000
Message-ID: <7239695e-6dd6-7a00-f4fe-3bd36ae2d924@suse.de>
Date:   Wed, 14 Jun 2023 15:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de> <ZIm4wyHZK/YMV2gj@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZIm4wyHZK/YMV2gj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/23 14:55, Matthew Wilcox wrote:
> On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
>> @@ -43,9 +43,11 @@ struct brd_device {
>>   	 */
>>   	struct xarray	        brd_folios;
>>   	u64			brd_nr_folios;
>> +	unsigned int		brd_sector_shift;
>> +	unsigned int		brd_sector_size;
>>   };
>>   
>> -#define BRD_SECTOR_SHIFT(b) (PAGE_SHIFT - SECTOR_SHIFT)
>> +#define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - SECTOR_SHIFT)
>>   
>>   static pgoff_t brd_sector_index(struct brd_device *brd, sector_t sector)
>>   {
>> @@ -85,7 +87,7 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
>>   {
>>   	pgoff_t idx;
>>   	struct folio *folio, *cur;
>> -	unsigned int rd_sector_order = get_order(PAGE_SIZE);
>> +	unsigned int rd_sector_order = get_order(brd->brd_sector_size);
> 
> Surely max(0, brd->brd_sector_shift - PAGE_SHIFT) ?
> 
Errm. Possibly.

>> @@ -346,6 +353,25 @@ static int brd_alloc(int i)
>>   		return -ENOMEM;
>>   	brd->brd_number		= i;
>>   	list_add_tail(&brd->brd_list, &brd_devices);
>> +	brd->brd_sector_shift = ilog2(rd_blksize);
>> +	if ((1ULL << brd->brd_sector_shift) != rd_blksize) {
>> +		pr_err("rd_blksize %d is not supported\n", rd_blksize);
> 
> Are you trying to require power-of-two here?  We have is_power_of_2()
> for that purpose.
> 
Ah. So let's use that, then :-)

Cheers,

Hannes

