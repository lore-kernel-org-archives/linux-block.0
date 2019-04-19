Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF921C282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAAC208C0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 21:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="RL68ayPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfDSVQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:16:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45008 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfDSVQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 17:16:31 -0400
Received: by mail-yw1-f67.google.com with SMTP id x84so669411ywd.11
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hvjN0788XGTPoZtwwgzsU9oW2wWbr/UmTq8LI6v2CVA=;
        b=RL68ayPa2YsbLU6MnLBfcRWRyySgigQQ+2wKw/aeS98Ca0eStyJU+b8CemMx+WDxGm
         CUHW3bDAJJSiXr8VXDM3Y1HoDgewiZyRqV5bHiTo1KHLnqp0r7fH/coso9hehnjNpc/V
         V8s7DpbjJl8cc4rs66TSQBja/zB11lC4Ia7l1DIgqkOqUQ5pRH6zKq4hKdY0GtpBvcQ1
         RY/6xBaG9ecHD/lxGaXY7s7zrL0s8sev9/zoQUyBG0z2VlNbtw8db8DiJkTj4Y5excI/
         4Yt8jML3G05kgrVtmPS7rwoFnOS0t4YyQDztF2grRD94zk88aKF43PeGol9JDMAYq1IQ
         SmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvjN0788XGTPoZtwwgzsU9oW2wWbr/UmTq8LI6v2CVA=;
        b=bg/UnyqwSmRT97y+IARZi6ZGzsabrFZxfSZ3bgPrWgKO6AkB9xGuVGZPGhSx0IGL4V
         qUTiINecxbgyJK7ttEY3AuwUOQswyBdIQyvcwW7+GDB/8cIwHLUfOmMreHUiBtz8LLJU
         jhNi4mYPsP+M20NoSAyRkuSEM0q3GNbZs8fLLwz2+GvH+AAXLP470f8XZonT8bJe9JAu
         f2Z1PvBixyFhScEv4yAFhAbgPSJe4U14ciM8k95+KU9BaokBLZW5O2JWPWKDtJVeb3wt
         t9NLpsRT230YOevHFZNS0pityB8YxzNV5ckmjwgxgXKFkDHsRAVfvXkGjDj/x/mLK0mb
         cYVg==
X-Gm-Message-State: APjAAAVcqenthYHckqyrgxjlTGrMyVRxVNNvKerzUyv6k2GexKARTThk
        TM6Vp7EqujmaR44ROHsVyHibag==
X-Google-Smtp-Source: APXvYqz710yg1aQnyb5hmsYcYpihRMyNYyWsjmr/3Dh9dhywgaW2sTDOHiGcj+12FPtouBkVUNS7wQ==
X-Received: by 2002:a81:1b53:: with SMTP id b80mr4745472ywb.443.1555708590972;
        Fri, 19 Apr 2019 14:16:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1c6c])
        by smtp.gmail.com with ESMTPSA id i206sm2138455ywi.99.2019.04.19.14.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:16:30 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:16:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     hall@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH bpf-next v3 3/5] nbd: add tracepoints for send/receive
 timing
Message-ID: <20190419211628.zzn42bfpqelfq52p@macbook-pro-91.dhcp.thefacebook.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-4-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419210409.5021-4-mmullins@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 19, 2019 at 02:04:07PM -0700, Matt Mullins wrote:
> From: Andrew Hall <hall@fb.com>
> 
> This adds four tracepoints to nbd, enabling separate tracing of payload
> and header sending/receipt.
> 
> In the send path for headers that have already been sent, we also
> explicitly initialize the handle so it can be referenced by the later
> tracepoint.
> 
> Signed-off-by: Andrew Hall <hall@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
