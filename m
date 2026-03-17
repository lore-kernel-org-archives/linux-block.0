Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2E374E6F;
	Tue, 17 Mar 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734843; cv=none; b=lj/LjtXyEZxjpH7oe8W6qQV2F7A6DuUwq/6yvOOcfyLJFmy71WDQ6fpNhzX4J4eABo9U9jESNuMeZcAe1KFtK/h+4nhrPhnZXyZTRjkGzd75HdV4OD5v3qrL/on5Cp7exU7dcloorSHGpdLgptP8/2+PSrenRs3gZ53+YVfzELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734843; c=relaxed/simple;
	bh=FITm9A8UIKgHqWy1u5OiJZbLLUBgK+mnHdRGjmi9HN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoPE2FD1M4U+9prFQdEjySfJXcwo23R1pkm2AIDGf1V/qLjzPVEDOjAkHQSm15obiO0+SlHakRKjQFcgFbkyvLWnM8amrB6ZV2S/u+zThDmSvm0ShOjPwn2fcAuVscLLqSBFPVIPm3ktfyOzIi2xkDBOpwk4N/ddTdYIyvVXYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idoj2u/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idoj2u/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6042BC4CEF7;
	Tue, 17 Mar 2026 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773734843;
	bh=FITm9A8UIKgHqWy1u5OiJZbLLUBgK+mnHdRGjmi9HN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Idoj2u/C1a5qo5r43NdAcHx5/MJjALBeKR1Vq09COJQZwtyHqjwqdY1MlZ3TNTgvz
	 vk0LZkaEOWa50j5pZXsQDxzrhdXzLqlbzlT6j8obNAGa3WwkfU2jrsroiAAGhVb0oq
	 9r+9P1bEZGsPpkY0f+sKe2kCTwyyaZDUCo4tAPUeeeCP1lG6uTF1gfQo/AOopsVOBV
	 eHD8TvJo5oThODL3cHYFsv+zojgJfUMX+xKfkYJwjIgpLeWvmeLagQmcKMP07PrFGX
	 6nRSHPEJnjbf7mkVQB3xQbUlIZ9ngwbSrCL5qyP6ETchymHPrCFCNCmaNoL/10mQB+
	 qmp4YCsKblEYw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi
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
In-Reply-To: <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
References: <878qcpbux5.fsf@kernel.org>
 <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
 <abiXkTSpZ8CWbJVx@kbusch-mbp>
 <SHJfcozLGkQIhP4Uu-FI07pSniNPU4Fm-OSq0PjGt2cWg4gimUJttaJz_iEyz-brOqgvcqUd_camzQwgRS9-Ag==@protonmail.internalid>
 <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
Date: Tue, 17 Mar 2026 09:07:10 +0100
Message-ID: <87a4w6swup.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hannes Reinecke" <hare@suse.de> writes:

> On 3/17/26 00:51, Keith Busch wrote:
>> On Wed, Mar 11, 2026 at 02:21:00PM +0100, Andreas Hindborg wrote:
>>> As this topic was not selected for discussion at LSF, and I did not
>>> receive an invitation for LSF this year, I propose that we discuss these
>>> two topics on list.
>>>
>>> I do believe that these topics need to be discussed, and I would very
>>> much appreciate your input.
>>
>> I can sympathise the difficulty of maintaining external modules.
>>
>> In terms of this being a reference driver, that implies some future
>> hardware driver may leverage this for its development. Is there anything
>> in mind at this point for production? If so, maybe that use case should
>> take the lead. But either way, I think rust-nvme upstream inclusion
>> would invite confusion. Once it's upstream, it's no longer a reference
>> when distros and users turn it on.
>>
> I wholeheartedly agree.
>
> While I do see the original appeal to have a rust-nvme driver, having
> one will just lead to confusion on all sides, especially for distros.
> (Why is it there? should it be preferred to the original one? Do we
> have to support both of them? Are there features missing in either
> of these drivers?)
> In general we are trying hard to avoid duplication in the linux kernel,
> especially on the driver side. We constantly have to fight^Wargue
> with driver vendors why duplicating existing drivers to support new
> hardware is a bad idea, so we really should not start now just because
> the driver is written in another language.
> (That really might be giving vendors bad ideas :-)

I actually agree to some extent. But I do think we can get around most
confusion with loud and clear documentation. We could make the driver
not probe by default, requiring a configfs setting to probe. Or leave
the PCI identifier table empty, so patching the driver is required to
make it probe.

For me, the big benefit would be having the rust nvme driver as part of
an allmodconfig or allyesconfig. That would prevent a ton of trouble.

We do plan to utilize the block infrastructure, but I think we are still
quite a long way from sending anything. Keeping the rust nvme driver in
tree till that point would prevent pci, dma, irq, etc. from developing
in ways that would not support a block device use case. As an example,
upstream Rust irq APIs are not actually able to support NVMe at the
moment. They work fine for GPU drivers though. And I cannot go an fix
them without a user. Same for DMA pool.

I could go and find some other piece of unsupported PCI hardware and
write a driver for that, use that to keep the APIs in shape upstream.
It's just a lot more work and the NVMe driver is already here and 90%
ready.

Or we can fix the APIs at a later point, when we have a user for them
that is not a duplicated reference driver. My fear is that by then, I
have to patch a number of GPU drivers in the process.


Best regards,
Andreas Hindborg


