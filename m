Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhKWQJ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhKWQJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:09:57 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64709C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:06:49 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w4so11067080ilv.12
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUkn3Om0wQZU5l9RmaeWSy6fKRmf1I8viU0TzCBnWeY=;
        b=fxCDU8T0G0oTPhQFiFuY7JjtKXAIWagaSO2VQLM08T4sdaFyP04gZnEZ01sqzN21L+
         jxPlj0oYYbQ/Nx/u+NIzhFy4YTxdi5144itBfR1KWQFbaCkHRq7XkrlJpXRca5qf1WRZ
         LcXrwanqVoei9TiXEs14eP5k1+eJs4JKG0Oq6s1H34Qo4wiRDRYY+PBiQIb7r47zkhqF
         5ZhZ6U1qBbIz1RTsy5QlpQdFzf9uS4UxfmbDTTFlq2/eDkfp6eWS03yy3h4IKVCfnJu8
         w/DYlC9xhV7X/B/qdk7Y3k3PfFhSd2wrJ8aLZuDNG5h6x8mX2FLzqO/bPU6FlT0mMeZS
         KhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUkn3Om0wQZU5l9RmaeWSy6fKRmf1I8viU0TzCBnWeY=;
        b=u+YmIy6lEz9aLChzlWnx2ybuxLhiPeyi2bbUXvoPewzeSPazrOd7LuM/w1zZoKMkeh
         KRf/h4RjD8TkkcWMWs3FVXaCyeqvLHArx24hGIqJ9NNa1h6snhr1ZyWVmn9h2hiG/HeQ
         Az0dqie+BaTGRL3bF+9qz6vgjJ06WlseFhisoibd6M9VmdWGzQ8BI2WQ+DfQCM9lr+VC
         SYaQi1epWpb9hTLegxcCoVyHALUbo9BNpKlpEH8FA+gpciw0HlbOZytBpn0t+y415Jpl
         paF+eaBwaVPboMjmaeCWgb55aGFqI8haCPpamB39D0VRlB4dA5vcmu9YBJ2u+uU89VrF
         sH+g==
X-Gm-Message-State: AOAM530VMKyihOYWx4r4DiACt+mCXCDy0KFw5/cwzvq2IG2YZpyTjZyj
        oGmJw/Mf6jm+UHGlobp21VdfQw==
X-Google-Smtp-Source: ABdhPJyFziqw10pofYgRSWEdapcg7hwNvTwXXQ5V/xuidVtd9SWaWAbO2FBJW6nSRZ08khpA2Kgi7Q==
X-Received: by 2002:a05:6e02:1090:: with SMTP id r16mr5802539ilj.208.1637683608753;
        Tue, 23 Nov 2021 08:06:48 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x2sm7204598iom.46.2021.11.23.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:06:48 -0800 (PST)
Subject: Re: [PATCH 1/8] block: Provide icq in request allocation data
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20211123101109.20879-1-jack@suse.cz>
 <20211123103158.17284-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cae86cc-e484-cb91-7189-0afbe84f69b9@kernel.dk>
Date:   Tue, 23 Nov 2021 09:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211123103158.17284-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 3:29 AM, Jan Kara wrote:
> Currently we lookup ICQ only after the request is allocated. However BFQ
> will want to decide how many scheduler tags it allows a given bfq queue
> (effectively a process) to consume based on cgroup weight. So lookup ICQ
> earlier and provide it in struct blk_mq_alloc_data so that BFQ can use
> it.

I've been trying to clean this path up a bit, since I don't like having
something that just one scheduler needs in the fast path. See:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=f1f8191a8f9a0cdcd5ad99dfd7e551e8f444bec5

Would be better if we could avoid adding io_cq to blk_mq_alloc_data for
that reason, would it be possible to hide this away in the sched code
instead on top of the above?

-- 
Jens Axboe

