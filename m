Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C02600D4
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJSAny (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhJSAny (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 20:43:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DEEC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 17:41:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h27so10995477ila.5
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZE1w99zHSeEaOVW5PLZYTSPH8uDVmcv6n6KnaTAnwU=;
        b=okCeuXC1zwp0QxH0yGpBnlfHVC3RfEtpKqwVasA3RQ3DIdNDTGcv0VI+Mvxsrgrc/j
         88xARknJ9wOl+uMkMAMBoPjnzm8XRKXplFuaJRx3arL313pun4qJid91QkXVMWVF1B7v
         T10RCt3smXy2kSpwqODU2CqC1h4SIt/YCWodxXk/VdqTPfxbntVpEvZkbsa70yMmv6vg
         K6SX9WQ6MeAxPTkRakpkyEOFxpgzm02qY/9G5I/i8sCbI6IR75wWZRiHJig2usjIebgv
         XJBoUJZt3xR0epuy9DVlJkgt4DZX8ONaO5iVQ+TYi1whgsTA4ottXf4N3RDLrMHApnzx
         MNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZE1w99zHSeEaOVW5PLZYTSPH8uDVmcv6n6KnaTAnwU=;
        b=ED8wpCR3rECdO2S7cu3LKlODE+n/tegJSWc38pdBS9FT8q3Xrjpt3gpU+ILIwq8YRz
         NUz4KzGvVVYzxVyb15UW6A+tNRbe/h2qkpjHq+/espdZn8HDa9Gz0OKEZGdOmlRrQlLC
         u/vLe/gKFp1sHax+l1mZ+tQRh6WFTXmXUu2upg00ASq1Kbc4A3xev35wUHxZ4+BcqSkX
         Kwccjoq/lRiN46k6MsPWuQmqxDrFVmSeYO3C2XHqZCoUC+yqjw6ih0XbP2PA4+pNpoTQ
         CRa9chNief6/2IYjNcXRn2/IWJ0jxDXYg20l+puoB1xvH65jYFgjxUGZd4jOlYKKJ+GP
         WPug==
X-Gm-Message-State: AOAM530GRYLpMzzk9uOrOMGOxKPQkAfiqC488fqTCG506q9W67frpDUN
        J3O3sYzeaNtUTzckdLdka0E5Fg==
X-Google-Smtp-Source: ABdhPJzjf+ugZkSyF+BU1QlViAy/1tFHwsKG9bUkv42N1Wi4sFpEsPJGRTLS9mAuCMRgW4QTjrOwmg==
X-Received: by 2002:a92:ced0:: with SMTP id z16mr15979755ilq.256.1634604099877;
        Mon, 18 Oct 2021 17:41:39 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u15sm3613307ilv.85.2021.10.18.17.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 17:41:39 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org>
 <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk>
 <604778bc-816a-3f2e-d2ad-d39d7f7f230@linux-m68k.org>
 <460a172c-6103-3839-eecc-a193d1cc208f@kernel.dk>
 <a4e827c-9163-9fff-dd20-cdd44432fda5@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3596239b-3637-6ea7-d7d5-fe81d0c7604f@kernel.dk>
Date:   Mon, 18 Oct 2021 18:41:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4e827c-9163-9fff-dd20-cdd44432fda5@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:14 PM, Finn Thain wrote:
> On Mon, 18 Oct 2021, Jens Axboe wrote:
> 
>>
>> Oh please, can we skip the empty words, this is tiresome and 
>> unproductive. Since you apparently have a much better grasp on this than 
>> I do, answer me this:
>>
>> 1) How many users of ataflop are there?
>>
>> 2) How big of a subset of that group are capable of figuring out where
>>    to send a bug report?
>>
> 
> Both good questions. Here are some more.
> 
> 3) How many users is sufficient to justify the cost of keeping ataflop 
> around?
> 
> 4) How long is the user count allowed to remain below that threshold, 
> before the code is removed?

I'm not interested in bot conversations. EOD.

-- 
Jens Axboe

