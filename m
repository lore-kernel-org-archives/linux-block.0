Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13619C28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 20:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiHVU4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVU4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 16:56:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186D48EB1;
        Mon, 22 Aug 2022 13:56:15 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l64so10499452pge.0;
        Mon, 22 Aug 2022 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o7/x0hwIETeQ+szcjDZb17kzpt4rvh/NFpHMX/eX9qo=;
        b=fqjLpGGu0jPpMgGfHkmfUqn1+MhBTI6xny0mx2rZNTHq/bWCpancj2z0nkwyF/jSw3
         LE34ClSb0b6s+lHZpM5qzk0UA4d7VYyIVR+uRZPwy73RMbrYSFo4/fnXk3WYi1C68lzi
         xMIqfbEtbr02ul6udeJ3FlS8C/QY+FnQwhFy4T+ke1pFUyV/vp6X84ZE4eA/Ix33jzMU
         OQ5yhXV14ZCs3oXdDOBueNcFx7r147VPBV0b1L98DoDwWPFURh2Z+qko4HZcBPh9gBj+
         UJoMSaUdziFkY+aUhT4yy8+smJgUso29KyxK7t5ir0e0w880rwVjoNozti3Eu28JFDoR
         snCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o7/x0hwIETeQ+szcjDZb17kzpt4rvh/NFpHMX/eX9qo=;
        b=WoazsjU1X9qnlJv8jZYp1mL8cWWI2IKV64TQmdVLRj6CVU27FfSWry60lcSHFEPzkd
         h6+MXQAuoUIWurj+5gGlX0vXag88UuqfHcIsVylUkF6K/h75HoqmNEcW2+M66Jj5UKzU
         c8aR9i2pQhVmaNdi+V736RnUUoK0zIzK5mpXuAXaoIWTvGQn+ScDHKn6AJgWbY4qNFsg
         He3UFKk+spzlW0qx5Qc90qDoByoFu3z0EjMzF8w3d/z2r/n7UDUA6clZT1NdhOOXvTJ2
         0tapAoxns7WDOeI/7++WvXqBDI5ekHUEpnjaHwZt9SW2mzKf4bgkdy7f6tG0+ZHCqC0S
         tUEw==
X-Gm-Message-State: ACgBeo0JQee3FPYS0e/ZvwkPsPEvkMJlZmS33EkJnDTGkb3cepZcyc4p
        TTuvJRiSqPGDD4vzlrkTF9w=
X-Google-Smtp-Source: AA6agR5J9WqUVdMGUwHEzscB5wDWztHi6mpmnRrNOf9ImGzDYDbuyHl4DbfYjxxVZTsD6NjHY+xEXQ==
X-Received: by 2002:a63:89c6:0:b0:429:a28d:7b4 with SMTP id v189-20020a6389c6000000b00429a28d07b4mr18123655pgd.42.1661201774453;
        Mon, 22 Aug 2022 13:56:14 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:642a:8878:46a3:c3df? ([2001:df0:0:200c:642a:8878:46a3:c3df])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b001714853e503sm8809100plm.36.2022.08.22.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:56:14 -0700 (PDT)
Message-ID: <2b924d0b-f278-e422-2a2c-f149265dcf9a@gmail.com>
Date:   Tue, 23 Aug 2022 08:56:10 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
 <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
 <2669426.mvXUDI8C0e@lichtvoll.de>
 <6fa2c159-e7c7-2d2c-04b5-54c2b2c9a24e@gmail.com>
 <023b3e08-8782-cde9-4eda-ea419d461bf4@kernel.dk>
 <3aca03ae-f01f-962d-b552-d6efd1cd47df@gmail.com>
 <cf6a3edc-7f9c-7a70-23b0-edf43769d994@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <cf6a3edc-7f9c-7a70-23b0-edf43769d994@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

thanks - the Fixes tag in my patches refers to Martin's bug report and 
won't be useful to decide how far back this must be applied.

Now the bug pre-dates git, making the commit to 'fix' 
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit special, 
please yell if you want me to lie about this and use a later commit 
specific to the partition parser code.

Cheers,

     Michael


On 23/08/22 08:41, Jens Axboe wrote:
> On 8/22/22 2:39 PM, Michael Schmitz wrote:
>> Hi Jens,
>>
>> will do - just waiting to hear back what needs to be done regarding
>> backporting issues raised by Geert.
> It needs to go upstream first before it can go to stable. Just mark it
> with the right Fixes tags and that will happen automatically.
>
