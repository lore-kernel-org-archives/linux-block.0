Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A298BC10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD6820896
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hl/hDP1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDGTib (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:38:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40579 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTia (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 15:38:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so6311062pfc.7
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HkaVehFig8o7l5a8m8wW/JR7z1NrJPJwcxryFfM82dM=;
        b=hl/hDP1gM3zoyWq4W0b37djQXN51tfAVD3AkbYA7oL6yfXPc0W33nAmPCWsUee+e5Y
         M+zI1bQ+0H6ivUcwYNjQg+7zGMkR8zBArPukIrWwytvImpQvnwmgDLQ7mDhOyiVzKxGF
         MM/mGfbI6MmsgIMvbdsMxsgd/IesOIUspgtwE1RQW8BF+MQ48JpWf89+2mnPQbvkKeHC
         oJVBGPftBZ/WIRF/MnYwQ97q4FD5eEG+y9rW+stgjH1iZJmL+BHRSGQqk4uQPWgTix3F
         6sOeRrSIztV3w93AInO0/h7amAy2kN1Hno2C7Sy0hPaWUfEqymBdggi8fbNgV/XNJpdm
         MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkaVehFig8o7l5a8m8wW/JR7z1NrJPJwcxryFfM82dM=;
        b=TQiYN5QBT8Yd9njCuBg7wYbxzZYLcSwtsAlSXbJmIxW6gM5DWAE69QDWOEHwyutMwe
         EH6HNpqftFIuJqGl48X5CgZD9N/LNUJA8yEFPjkR2EVQpfSMdlvdbgKgu3pnOZjbakwM
         3H9o72Ur3ixMrmJUidE8vzQnbbGDf9qM9u8vhzJLwhsGvz+Zb6Boh8VqZY9acwHIPZfF
         v7AZbm5qT2lBeXN0Y456uKDdCr6yin4qArNXCee5dkSpJTH3pM7JGlEAjsw+FH755Dc7
         G5r8qd8o6u1Oc/vfdg+laIXP1E9RVZD8mcSfV4ifI9qm5rzPVwFdWH4osiQXsoMN/G6X
         Olxg==
X-Gm-Message-State: APjAAAVUo2hR36ahfHfV7JH+KZUU4QyK1ToKDXp1mftAI+boTqAW7857
        aGf+wlfVzCSXN8OJuBYEvMIH41pfVNbhog==
X-Google-Smtp-Source: APXvYqxObvqSajn59JKri4uAaEiZSaZexlIQ2jmmt5Qy7Fzg0I05ut2XVSgIG/0hjpJSXkfMFlBNHA==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr25402528pfc.119.1554665909646;
        Sun, 07 Apr 2019 12:38:29 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j62sm21454665pfg.6.2019.04.07.12.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 12:38:28 -0700 (PDT)
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alex Lyakas <alex@zadara.com>, linux-block@vger.kernel.org
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
 <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
 <20190407075651.GA23397@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0e5ec7c-08f2-f2bb-911f-cc1e4e5ef853@kernel.dk>
Date:   Sun, 7 Apr 2019 13:38:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407075651.GA23397@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/19 1:56 AM, Christoph Hellwig wrote:
> On Sat, Apr 06, 2019 at 12:58:54PM -0600, Jens Axboe wrote:
>> On 4/6/19 7:03 AM, Alex Lyakas wrote:
>>> Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
>>> "bio: skip atomic inc/dec of ->bi_cnt for most use cases"
>>> made __bi_cnt dependent on the new BIO_REFFED flag.
>>>
>>> bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED flag.
>>> But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
>>> needs to preserve this flag.
>>
>> Looks good to me, applied, thanks.
> 
> Uh-oh.  While this fix isn't wrong per se I think it is confusing and
> set a dnagerous precedence.
> 
> We have BIO_RESET_BITS to indicate which flags survive.  So any flag
> that is supposed to survive the reset should be be added to that
> instead of specifically worked around.

That's a good point. I've pulled the fix for now, Alex would be great
if you could re-do with that in mind.

-- 
Jens Axboe

