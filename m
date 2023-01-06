Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6BC3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAFSII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFSIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 13:08:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60861A05C
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 10:07:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a184so1612024pfa.9
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//4YyY+R3Zvxj//qrfQ/8SUpcqPL2BUP4S2f+8LppsI=;
        b=GjNGe87iarMz9xzLWJbvuTpMDWCQA2+W1WVxnP+fJYjnmMv7m/6p9+01ELwcZGYByN
         sp+8DGsECa67c/twZDqrpNNIeNrZR84IzoPJgyp25dPCHvXXT7VlsAXvjYRBKMK9KT0K
         U3WxvQeLLXYTtteKi9iuV0Xmx18QLICl7dsCCpXPElWxet+sH1a4y7Y7TWBiTaU4nhZo
         80fA6E6O8WzBkJgHlTbZ5T2b4qjLpExO7alWown5M6oReIgqYyQXQq3dayus2N1Ut+S8
         V+J0Tf2Bq4Y+HIoRdcE92fZz0DNtzggABrgBoSijo2SFq+rEuHkMXS8gQRQAQeGL/gRn
         RKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//4YyY+R3Zvxj//qrfQ/8SUpcqPL2BUP4S2f+8LppsI=;
        b=aFpMoqeissua3uJdJop/4/aaBDho5IHPtJ/xstqqc4ENPQN4DxMZmmEnAkQkrjcmv/
         h5EKBWC7hnrvZRvw4EFfXEUmaiDVXh139joVHeNe5wUwlVElM39CagRr3NyI9TVXKKjj
         r6Uo+MZFRHF8yL3XWNladUu2tkNg3Rg1hX1ao6e7mcYowDVpHDwUX1WY5SwY7qXDBl9L
         uwQMxudj4YGqzUcW1VZF0Gw1CyJnp+BZZSysisuzCze60L4+PROMaH8/XIyClB1pFCjm
         u2uIhzxPi4ClKkXXUkBtvjpm2uvYegm1BMaXjBpJUrxMVWzjLqJWkkFUnX3V7DhYpYzf
         /Rtw==
X-Gm-Message-State: AFqh2koj6a365T6yBps9Es/0deupVW4FV9m/2iWd4azbKC2dvf2JmNfH
        AVmUOdyoKIgUNjO1MrxsjJ5zAQ==
X-Google-Smtp-Source: AMrXdXtCwTCe/Z1erNxyHU+FOuguAbrMXDNIsjW7nphPRq8ZDn5GFcuLxYCKVdaiJMB4i952xNE3OA==
X-Received: by 2002:aa7:9154:0:b0:57b:30b6:9e85 with SMTP id 20-20020aa79154000000b0057b30b69e85mr54858191pfi.22.1673028463336;
        Fri, 06 Jan 2023 10:07:43 -0800 (PST)
Received: from [10.255.208.163] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00581dd94be3asm1412263pfr.61.2023.01.06.10.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 10:07:42 -0800 (PST)
Message-ID: <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
Date:   Sat, 7 Jan 2023 02:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2023/1/7 上午12:58, Tejun Heo 写道:

> 
> Jinke, is the case you described in the original email what you actually saw
> in production or a simplified test case for demonstration? If the latter,
> can you describe actual problems seen in production?
> 
> Thanks.
> 

Hi

In our internal scenario, iocost has been deployed as the main io 
isolation method and is gradually spreading。

But for some specific scenarios with old kernel versions, blk-throtl
is alose needed. The scenario described in my email is in the early 
stage of research and extensive testing for it. During this period，some 
priority inversion issues amoug cgroups or within one cgroup have been 
observed. So I send this patch to try to fix or mitigate some of these 
issues.

Thanks

Jinke
