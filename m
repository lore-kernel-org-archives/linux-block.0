Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27533290F
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055510; cv=none; b=cJGRUCSWA3m7aGzadqLNezx94zwre4s9yanqlVd8OJUW3Bn0SQHumsGWvhtLoE4XUuTODP24/Rcy0aEC0KHWy1xJhTksaqIe+7Sp/vOaH2mf6RYSr55bD4FHzkFMFb5NtD6tKjxQAW/iZ43mn5M5kCYsPKwFOeMfysZE5Y3PVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055510; c=relaxed/simple;
	bh=SzAcXpbx5Og5Y7n5f5/G5AwBnUDbY+PrfaRJ1Xfz/6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL5DNbfcAHRY62PgKEW1aqWnFlAa3uroNGyij+AK4nAl6LgZfLvCvQAD7MkenkItzyPG10R/QlwNJvbLNltOWXflwWATnDzuJ6WpPOd1cmJBYtp+2fhHTduooYViUGHTl9OFcVJfSl0zOgFyT88wgiPXkKBfmQkVTGfaRac3JdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfLq4XXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfLq4XXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7212DC2BCB0;
	Sun, 17 May 2026 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779055509;
	bh=SzAcXpbx5Og5Y7n5f5/G5AwBnUDbY+PrfaRJ1Xfz/6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfLq4XXMZWI1tx2PujHN/+coHj9Gb8M0IWaUi1gHJO2QzzZ/jHO/QualTI84IkyEw
	 OCBcVFwnG8GtWTzFVHoFdbcNQTRfEapO5JfuCy2/Bnowlk/zwsAFQUgkVGfxP4pipN
	 sSdych3SZHmv4idBZC2V7+VY6gttBDwGg8zLbhnGZhXWzvjTLfUCW6OXmMLMzmijcD
	 vDajKo4o4hU+5jgMuAN/Nv85apXu9gMr0ETdZG36x7VC7kiaQ0FxzhfqGP7jURwQoc
	 nuMmf1ncXIxghWiZBC5Vo5ad3DXhSA8nDPrzHK5LmUzWvloBMBWxcKKtZjfYQw3vNs
	 +7qORCpuXX/xA==
Date: Sun, 17 May 2026 16:05:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <ago7kyBnaWKU7l3E@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>

On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> > [...] how that was defeated [...]
> 
> Hi Keith,
> 
> Not the freeze.  The WARN does not depend on q->limits, but on
> ns->head->ms (read live at dispatch, set inside the freeze window) and
> on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> gates submission (bio_check_eod()), not dispatch: a writeback bio that
> passed bio_check_eod() under the old capacity sits on the task plug
> holding no q_usage_counter ref, so it does not block the freeze;
> blk_finish_plug() flushes it after the update committed head->ms != 0
> (dmesg: the capacity-change line prints before the WARN).
> 
> So it is reachable -- the host-unaware geometry change you described,
> unrelated to your block fix.  The deeper fencing gap is the separate
> TP-level issue; v2 does not attempt it, it only stops a
> device-reachable, already-safely-rejected dispatch from being a WARN
> (a panic under panic_on_warn).

I think tHe WARN is serving it's intendeded purpose: the block layer
shouldn't have submitted this request. You can't do generic read/write
with extended metadatate as the DMA is going to corrupt memory with
respect to what the block layer expects.

This driver is depending on the capacity constraint to prevent this
scenario, so I think The "end-of-device" check needs to happen within
the entered queue context. If there's a scenario that escapes that
check, then I think that's what needs fixing, not the driver.
