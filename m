Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13DC4332F
	for <linux-block@archiver.kernel.org>; Sun, 20 Nov 2022 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKTWGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 17:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKTWGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 17:06:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50235C76C
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 14:06:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so9545349pgl.11
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0idfX6KupPrFGXcCTOIXJvk2AfpkvRYBa/fQjACwmc=;
        b=MZ5qhxs9MXjQ5YZZdVSBYmrkNgNAPrGapIWxcDDnDLq+Foqr5WfBpTCQxelD1a5Aod
         aC7ZuxYIvnyObQkGC236tD18Al/Gbf4wjef+ZmAJwrAqQ/98TMQAyoLbjNI+cpwImtLo
         0tVek23YKSEA+a14hajSzbajF/K58ZkQXHCi3leppNiNq6EedleO2GxCtbQDiS92BFQb
         CA/kk2rZmpTU3fCHVoHKrpVkHE5YG/BDTvrGI4Htqs3ZmBF5Ld9h4TnRP/Gn9jLCy+OF
         0EMiETb5siTFNhyXkp5w1D15LpNNbdAOehPItYKUwex0D1LyweFR3Za9rX0Z6cntesuR
         ZDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0idfX6KupPrFGXcCTOIXJvk2AfpkvRYBa/fQjACwmc=;
        b=WD0zGK3HW0e80ZAYQ0UC9M7I5uNbcBZWYA+B12lUzmoff4vTdoHaU+zFnajxuabDOf
         BssNgvn/UQbRLjSFwQYu9U65j0PY7pBJ9j3ik30sw+y79Yog9UPDVKYLd9a+9PEylnbf
         p8askC67y2nfBdt3AP/iaxXmiDfjvBPXNTehjznOzILR1mU/eRER0RHpS9Wo2gYoVOh2
         vktIgnFDHWoBisPxGX1Lx5d7WlLYmY03vEeVNzQDzotzk7YbaTZKxkpIjVHVxIgWTJt2
         4o1pdqW7cbm7iFrgP+nV5vh+bK5VW+3Brr52h2UbRkrg/+yggjsRcqPpFtL9r9mqNOV4
         F/SA==
X-Gm-Message-State: ANoB5pnlkIPbYGnE2RcqtagfK2l8+etmaYFNu1082hkxcXVJ6cR7FVHE
        kirq3vdO7q00cHI/xVwvZnG+yQ==
X-Google-Smtp-Source: AA0mqf6znd4GOY3Sb6QU+oPDLaIHVqTWn/P/d5FQP3pAQ1XAbaN95EgkwcWOmUGTZJdvqW7mhxqoXw==
X-Received: by 2002:a05:6a00:21c8:b0:562:e0fb:3c79 with SMTP id t8-20020a056a0021c800b00562e0fb3c79mr17415895pfj.39.1668981978460;
        Sun, 20 Nov 2022 14:06:18 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a4f0a00b001fe39bda429sm6318020pjh.38.2022.11.20.14.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 14:06:18 -0800 (PST)
Message-ID: <e2565d52-e75f-0320-6136-97b7953deda2@kernel.dk>
Date:   Sun, 20 Nov 2022 15:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V6 8/8] block, bfq: balance I/O injection among
 underutilized actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Davide Zini <davidezini2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-9-paolo.valente@linaro.org>
 <PH7PR20MB5058FFC62E46AB2AE3AB0F38F1019@PH7PR20MB5058.namprd20.prod.outlook.com>
 <FB99E53F-886D-4193-9B38-32452E70A35B@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <FB99E53F-886D-4193-9B38-32452E70A35B@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/22 12:29 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 10 nov 2022, alle ore 16:25, Arie van der Hoeven <arie.vanderhoeven@seagate.com> ha scritto:
>>
>> Checking in on this series and what we can communicate to partners as to potential integration into Linux.  Is 6.1 viable?
> 
> Hi Arie,
> definitely too late for 6.1.
> 
> Jens, could you enqueue this for 6.2?  Unless Damien, or anybody else
> still sees issues to address.

Would be nice to get Damien's feedback on the series.

-- 
Jens Axboe


