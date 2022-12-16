Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD80C4332F
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 15:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiLPPPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiLPPPX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2022 10:15:23 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A550D6D
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 07:15:21 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z9so1373234ilu.10
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pl8+MRA/DHBGoBuh7tSeAAuJjLKnvBS+4TdVZj29RM8=;
        b=f+roZpLD3nWq7rB/LomJFjc1II1/D3xOjqqgK6vokJl1gCsJdr2BBBHuzGxQZbiaqO
         oscm5pKFeIDHTM3mJp97EpzN9OEYfIkAJNI8WDIqv6F4A9Wlwj2cCt+oAAfr2PH1IqQH
         aSiY/iESQ9sTOyrL7lyBA92wJTi1B1/O3W8ExjzZzrjQgV2FwTVzw8SuAYi4PABlB3BL
         ccs05gltXQwQOkkjX/eBD/qJExA8/bZgBgQBBlLI032whR1/3QPKXD+fKJ6datQtm3Ns
         Si88bDh/hz39JnEMz1l+fud6poVz5mnKGZwtaYMTZWv2TnbUEkhFYDi3Sy/I3uRkOzAT
         kwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl8+MRA/DHBGoBuh7tSeAAuJjLKnvBS+4TdVZj29RM8=;
        b=vMJyFB95g5EnRMLAOO1M6XpkeUrRsI1SWByQeqbT/qYtiikjT3ZL1RAfGUeyexFl8Q
         z5Ozj4/Iw3W0zdChd1GS+rfTIzvml7EMrTip5jppOyhwgoRtHMHmo8mQ4UVuoAbFylpW
         Or3KwgFJN8tLNJn7WCcdxVy6RVej4ipsR5+gbBXVdj+vjicZEYmoEA9vCtuGBXsBeyWs
         QbILoMy6Bn93kHJLsoS8H0jolHgSm+IRiDhgY7YUiIFKLAA51cch5LQGW6WWPUNmBhGV
         9nvASE4LPPOIzyAQsIAhnuIVLV70zeLfB3RQeWP/RdcvJwOjkOBphIaPv0O9D/IM4atD
         4pxQ==
X-Gm-Message-State: ANoB5pkq/nXFEkAVQDSzynf2V8umUXn3C48x1CweQZViCnhBio+UhibI
        RIwz8EPDgyQrgNLRmBnimo9wPg==
X-Google-Smtp-Source: AA0mqf6jOIeZAgxg1qYJpSUIuPzRkTH3DQpioJoclm2l9Fmq+v94PQxxrKAei8L5v1M7G43HAvXzsw==
X-Received: by 2002:a92:680d:0:b0:303:8174:ba2d with SMTP id d13-20020a92680d000000b003038174ba2dmr3211925ilc.1.1671203721135;
        Fri, 16 Dec 2022 07:15:21 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q6-20020a02a306000000b00356738a2aa2sm784694jai.55.2022.12.16.07.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:15:20 -0800 (PST)
Message-ID: <6e656544-ab31-8823-f4aa-3773a47b51d8@kernel.dk>
Date:   Fri, 16 Dec 2022 08:15:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] blk-mq: fix possible NULL pointer access in classic
 polling
To:     huteng19901016@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "huteng.ht" <huteng.ht@bytedance.com>
References: <20221216150636.18111-1-huteng.ht@bytedance.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221216150636.18111-1-huteng.ht@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/22 8:06 AM, huteng19901016@gmail.com wrote:
> From: "huteng.ht" <huteng.ht@bytedance.com>
> 
> Since poll method in blk_mq_ops may not be implemented by driver,
> add a judgement to avoid NULL pointer access.

So the queue has QUEUE_FLAG_POLL set, but no -mq_ops->poll() set?
That seems like the real bug.

Where did you see this oops?

-- 
Jens Axboe


