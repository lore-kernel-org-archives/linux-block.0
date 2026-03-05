Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285633B6E4
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742660; cv=pass; b=fUMqg+GB2J8NeW+GkDfG+1BZRgw/E+e7e8dF10xDqXpG2IMfPEVW9T4LGNkeMTTQoE/606ZkIG/YVyAToOucLjQKGOrVoAzWpuez/XEuhTqoVKXx67kcIwj4t9zT+1So898mLPGX6WtAiI5Qpmmu1nxQ3PK2MGAQf8cr9ARvAC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742660; c=relaxed/simple;
	bh=hu0nU5CwUWmu6r+DAlrbJzJkymGib5d+WCOluzWJl8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncvmon/nY6guG1RiOJoYI6NIRTu08J5KUXhCrF48UGxX3Bb5j9IQ9fvIypbvE/pWR/JDa/RITC4EfUy8ppYOLQUR0wzL+OvqabXPdS34mC5xti7BAZ+vjsuZcZ6RY87RHjwNnGaIkux7C3+325YsMYjcK6Av9+WUs/mAijkgCi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2Fy9r6U; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2Fy9r6U"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so1095698c88.1
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 12:30:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772742658; cv=none;
        d=google.com; s=arc-20240605;
        b=F7D+ZmcsA4PJZ7jh04/8xxWlON+CT+7TfmoxD6SnxWiVvVGod5OrhOahyLZhTi5ZAg
         J8JaLUyGuTusKdO1/42SiIIG7aN50vkTd/Wc8HwFftbhdAdz0MCyMGvjCulSW8Sc0yeQ
         nIfIFhrFi1qqX1cryXipgpl1Fy9Fjvfj8Q94CZprJBUBc06ukBe4BgmeVyPJiYdDpwh/
         2xnLALEWQvzh+EQTx/seyUZkNArfm1HYm2wG4j66P6iGG2eqW25kSiMW/UYbJIiaaufX
         +jrx6HLNeWgu49ZZviLeyaB1WII2kgNA8NzEv0hDhIiMvaydjh4nBraKYaNMrVcPaZYu
         kcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WqtwBaoPhWfAapVzu07TOim6EOD/dcsX58RvsS9D7yE=;
        fh=QN9Rce/uxPGQvhONk2Om87ISdMZqoAg631Bkqcm+Z2k=;
        b=RTfU2Lu9JDEby1CuLXTWapKsAAJKDkL2dYWPZ9WMJ1fvKOv4YNWgtTmiLw16ZIBaPp
         Mb1zio+MxPylwSB0yvsc3MEL1RZtbxsOwgkIAVwsiJrQC4l39PI5FnR9cSypWEEvOdJk
         v2iSzMpGgvB8/C4dKKuXUIY03VwaoyDcI7vR5Z0E8seQaW8cfc8RAfLlSM8UY9j/kkRs
         RVHL5tm06W82XnE8QyxlO84IT4VmIPBrULc2tZfUomJSPKMDcnEf/d8TKITS4uAxvLIB
         vNfP5LxJST+xad89ZuPi6EZuDxfhM6SSL2JSMVlXw+VUqE6hyYCKqvkPc2bcVME5i3uO
         XJVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772742658; x=1773347458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqtwBaoPhWfAapVzu07TOim6EOD/dcsX58RvsS9D7yE=;
        b=M2Fy9r6Uq77kOYROC4CX/9t7bRhxSiXsbHpAIJ+6xutt6+KmB8vhnPVp6H1o2hKDWs
         9gybKtAywRbK3ZekZwuBPd46n6xNbduXjNw2t/I1i0SJUZSJqDQuWdLNv0SY6z13kcLg
         iOHJ9SE4MUcyR0xQFxBb2GCZ3NrAgW0Pj/DCEZGvNI0zroUWqcDqlqZoFkGcMq5k/eob
         Is9yWDcVS29QIVyfGj+FXSIcSBLMObTZCOYnzf7IRgTL0PeWFrJDbiHaE6pGCKzTfTP1
         6XuTKC0uUJdlOadwgAx7mve8ojPm4sGVDxrHfqVThfUqAmba2KYxGYDl3teAFoq1pypd
         CeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772742658; x=1773347458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqtwBaoPhWfAapVzu07TOim6EOD/dcsX58RvsS9D7yE=;
        b=DQJ7l3vQvb9NB23SbRMjYFoi8aSGqkSHEPHJjBy83EG9A7b3950LaAP0FDS8gZrGIe
         e2v+Uyx+fYE9lq3lledOmGjECgbfnCVd58gYWDOj1ZCJ4SweOiytML/SqtKBS690ZvD6
         KPrAFmErdImXMlL00DKn1G+QXU7JGVjLd78q2fHH02MZoHh8Zj5ai5K20QW706gGOZZE
         ++EfaccLRv2ZQUyxTXKsU9DJWnQ7REuXBRwiGVE5oSa39ZUZszz7EGZV1dkeJhtn/lyl
         gW1sWaw1HnVg1yV5Zo01RzeX0FJn4IRjPevDyQx6fq9YxFHMc5bx7aoO9DyDeAEZJM/B
         gvwg==
X-Forwarded-Encrypted: i=1; AJvYcCXTM6mUXpbKTAff3Zs5F9+KvHpBjV6MfdproD1xHV9Yrh84G+44aGWxj87dttVK6W1+SvyWwf7/ptB+6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39h/TEb0lqBjntId9HxDK28A6yU0hfA9ZV/XRFGpRY18cNajc
	hHMPDL52InMoT9sZpj3U4J6CY3DYflUVDO8NJ4imSyq1hwWAXlZpt1gFnIrPXotcjzMJIpPCKec
	6rlQQf/RUMLKVJ4VSLQJG/NlyscBuQZx/sYD1l4pe
X-Gm-Gg: ATEYQzwrNcqTLCJU3xgFxaC37eKuQbZe0ioCwcNMcwJ7Zqm2taYKrIjuIf17Jf4eb6R
	W0Qf2tg/BlxtEdtluTYG9M365Z42mehCpKQMUHjjBWo22wl92gzqnz7KMy3h6qTJmMwht6xhctf
	O2ij/Fqcnx4imsHsO3EGmmZdaVLWIiAx0JuALGI20NC2OstBuoPzVPZ1EnFQT559wnEzCykEQis
	HVuFL1iD0RXqIu9BKKCEYLx7Q7YMT9AeuChnAj8UXPcDswcMdLCVrn+XuZlXyWEEN2F/sCKNZc3
	n8NbXsDyKAw//hiFgjUi2gCRG3TAMgu450Kjdg==
X-Received: by 2002:a05:7022:30b:b0:124:acc6:6dd1 with SMTP id
 a92af1059eb24-128b70f7458mr3837302c88.46.1772742657943; Thu, 05 Mar 2026
 12:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304194843.760669-1-bvanassche@acm.org> <20260304194843.760669-3-bvanassche@acm.org>
 <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp>
 <a7834c93-1eaf-4230-9add-d1c4b77549c8@acm.org> <CANpmjNP0gqV7A34Gsyu2AjE4Cfg=k2FX3NyLd3XhD_gTJ=jyuw@mail.gmail.com>
 <adf8116b-d88b-42dd-9790-cd4c5582271a@acm.org>
In-Reply-To: <adf8116b-d88b-42dd-9790-cd4c5582271a@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 5 Mar 2026 21:30:20 +0100
X-Gm-Features: AaiRm52wh3tu6FTlGfeVTcN2qq-5bIo6sXmq6M6zvTQQNiSo8bG9Sfsi9jzN5MY
Message-ID: <CANpmjNNKnptdQNPp5LqvH93EJnZngDY=VSmwa-Wvc76e1cgjuA@mail.gmail.com>
Subject: Re: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org, 
	Yu Kuai <yukuai3@huawei.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 15:36, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/5/26 7:18 AM, Marco Elver wrote:
> > It's a tough one, and no clear solution exists yet. Exploring the
> > design space here is the first step - I don't think "accepts a range
> > of successful return values" is trivial, because we have to either
> > list those values, or encode the possible ranges as an expression
> > which we can then match against. Only the latter is usable IMHO, but
> > implementing that in the compiler is a big deal - we need some kind of
> > solver to match expressions - or severely limiting allowed
> > expressions.
> >
> > Either way, getting that implemented and upstreamed is a ~2-3 months
> > effort. Which is why I have ignored this for now given the poor ROI -
> > the current infrastructure is opt-in, and my thoughts were to enable
> > in as many places as possible where we don't run into this issue. We'd
> > need an estimate %% what coverage we're missing and if it's worth it.
> > I understand you're working on global enablement, but this particular
> > problem needs careful design analysis before committing to anything.
>
> I'm interested in enabling compile-time thread-safety analysis for the
> kernel in its entirety. If thread-safety analysis can't be enabled for
> the kernel in its entirety I probably will stop working on this topic.
>
> Regarding your questions, so far I have identified 17 functions that
> perform conditional locking and that may return an error pointer:
>
> $ git grep -nH '__no_context_analysis.*ERR_PTR' | wc -l
> 17
>
> The most widely used among these functions is probably fc_mount(). The
> direct and indirect callers of that function include
> fc_mount_longterm(), vfs_kern_mount() and path_mount().
>
> Another concern is the concern Jan brought up: with the current support
> for conditional locking a large number of callers of conditional locking
> functions would have to be modified. If I counted correctly the patch
> "treewide: Modify mutex_lock_interruptible() return value checks" on my
> thread-safety branch includes 173 changes. There probably will be more
> kernel maintainer than Jan who will protest against these changes.

I will take a look in a few weeks if it can be fixed with a new Clang feature.

But I think you can still proceed to attempt enabling context analysis
tree-wide, but simply disable the analysis for some of these
problematic subsystems completely. Specifically, the Makefile
directive should also works as an opt-out:

  CONTEXT_ANALYSIS := n

, if you enable the WARN_CONTEXT_ANALYSIS_ALL option. Either way,
incremental enablement is the way we should pursue this, and not in an
all-or-nothing approach. I imagine the path that will work is:

1. Incrementally enable context analysis for more subsystems
(CONTEXT_ANALYSIS := y)
2. Add selective opt outs (CONTEXT_ANALYSIS := n) where
WARN_CONTEXT_ANALYSIS_ALL complains.
3. Once we have a clean WARN_CONTEXT_ANALYSIS_ALL build, make it default.
4. Remove all 'CONTEXT_ANALYSIS := y' lines.

I don't think we'll ever get 100% coverage, but even if we get e.g.
80% coverage, we're able to prevent several classes of locking bugs
from ever entering the kernel in 80% of the code. I'd take that any
day over 0% coverage (which is/was a risk when attempting to make it
perfect halts any progress). It's just a pragmatic trade-off we have
to make. New compiler features will of course help, but they shouldn't
stand in the way of getting to that XX% coverage.

Thanks,
-- Marco
