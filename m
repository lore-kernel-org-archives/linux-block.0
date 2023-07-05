Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D6EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGEVln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEVlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 17:41:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE561997;
        Wed,  5 Jul 2023 14:41:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b7e6512973so41723635ad.3;
        Wed, 05 Jul 2023 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593301; x=1691185301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/lVj5gPmLURUZ8+Mv9X8G+CA35E2AqNq3uoTksdsmo=;
        b=se6Q/2OFylpAzxdlY63CpoSHnjhghpfMulQTChEuQFiyZbU77WZ0CRJGarEVGsedFD
         m92ZHT7CGIwiEdAAq/fcFdIkBPROS2TizGtUhVlIfwupCdwTsAawMRdZ1KkpJRnpSu88
         8Py7MEDlvtXh3oEPyCAVscTRM+qM++Gy4K1cAQ6n5jwkWqLKHf+JTGoaVeyFyx30sTga
         R+XI5zb66s/J61c0tsLfAMrWyDoAR9wsKrS3CXSojwelSJLL3UG2BQcfUbUIZ/waR1nZ
         Dv6EjrBaD3UrlAKoOcKhpr74ctfvNElfDoycwC+A7qIIAuz9jWnIj6SsXCQtTJbPNtCh
         AaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593301; x=1691185301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/lVj5gPmLURUZ8+Mv9X8G+CA35E2AqNq3uoTksdsmo=;
        b=QyAPar29QKSGYcXP2DXbUsKtRlcahh9z2r/PAIIa4hWAjnkASBVL52rjL6lwoYpuW6
         q5vw4+te0lHHdt1qIOqMYgZ0Gab66j3eyaeolqk4CqbMW0qoLHZZ4cIXyAeYmoRTzwhP
         UQfSeixumjsrPc4mNEre6aEi9glUqIpBZ2aZS/iZ5B/jEnQBZgcN186rlnJtf7Q+ILGj
         KlSWwPgaJ3dCltZClBetUKrNK6MfK04U942dC103j9MarRW0MYNlOzph9Oo2hMEi0oE4
         +jGHk3B02bVaZdajpOWCislPwpw7cwtDGMD8vTMAA3ZkR8tIYAmh1oE7wZN5USU7dMD6
         Vk2g==
X-Gm-Message-State: ABy/qLZ7BuhkLpqZ3ivjJq0c0+tBGKMOZgWeKJjKnsdvn8Z2sveS+zDX
        yjmBsYLoClfhJ17as+foEJ4zgUpWBOs=
X-Google-Smtp-Source: APBJJlHJfLE07Mc6m5LBHzBExI92j5OITt2lwzeyfN8mEXDhg/2rmU7pqDrcK+8wLH7x9JS3ttd56A==
X-Received: by 2002:a17:903:120c:b0:1b8:76d1:bdcf with SMTP id l12-20020a170903120c00b001b876d1bdcfmr206396plh.23.1688593301407;
        Wed, 05 Jul 2023 14:41:41 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:65c6:1730:4701:8c0b? ([2001:df0:0:200c:65c6:1730:4701:8c0b])
        by smtp.gmail.com with ESMTPSA id n22-20020a170902969600b001b89b7e208fsm5550849plp.88.2023.07.05.14.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 14:41:40 -0700 (PDT)
Message-ID: <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
Date:   Thu, 6 Jul 2023 09:41:34 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 6/07/23 08:42, Jens Axboe wrote:
> On 7/4/23 5:38?PM, Michael Schmitz wrote:
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>> Cc: <stable@vger.kernel.org> # 5.2
> This is confusing - it's being marked for stable, but also labeled as
> fixing a commit that isn't even a release yet?

True - but as you had pointed out, the commit this fixes is set in 
stone. How do we ensure this bugfix is picked up as well when the other 
patches are backported? Does that  happen automatically, or do I need to 
add a Link: tag to the patch being fixed?

(Greg didn't seem to object to the Fixes: as such, just to the incorrect 
version prereq)

Cheers,

     Michael

