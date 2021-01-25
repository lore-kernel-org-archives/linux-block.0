Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B79C433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D5B22CA2
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAYEhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbhAYEhh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:37:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BACDC061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:36:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id jx18so2292892pjb.5
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CvMA3FL8dHSfKJXeGv3WAf10xOnVS1nCO8k/Gm1YzTQ=;
        b=su+CfV5uTWK9uTt1Ew0ySTu9kxgdoDgPjBAY0wClNThUH43koxiXLnDyyfv/rfikW8
         BIYIC4b85X16l79slKjRUYF1hsnYs/nIaGp58SqKq0sEFpHjkAS3XBDPf8+w6dgpI5Rv
         GnH6atAAScQb+FkV7B+rLbPCxSYX4614HldAA9hSvTMhYktagh/KFeeQhFLMG7KFAxb8
         AcPFCMmOqn7FlsQFwc7v133qo9aezgVHK6s8BgS9SZtl0coRyrS40bNFBU1MfaDB7R8z
         bhKiWeCrPk88rv/2ncADRRly5wu9XjHa49OorOPU1Ytl5EDbOg71iZPv3AgqSToLU+8K
         RmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CvMA3FL8dHSfKJXeGv3WAf10xOnVS1nCO8k/Gm1YzTQ=;
        b=AsY9l5zs98Y3fshNlalru2qVGssoKhMhPZCy0bcTLY9X7nnS7twc6rtcBc+SrjWD7J
         GkQLhUny3brkXma2lNF6BaL9f+4NHWf8HG87x5XYOpiSOU+2bGIZLYrA+Fi5bop8akk4
         8OTVYPtWiUNWcM4YTBvC0NWF1xKZNZPHsnYJA5Yd20xYHa+ELx7uEb4uJedJdzwBH0VI
         89PulHF1Zfu21f+2hgRiZYmH8WkJ8X13h3lHzpIOTNskSRl5w8FEUVt+LQ+ySu+iI5BF
         vKz4gfHBZluCH1g3QADGUonFTf75u1yhGY8x+ZXsGsAH9+/YQGxC9MS0Q5vvwZTceT8X
         WpyA==
X-Gm-Message-State: AOAM533DEhwyNBpMJwRplFF63W4oivqxNUsevTSt8q3M7NlsY0+NVkgs
        sA2Mqg2rHtTVS5nVFHiO24TQJQ==
X-Google-Smtp-Source: ABdhPJzLQpPv+gD+Lys9TV4lNKinpYYaDjG7wsKLtc/8IPHdd11nmaWfE+aFmtiaHwis9uk519M7KA==
X-Received: by 2002:a17:90a:5aa4:: with SMTP id n33mr4205318pji.66.1611549417115;
        Sun, 24 Jan 2021 20:36:57 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a30sm14772483pfh.66.2021.01.24.20.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:36:56 -0800 (PST)
Subject: Re: [PATCH 1/1] bsg: free the request before return error code
To:     Pan Bian <bianpan2016@163.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210119123311.108137-1-bianpan2016@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <391237ba-b507-25a5-555d-23d59d3dbfb4@kernel.dk>
Date:   Sun, 24 Jan 2021 21:36:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119123311.108137-1-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/21 5:33 AM, Pan Bian wrote:
> Free the request rq before returning error code.

Applied, thanks.

-- 
Jens Axboe

