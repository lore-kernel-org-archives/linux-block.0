Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101D198E91
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745721284; cv=none; b=Anc15LP5L7y2SXuCweMmNrZ3is/lvA01Od46/dYGYk4zSEfvEVqWz4Wnzlqev4Xo0CtxQlc1K95yP0D/ir6zSeov3iO6c9EJrNw3wcnT8+zfnZgoQb2bPj6MpYptOS9kPuS0g9EM+NKgxx7JcIgLSHm1lNDUAa7LPAPrdFBG3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745721284; c=relaxed/simple;
	bh=03LbawJe26o6L/mUYPX1dN2FGVGEkmIPbKjTCYLCn/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlSyunH/JLXFOl/rjC6Obhoh4XdqxFDBayVBXd6MQGjJQN/CHhjXAWzMweAk70Z7kLRNWvTvsU6P6O5728jByAGaFfQa0+fmCOcrOKMor/rogIsgTBOQ5AjSRkh24DJCh+uLUmUVe/ILtsxrnsQy6FA61I2ECM4n29FiL0Veq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygh3807D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygh3807D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB83C4CEE2;
	Sun, 27 Apr 2025 02:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745721284;
	bh=03LbawJe26o6L/mUYPX1dN2FGVGEkmIPbKjTCYLCn/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ygh3807DSdl523G8ec7VuFDRCwRyunnguyliNQUxJOvgQXry1vGNiyc1DQoUjCLos
	 CNJ7mGdREDQFIg3v/99rcSpbhPAVWzc5xpAuNWD8olAFXqR75zJwe6l6Xaf+hU+fbc
	 /zSqzq88riMaCUhegje3KrevPzoeQOo+vz/VXiuOwuUotn3dHWgB2fzsK/yu9xRPW9
	 wrgfZJwDa5pJcGatEcu8WOLcdqjM1Mtk+6xJucL2mLFFn/UoG1DzuP2CLsQLEafYvj
	 14jRqIaBGyNG7pjYnIgm9LqR0DSS1/IsNJ3go7wSoGX0XlxGXYBq7pzjgpVyEqGdoR
	 O2BqVz8REkBBw==
Date: Sat, 26 Apr 2025 20:34:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
Message-ID: <aA2XwIcOPysPTra9@kbusch-mbp.dhcp.thefacebook.com>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-4-ming.lei@redhat.com>
 <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>

On Sat, Apr 26, 2025 at 03:42:59PM -0700, Caleb Sander Mateos wrote:
> On Sat, Apr 26, 2025 at 2:41 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
> > register/unregister uring_cmd for each IO, this way is not only inefficient,
> > but also introduce dependency between buffer consumer and buffer register/
> > unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
> > in which backing file IO has to be issued one by one by IOSQE_IO_LINK.
> 
> This is a great idea!

This is very similiar to something I proposed off-list, and the feedback
back then was this won't work because the back-end ring that wants to
use the zero-copy buffer isn't the same as the ublk server ring
recieving notification of a new command; the ublk driver has no idea
which uring to register the bvec with. Also, this is using the request
"tag" as the io_uring buf index, which wouldn't work when the ublk
server ring handles multiple ublk devices due to the tag collisions.

If you're can make those trade-offs, then this is a great simplification
to the whole thing.
