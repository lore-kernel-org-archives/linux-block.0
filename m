Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF5C433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148E520882
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XsGUJB1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHSQ41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHSQ4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 12:56:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F2C061342
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 09:56:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so5137298plp.4
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DyPe34DueaqLfEcDqZqm300kn/odPwqy1uJt22bP0Z8=;
        b=XsGUJB1Hdc8az/rXuro1bWhBsdgGdQHjYKQpuunAo8x0WekUdWBNsmSDFJj67GVWVG
         5hPdTKlI6scfsCliWtIOLtIYsVj1YwZaDB5Moe7+6/awpbvAiGHWPGqlMMiQH755AjTS
         vfPiJNDbB+aPu6VjtibhyAOy9LSk3+Tr2jZ+44/eXBtbf+XOZ8K+VQwL9BGEgF8JGQKK
         5KG7zpuu/Xea1f/72jgUaeUpmt4D/ORaIe5NpGI/tYWzxvMEzO/L884n90j+BH7HiH1m
         QMIIcf8a02yI8nCtJ4GjS4kGwrIFsNa8Q8Tri7Y3/f7lv1J5QYlIRrGUMNjHynb2RGMA
         GacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DyPe34DueaqLfEcDqZqm300kn/odPwqy1uJt22bP0Z8=;
        b=IgFnajsQaXJ6vlZNvgIpbCEAr67Hy5Q53D2AB6TzHeF7sTPMMlHiyqPzztr3BBDdyM
         cJqEADK8z9kg8SZjWQu9JC47OEM65uNG0U4ehD7mebu/K79YARdlXzQ+TninEF2HA02W
         cs0z4oqOu1oLFau4DDG5WQGPc0DQCxOGETgLpV1g+9Mb0xCm8JUJfCSV8ZQcr8loO954
         Owso2Ziwx3oBd3OxqhDSrcBFGS2V3S2P/YByfiypbfEKrZz0YVhMZRTgDxoQjDjHUQ9g
         /6gQiL4Zmc3E7voU/cvguIYSATpI4gMtp3Bj5nfsKER0jasaxjesdTvH12t1qUByRO03
         6OBw==
X-Gm-Message-State: AOAM533CLwo9/4VCKvyvhvXUT5eK5zjkCqMrfHc5p2kkD30KUU/5b+Y3
        ELlvbIIgwRS2wUdYbToZL8vh5A==
X-Google-Smtp-Source: ABdhPJwmU9GVpeA/a5GSwGnni05DgMGKqd87OvDU6WClq1X+wlrKxKnBzQboSPP7uq4T48DrxExHZQ==
X-Received: by 2002:a17:90a:f2c7:: with SMTP id gt7mr4669042pjb.204.1597856175023;
        Wed, 19 Aug 2020 09:56:15 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w23sm25765910pgj.5.2020.08.19.09.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 09:56:14 -0700 (PDT)
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
To:     Allen <allen.lkml@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com,
        stefanr@s5r6.in-berlin.de, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, sre@kernel.org,
        kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com,
        mitch@sfgoth.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, devel@driverdev.osuosl.org,
        Romain Perier <romain.perier@gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
 <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
 <202008171228.29E6B3BB@keescook>
 <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
 <202008171246.80287CDCA@keescook>
 <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
 <1597780833.3978.3.camel@HansenPartnership.com>
 <f3312928-430c-25f3-7112-76f2754df080@kernel.dk>
 <1597849185.3875.7.camel@HansenPartnership.com>
 <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b1a5987-9b54-d63e-b3da-d3024505776c@kernel.dk>
Date:   Wed, 19 Aug 2020 10:56:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/20 9:24 AM, Allen wrote:
>> [...]
>>>> Since both threads seem to have petered out, let me suggest in
>>>> kernel.h:
>>>>
>>>> #define cast_out(ptr, container, member) \
>>>>     container_of(ptr, typeof(*container), member)
>>>>
>>>> It does what you want, the argument order is the same as
>>>> container_of with the only difference being you name the containing
>>>> structure instead of having to specify its type.
>>>
>>> Not to incessantly bike shed on the naming, but I don't like
>>> cast_out, it's not very descriptive. And it has connotations of
>>> getting rid of something, which isn't really true.
>>
>> Um, I thought it was exactly descriptive: you're casting to the outer
>> container.  I thought about following the C++ dynamic casting style, so
>> out_cast(), but that seemed a bit pejorative.  What about outer_cast()?
>>
>>> FWIW, I like the from_ part of the original naming, as it has some
>>> clues as to what is being done here. Why not just from_container()?
>>> That should immediately tell people what it does without having to
>>> look up the implementation, even before this becomes a part of the
>>> accepted coding norm.
>>
>> I'm not opposed to container_from() but it seems a little less
>> descriptive than outer_cast() but I don't really care.  I always have
>> to look up container_of() when I'm using it so this would just be
>> another macro of that type ...
>>
> 
>  So far we have a few which have been suggested as replacement
> for from_tasklet()
> 
> - out_cast() or outer_cast()
> - from_member().
> - container_from() or from_container()
> 
> from_container() sounds fine, would trimming it a bit work? like from_cont().

I like container_from() the most, since it's the closest to contain_of()
which is a well known idiom for years. The lines will already be shorter
without the need to specify the struct, so don't like the idea of
squeezing container into cont for any of them. For most people, cont is
usually short for continue, not container.

-- 
Jens Axboe

