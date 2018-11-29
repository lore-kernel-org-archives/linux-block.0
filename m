Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6FEC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8056121104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 18:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8056121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeK3F1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:27:00 -0500
Received: from foss.arm.com ([217.140.101.70]:42766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeK3F1A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 00:27:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8307980D;
        Thu, 29 Nov 2018 10:20:44 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BEB3F575;
        Thu, 29 Nov 2018 10:20:43 -0800 (PST)
Date:   Thu, 29 Nov 2018 18:20:41 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-block@vger.kernel.org, liuyun01 <liuyun01@kylinos.cn>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
Message-ID: <20181129182040.GR3505@e103592.cambridge.arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
 <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 07:09:10PM +0100, Ard Biesheuvel wrote:
> On Thu, 29 Nov 2018 at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:

[...]

> > > +static struct xor_block_template xor_block_arm64 = {
> > > +     .name   = "arm64_neon",
> > > +     .do_2   = xor_neon_2,
> > > +     .do_3   = xor_neon_3,
> > > +     .do_4   = xor_neon_4,
> > > +     .do_5   = xor_neon_5
> > > +};
> > > +#undef XOR_TRY_TEMPLATES
> > > +#define XOR_TRY_TEMPLATES           \
> > > +     do {        \
> > > +             xor_speed(&xor_block_8regs);    \
> > > +             xor_speed(&xor_block_32regs);    \
> > > +             if (cpu_has_neon()) { \
> > > +                     xor_speed(&xor_block_arm64);\
> > > +             } \
> > > +     } while (0)
> >
> > Should there be a may_use_simd() check somewhere?
> >
> > If we invoke this in a softirq I don't see what prevents us from
> > corrupting the task's NEON state.
> >
> > (The check might be in some surrounding glue code that I missed...)
> >
> 
> There is no check. This code should simply not be called from
> non-process context, same as the RAID56 code.
> 
> This is not terribly robust, obviously, but appears to be common
> practice in this realm of the kernel.

Fair enough -- I was just curious.

If this goes wrong, we should get a clear splat in kernel_neon_begin()
anyway.  I'd be more concerned if we could just end up scribbling over
the NEON state silently.

Cheers
---Dave
