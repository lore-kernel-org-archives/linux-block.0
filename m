Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FBFC61DA3
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 00:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBVAD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVAD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 19:03:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF85FCA
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 16:03:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso6648840pjb.2
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 16:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drterpwutcAES3ZpeSgqLGpByTH2KXtwJq1zap9gSZE=;
        b=KZZR+/QUj04bDCloEwHY0HJU+ftyNN78uklpuZS+KgfcANpo3nbH9g8vfjs+v8oJ3M
         IkgOxd++JGlfko3u/VFXFC9vffpLJRv7XA2/dnh2QTAC+kkZdtdTfLRuM/HdjBww40gU
         fvYcA0aWyGOYb+xcoI5AnN0g2fRzziS/4Vjq6CICN995EO2GK4bvaE5SdPA17ObIJaCp
         rftFN++xnWA8HdtWAfEzPkOF3gDjPApYAz3P3xaqpNz8BaeOYOFGlTLColhoQ0bzfSfG
         wnQmxynTU5o1dSiHjNrXDF6S+nj4qd196zwZA+qeR8BXTmsMLLxnHNaBTzRbdUf/uk9r
         35fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drterpwutcAES3ZpeSgqLGpByTH2KXtwJq1zap9gSZE=;
        b=1LSEWt5v6/PK7At7SbpJKRhnIR3VkOG43kmKsJ6K02pI+9skKYXOwBNDrlyT/aUZOH
         CEaNjMK1nU/u3nk+ozMgpxsnOQUPGboXG2XblA60cBVsf3EDv6rfzYWzo3p2kZHEsSGF
         noorBdy0FmUAM5EzQd9h+TnwVdpyuEDEOd4GdST1ayNuOsfPGcykZZmKvAkYYApZIK/G
         AV8rkBj1tmgumPH1RnIe10Ai2Pf1uxLMneE2oM5xPZgYM5vcll5efB/HurvuV85EF8OR
         zDaYlV4u7KiEVLZFJ3uLG9yVJ5yfpDd2sU8wDRq81d+Knd+QhJooGX9SvPIgXDWvAE1K
         gw5A==
X-Gm-Message-State: AO0yUKWUEZgPJw0CbY5x98Twy+ZkndEGF5buf0lA/edU9njM6TeLAPgZ
        8oEM3Xq/9AFMUj//o5GlypdjGeNbpqgTUOxc
X-Google-Smtp-Source: AK7set8hLpQ2EySGAeZWIt0Jur7XA6/sEfqBxRLAFUMDsFKk4skjdCSxBhgBCIURC+S1cU7xLHecsQ==
X-Received: by 2002:a17:902:ecce:b0:19a:af51:c282 with SMTP id a14-20020a170902ecce00b0019aaf51c282mr7135995plh.0.1677024231637;
        Tue, 21 Feb 2023 16:03:51 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902b09200b0019a97faf636sm10428154plr.83.2023.02.21.16.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 16:03:50 -0800 (PST)
Message-ID: <9a048f21-1938-084d-b328-8a345bd20263@kernel.dk>
Date:   Tue, 21 Feb 2023 17:03:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
 <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/23 3:52 PM, Linus Torvalds wrote:
> On Thu, Feb 16, 2023 at 6:54 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I've pushed a merged branch here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-6.3/block-merged
> 
> Hmm. I do verify against suggested merges after doing my own (even
> when your suggested merge was then made stale by another later
> addition), and I think your merge was wrong wrt bfq_sync_bfqq_move(),
> which in your version does the bfq_release_process_ref() before doing
> the bic_set_bfqq().
> 
> IOW, I think your merge essentially dropped one of the fixes in commit
> b600de2d7d3a ("block, bfq: fix uaf for bfqq in bic_set_bfqq()").
> 
> Maybe there were reasons why that ordering wasn't required any more,
> but it looks funky (and you appear to have correctly merged the other
> case in bfq_check_ioprio_change()).
> 
> Anyway, this is just a nit-picky email saying that I'm pretty sure
> I've done the merge right, but since it doesn't match what you did, I
> thought I'd mention it.
> 
> Worth double-checking this, in other words. I realize you're mostly
> afk this week, so whenever you're back.

I'll double check it. The merge doesn't end up touching any of
bfq_sync_bfqq_move(), just conflicting with:

bfq_check_ioprio_change(), where the release ordering should be upheld,
and

__bfq_bic_change_cgroup(), where it's still done after assigning the
async_bfqq.

I'll double check tomorrow...

-- 
Jens Axboe


