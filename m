Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E497CCA47F
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 21:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGLV0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiGLV0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 17:26:20 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7977D0E11
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 14:26:19 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso377975pjk.3
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 14:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KK7P3L9Kli1wdat4RBjBc1YBJWepWM2uXjn/zFCX0Eo=;
        b=BfDMTs5B69WcjqG30oJyG988Awdle/HnUT/ASLtjLyjJUNNHzQushDXpcz1BT659oA
         WUYI7p4hJrvvxlZSsgTmd4EYfyjHNvnY9MT/PJK5OKKoMmtrTbGr6DD3P/SRdqjAnP1D
         LDct3ak5ga/cpTO2wUq0jUMtZQYEiR4Wk1Nzsg9cDlx0IpAF+F0MvLxTNGCuBHikD3mV
         yR9Sd5yktqptm7SdXW64IhS5gJvkv9mUmxkJ4Muxn3Igo0I7YP5HurcvRCRmPFYeAVlH
         5Fc/B/AcnCluqM0KMINuXk0HiKO2yqKAkkL+5f0/vCqCx4dEh4oQqBLzazhKNdAbniGr
         BXNA==
X-Gm-Message-State: AJIora8nZnJki5rxunQYL9+UJxTRkUvuO91a6rvefLQWX6Xx7J31PCWu
        +RYLB3DfZryqxm26iO8xVVcd7tlndNw=
X-Google-Smtp-Source: AGRyM1sAxH/IiZseTiil5+UZYLnk6BLHYzNtNNbC0Q8eR+MoRD4f/DXFIYslOnjsMbiXVPfQ/HCUUA==
X-Received: by 2002:a17:90b:92:b0:1f0:6331:e9f1 with SMTP id bb18-20020a17090b009200b001f06331e9f1mr195745pjb.102.1657661179216;
        Tue, 12 Jul 2022 14:26:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:de3c:137c:f4d2:d291? ([2620:15c:211:201:de3c:137c:f4d2:d291])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b00161a9df4de8sm7406195plf.145.2022.07.12.14.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:26:17 -0700 (PDT)
Message-ID: <149ae9d9-f4b7-cbad-61ff-69d06eb901c4@acm.org>
Date:   Tue, 12 Jul 2022 14:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH blktests v2] common, tests: Support printing multiple skip
 reasons
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20220712082810.1868224-1-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220712082810.1868224-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/22 01:21, lizhijian@fujitsu.com wrote:
> Some test cases or test groups have rather large number of test
> run requirements and then they may have multiple skip reasons. However,
> blktests can report only single skip reason. To know all of the skip
> reasons, we need to repeat skip reason resolution and blktests run.
> This is a troublesome work.
> 
> In this patch, we add skip reasons to SKIP_REASONS array, then all of
> the skip reasons will be printed by iterating SKIP_REASONS at one shot
> run.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
