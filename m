Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3712CC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050DD2082F
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050DD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeK1FBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:01:50 -0500
Received: from foss.arm.com ([217.140.101.70]:44384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1FBt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 00:01:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200481DC8;
        Tue, 27 Nov 2018 10:03:08 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4D5A3F575;
        Tue, 27 Nov 2018 10:03:07 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id BCED91AE0A0D; Tue, 27 Nov 2018 18:03:25 +0000 (GMT)
Date:   Tue, 27 Nov 2018 18:03:25 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     liuyun01 <liuyun01@kylinos.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
Message-ID: <20181127180325.GA19216@arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <CAKv+Gu8u2exYQ-Q=H1_WrpmQHEddNaC7VC=OYsz-C2kbCobyGA@mail.gmail.com>
 <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 01:46:48PM +0100, Ard Biesheuvel wrote:
> (add maintainers back to cc)
> 
> On Tue, 27 Nov 2018 at 12:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 27 Nov 2018 at 11:10, Jackie Liu <liuyun01@kylinos.cn> wrote:
> > >
> > > This is a NEON acceleration method that can improve
> > > performance by approximately 20%. I got the following
> > > data from the centos 7.5 on Huawei's HISI1616 chip:
> > >
> > > [ 93.837726] xor: measuring software checksum speed
> > > [ 93.874039]   8regs  : 7123.200 MB/sec
> > > [ 93.914038]   32regs : 7180.300 MB/sec
> > > [ 93.954043]   arm64_neon: 9856.000 MB/sec
> >
> > That looks more like 37% to me
> >
> > Note that Cortex-A57 gives me
> >
> > [    0.111543] xor: measuring software checksum speed
> > [    0.154874]    8regs     :  3782.000 MB/sec
> > [    0.195069]    32regs    :  6095.000 MB/sec
> > [    0.235145]    arm64_neon:  5924.000 MB/sec
> > [    0.236942] xor: using function: 32regs (6095.000 MB/sec)
> >
> > so we fall back to the scalar code, which is fine.
> >
> > > [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
> > >
> > > I believe this code can bring some optimization for
> > > all arm64 platform.
> > >
> > > That is patch version 3. Thanks for Ard Biesheuvel's
> > > suggestions.
> > >
> > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> 
> This goes with v4 of the NEON intrinsics patch.
> 
> Jackie: no need to resend these, but next time, please repost the
> series entirely, not just a single patch, and keep the maintainers on
> cc.

Actually, it would be helpful if they were resent since I'm currently CC'd
on a v4 1/1 and a v3 2/2 and don't really know what I'm supposed to do with
them :)

Will
