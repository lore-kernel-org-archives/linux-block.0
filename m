Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879CCC433FE
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 15:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKEPU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKEPU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 11:20:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088F20187
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 08:20:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so6869490pjl.3
        for <linux-block@vger.kernel.org>; Sat, 05 Nov 2022 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s38vWwYYX2y546V50u15z++E+mYl2BBKlENn8a7JkAo=;
        b=xjrhbtCEQ7zi19qp7WscPoMQFmuuepai1qEr6tH87LKPSBuDArDVPtCmlZ4aPiaPG9
         Dc5U6M7fi5Az5vXCbS3s/TiCythTyGNeE/40zr3S9zezhN7Jl1OgAFhVA9gXkHUyZZOQ
         Fp3r8ObhpXELG+sGJJYboYU7jcDGEk2pzo1LMlJvjSo9fP0aSzdN/Jg7KJb2gJ5RLHOn
         +WqTMrTuJBvTOTrhzdLB1xQolSN48jB89+aVUeujidmq9FsYH01Q6XUGUqklDENrpvgg
         x0zTMAeApuAcJC7GlU9EmaqHbJ56O8A4Z9C4LinMP/SiJmFtZYnfNX/el3xL995B9MSb
         HcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s38vWwYYX2y546V50u15z++E+mYl2BBKlENn8a7JkAo=;
        b=XhISeLZwlwVVWZsnpC0LdO1HAUDyFES8I/6kCAn47BILBZviHBDN8XpILPKgDs54JB
         6avd1DE+XRnATpmicNECOzSy0Y3YZI/E/uZi2HNYWav1DkYNPoXiv/wqJkfpGEHaDR9d
         DvSOexDCHvmy1NTjL2xUkGAh/AuGhTqUUqyWVAZKL76O6FjwVcDTrdySn6huj0CDJ9ng
         RiK+oRBNtXqNJ6cN+hxym4q+p28YE1wD3pzLlOLuTF7E9AvTAreDKLv0wjJUmq8VbLUT
         TKcoyi1GU72/YfIpIwMamIywc79yPFctZKRdFJ6Hw8RXCMDQnZ7X/oQ/QEgXaW9N8V7s
         S2gg==
X-Gm-Message-State: ACrzQf1nl0lVrqpRugQ+p4tnc8lgktjyKkTPczzXQEFh30bDdMvvDMEh
        Od5ZB3CfLskObgSgVw0LvaaaiRht1zEViAN4
X-Google-Smtp-Source: AMsMyM73TsVCu6Fz4bBIRD5vir6gldEVi3Ttrw6t3Ca1ysCIN3L11vfE+G3InH8PK/06xeQo0xeBBw==
X-Received: by 2002:a17:90a:d901:b0:213:dc98:8b0d with SMTP id c1-20020a17090ad90100b00213dc988b0dmr34154537pjv.11.1667661626869;
        Sat, 05 Nov 2022 08:20:26 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b0018700ba9090sm1810248plg.185.2022.11.05.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:20:26 -0700 (PDT)
Message-ID: <fc438fc1-213f-8203-ffc7-f88600030fc4@kernel.dk>
Date:   Sat, 5 Nov 2022 09:20:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next] block: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221104062014.62656-1-yang.lee@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221104062014.62656-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 12:20 AM, Yang Li wrote:
> Remove the description of @required_features in elevator_match()
> to clear the below warning:
> 
> block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'

I'm guessing this was introduced by the recent series from
Christoph? Can you add a Fixes tag?

-- 
Jens Axboe


