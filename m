Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C75375F7D;
	Tue, 17 Mar 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740207; cv=none; b=JLqv4sTAiAYKDAN2ajcqdIp/po16K2F0kGTkncdi9bICjAcuLOOcDv7VjE9dlGmp7hWkFfFOjkFBix03vxppa9OOGtHTREL0XEbOiDsPWf3J433tkzPVW7c64MNEzcahjVUOJm2myUnouUt5+B30dGpxMAsBhkpxpBthFeJKfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740207; c=relaxed/simple;
	bh=xLmzFPmaV4uwZSmTV4mD6v0sxHNn+jTMqp54v3/jmOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idS7LoQ+OjI2yVtBZfjQ70sdRZIFRpUQDWr5yVdFYIrnsrT3tnBG69boeaNpBbnT08ZbU1XfkUjamEnRwkVJbwCh9HdAC9TROSI+8Mi/kd2fEOQ8OpRDIogx1EtGUjzxMzmQ44GoEuLC+IpEUrsYeB/ZC9u+xyCT7HFt43CFwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4pVea9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4pVea9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6124DC19425;
	Tue, 17 Mar 2026 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740207;
	bh=xLmzFPmaV4uwZSmTV4mD6v0sxHNn+jTMqp54v3/jmOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i4pVea9D26RyGMnS6uxLPkM60dDwGuu4MZeDWllV+nbtf2LryBuQOeV1Ey7Fl1ri9
	 Lnwmmrj0p3hW172th3Zb4SQ8E5NLNTzj4I6xuJRaFipPaeB8tTZg7/8qYDdpLQDVuu
	 WH4JOML31ZyqSQVuKcEgry524LGFPhmFDC7MVSj0imXCg56jUjDwJBOyywhv9ARc27
	 xntLFuBZ8kcTcI/3UHYVro8qD6F1JG1k9XkPJqiHvFq2EbZRnqty/kqOwUZUuQ/wqi
	 MXYpS1mR31+KYyAq6DLhTk15m04ESgxev3RxzSWsJG3i9ttQpQX9PQfIftkUCwCjDD
	 hchK4tmKWmXew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Damien Le Moal
 <dlemoal@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, Hans
 Holmberg <Hans.Holmberg@wdc.com>, Jan Kara <jack@suse.cz>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, John Pittman <jpittman@redhat.com>,
 John Stultz <jstultz@google.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Miguel Ojeda <ojeda@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Niklas Cassel <cassel@kernel.org>, Nitesh
 Shetty <nj.shetty@samsung.com>, Oliver Mangold <oliver.mangold@pm.me>,
 Pankaj Raghav <kernel@pankajraghav.com>, Shin'ichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, Theodore Tso <tytso@mit.edu>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, gost.dev@samsung.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC][RESEND] Status of Rust in the block subsystem
In-Reply-To: <2026031730-sixties-camcorder-bf42@gregkh>
References: <878qcpbux5.fsf@kernel.org>
 <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
 <abiXkTSpZ8CWbJVx@kbusch-mbp>
 <SHJfcozLGkQIhP4Uu-FI07pSniNPU4Fm-OSq0PjGt2cWg4gimUJttaJz_iEyz-brOqgvcqUd_camzQwgRS9-Ag==@protonmail.internalid>
 <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
 <87a4w6swup.fsf@t14s.mail-host-address-is-not-set>
 <_GaL00txVaF_Sjyfl2GBXOxmALDBVv79LLeKGF5q6AEczDDrzeikvRn3a2ZMXSldlNCa2czJP_YOVEKOuP-MbQ==@protonmail.internalid>
 <2026031706-simile-cornball-7744@gregkh>
 <874imesvsi.fsf@t14s.mail-host-address-is-not-set>
 <8zT8NOBL0VUIdwEkzIrXtDFYg40i9cIpRq2qlooYVHTmq0X1Qwy-uFAXE6lR6HziYUWio4ANaIFit56sJBlStQ==@protonmail.internalid>
 <2026031730-sixties-camcorder-bf42@gregkh>
Date: Tue, 17 Mar 2026 10:36:33 +0100
Message-ID: <87y0jqre5a.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg KH" <gregkh@linuxfoundation.org> writes:

> On Tue, Mar 17, 2026 at 09:30:05AM +0100, Andreas Hindborg wrote:
>> "Greg KH" <gregkh@linuxfoundation.org> writes:
>>
>> > On Tue, Mar 17, 2026 at 09:07:10AM +0100, Andreas Hindborg wrote:
>> >> "Hannes Reinecke" <hare@suse.de> writes:
>> >>
>> >> > On 3/17/26 00:51, Keith Busch wrote:
>> >> >> On Wed, Mar 11, 2026 at 02:21:00PM +0100, Andreas Hindborg wrote:
>> >> >>> As this topic was not selected for discussion at LSF, and I did not
>> >> >>> receive an invitation for LSF this year, I propose that we discuss these
>> >> >>> two topics on list.
>> >> >>>
>> >> >>> I do believe that these topics need to be discussed, and I would very
>> >> >>> much appreciate your input.
>> >> >>
>> >> >> I can sympathise the difficulty of maintaining external modules.
>> >> >>
>> >> >> In terms of this being a reference driver, that implies some future
>> >> >> hardware driver may leverage this for its development. Is there anything
>> >> >> in mind at this point for production? If so, maybe that use case should
>> >> >> take the lead. But either way, I think rust-nvme upstream inclusion
>> >> >> would invite confusion. Once it's upstream, it's no longer a reference
>> >> >> when distros and users turn it on.
>> >> >>
>> >> > I wholeheartedly agree.
>> >> >
>> >> > While I do see the original appeal to have a rust-nvme driver, having
>> >> > one will just lead to confusion on all sides, especially for distros.
>> >> > (Why is it there? should it be preferred to the original one? Do we
>> >> > have to support both of them? Are there features missing in either
>> >> > of these drivers?)
>> >> > In general we are trying hard to avoid duplication in the linux kernel,
>> >> > especially on the driver side. We constantly have to fight^Wargue
>> >> > with driver vendors why duplicating existing drivers to support new
>> >> > hardware is a bad idea, so we really should not start now just because
>> >> > the driver is written in another language.
>> >> > (That really might be giving vendors bad ideas :-)
>> >>
>> >> I actually agree to some extent. But I do think we can get around most
>> >> confusion with loud and clear documentation. We could make the driver
>> >> not probe by default, requiring a configfs setting to probe. Or leave
>> >> the PCI identifier table empty, so patching the driver is required to
>> >> make it probe.
>> >>
>> >> For me, the big benefit would be having the rust nvme driver as part of
>> >> an allmodconfig or allyesconfig. That would prevent a ton of trouble.
>> >>
>> >> We do plan to utilize the block infrastructure, but I think we are still
>> >> quite a long way from sending anything. Keeping the rust nvme driver in
>> >> tree till that point would prevent pci, dma, irq, etc. from developing
>> >> in ways that would not support a block device use case. As an example,
>> >> upstream Rust irq APIs are not actually able to support NVMe at the
>> >> moment. They work fine for GPU drivers though. And I cannot go an fix
>> >> them without a user. Same for DMA pool.
>> >>
>> >> I could go and find some other piece of unsupported PCI hardware and
>> >> write a driver for that, use that to keep the APIs in shape upstream.
>> >> It's just a lot more work and the NVMe driver is already here and 90%
>> >> ready.
>> >
>> > This implies that there really is no "need" for these rust bindings at
>> > all, if you don't know of, or are planning for, any real driver for
>> > them.  So why have them at all?
>> >
>> > For the PCI and driver core bindings, and the majority of the other ones
>> > merged, we have real users (binder, nova-core, etc.) and so we are
>> > willing to take them and keep them up to date.  For these block
>> > bindings, why is it even worth it to have them around if there's never
>> > going to be a real user?
>>
>> I'm just going to quote myself in case you missed these few sentences:
>>
>>   We do plan to utilize the block infrastructure, but I think we are still
>>   quite a long way from sending anything.
>>
>> <cut>
>>
>>   My fear is that by then, I have to patch a number of GPU drivers in the
>>   process.
>
> That's the "penalty" for not getting your code "ready" sooner :)
>
> Seriously, don't make others do the maintenance work on these apis until
> you have something that you want to have merged.  It's always been that
> way in Linux, this isn't anything new.

That is fair.

I appreciate you all taking your time to discuss this. I think with the
input I have now received (again), I'm going to let go of the rust NVMe
driver and focus my energy elsewhere. We'll carry patches for the
subsystems we need downstream, until we are ready to send a real user.


Best regards,
Andreas Hindborg

