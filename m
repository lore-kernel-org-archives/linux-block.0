Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895653148D5;
	Wed, 11 Mar 2026 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235274; cv=none; b=ICB8mf0cVnu7WOb/qjGSYGZqe0yDVV7C2B3jnIzHDWNEyyI0WEZ2l+IBdR3kDTr2KCOdgvfp4MINlD97xEJGC7ZAE0WfK6bEWRubtGtv4gmIBK4BFhXG1Sw+dmQz9jN5zplej0qCZkqSCXLeK+D7a7pWqftg3Aa5iOXpbslY//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235274; c=relaxed/simple;
	bh=RXdVi4o90dChxbva+1+5nQfEtOIAGmmKN8r49o1nvfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNeMg3BideDri5Uc7zw8pdKFn5e11uPwiJh7aQeajWznKE2H5dkxqYTEvp3JgZUHC+kAnBqHbWiHhqceSvkysX+Ib0s0o7i/BbLpLw0EqnWgvJnswgBa2wb68ukIi30OC1GijNqVCJNfNfJR232dYBveiXolgKq5bkI8GZpVgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYslXCcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYslXCcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B50C4CEF7;
	Wed, 11 Mar 2026 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773235274;
	bh=RXdVi4o90dChxbva+1+5nQfEtOIAGmmKN8r49o1nvfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SYslXCcg8ZocLdT9Nn5mr1QaU/7bNoDc232jum50wN6xbNZ+uWju1afqBneVGuocz
	 1HKDIt816EDwj5iiTFX9r+Xx0k5/Bv68ggEGGRF42q7ddeuXmYn246eMpyZbeIthSb
	 dIkZdQtgPyPKlIey0NGOHM4yAFo042f7KigtmT2i+P3iJcYA/mT/hwzyIaKf8L8SC5
	 9h83BXWCfD6U7KdEYFv4VjKFpSCBLpiLKoc11feaKvkpUyTWxniWYSKZ5NC4byurtY
	 dgnZG3oI4Zzg1+D4eP4qTrFzLJjA7SSkqBSG8TuL6AkN+zGOQf7fkx76g9IGtoP5aN
	 xqQ3vT7odEcMg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Pittman <jpittman@redhat.com>, John
  Stultz <jstultz@google.com>,  "Martin K.
  Petersen" <martin.petersen@oracle.com>, Miguel Ojeda <ojeda@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Niklas Cassel <cassel@kernel.org>,
  Nitesh Shetty <nj.shetty@samsung.com>, Oliver Mangold <oliver.mangold@pm.me>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Theodore Tso <tytso@mit.edu>, Wedson
  Almeida Filho <wedsonaf@gmail.com>, gost.dev@samsung.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC][RESEND] Status of Rust in the block subsystem
In-Reply-To: <878qcpbux5.fsf@kernel.org>
References: <878qcpbux5.fsf@kernel.org>
Date: Wed, 11 Mar 2026 14:21:00 +0100
Message-ID: <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> I would like to propose a session to discuss the status of Rust in the block
> subsystem. I have two distinct points to discuss: 1) The status of Rust in the
> block layer, and 2) the out-of-tree Rust NVMe driver.
>
> == The status of Rust in the block subsystem ==
>
> Rust has special status in the block subsystem [1]. We are currently at "Stage
> 1" of a two stage "kind of thing", where enabling Rust code in the block
> subsystem is essentially an experiment that can be terminated if it does not
> work out. In order to move on from this stage to "Stage 2", where Rust in the
> block subsystem is a first class citizen, we need two things. 1) We must observe
> that Rust is applicable for writing block device drivers and 2) the kernel in
> general must have fully adopted Rust.
>
> For 1) I just sent a patch series that brings the Rust null block driver to
> feature parity with the C counterpart [2]. Although the null block driver is not
> real hardware, I think this submission goes a long way to demonstrate that
> Rust is in fact applicable for writing block device drivers.
>
> For 2) I would point to the fact that Rust in general is no longer experimental
> in the kernel as a whole [3]. The "Rust Experiment" has been concluded,
> successfully. We see adoption in the form of the binder driver, and in the
> large, ongoing, effort targeting GPU drivers in the DRM subsystem. A few network
> PHY drivers also made it in. There is a lot of activity on the Rust list though,
> and I expect we will see Rust in more and more subsystems over the next few years.
>
> On that basis, I suggest we discuss whether or not we can move to "Stage 2" -
> and what that entails.
>
> == The out-of-tree Rust PCI NVMe driver ==
>
> As you may know, I am maintaining a Rust PCI NVMe driver out of tree. For the
> development work of the block layer Rust APIs, it has been essential to
> implement a real driver, in addition to the null block driver. A driver
> targeting actual hardware has to deal with interrupts, registers, IO memory,
> DMA, memory mappings, in a way that an emulated device does not. Keeping this
> driver around has helped shape the Rust block APIs in a way that makes sense for
> real devices, not just emulated ones.
>
> Rebasing this driver every cycle is a lot of work. Driven by requirements of the
> DRM drivers, core Rust APIs for DMA, register access, IO memory, etc. are being
> reshaped and rethought, which is great. Rebasing on top of these changes as a
> second class citizen all the time - not so great. But I believe that the Rust
> NVMe driver is a great piece of reference code, so I keep doing it.
>
> I would ask that we discuss merging the Rust NVMe driver so as to have a reference
> implementation of a real driver in-tree. I think it would have the following
> benefits:
>
>  - It would help ensure that the Rust block layer API actually works with real
>    devices.
>
>  - It would help make sure that the changes to core APIs that are made to
>    facilitate other subsystems are done in a way that is compatible with block
>    layer requirements.
>
>  - It would serve as a nice reference implementation and a great piece of
>    documentation.
>
>  - I would not have to rebase it all the time. Patches changing Rust APIs used
>    by Rust NVMe would have to change the Rust NVMe call sites.
>
> Please note the emphasis on *reference* driver. I am not suggesting to replace
> the existing C driver. I will maintain the new code if necessary.
>
> If we could establish consensus on this, I would clean up the driver to a state
> where it can be included in the kernel.
>
> Best regards,
> Andreas Hindborg
>
> Link: https://lore.kernel.org/r/593a98c9-baaa-496b-a9a7-c886463722e1@kernel.dk [1]
> Link: https://lore.kernel.org/r/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org [2]
> Link: https://lore.kernel.org/all/20251213000042.23072-1-ojeda@kernel.org/ [3]

As this topic was not selected for discussion at LSF, and I did not
receive an invitation for LSF this year, I propose that we discuss these
two topics on list.

I do believe that these topics need to be discussed, and I would very
much appreciate your input.

Cc: Jens Axboe <axboe@kernel.dk>,
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>

Best regards,
Andreas Hindborg


