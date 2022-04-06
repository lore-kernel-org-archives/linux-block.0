Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59241C433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiDFPDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiDFPCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 11:02:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B6674223
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 05:36:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so1804360pll.11
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=odt5YKmMJSj5TevCN9iB8kF64NZNPCBBQ6O3JBapXtw=;
        b=jx8rjvkPQdndpWlBqdzNaiU8V7O0L9ryqTK/IFAtQ6YsNXlwRF0w/Uxe1PMQIMGxsa
         92TfmSIsqTSKD2VTxfrJlPBdW7slHAxXzIv8yjCHzh1R2XsoBYgbst+ayNHt8yvhi3/T
         zW0jBz+wDThcMLiIfD2kAXO7b6g/zHbHAiv7BDqwL8+PV4N6c6AnB4lByHBAsuklGmIK
         J8hvEqNTlrE2s80JO0RSSdQCim8Ji9FtQ4P7K83sjSXI9zmjU1mY+GPyeSn0kdFThtZT
         mZHc9kNytXwj9AkF/dVqrgkTodAlyCAAWT9Q7akXeJDC8q4cyrhfDIZFO2SXHZNrtt1w
         5QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=odt5YKmMJSj5TevCN9iB8kF64NZNPCBBQ6O3JBapXtw=;
        b=Nte1+pLfI4BDrnwM/VWXe+odk85Tcxsn4FnHcPfRWpoKSm56Bowg+UP7V9MsoqTl+K
         FizEkJrUIJXlNSqKYOfSLRtEw11RR+RYr0EI7toMblT1/kAHGOG49ahBpoTN+kQiInMo
         4jyoS67VFYR+8aSp5BGoIsrFP/kRushmxvzDENzBqrJnMjNozsjcjm7Tu05LEpVsYGlW
         kStwsM0XpPn1jjLc2G+Rw5nCaIvsznqxO+7s2RZsXz/gAePUQ5yBhapQlDoHpvCSGTIZ
         Tw/wDnxFomQ/C8z4pRaltPcXSM2XyGl9chHOSuOaFKtf2siZND99fiZRmLSH3on12UKg
         5VEQ==
X-Gm-Message-State: AOAM5320HllD9na+b/zxE7YW/2UXE453UhaArckwRnsiHSl/e8JX3DrF
        ILUHCnTONDqpzbdfIBBX23lPRw==
X-Google-Smtp-Source: ABdhPJxyD2kZKAeDbbyKliugJjKuLxRxQVesGftYslgT++r2Fmts47ksjmG+WYqpO8FPq1c4Lj7qQw==
X-Received: by 2002:a17:902:b696:b0:156:b63:6bed with SMTP id c22-20020a170902b69600b001560b636bedmr8461832pls.24.1649248542201;
        Wed, 06 Apr 2022 05:35:42 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm19356588pfj.43.2022.04.06.05.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:35:41 -0700 (PDT)
Message-ID: <e2035fff-01e2-0df7-2508-82b741615519@kernel.dk>
Date:   Wed, 6 Apr 2022 06:35:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] DRBD fixes for Linux 5.18
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
References: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/22 2:06 AM, Christoph B?hmwalder wrote:
> Hi Jens,
> 
> this is the first batch of DRBD updates, catching up from the last few
> years. These fixes are a bit more substantial, so it would be great if
> they could still go into 5.18.

Thanks for sending these, but you based the repo on my 5.19 branch,
which won't work as pulling your tree will then result in me getting
your 5.18 changes with my 5.19 as well.

As it happens, this is also a problem for your 5.19 based changes. My
for-next branch is not stable, just like linux-next isn't stable. In
terms of shas, not how it runs...

In general, for the block tree, here's what you want to base the changes
on, using 5.18/5.19 as examples as current/next tree.

- If they are bound for 5.18, base them on block-5.18. That branch may
  not exist if nothing is queued up yet, in which case just base them on
  the last -rc1 tag for that series. That'd be 5.18-rc1 in this case.

- If they are bound for 5.19, usually I will have a 5.19 driver and core
  block branch. Base them against for-5.19/drivers. If it doesn't exist,
  previous -rc is a good choice again.

Usually post -rc2 all of the above branches will exist, during merge
window and right after things are a bit more influx and haven't really
settled down yet.

Now, there's also the fact that you're using a non kernel.org git tree.
That's fine, but ideally we'd like you to use signed tags in that case.
But not sure your key has been signed by anyone in the korg ring of
trust? Since I've already seen these patches this isn't a huge concern
for now, but something to get sorted out going forward.

Can you rebase your two pull requests and send them in again? Either
that, or just git send-email the two series, that'll work too. I'm fine
applying series from maintainers like that, it doesn't have to be a git
pull request.

-- 
Jens Axboe

