Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D5FA3741
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ1OLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ1OLc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 10:11:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647337F9B
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 07:11:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p184so4611051iof.11
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGB0yLuP8CITE3oAOA1XPVmKhjSqbWLjvxAfBGLgZKA=;
        b=0z66opcyZ//OUKHR6i+YUV9zNteirxKzVrdMRkn0+t0luxKI9/P6+kH98WqeYPwWOP
         hd3EIXwncilkJxXhLXlKVfmdH2pDo3lfHq+9bFl3L/Kc/f5ySbf/0zXUGnxYQKqSn5El
         ejjYwTczrw7KnUVP+04ANMYgKqO8pZRJMtT5YoeqqiCfsjqk/zJGUGtpb8by4sNTF5g1
         NT7PUPSDk9/l6OlE+zWWbP8fvgQeQ+goVHsVjTR+ImIICz28N+hGiTJy6RntgiPd9AWk
         9zlKeTWllGAXlQRfjBtK+s2XipUhQ5LxhQ2XSpT9TFct6VqvGtZQMeNUFELFPT87uJIX
         lBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGB0yLuP8CITE3oAOA1XPVmKhjSqbWLjvxAfBGLgZKA=;
        b=FV86HsYb411DLdOBo8GtZCmcynsmV2D1JqYGjqT/Hslh634MeJ3G5FecezNLuQ2kox
         gt0fk5cSFjXT9cPLevhNx2llF/0CfesleSnRMWjAMrY6XHZKN4kr/twYb9s9fLxE1fnx
         V1GABff/2ct2QsU0t0jMvIdIy5Q0AwL3KTXbVt2CJo60D5z+KOZ+e7rsMIWI7h8lSYX8
         sUsDvczKDecpjq97VKJyURXVt0JErYg9ycGm+M60i+HnvzN64asO1m6Zwkin/dNAsuvF
         3Oqh5D3655/Q3yrN8wx8Lhxo0bJxrDJ/jVI1zu4qHErElvkthTbATQYsu0InkMiZZBWk
         7DvQ==
X-Gm-Message-State: ACrzQf0P3wKfSKI/+222fNQ1gnzmOqyt5IrVFBffCGbHGFRNbMLt8gXa
        XKOnN4MDGhxsY3YJE5HFTsZY9A==
X-Google-Smtp-Source: AMsMyM4/5ZopQptSCtSMxaggiFO9t/PzM0w/oOyCZM7WtIJHpTZirom0eWqLcxmWEoYqJZ8S/K7f4w==
X-Received: by 2002:a05:6638:164b:b0:363:de33:99dc with SMTP id a11-20020a056638164b00b00363de3399dcmr38538555jat.117.1666966290311;
        Fri, 28 Oct 2022 07:11:30 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n23-20020a027117000000b00375126ae55fsm1711886jac.58.2022.10.28.07.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:11:29 -0700 (PDT)
Message-ID: <9bb423f8-5910-494d-2522-2fcf8e41c2e4@kernel.dk>
Date:   Fri, 28 Oct 2022 08:11:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
 <20221027111944.39b3a80c@gandalf.local.home> <Y1uSG/7VXWLNlxlt@infradead.org>
 <20221028062414.7859f787@gandalf.local.home>
 <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
 <20221028100656.00a4d537@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028100656.00a4d537@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 8:06 AM, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 07:56:50 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 10/28/22 4:24 AM, Steven Rostedt wrote:
>>> On Fri, 28 Oct 2022 01:26:03 -0700
>>> Christoph Hellwig <hch@infradead.org> wrote:
>>>   
>>>> This is just a single patch out of apparently 31, which claims that
>>>> something that doesn't even exist in mainline must be used without any
>>>> explanation.  How do you expect anyone to be able to review it?  
>>>
>>>   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
>>>
>>> Only the first patch is relevant to you. I guess the Cc list would have
>>> been too big to Cc everyone that was Cc'd in the series.  
>>
>> No it's not, because how on earth would anyone know what the change does
>> if you only see the simple s/name/newname change? The patch is useless
>> by itself.
>>
> 
> I meant this as the first patch:
> 
>   https://lore.kernel.org/all/20221027150925.248421571@goodmis.org/
> 
> Which was what the link above was suppose to point to.
> 
> It's the only patch relevant to the rest of the series, as the rest is just
> converting over to the shutdown API, and the last patch changes
> DEBUG_OBJECTS_TIMERS to catch if this was done properly.
> 
> That is, patch 01/31 and the patch you were Cc'd on is relevant, and for
> those that want to look deeper, see patch 31 as well.

So we got half of what was needed to make any kind of sense of judgement
on the patch.

> But if I included the Cc list for patch 01 for all those Cc'd in the
> entire series, it would be a huge Cc list, so I avoided doing so.

And my point is that just CC'ing the relevant list for patch 4/31 is
useless. Do we need to see the whole series? No. Does everyone need to
see patch 1/31? Yes, very much so. Without that, 4/31 means nothing.

This is pretty common for tree wide changes. The relevant lists need
to see the full context, patch 4/31 by itself is useless and may as well
not be sent at this point then.

-- 
Jens Axboe


