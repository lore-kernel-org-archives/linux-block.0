Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01933D8123;
	Wed, 15 Apr 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266408; cv=none; b=GfM9tzgeafx1o7+G0FdsioktHlBBRHTR97mL3g+ZP4XdWU+9fpo56qMO9gK9xbXxVznaHq6mVWEa+j9IaSjLux0avuqKvoE4KC/ktGgdlboCA3VME5UNcHGWbeD8m20DROMU48dZyKBtJUo+x/Tc+/gFgPgnLeXivxAmZ8yqu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266408; c=relaxed/simple;
	bh=B/Hyg7x8PYnDVSR14340tPKetY3zAVNOK3YI7sycpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2GILU/D4ksqchB1zzpCxMVXbYfLum47v4vE7gOy+V/Tp12xhvuV81f1IQKYU0fxsqomZzTI5XQXE9qcyEBnRFsksHSS9uVgRoIl9kvrND6nlb+JhiDFiLRMwenZf6dCey6agJCQFh0gyWm3DdO9gG4Fu59Pj5+U2UcnDmCFznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXV/xMAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXV/xMAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09927C19424;
	Wed, 15 Apr 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776266408;
	bh=B/Hyg7x8PYnDVSR14340tPKetY3zAVNOK3YI7sycpEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXV/xMAQIT0yjw5vtey1URygslRf4JQte4jVZVEM+w9dKkB3d4LfCa+xG1U+mulX6
	 iySJxY+mMyQtj01rrAEJggFALLl2u/iY9LcbHo8c1yhUUUOlpKHA/UGadIKKhfryRs
	 BX6DmatYXXUiou79qMjuGVRAaBM9Px/MJmTyvCA0klwpq77RZc1oVTx9vCnYzmUeG5
	 wKz0H3Ta2Mc6VHs+eGul3vXrY460eAJEzEmU0AjGzdcxmWWNWuuFqRdHDhM60wBU5j
	 Ej9CCYztz9L45StPO9XyFBiovg1WkivxH6GmXJgJW/vtQ9nzo6cS4i7K3SNw8aRYIr
	 POVZDtwgK64RQ==
Date: Wed, 15 Apr 2026 09:20:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Tom=E1s?= Trnka <trnka@scm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Spurious raid1 device failure triggered
 by qemu direct IO on 6.18+
Message-ID: <ad-sprBWPA20iola@kbusch-mbp>
References: <2982107.4sosBPzcNG@electra>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2982107.4sosBPzcNG@electra>

On Wed, Apr 15, 2026 at 02:18:59PM +0200, Tomás Trnka wrote:
> Since 6.18, booting a VM that is backed by a raid1 LVM LV makes that LV 
> immediately eject one of the devices. This is apparently because of a direct 
> IO read by QEMU failing. I have bisected the issue to the following commit and 
> confirmed that reverting that commit (plus dependencies 
> 9eab1d4e0d15b633adc170c458c51e8be3b1c553 and 
> b475272f03ca5d0c437c8f899ff229b21010ec83) on top of 6.19.11 fixes the issue.
> 
> commit 5ff3f74e145adc79b49668adb8de276446acf6be
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Wed Aug 27 07:12:54 2025 -0700
> 
>     block: simplify direct io validity check
>     
>     The block layer checks all the segments for validity later, so no need
>     for an early check. Just reduce it to a simple position and total length
>     check, and defer the more invasive segment checks to the block layer.
>     
>     Signed-off-by: Keith Busch <kbusch@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> The issue looks like this:
> 
> md/raid1:mdX: dm-17: rescheduling sector 0
> md/raid1:mdX: redirecting sector 0 to other mirror: dm-17
> (snipped 9 repeats of the preceding two lines)
> md/raid1:mdX: dm-17: Raid device exceeded read_error threshold [cur 21:max 20]
> md/raid1:mdX: dm-17: Failing raid device
> md/raid1:mdX: Disk failure on dm-17, disabling device.
> md/raid1:mdX: Operation continuing on 1 devices.
> 
> There's absolutely nothing wrong with the HW, the issue persists even when I 
> move the mirrors to a different pair of PVs (SAS HDD vs SATA SSD).

Thanks for the notice and the logs. Sounds likek something is getting
sent to the block layer that can't form a viable IO. The commit you
identified should have still error'ed though, just much earlier in the
call stack.

Anyway, I'll take a look if there's something I missed handling with the
stacking setup you're describing.
