Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C219C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348837AbiHSOya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348671AbiHSOya (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 10:54:30 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E402C927B
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 07:54:29 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id w14so4335629plp.9
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uTeohX6f+RskuT3kfU0U7ZVsQqjhWiTxPjmu0dEQ8XQ=;
        b=Jeu5THSQ58N6J0UD24P3C/Ir73nW2MGoPKdCWJC/ce+vyelG0m1bTvb7BoPs0xSTWl
         YnS94ds5s4CAnHPslyZ1aeBpCzAA1hE78X/YJTi8cy3UCNzHKQA3kxqVqhLCa0vTRpUG
         uhOMDO6NWmmN9ueEVPbKoNSAJky1u5yNawMngTluj1aW+B5V9nKyAjDsW3KWvRpYsuqO
         A3m20WKaquE/2iNIYx19sKCsuYT8RZrt8MupQHNX6kPNXq1a9H3qZtaVBkATLEispTzm
         r1Y33uubmhg2y/QG/bZD5PLTQkh2Jq9DBbuyPIicTc1edr3CdSbZSJFaVps4l+W0SNIw
         mJgw==
X-Gm-Message-State: ACgBeo1C5vLZZWW8PeQoPX9KTTQR9ylofj12D34XJxSQI9pNNpw3pQqg
        roR008UM5wlKgeNu3hksocI=
X-Google-Smtp-Source: AA6agR7+czLqWZhTWtUlVDqY0ndmtQZ3cilE+OlvY5fLAFVl+uDGK9vDFG3U7mkj2dgbknqGBuK2vg==
X-Received: by 2002:a17:902:f650:b0:172:8ee1:7f40 with SMTP id m16-20020a170902f65000b001728ee17f40mr8054350plg.101.1660920868754;
        Fri, 19 Aug 2022 07:54:28 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id lj13-20020a17090b344d00b001eff36b1f2asm3336522pjb.0.2022.08.19.07.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:54:27 -0700 (PDT)
Message-ID: <9fe5751a-c7b7-d6ef-bfb1-cd1015e6c1f6@acm.org>
Date:   Fri, 19 Aug 2022 07:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH blktests v3 6/6] srp/rc: allow test with built-in sd_mod
 and sg drivers
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
 <20220819093920.84992-7-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220819093920.84992-7-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/22 02:39, Shin'ichiro Kawasaki wrote:
> The srp test group can be executed with built-in sd_mod and sg drivers.
> Check the drivers with _have_drivers() in place of _have_modules.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
