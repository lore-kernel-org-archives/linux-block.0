Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AE1DE8A4
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649180; cv=none; b=mwTnjrDx3VW3Plp7+enoN5Y9g+ZAVVoSJK5/hBaedY7hYiwaagXBRPM7LQdhW98VCJq6J7bUTGToNDdmjUY1lKft0YuBoX5NhtbPyX5CH4LiTFpT9xTvj8CDZyijFaxxwWFtnFy9JQQreQDPXjfRDEkLc8CF9phbzNO+4kvLOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649180; c=relaxed/simple;
	bh=O76e0p2UNSe9qHMSPG42biK8dHTwC/AH3JfNGWExta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNoISfK1hgnOG1x5nuq8xrj4A+EpVwdfNjRZaZ4MNsnPtkZtep1OCcxhFJmIupfp4fsaTtLqEtTJyXHZ2+YKv2GmtzdIztzI+wcr1eITqR+Ru3pNUbCtWgS21dw/cMH9eQH0eBtcC4ciOHi9YdrA6oBXFDRZHSlvMd7CfpVEPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJYHlchB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJYHlchB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C0DC4CEF1;
	Thu, 20 Nov 2025 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763649180;
	bh=O76e0p2UNSe9qHMSPG42biK8dHTwC/AH3JfNGWExta0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJYHlchBWS2bygNRIW/OOaQtTv/FW3PBKEgpByED2qbKWm7tpO8KY7/yb2aEw2LDz
	 CastRgmoGWFkVkaRsZT+sucn5T/uRUeQ8mQdrI/drM615BOZdC2/zlg0tjpIH2utSV
	 kT5X/XgQcon0g5K3csBMiZZwD6wJorcG8hXqvmOSbSOuHaxWUUd6+pt1dm4GyoU4CF
	 kC8kiGnDe3h9omw51LJ9KylJZSn8q+OC636O7l+zzuXhWkxWqB9LJ3vbe81W7NWdmJ
	 OdIlCrsFSaaqptmK19xijb34Tn2OdbT+BTNMpSGwe9lM5RVoPnMLcd0I1BEbHM8/C6
	 S7ehezn2JUHkg==
Date: Thu, 20 Nov 2025 07:32:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Message-ID: <aR8mmpmwSf6QRgwm@kbusch-mbp>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
 <ddda3d01-b95e-4798-b21d-a0c526b5b5a8@nvidia.com>
 <aR5ZyoBaX-47tgNn@kbusch-mbp>
 <d97a75e3-2ba9-488c-a22c-9cb505cb2ce8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97a75e3-2ba9-488c-a22c-9cb505cb2ce8@nvidia.com>

On Thu, Nov 20, 2025 at 12:56:36AM +0000, Chaitanya Kulkarni wrote:
> On 11/19/25 15:59, Keith Busch wrote:
> > On Wed, Nov 19, 2025 at 11:48:47PM +0000, Chaitanya Kulkarni wrote:
> >> On 11/19/25 11:54, Keith Busch wrote:
> >>> +        ret = pwritev(test_fd, iov, vecs, 0);
> >>> +        if (ret < 0)
> >>> +		err(errno, "%s: failed to read buf", __func__);
> >>> +
> >>
> >> is pwritev correct above or it should be preadv () ?
> > Good eye, it should have been preadv. This part is currently unreachable
> > though, as it requires byte-aligned dma limits and the kernel doesn't
> > report such a value. But if this were to run, the test would have
> > falsely declared data corruption.
> 
> how about ?
> 
> 1. Keep the code but disable it until kernel gets that support ? OR
> 2. add an ability to autodetect if kernel has a support before running the
>     test else skip test_invalid_dma_vector_length() ?

It already does the second one. This test function checks the device's
dma alignment requirements and purposefully dispatches a command that is
expected to fail before it reaches this part.
