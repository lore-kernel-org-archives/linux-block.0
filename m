Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED67C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 18:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhLWSdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhLWSdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 13:33:24 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA91C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 10:33:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y70so8249231iof.2
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TtGTsDOS1sv5VjAapnrKvw759mjru/5vHNygb4N0eQ=;
        b=JdTfLfrrGmDFScx/OQtMg7HYOPFuDdER34j5YkQsfD8NbSnAoJ1auYNe74thKI8HBQ
         ixj/9ym6KBf9zWCPoJpdIrjJXHgoNLqR3YpOacJNUxkGWkbUITQwybiRXtKaBfaoK3dn
         NVQMirY+aGB/9jMjOoxYati/9ByK7hxJm+NXHIunrT8yEz0vvGNZklxJWFdyj9FuAP3G
         hpn+pJu/VLfAoFePe4Ssyq8QHshR04SYAJmiz6FcYRUzD4kgsc3EZoVuJRNCLInH0DZz
         1WDYaA40WPxL2iNUKQWTNLetZY8u3r13e5CqC//HrRX6+yo97z/FOQmvUb/Va0GFby59
         ykRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TtGTsDOS1sv5VjAapnrKvw759mjru/5vHNygb4N0eQ=;
        b=bC4mQycr1abeF6T992wFQbASq34ow2z4OaQxknBXSi4VFXS5B/88ke8K37K/k/+6y6
         BWP3GDEB7v224UK13/GZGYF38/BGKvcccOtiP567xYXcU5BUcWKg/OngJtjmRnD4vQYo
         kyHHDMooz1As9IJc0J3Ag0kx+/ZgAN5+xU/hnpHJOk8M4jdDllQ2Ke0ikWgMIeUZ/OeI
         n5mcirT45/2z2bhaYvfZ3qp68UlvRttXDiYa0K/ao7sNWMjfJVn2zyjI/fRsNIKrPUZg
         wHAr2mKUmXSoo6dlyaT9WtS+KM9CetgLaSMd68aQ8iXpjQGx+gHed1rvLYm2PPcQqJPG
         Jk2g==
X-Gm-Message-State: AOAM533JNJKAzr0U/uh+p+bNEEIjIR+1HexHJ5Jb3Y+gL4Tm+D5bYt7q
        a3cdWbIwwvVjKjHWzpqRNnJ0wA==
X-Google-Smtp-Source: ABdhPJydAZ45WTRPq5+RzQwSrvcrY4VGXEmM5jOIltHvqumauXgrJtdp1sDGKNOJCQQ5WH5IkXgfzw==
X-Received: by 2002:a5d:81d3:: with SMTP id t19mr1829959iol.199.1640284403854;
        Thu, 23 Dec 2021 10:33:23 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a12sm2953694ilv.69.2021.12.23.10.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 10:33:23 -0800 (PST)
Subject: Re: [RFC] remove the paride driver
To:     Ondrej Zary <linux@zary.sk>, Christoph Hellwig <hch@lst.de>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org
References: <20211223113504.1117836-1-hch@lst.de>
 <202112231829.25658.linux@zary.sk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4f88a1e4-1bbb-1c32-79dd-389f18cb3fa4@kernel.dk>
Date:   Thu, 23 Dec 2021 11:33:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202112231829.25658.linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/21 10:29 AM, Ondrej Zary wrote:
> On Thursday 23 December 2021 12:35:03 Christoph Hellwig wrote:
>> Hi Jens,
>>
>> the paride driver has been unmaintained for a while and is a significant
>> maintainance burden, including the fact that it is one of the last
>> users of the block layer bounce buffering code.  This patch suggest
>> to remove it assuming no users complain loduly.
>>
>> Ondrej: you're the last known users, so please speak up if you still
>> have a use case!
> 
> Looks like I really need to do the libata conversion.

That would indeed be great! As mentioned in my reply, I don't want to
remove drivers that are actively being used. Is the libata conversion
something you are going to do, or is it more of a dream at this point?
Ideally we get that done first, and then remove paride.

-- 
Jens Axboe

