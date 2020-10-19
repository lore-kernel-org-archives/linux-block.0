Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA2C433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF122269
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 15:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y/TH7WtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgJSPcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgJSPcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 11:32:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D60C0613D0
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 08:32:52 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j17so567757ilr.2
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6IqZPH/xvsjeV+KO4PrfwtgG9S8DY4P3ygKvGFV+Wk=;
        b=Y/TH7WtZNNRhTiDN1VAyBBdljrCIJKN6XT05Ag7KnMLwK12/Ung3jtuMQBGYi5vmhL
         72/8lisWN3QniaCEz9Ib59crBAL4W1ZrUu/PaALYAA96srEE+L40iZ2Fnizhbkk2angL
         n6p7BdbI7RXC6n4N5OwCcPTdftLKF1OCH+NUNUPpmCAhDrhdkH82Rv1C7nl9I/ojaHcV
         kmS7yyp69BJmWKnQSo8qs4q3hxKII5v/b9LrtNGumGkzr/60C+mgBR70JPZ1kZ0Da7c/
         NnasKweHHQHA+GwqdLowZhENOTy302Sg6tYVr8qE71tIiiRNXAfefesK4386lqvMYonD
         vH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6IqZPH/xvsjeV+KO4PrfwtgG9S8DY4P3ygKvGFV+Wk=;
        b=K82sl7RFjYHiwJuYjG2iruX+UaISCYoAiLbQh2w2INSCnq1CWl//fP5uYzhNUPUxjb
         zlTmnjTC0CPB2Ud9EwgKB/iPmn9SWHIeShcFX3TFZPdA1m/xW++jH9gRmMAIMf32EzVB
         ufztO5AVHZc66EMbnfu7Jch7UEWWd0zbSqKcAUcyrR0rSaTgBDpnEuB3524t68+oJXPU
         z10E71akS4JGyDO2bBM64hHEsxGQm5O1xoyWi0na2IB+GXTxTevgvRsN93XHIHYLGs+c
         U9GQWM+4BgShKa21HmGZsdM7jkajB+H6HoNmV29GumHP1uxm+yqP1lagJjZWlT8seOuZ
         fQ5Q==
X-Gm-Message-State: AOAM531SQ01Bwwp8XETUGbeCl8m3Hq1SfxEpfEpGJoj1jZPZmUszbws1
        qz231cg/03NKeIfq5hV9oRPqqJwdEZgXfQ==
X-Google-Smtp-Source: ABdhPJybmO34vOS8G/CY+b47HRjCg2ALL11YTrOppEKdrvmkSd2kXA82tTKNLtwzSN0eoE8vTukKMg==
X-Received: by 2002:a92:dc8f:: with SMTP id c15mr387228iln.293.1603121571501;
        Mon, 19 Oct 2020 08:32:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z200sm65790iof.47.2020.10.19.08.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:32:50 -0700 (PDT)
Subject: Re: [PATCH] zram: Fix __zram_bvec_{read,write}() locking order
To:     Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, bigeasy@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
 <20201016153324.GA1976566@google.com>
 <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b50bdd18-941b-cc05-2be3-6288f227be4d@kernel.dk>
Date:   Mon, 19 Oct 2020 09:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/20 4:13 AM, Peter Zijlstra wrote:
> 
> Mikhail reported a lockdep spat detailing how __zram_bvec_read() and
> __zram_bvec_write() use zstrm->lock and zspage->lock in opposite order.

Applied, thanks.

-- 
Jens Axboe

