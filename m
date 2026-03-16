Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015F27FB18;
	Mon, 16 Mar 2026 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705109; cv=none; b=QT4g+2IbRg4I5WYCDcCGt28bWl+mTI8SKVtkOJeVHSWV3Vqxrgmr+ldUE/qSSMT6ief4uLZt92TRXP2fXgfIfEWLH/VZ/xtkxpzwkszqCRoaGh/TxMCvJjgKlB3jT+V/Bd0PATeLjYwS6TKFtiGb8UME3RPN7OXVTmUvwTvW8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705109; c=relaxed/simple;
	bh=alHPy1osXUvrgfN4YBAjlweiFW13jCwbEx/aQkDdYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqCltiCc7Lh+YZ/m9HauSDQqy8MWuXwK66mJWzSAgOMWAzmsMxyTAkuqWu1HxuVDZoAc4Aq6kGxb28xDDNWLTo3bu3g9lAKrEw/ZEIOjOyS46MoxWs6xmAtmARg4HGOQbgI0ahAmwqaMN2hHtqWbTKbNcKEntuQ6M5gVuqINKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke3T/QV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke3T/QV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F4CC19421;
	Mon, 16 Mar 2026 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705109;
	bh=alHPy1osXUvrgfN4YBAjlweiFW13jCwbEx/aQkDdYww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ke3T/QV8nubHG14IGjMbgT8v6PR9ktklFNGrXHzRupwo46vwnH47cC0/2OtxiTRdA
	 DPQCG2YCF4pCoX82z4AUZArg1yLP8WK2cOWIJ6tVSL3bCnMzWy5CTHQRQ2+id8+dbI
	 W4zObwLGWAMQktDymohk9tpVCT0zumdgJSt8CdAbD7meA4vUQcA4Kjp1FMctZn/w6J
	 daar/92ezeH3lslbtXU0UUbNN7GbgKdlQR+IMiwzAtUWHeDiw9YbF6ax9JW7CD8Ogk
	 yxEF0hht8LlNJQDXv5qIKmXuoTS+rMRMDmER8vSmjaOLcjvACiQtkmL50inTByJ6DD
	 lCa/VV9Ymmxqg==
Date: Mon, 16 Mar 2026 17:51:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, lsf-pc@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>, Hannes Reinecke <hare@suse.de>,
	Hans Holmberg <Hans.Holmberg@wdc.com>, Jan Kara <jack@suse.cz>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Pittman <jpittman@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Oliver Mangold <oliver.mangold@pm.me>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Theodore Tso <tytso@mit.edu>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, gost.dev@samsung.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC][RESEND] Status of Rust in the block subsystem
Message-ID: <abiXkTSpZ8CWbJVx@kbusch-mbp>
References: <878qcpbux5.fsf@kernel.org>
 <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>

On Wed, Mar 11, 2026 at 02:21:00PM +0100, Andreas Hindborg wrote:
> As this topic was not selected for discussion at LSF, and I did not
> receive an invitation for LSF this year, I propose that we discuss these
> two topics on list.
> 
> I do believe that these topics need to be discussed, and I would very
> much appreciate your input.

I can sympathise the difficulty of maintaining external modules.

In terms of this being a reference driver, that implies some future
hardware driver may leverage this for its development. Is there anything
in mind at this point for production? If so, maybe that use case should
take the lead. But either way, I think rust-nvme upstream inclusion
would invite confusion. Once it's upstream, it's no longer a reference
when distros and users turn it on.
