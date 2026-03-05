Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7726AF4
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721371; cv=none; b=gGKcAlt/XmOUjqGikP+HTR1VKOuRpEXAYFqL0a8CRClFiSj0mrLz5WmJC/CBPiKB8IHX27Us47ssdymeWwuW/ZDs7AFJKUMBgkXvmSq6lzpOnOJHMPrJkAxUwfKAH6gEKZyjP/qI1YU/7qwI1q3H22mpfxLNJgA9xxgRGHo+glU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721371; c=relaxed/simple;
	bh=gPDQSiRMlnXGq1lpzK7vHGuOq7ZpePhHZ1fiiuyIP34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTszWgEH3k3NcUpSE3u5fC6QZLhJHOTgpaRkbHX7yyVTtxbvrVT6JVmkWh0YeWsl8CItkoLmqOVR1f1+x1QARPFM+TNKOW1V+HDTuUOjXOkYEBt+hHv74/vvarKPMXaqDhTLDC0jpjrMdL7Lv+r3LCV3fL8SVV9ncl0tqepSAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yztMxbQl; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yztMxbQl"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fRXCY5fhbzlh1Rb;
	Thu,  5 Mar 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772721364; x=1775313365; bh=vqcEVW66IQt4Woec1RZhhnYE
	N61x+uvz4GOE+opTKy8=; b=yztMxbQl7ULCB3BOfDOIkDyUrrlxZi+YJVVgRnqT
	voSwI45l06v0IKijGdYFTE+BXqgQNPfT2jIlcdz1roJvzvxm/8WUGOHie8ZgZecK
	1Sa/VI+QRoPA/o41Pxp8zfTDWOw0J1ilFXVISpYj2P5dTmIQ4ecedIAOB8ATFzk0
	FatLmLAeVgeBTLVsKTasWEgRzTwAxwhhABPJwScV0y38fbbuAouvTyV8t3FnnW6S
	ET37XhQe+BJ6tHNy/6tcwfVCmPCTD9MUipDJ0HozMiGfSQ0Ki4hv0TcoasBjVO6u
	/hGIqCBBKRGbsjMJVrl+v92DxkadCwpoivcZxwg7NY87Fg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8kcgr82mTT8d; Thu,  5 Mar 2026 14:36:04 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fRXCP4lHtzlh1Rd;
	Thu,  5 Mar 2026 14:36:01 +0000 (UTC)
Message-ID: <adf8116b-d88b-42dd-9790-cd4c5582271a@acm.org>
Date: Thu, 5 Mar 2026 08:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety
 analysis
To: Marco Elver <elver@google.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-3-bvanassche@acm.org>
 <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp>
 <a7834c93-1eaf-4230-9add-d1c4b77549c8@acm.org>
 <CANpmjNP0gqV7A34Gsyu2AjE4Cfg=k2FX3NyLd3XhD_gTJ=jyuw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNP0gqV7A34Gsyu2AjE4Cfg=k2FX3NyLd3XhD_gTJ=jyuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 7:18 AM, Marco Elver wrote:
> It's a tough one, and no clear solution exists yet. Exploring the
> design space here is the first step - I don't think "accepts a range
> of successful return values" is trivial, because we have to either
> list those values, or encode the possible ranges as an expression
> which we can then match against. Only the latter is usable IMHO, but
> implementing that in the compiler is a big deal - we need some kind of
> solver to match expressions - or severely limiting allowed
> expressions.
> 
> Either way, getting that implemented and upstreamed is a ~2-3 months
> effort. Which is why I have ignored this for now given the poor ROI -
> the current infrastructure is opt-in, and my thoughts were to enable
> in as many places as possible where we don't run into this issue. We'd
> need an estimate %% what coverage we're missing and if it's worth it.
> I understand you're working on global enablement, but this particular
> problem needs careful design analysis before committing to anything.

I'm interested in enabling compile-time thread-safety analysis for the
kernel in its entirety. If thread-safety analysis can't be enabled for
the kernel in its entirety I probably will stop working on this topic.

Regarding your questions, so far I have identified 17 functions that
perform conditional locking and that may return an error pointer:

$ git grep -nH '__no_context_analysis.*ERR_PTR' | wc -l
17

The most widely used among these functions is probably fc_mount(). The
direct and indirect callers of that function include
fc_mount_longterm(), vfs_kern_mount() and path_mount().

Another concern is the concern Jan brought up: with the current support
for conditional locking a large number of callers of conditional locking
functions would have to be modified. If I counted correctly the patch
"treewide: Modify mutex_lock_interruptible() return value checks" on my
thread-safety branch includes 173 changes. There probably will be more
kernel maintainer than Jan who will protest against these changes.

Thanks,

Bart.
