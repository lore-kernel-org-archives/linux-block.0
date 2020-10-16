Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A93C433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7E420897
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABXe786v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405563AbgJPOAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394143AbgJPOAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:00:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E7CC061755;
        Fri, 16 Oct 2020 07:00:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so3080828wma.4;
        Fri, 16 Oct 2020 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZxiSkKJIQIB5PidhClNmB2YPlNf3Wah9XPCO/SvxnQ=;
        b=ABXe786v9mEdTIIAGOuMPv93Amrvl26X+bvova6WNMzoWbn/s43ZDlJI94dsaxLOZu
         1UbW1odsrxKdlY6VjITDACb222IfEBTxU8L0O3pDw5/tvTLAlI/+RQUC44EAWxpL6ufV
         gDfjF6Vi3h08A/tncqNXRSg8VbnsE9w/Krz/6S1B7qbnlvcK3cwIYSmBf6eD8aR+I2Q5
         nZ8D+3x7v8WQG2Yg7vna1oz6SSKZZcG/IdMRU7ZKnaRas2BNbfAuT3ygeOAG25NLmswp
         8WrRQ4uQsP8RQHAAUfik/riech7+0iH1c2CV78Ie0oklNAxePLTE1OP5IINmY879RuqZ
         bRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZxiSkKJIQIB5PidhClNmB2YPlNf3Wah9XPCO/SvxnQ=;
        b=U+OtHDFerl8ioeEmUYVrI6hxBG5KDLHvAgF1B5EALKj5yXlJ352DbpbDlpwbzsFKuR
         Em+d+k/ht6YBx0pSZEdoc4tUY09VVfM+ApeDmmociMytORDUqaF+m/uyEV9lbYjFG64t
         laqpVTSiX1sXDyJdO1Fo9foxGpiBQVnMLlnXMhAtXxnUMHmOd18/pulCGx0Vi8rbdNWh
         mXcsIL3ldQMWYThB//RS7PAgjWhpdq6txrWeIhwh0Tt9CCnJAsUoxNTe1JpT4D3Vn7AW
         PeI+LBlSOUzBR0ONa9LdepreC3bOQv2k/B14x/dZCNa4wX7pc87XMmutsSSbuH8aNNXy
         6oBA==
X-Gm-Message-State: AOAM530RlBPmeVvLQele7J06kn0URMskcBSXi+RPf2LE+r+42J4B/hoT
        6Pc7JbqFKdCcywlgjtgVVqRAPWUTAb5K6WDRFgI=
X-Google-Smtp-Source: ABdhPJwEMehNpJ8fQRVb6auH0sERdAn25ysw7A0UhRBP+wRdmLkHjed/aXYl9+UpqgdxZQeXhYQbMYUO+LpU+E5rE14=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr4010888wmk.73.1602856840762;
 Fri, 16 Oct 2020 07:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 16 Oct 2020 19:00:29 +0500
Message-ID: <CABXGCsOoY+J4kfX22c=KhGui_f=M4t72xXEEkUPM3szOd0WG+A@mail.gmail.com>
Subject: Re: swapon/913 is trying to acquire lock at zcomp_stream_get+0x5/0x90
 [zram] but task is already holding lock at zs_map_object+0x7a/0x2e0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 16 Oct 2020 at 17:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Joy... __zram_bvec_write() and __zram_bvec_read() take these locks in
> opposite order.
>
> Does something like the (_completely_) untested below cure things?

Excellent! This patch (_completely_) cured all other warnings which
were present in the log.
dmesg before patch: https://pastebin.com/tZY3npHG
dmesg after patch: https://pastebin.com/iD7ZL1mb

Thanks!

--
Best Regards,
Mike Gavrilov.
