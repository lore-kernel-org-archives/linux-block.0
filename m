Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E79C433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB55022CA2
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 16:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAEQ36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbhAEQ36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 11:29:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7BC061574
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 08:29:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z12so1992612pjn.1
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=egnuumYuFUsVrh1OKb+w7xeuF5QF74aK46OUpKNfCeU=;
        b=iSnBqORTDlr9loFiInx6uGDt27BdpuVflPrhE3Z+MNDQ2T6P3hHi9UM2tWlJb1QyWf
         bBz0z7rW9X/6ID39PzEav6kl+ikBklrwqUFpn+OvbH2he34+0R1/VE3YspqNd3ivO1C1
         2zcwx5pTb9pBSdix07iBCY+8jyDT7si/nzUI6tww6PTv66pCeXGoPsra/DCMf7gkOiy5
         UZkunIQogBVG7RAGXKjnbJ5oy5ncV2LPjTUZDryap6aML9hrlENJCFhZw3JZnqLmMmvz
         ihp3QF+Ny7slELu35jy94Xlkrfflz022FHDy37ybC3uMuI6hCna2FHbo4ENmHEewFh5K
         vjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egnuumYuFUsVrh1OKb+w7xeuF5QF74aK46OUpKNfCeU=;
        b=icKbgrbTZWBkvQB1N5EaaxSMdJzYt3AlG26km+QLGW5vcEJS+1XFxliylZe35REJ2j
         7ld5l7tytlrX6sEnNKpSmgfpR4sfvIlyQAdhzxrwP1W0ouRRQB7eiBPpUK9oJdDukLKv
         W4r9XGbPXUE8RMMAzmZUtN67ogtFKMl36c/U/moPJGOLa5ydBAFpcG5MTwHhqXp/wkCc
         dDrUGrU53QVC6xYXy8DgJJd3J66cSKOdiRTn2FWppLTa5MwbaOEUR7a74vh7yPlYZPPd
         uupP05nO7MbbpweeLW1U3ErZNE32NnLcGashyb9d6s70Gt+3MAav73Cd9fc2/B3ssIOJ
         QUjw==
X-Gm-Message-State: AOAM5326xZdRgMgKqtKq3BV0TAE+/aks4EMx0rYDR7jfweyiOTe/ZIlB
        Oai9qNyKkm1o6vazsALen3OsKw==
X-Google-Smtp-Source: ABdhPJx+IMIS6bPbXSyNDfdt20g5dgWHGZqRcaVLrYgGB6MHOE3alKRz3S/CPUkx2pDy0Tyq9VGCsw==
X-Received: by 2002:a17:902:8e82:b029:dc:3182:e0b7 with SMTP id bg2-20020a1709028e82b02900dc3182e0b7mr70821plb.78.1609864157518;
        Tue, 05 Jan 2021 08:29:17 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c1::1298? ([2620:10d:c090:400::5:c43e])
        by smtp.gmail.com with ESMTPSA id h17sm113335pfo.220.2021.01.05.08.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:29:16 -0800 (PST)
Subject: Re: [PATCH] bfq: Fix computation of shallow depth
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20201210094433.25491-1-jack@suse.cz>
 <20210105162141.GA28898@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <238318dd-9103-e4e4-d591-ef7212b86a48@kernel.dk>
Date:   Tue, 5 Jan 2021 09:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105162141.GA28898@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/5/21 9:21 AM, Jan Kara wrote:
> On Thu 10-12-20 10:44:33, Jan Kara wrote:
>> BFQ computes number of tags it allows to be allocated for each request type
>> based on tag bitmap. However it uses 1 << bitmap.shift as number of
>> available tags which is wrong. 'shift' is just an internal bitmap value
>> containing logarithm of how many bits bitmap uses in each bitmap word.
>> Thus number of tags allowed for some request types can be far to low.
>> Use proper bitmap.depth which has the number of tags instead.
>>
>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Ping Jens? I think it has fallen through the cracks?

More like waiting for Paolo to take a look. Don't mind taking it, and
I'll do that now, but I do expect him to review any BFQ patches being
sent out.

-- 
Jens Axboe

