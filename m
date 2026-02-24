Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6338BF60;
	Tue, 24 Feb 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950253; cv=none; b=UaCUsH06FRPXRiVojJJ4XQPoXj2Vsjil08oo1ELGhDHntGE29onIK4pEQA9nvnvf+KodK7amnytZeG3qCsvAqFXtNXFcTE5ZC5yHD/mAGfG6bD5YmGZjaFJrdg1VYUTkdZFI18X3wNa0CWS2GZTDfymG0+PJ66pyiqSthOEUpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950253; c=relaxed/simple;
	bh=E+YpZPlAvHFc2y94af8AqiwEjdfj3200a4PVDZwLA0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgLYZnicUh2C5fLBe8w+J6Vx1xMbHR2Wuv0iG+dBjPOJoQ7AlFm38CiRdx5Sul3Uow9xT+BTVn04uQGpsN43TR/whIMb85Gshu8XsV7m6jLK2ApBkLqx9M8ewyPmCRGsmfybVUpURbfLlVZcJns/l/KdQOOcIccxkSAEhr9hGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjhhEuX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjhhEuX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CE3C116D0;
	Tue, 24 Feb 2026 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771950253;
	bh=E+YpZPlAvHFc2y94af8AqiwEjdfj3200a4PVDZwLA0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjhhEuX28k3bGq62b9kkXXk8bpIcr7Vy+/MxBjO1oSERsQdh8MYrR4/OPe0P3MJio
	 PRbKtsuVL0iLLdG6Kl9YsNZvEqbCJMNeaDrP1O1MFV9IanQZSCSYig8ZIT/DYl326R
	 H+WhCvEzH2J9RYUElghrjApV2bLLs3t8wDa105ZB/2IUk+PDTkNYCX/gSg+8bKjbvg
	 pN39spI5iqCXlIntTL1hLkOyGQtDCAn7Db3FqoukYyf7uBaaHOi/UYI287ym6nIJI1
	 9Qu8/3c5XMNBvbSI5FHgpEIxLxB/Wl6cc9a+3F0rTACx4vkTq4/A0LGvHS/nWRRBCt
	 wbVVQKg8wNgxQ==
Date: Tue, 24 Feb 2026 09:24:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xiao Ni <xni@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
Message-ID: <aZ3Qq7kTBKGZjKp3@kbusch-mbp>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>

On Thu, Feb 19, 2026 at 01:38:46PM +0800, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework
> 
> During the implementation, I encountered several technical challenges.
> The primary challenge is performing XOR parity calculations in a true
> zero-copy manner:

Great use case. The indirect reference to memory from user space is a
bit of a blocker for various zero-copy plans, so being able to leverage
the kernel to perform parity and crypto transforms would be awesome. I
think there's potential for fuse as well as ublk.

Anyway, I'm interested in the topic.
