Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10765C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7900206B7
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iFzhghGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7900206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCWUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:20:15 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:32959 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLCWUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 17:20:15 -0500
Received: by mail-pg1-f171.google.com with SMTP id z11so6376002pgu.0
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 14:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6onoalcLzZl8DXFeRRa0wid6N+kbEzHhJ0pRtO2wNU=;
        b=iFzhghGblStO7TOF0JPFofh4COMPw0wQLeGQIhxIGIZ53A94+EXUPydiDiBrgsCUs+
         54kVou/iLwlMxTGFP8leW7oEo8opm/tzx5aEuiVVZ4nb/HIT/02VxkkukesJHmu8BIDQ
         dyizqVCCJe5F7taTjC4Yi8uzy+kb+GbMxMKDt5CnLDbXeujdGsZd9YiFcpZi1p7n9B4k
         X7KkXdXloBv/ulcP9jWNBMYA5moxRcBtGzCsqfUIYUBe+KIFD9vLAaG3VFOM5g48kgHL
         fPfOARfpwx2oDPf4PN+dCCAi9Tl6fykyv2yuz+c+RHEdQ2H9g4my13ChPWK9NOdGkeZN
         F01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6onoalcLzZl8DXFeRRa0wid6N+kbEzHhJ0pRtO2wNU=;
        b=XRUptac5q2I/giJmUYZy3v8HYElGNngGEAJYk42q8Wg3v2DglYGvJjVi3fIIl15BHG
         2mNcn181CPSCPrlkZny+c0TebEqk1Ar/6iNpzXh9BvOLkzsLRJxIYD77/FxaaEyNYT5b
         u6jLtALkO1lNLyHFWHb+ZK8KpNPkzcD1XKvZR+aKBhV4kJ3+L51sdurbja4k+Ol1QeLS
         pcmzrOyeYE5fF2nCgcDNfIsinWn63ypEXUFsX4njVKtsN+l37jB8O5r/Av8jQT0MKYWS
         nblFtdWOTgumimUyHrkhBOpgGJ6QaHvmv71L2NsrZ89iS1PdYOtgJffnMt/cemdpaTe2
         3RXg==
X-Gm-Message-State: AA+aEWbOYwxYU+jPAeCXka8E5VNY1obO+XGILfsyYOD+QDC4g6Adg34M
        FKQDICIumiyThj3y7bdqm57f5oOFN1Q=
X-Google-Smtp-Source: AFSGD/WhFJK4TSl0Gws6b+moA2ZOguD6WtTJLfSVHB0SGa/zR1Nfo0XTS+QTMQFfTcKrGrAjBMBdUQ==
X-Received: by 2002:a63:165e:: with SMTP id 30mr14713677pgw.103.1543875613455;
        Mon, 03 Dec 2018 14:20:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::106f? ([2620:10d:c090:180::1:94b1])
        by smtp.gmail.com with ESMTPSA id a90sm27992727pfj.109.2018.12.03.14.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:20:12 -0800 (PST)
Subject: Re: sbitmap: check cleared bits when iterating busy bits
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <8bde3953-56d8-32cb-2c34-582d632f4a3f@kernel.dk>
 <20181203220517.GD11220@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <028ac9e9-18c7-c38e-8649-2663b2fe7160@kernel.dk>
Date:   Mon, 3 Dec 2018 15:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203220517.GD11220@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/18 3:05 PM, Omar Sandoval wrote:
> On Mon, Dec 03, 2018 at 02:56:17PM -0700, Jens Axboe wrote:
>> When we are iterating the set bits in a word, we also need to factor in
>> the cleared bits. Don't call fn() unless the bit is also not set in
>> the cleared word.
>>
>> Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index 92806a2dbab7..9f374fbcdba6 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -283,6 +283,11 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>>  			nr = find_next_bit(&word->word, depth, nr);
>>  			if (nr >= depth)
>>  				break;
>> +			/* if set in cleared, it's actually free */
>> +			if (test_bit(nr, &word->cleared)) {
>> +				nr++;
>> +				continue;
>> +			}
>>  			if (!fn(sb, (index << sb->shift) + nr, data))
>>  				return;
>>  
>> -- 
>> Jens Axboe
>>
> 
> How about something like this:
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index f0f49bbb2617..fe9122386255 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -265,12 +265,14 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  	nr = SB_NR_TO_BIT(sb, start);
>  
>  	while (scanned < sb->depth) {
> -		struct sbitmap_word *word = &sb->map[index];
> -		unsigned int depth = min_t(unsigned int, word->depth - nr,
> +		unsigned long word;
> +		unsigned int depth = min_t(unsigned int,
> +					   sb->map[index].depth - nr,
>  					   sb->depth - scanned);
>  
>  		scanned += depth;
> -		if (!word->word)
> +		word = sb->map[index].word & ~sb->map[index].cleared;
> +		if (!word)
>  			goto next;
>  
>  		/*
> @@ -280,7 +282,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  		 */
>  		depth += nr;
>  		while (1) {
> -			nr = find_next_bit(&word->word, depth, nr);
> +			nr = find_next_bit(&word, depth, nr);
>  			if (nr >= depth)
>  				break;
>  			if (!fn(sb, (index << sb->shift) + nr, data))
> 
> Might be marginally faster.

Yeah that looks fine as well, tests out good too.

-- 
Jens Axboe

