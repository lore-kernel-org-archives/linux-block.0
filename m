Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52801C43334
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 11:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiFILCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFILCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 07:02:49 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA852317E
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 04:02:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h192so14736868pgc.4
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2022 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eA2rSMTUFSewTOnPsmOrnE6HCmgRpXaUuyafBR4ipFo=;
        b=PhF2l/vtHVZjCKAqz4OpktNX8yi0juQT7/9mlOjaRI+WJ/8mFLlvmrChupswhPlMoa
         bc7vMTDPOhZSuBdmsu8Ao+uRlmChD/jUJbcP2miIjzmjYzQ9L3TWeewo4w8AdkVg1o6p
         4Y0jslyAC5Xw0nkFpxZEl70DVxJkswiTrwXxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eA2rSMTUFSewTOnPsmOrnE6HCmgRpXaUuyafBR4ipFo=;
        b=Zfxj0Z+XC6PlyA8ftooPHmzUqCniHR9d5DZ68cvVt8TFtbDBJveqFB18gY7pZJGY6Y
         xwfKkGN3Lz29wk2EhC3vrK305R0bsexq5m3gOTRmq2uNTvuGAZPazqr+dgCNmTr3aJQF
         zyDaOhhReU1eO8nMW9lqP1wUhV78tlpHIfWDKfJzjfV83t3q96CENrhtLkRVvtLgc3aK
         gT+ZQN303Tr2O389h1MBRhgPBHbdhsKwJqeSp2L8D8Joq8zxNA9yWG0SX0fBexWWf++s
         fFA2zoegyDZ8QxR5aMiHZzZrKuw2NOARpDDtFfjgDO0ri91/d/HlO0AUeSgmxHRqgBCz
         O0rw==
X-Gm-Message-State: AOAM530/3QZRndPFlLkqwWT2u3P69D6N/UXiI+aOiMx9C55SvE1iCaSa
        8kl1YMACNDuatCAikDdDsGppKQ==
X-Google-Smtp-Source: ABdhPJyRD8M4C4AIWlnMkoCdrxA428zPc/65lMrKv7boT8iwH7ATo4M+sNcCYcjeZm4RCxc0iZEi5Q==
X-Received: by 2002:a63:8242:0:b0:3fe:3601:747f with SMTP id w63-20020a638242000000b003fe3601747fmr6713986pgd.314.1654772567192;
        Thu, 09 Jun 2022 04:02:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:1572:8d44:6d26:109d])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709027fc100b00163f2f9f07csm194145plb.48.2022.06.09.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:02:46 -0700 (PDT)
Date:   Thu, 9 Jun 2022 20:02:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqHTUdeZ8H0Lnf8E@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqEKapKLBgKEXGBg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqEKapKLBgKEXGBg@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/08 13:45), Minchan Kim wrote:
> 
> I am trying to understand the problem. AFAIK, the mapping_area was
> static allocation per cpu so in zs_cpu_down, we never free the
> mapping_area itself. Then, why do we need to reinitialize the local
> lock again?

Well... Something zero-s out that memory. NULL deref in strcmp() in
lockdep points at NULL ->name. So I'm merely testing my theories here.
If it's not area lock then it's pool->migrate_lock?
