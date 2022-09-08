Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0728BC38145
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 14:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiIHOld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiIHOk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 10:40:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FD61702
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 07:40:56 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y15so2077539ilq.4
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pZDBeWxSoDaW9so+HKgnIStCCw0Inuk1PaP9mjbSPow=;
        b=dN8iGrQe1i0lBn6Y/EIQeR0beICKZxdPQWHi42MzhW+7/ssMDVDQtIOep6pl0p4qeQ
         qtgUs8lbdMrSTREUL0HMXP+7THi9YfX52Uofgfnvu1eqAQ/7yPh3Sfi2zfBF6JBhbyWv
         4FNafl8cGUipoIJvwyowSaJmsiWMmfB5YVSV0MvBL80VEDkcsF7XehPvoHtaM/9xFsNO
         qlti61PQtsC9J8zZ80yyrDsDqSshoZ8Lu42oB2i45Sc2YYmRFxtIW7sdM/FhpaNABUGh
         mfsBTPc0ciffdjRhqgqiMDTtxXhY8e5IesWDyNEtfpLpPIrWuvGzB5SkudT/INEzeuHF
         2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pZDBeWxSoDaW9so+HKgnIStCCw0Inuk1PaP9mjbSPow=;
        b=gVynGGccfY/vi2dAQee5RvLUaTxlwCEakCJhOcDAGrm9ECNkMFoYrKtI1zvwQx1IsK
         SRwfts9alDG0E0xDP2S0IrZEEX2kjb6P+KmIS8A7DwXgsSkAVVIE3vzBpd+50ST6Lana
         A22bv1aYJ8lem6hJurJKHSHQieDpBfh+YaLQc8pM3dEyN98GwZecIpCwnTf3YqPh/la7
         BtdF5T+CNeAk5lsykHvD1+RW4f14isdqZb6vyozRKqYmOABLBCdhX61w9V+AmV07a2R3
         NGIpjW6R47W5HF7HgftTEpZf0wms/0Pihg0+f9WFw5hn2gWe7emRyKXSTCdRqSsL53Xb
         YHlQ==
X-Gm-Message-State: ACgBeo01S90YR22j2Pb3KEhT29p8zJtRPEQFdAlTB/6Y31YedkNGZkwk
        Cb4bYxR3x+MGk/BVz8iO5ipVHw==
X-Google-Smtp-Source: AA6agR5W3eYq5Eak6estuvfuupN5ysbc8kQnmprzj2KXFpS8oupPo7ADaJCYelLa0ygWHxzZWm+jWA==
X-Received: by 2002:a05:6e02:1a8f:b0:2f1:dc7a:c514 with SMTP id k15-20020a056e021a8f00b002f1dc7ac514mr2041198ilv.242.1662648055502;
        Thu, 08 Sep 2022 07:40:55 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p63-20020a022942000000b0034a59bc9b87sm8268143jap.76.2022.09.08.07.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:40:54 -0700 (PDT)
Message-ID: <9cce17dc-2fba-d339-e88b-b76eb9a382b4@kernel.dk>
Date:   Thu, 8 Sep 2022 08:40:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND] sbitmap: Use atomic_{,long}_try_cmpxchg in
 sbitmap.c
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907182144.3245-1-ubizjak@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220907182144.3245-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/22 12:21 PM, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg instead of
> atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch
> and atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in __sbq_wake_up. x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
> 
> Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications, e.g.
> an extra memory read can be avoided in the loop.
> 
> No functional change intended.

It doesn't apply to the current tree, can you please resend one against
for-6.1/block?

-- 
Jens Axboe


