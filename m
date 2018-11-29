Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA7C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0513221019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ou9xwDAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0513221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeK3Gum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:50:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35417 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3Gum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:50:42 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so5621815itp.0
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3f22TmXnCAKR0Z44hsLr5pvxzpJLkrazGFIHM93eE8=;
        b=ou9xwDAplZU7SfdfSUeXPDFOV7XyLkwP4vhaJ3EuyO//bfOqRO6MlWwoR91y1ML585
         irQlxLa60WpAWC1BDrdO8TK7xNz+73VB0h2UpKESsnJ7ygkA3/8C/Uz/05Q4oyy4wIWc
         HudPLTDW/CothJS5gRx487ciZgQtXEoYb/OtoTWUbkohS0XSXXKT0gEUXODXqQJYZYRe
         HS/6HPTpg6QhgJyv//uLQVruJ2rd/vUBkUEFt/SIdyrG8DH0Wb7Pnkn32F+6NZBKZWWy
         Gs7OTNmorziT/8tez2RyhHOrkYHbyShBuWIa+gXE0L6932NZBcEbwzKjXVu+IOQt+Q2H
         aPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3f22TmXnCAKR0Z44hsLr5pvxzpJLkrazGFIHM93eE8=;
        b=dURIvr8CdhtcvFCiuaIMsePMCWcwslckerq4VpFdwIr/DVcZkcSzyBVONLpFWLzs13
         ajK/SCD5MDr1TwHoWLgVCkg6jtZx2koTdpNTzpDc0HbjRk5v+ktbFfKDp+z4LwfikWVL
         3Z+HiLMyPbeoOYC5pIL+R1eQFNC3l0ZrqioMA2/hdKj7IUQfjBFSpEMY+d1uOcXnaej9
         PLaeeslS2pDZSB/Oclf7eBRH+j+y8zGR4PwpZvKY57vKwrT70SicmRje1ZEVgy3nGl95
         CxXXRknc4mhyJ4DY+w4/FWCDYt+ME5Xd3EHC8LAj1ammaFdzw0h1j2zXSyrVkb1KhCre
         VEPg==
X-Gm-Message-State: AA+aEWYuoovVVIiNFW1bgX3R1GbPaha3BtZy2IaSmC2QeKKn3+YyCxJz
        i2JasNQ3eqaBrgtWNAGgFneT6mzMSAQ=
X-Google-Smtp-Source: AFSGD/Wy45h2OHxVfRvlEvVs2jQ0xPdnpg+ewhTc5cZg7XyliDbJlxUfk1kUqlXiDQxfkPGUgTfppw==
X-Received: by 2002:a24:4d05:: with SMTP id l5mr2772729itb.147.1543520648781;
        Thu, 29 Nov 2018 11:44:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x99sm1430592ita.23.2018.11.29.11.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:44:07 -0800 (PST)
Subject: Re: [PATCH] sbitmap: don't loop for find_next_zero_bit() for
 !round_robin
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <de7c5294-7f97-6fa9-9729-66992a58a1db@kernel.dk>
 <20181129194236.GA21082@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <627d7320-dcd5-43c2-74ae-72fbecf951c0@kernel.dk>
Date:   Thu, 29 Nov 2018 12:44:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129194236.GA21082@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 12:42 PM, Omar Sandoval wrote:
> On Thu, Nov 29, 2018 at 12:34:12PM -0700, Jens Axboe wrote:
>> If we aren't forced to do round robin tag allocation, just use the
>> allocation hint to find the index for the tag word, don't use it for the
>> offset inside the word.
> 
> Maybe also add "We're already fetching that cache line, so we might as
> well check the whole word."

Sure, will add.

>> @@ -130,12 +139,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>>  
>>  		/* Jump to next index. */
>>  		index++;
>> -		alloc_hint = index << sb->shift;
>> -
>> -		if (index >= sb->map_nr) {
>> +		if (index >= sb->map_nr)
>>  			index = 0;
>> -			alloc_hint = 0;
>> -		}
> 
> We need to set alloc_hint = 0 here for the round_robin case.

Good point, does need a reset for the loop for that case.

-- 
Jens Axboe

