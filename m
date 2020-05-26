Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF2C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB6620888
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RzxPeQ0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbgEZVZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbgEZVZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 17:25:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CBCC061A0F
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 14:25:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z64so6238895pfb.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2n60coN9bjuKWZ7OQA8PSocCTivwq7csYmNh/W9qIfI=;
        b=RzxPeQ0v7/FLRl3mH/hFjWrEzNESOz5HCnDli0t+fd22H/myq7BeEM7YTrpi3PBw/B
         UMoqs2iNwTp3GcHHcWBT+DbrhIFoXVG39XIvmwLKgTveNslXPgn4NtHNEjA3Vc3X4bOo
         zeIhjOSiV30DZQ7+gss+QKzItujzwihgO33lwx3kg8OaOvxbFDisQ5ukPGi8l4t9zQS+
         gNPYh3kF/ZfUKtlpzmtqurYiK2B2Gy2V/txZaR3tOWIGFxzwvsYcctJykeueIX7CDLsh
         OPGxaKrVngqTpx01V3EJW1Q6Tv/15yubLm6U3eZ+cGwem56F54MkX/hDnDBjaOATwrgS
         fHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2n60coN9bjuKWZ7OQA8PSocCTivwq7csYmNh/W9qIfI=;
        b=WXI4mldyBwEdVnou99r3glPgFMbGFDxsPvEXIloxNVwjcxbLqj5uWQsalTySc+BGdT
         mf85IdYfcl4J/reNgtX/iCn7EnZpJXrMZPpllc54Rgn5FoxyB6oFL0gcSVYvhjQOpwC4
         tJTjZUBArFKT3Zx+UlZAd9Gwy/k4isS0Pd+O5BqfA5p9Y1bbEoGJ+MTa7uqpvPqfwmm7
         RHjIoydSE71/SO5dVepfUzmWukcMMaF4X6vwaoV2aluoU9BoTI0pNuNdIPcLbiUwy4M2
         jQ/EyVI16HwmwT7oVqRHWtVLarkoTjP7cy4Y7SoggRbqTyY0SkYfKnv5qrAUAfI91BBj
         gN1Q==
X-Gm-Message-State: AOAM533WQVE72WEUdqexkP/c4NsEDs4yd34grEozbxIQty55Ou7d5TzZ
        NLqr8WHCKWHL1+i/b9LQbhBDIA==
X-Google-Smtp-Source: ABdhPJyzHwDWVyjnBZZecAiczyU803aGF7aueXA4vAnHg14vp1Op2xKRb8JF0VcsAczlBZgtH0J0OQ==
X-Received: by 2002:a63:ce14:: with SMTP id y20mr791257pgf.186.1590528304421;
        Tue, 26 May 2020 14:25:04 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:94bb:59d2:caf6:70e1? ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id l3sm355790pjb.39.2020.05.26.14.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:25:03 -0700 (PDT)
Subject: Re: [PATCH] block/floppy: fix contended case in floppy_queue_rq()
To:     Jiri Kosina <jikos@kernel.org>, Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Libor Pechacek <lpechacek@suse.cz>
References: <nycvar.YFH.7.76.2005261146420.25812@cbobk.fhfr.pm>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c1b4104-ca52-4e72-f1e2-f63f6904a713@kernel.dk>
Date:   Tue, 26 May 2020 15:25:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2005261146420.25812@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/20 3:49 AM, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Since the switch of floppy driver to blk-mq, the contended (fdc_busy) case 
> in floppy_queue_rq() is not handled correctly.
> 
> In case we reach floppy_queue_rq() with fdc_busy set (i.e. with the floppy 
> locked due to another request still being in-flight), we put the request 
> on the list of requests and return BLK_STS_OK to the block core, without 
> actually scheduling delayed work / doing further processing of the 
> request. This means that processing of this request is postponed until 
> another request comes and passess uncontended.
> 
> Which in some cases might actually never happen and we keep waiting 
> indefinitely. The simple testcase is
> 
> 	for i in `seq 1 2000`; do echo -en $i '\r'; blkid --info /dev/fd0 2> /dev/null; done
> 
> run in quemu. That reliably causes blkid eventually indefinitely hanging 
> in __floppy_read_block_0() waiting for completion, as the BIO callback 
> never happens, and no further IO is ever submitted on the (non-existent) 
> floppy device. This was observed reliably on qemu-emulated device.
> 
> Fix that by not queuing the request in the contended case, and return 
> BLK_STS_RESOURCE instead, so that blk core handles the request 
> rescheduling and let it pass properly non-contended later.

Applied, thanks.

-- 
Jens Axboe

