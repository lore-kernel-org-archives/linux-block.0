Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB6EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 01:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjFNBUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFNBUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 21:20:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99087C3;
        Tue, 13 Jun 2023 18:20:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25df7944f60so126591a91.2;
        Tue, 13 Jun 2023 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686705641; x=1689297641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhulmoGSB7sGxWdwqroB3Y8DgLgRBrm8tc2o1GdcU5Y=;
        b=LK0+IzkAVSRqezUYqouIvYxD1ljAeKRr2wrTcT2uo46MNgJI9Y8pcnAtuiazmd3G0H
         w9WUbl+fDcQaAr8NuJsqhOgYEIkozr8onEjnagv8wuyLO1HVH6I/ZOfH7f3wpQ3asDJc
         V9zdWnJjBzMp4hEcqkua2jPhWJRKspAvrRpNL0xzY5FTOQDpn0d2iy4UniFXIZA60GoM
         ATs1hCdPDMeaEmLLPF/E38cjyEcfQUlXMXS6stWh+hYvY0VO9uoQpDr4OOoR3Swbr4x6
         qldb8G2Y4ssdfnGjg6RxLzH5DEGAJYhkSvQNCWIkN7XGMXWDbi92y0uXOUyNXFs+EME0
         oU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686705641; x=1689297641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhulmoGSB7sGxWdwqroB3Y8DgLgRBrm8tc2o1GdcU5Y=;
        b=jO5nlKN4JAnqdjmPPQGuV/aUSltQHPM6TcZgpQLiilsApcj9KFC2yqm/KmAcSdC+L9
         2LNpD2am5O2cK/9/VuS+pjtifJGfEYS1uOsQ+XqmXQ1nbziHfF9whL8Z4fLxZZbnrI3w
         8HyVInKS0TIfslmjZ7yHsfRY21IfcpH7GjD0iEomqsUw39ptgITI/QbrgQR2etYCWvPv
         DOXg9itgZQ+VmjEvXuLp7v+cT5TUXvMGNmerWdrytDYabQqshEcdz5J8ucmT7gYWE4DP
         aejoJv6NkqZa7seeutWe2WKNZjBfBgPjkPyJOryadd0Vflg4dSK0LN6w7Sx9L4ToA3Pc
         urFA==
X-Gm-Message-State: AC+VfDzsQUWs1o2rMtaJMYcfC7dYOIFVR1islnqtvscFM/3qEKyFVCRW
        BnjGS+kTLecgyjylfnX9HXz7JecnTcQ=
X-Google-Smtp-Source: ACHHUZ7G5pBNjieB5ZiRi+IcMF2kbpUJ+zcW86h3EOnprlWdjUF/Jp5EmhynldKcoT6PBoL3pZRzdQ==
X-Received: by 2002:a17:90a:804a:b0:25c:7f2:2e5d with SMTP id e10-20020a17090a804a00b0025c07f22e5dmr425865pjw.13.1686705640941;
        Tue, 13 Jun 2023 18:20:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:ad3e:4a38:ffce:bee7? ([2001:df0:0:200c:ad3e:4a38:ffce:bee7])
        by smtp.gmail.com with ESMTPSA id gf18-20020a17090ac7d200b00250d670306esm9823426pjb.35.2023.06.13.18.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 18:20:40 -0700 (PDT)
Message-ID: <12c29812-4afe-96d7-5fc2-15573ea571fd@gmail.com>
Date:   Wed, 14 Jun 2023 13:20:35 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <4814181.GXAFRqVoOG@lichtvoll.de>
 <12241273-9403-426e-58ed-f3f597fe331b@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
 <437adeb4-160c-38a9-68af-ff4ec7454f5c@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <437adeb4-160c-38a9-68af-ff4ec7454f5c@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Finn,

On 14/06/23 12:07, Finn Thain wrote:
> On Wed, 14 Jun 2023, Michael Schmitz wrote:
>
>> My last version (v9) still applies, but that one still threw a sparse
>> warning for patch 2:
>>
>> Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com
>>
>> Not sure how to treat that one - rdb_CylBlocks is not declared as big
>> endian so the warning is correct, but as far as I can see, for all
>> practical purposes rdb_CylBlocks would be expected to be in big endian
>> order (partition usually prepared on a big endian system)?
>>
>> I can drop the be32_to_cpu conversion (and would expect to see a warning
>> printed on little endian systems), or force the cast to __be32. Or
>> rather drop that consistency check outright...
>>
> The new warning comes from this new code:
>
> 		if (cylblk > be32_to_cpu((__be32)rdb->rdb_CylBlocks)) {
> 			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
> 				state->disk->disk_name, cylblk,
> 				be32_to_cpu(rdb->rdb_CylBlocks));
> 		}
>
> The __be32 cast appears in the first line but not the fourth, which is an
> inconsistency you might want to tidy up. However, both lines produce the
> same sparse warning here.

Thanks for checking that - the cast is redundant as-is (be32_to_cpu() 
contains the same cast already). Does use of (__force __be32) instead 
make the warning go away? (I haven't managed to get sparse working for 
me, so I have no way of checking.)

> The inconsistent use of big-endian and native-endian members in struct
> RigidDiskBlock looks like the root cause to me but I know nothing about
> Amiga partition maps so I'm not going to guess.

The check appeared in the first version of the patch, after discussion 
around the RFC version at length. Going over that thread again, I 
haven't found why that check was added. It's probably been out of an 
overabundance of caution (as I know little about RDB, too) and can 
probably be removed.

Cheers,

     Michael


