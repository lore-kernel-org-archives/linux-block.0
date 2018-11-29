Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC19C04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54232146F
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="apExyLDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54232146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeK3J0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:26:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50477 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3J0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 04:26:16 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so6259983iti.0
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XX3MAam9aTRPYZgOtdxLDq8qrnzUl367pIbGK+n94R4=;
        b=apExyLDlMbRe7p/u0glL43AhYBZbBpG9/U6pAMtDksZd3HisovjpGCCwIlfYObNiIN
         RPQ/KpwPIKRCF0/7z8wIOXA6BGexXMcuke6cZUhVPqCVk2AydANMI7Rs/KPrgeQC1jtH
         dRqCcKDf30oasJyaykaCTaNEm5xTls5sfeoosoT24qL55wuX0taMEA5CPvkC/UWIBi+0
         6y+TU4BvL8EEi+xKtwBanlkHyCwohJ7t513wXk9YIg8K5gzwiw+M4C7E3WcwxT3b3aZG
         EHMz3I4Fc+uvWa8pF0yDO7A/6RSr7sMq+lVcRDM8Y4VVb2rycLIQvnkOH3NHRmSKnbWN
         Vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XX3MAam9aTRPYZgOtdxLDq8qrnzUl367pIbGK+n94R4=;
        b=QLRendAsZYKFDc+oCIsKlylmr0oumaMG9Dlm1UktSvYZmTBGEdcwt9kzgRPRozZoir
         SgBSId4PJIwwCbAcos1k1v4tLmE6XsL7OzM8mf2ne266FBSKxz+xxb6Pq0B4R78LMcl+
         dOAXEi+/pz+JrzLYvWBX26ZPgJp9YMe7ABYbdbq4Zj7Q4i/JLYgszsFCfjG9VqyutX7H
         QftsYQbcDa0QOfhVUmbtRZM1HAkdJy/5Pod48qCWgxLt994cXu9eSkjNBUzec5MW6UkL
         C/u1Cx8j0XEaLB4lCfSm9oYn/4BMjrwzCHC6svIpreWOF5LVHW9m9WRg82uaJ24VuDwl
         TWKg==
X-Gm-Message-State: AA+aEWYYLTstbBB/fdBzoOEPLToBOLaXUoGxdsHkPnbH8AdaZIwn77rr
        iNl+HZU3xSVPKBKNT63ghjT41n2ZVO4=
X-Google-Smtp-Source: AFSGD/UBLRHPJ/FSdetanpgDeX+UdWssKpaksLp2aAq08gwIdqiWUPhtQ8DAOfyDdnoZew5IrUi3HQ==
X-Received: by 2002:a24:8244:: with SMTP id t65-v6mr3065839itd.3.1543529955023;
        Thu, 29 Nov 2018 14:19:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q14sm1687517itb.36.2018.11.29.14.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:19:14 -0800 (PST)
Subject: Re: [PATCH] sbitmap: ammortize cost of clearing bits
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <91b96e21-45c9-63ca-334a-6f597b34123e@kernel.dk>
 <20181129215330.GB25153@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b435a0a-b11b-4381-f065-0b04d29fc99d@kernel.dk>
Date:   Thu, 29 Nov 2018 15:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129215330.GB25153@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 2:53 PM, Omar Sandoval wrote:
> On Thu, Nov 29, 2018 at 01:00:25PM -0700, Jens Axboe wrote:
>> sbitmap maintains a set of words that we use to set and clear bits, with
>> each bit representing a tag for blk-mq. Even though we spread the bits
>> out and maintain a hint cache, one particular bit allocated will end up
>> being cleared in the exact same spot.
>>
>> This introduces batched clearing of bits. Instead of clearing a given
>> bit, the same bit is set in a cleared/free mask instead. If we fail
>> allocating a bit from a given word, then we check the free mask, and
>> batch move those cleared bits at that time. This trades 64 atomic bitops
>> for 2 cmpxchg(). On top of that, we do those sequentially, hopefully
>> making that a bit cheaper as well.
>>
>> In a threaded poll test case, half the overhead of getting and clearing
>> tags is removed with this change. On another poll test case with a
>> single thread, performance is unchanged.
>>     
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> This patch is on top of the round robin fix for sbitmap just posted.
> 
> So I think this can lead to hangs due to interactions with wake_batch.
> Bear with me:
> 
> Let's say the sbitmap_queue was created with depth=64 and shift=6,
> i.e., 64 bits all in one word. In this case, wake_batch=8, because 64
> bits clearing should be enough to wake up in 8 batches of 8.
> 
> Let's say all 64 bits are allocated and there are 8 waiters. All 64
> bits are then freed (in the cleared word), so we wake up the 8
> waiters. Let's say they all attempt __sbitmap_get_word(), fail, and
> get to sbitmap_deferred_clear() at the same time. One of them does the
> cmpxchg() on cleared, setting it to zero, and then the rest see that
> cleared is zero, so they return because there don't appear to be any
> cleared bits. The first thread succeeds, and the rest go to sleep. 
> 
> Now, when the first thread clears the bit, it only subtracts one from
> the batch, which isn't enough to do a wakeup. Hang!
> 
> This example is contrived, but in general I think that the window
> between the cleared mask being zeroed and the word being cleared is
> going to cause problems.

Honestly, I would have been surprised if the initial version was
bullet proof! I think it should be workable though, but we probably want
to clear in a different order. IOW, clear ->word first, and then update
->cleared to avoid someone finding ->cleared == 0 and ending up
sleeping. Even now the race is tiny, especially considering we have
multiple maps.

I'll take a look at clearing in the opposite order in a bit.

>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index 804a50983ec5..cec685b89998 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -30,14 +30,19 @@ struct seq_file;
>>   */
>>  struct sbitmap_word {
>>  	/**
>> -	 * @word: The bitmap word itself.
>> +	 * @depth: Number of bits being used in @word/@cleared
>>  	 */
>> -	unsigned long word;
>> +	unsigned long depth;
>>  
>>  	/**
>> -	 * @depth: Number of bits being used in @word.
>> +	 * @word: word holding free bits
>>  	 */
>> -	unsigned long depth;
>> +	unsigned long word ____cacheline_aligned_in_smp;
> 
> Completely separate note (assuming that we can iron out the race above),
> this triples the size of each map. Does the word have to be in a
> separate cacheline from the depth? Ignoring resize, depth and word are
> always accessed together, so it seems to me that it would benefit from
> sharing a cacheline now that clearing happens elsewhere.

We can have depth and word share, that's not a concern. I'll make that
change.

-- 
Jens Axboe

