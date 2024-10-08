Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782A42077
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376588; cv=none; b=YWXL0kG9/Id3OHf08hSq+zwyVBiw3jATnGP1JXIRS41Kq+ZL7mbpA5PNLFCQ8Txw3m5Z4LyaBmyfDH9hV2WYR2d9F3otbqanyYVu25kT2KLLzF0+OoX6mkS6meapGW+PNX2US5uX00osPOvmX4AGT2KORBvkVXCsh5II6WpUHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376588; c=relaxed/simple;
	bh=NyBnLFHYHS6RaxwqjX8S7uBPv4kboNDbOTataqJfYvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cR8cYgueWgsnLk9kg6/d5TcHBWkJGGv3MfRz6rmUIxAi/AvOSIUbEpCgCqWPZfMxBCgEdHuzU8c4uwvEgHsCvPf/nlB7+PCt0/wi33GGGFxYfowi1shrouoEjJ8VTEaFWlgFH3rJA8eRKstCIQ/ALk+AIlKWAAi+fmWJI6+zADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJxnRW3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJxnRW3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD4C4CEC7;
	Tue,  8 Oct 2024 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728376586;
	bh=NyBnLFHYHS6RaxwqjX8S7uBPv4kboNDbOTataqJfYvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bJxnRW3bU3XRX11GifQMCVAidOaawm/iQmgjwpj7ezQ6bpjDbSS5C3/x4IPEC+ho9
	 r9nqutWOz2qfLTIggoBkTJ0wev7dAEFFqlRef3muY55Q7Emqb6eNyHZCVoysgR5u3Y
	 fV8YIWgLAQ/Fjr3lQXTYjnmrZC3WEoVp/op/DhDW4OekXirkYGQ1UYTNfsI2iFpgAe
	 zOtWpUXIxFuQDyvW63v8Pqm9O9Y7SWBFcysCyzLHANuYJSM2xW4XPzy5BMOUj0aqb8
	 zcbNfft4KDSEaOGX2OMM3edIbtXmKPtV5Lcc4GCbTL9PDYaa61q/oodC7msi9NCYvl
	 IMCbIfMbalgnQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk,  linux-block@vger.kernel.org
Subject: Re: [PATCH] block: return void from the queue_sysfs_entry
 load_module method
In-Reply-To: <20241008050841.104602-1-hch@lst.de> (Christoph Hellwig's message
	of "Tue, 8 Oct 2024 07:08:41 +0200")
References: <20241008050841.104602-1-hch@lst.de>
Date: Tue, 08 Oct 2024 10:36:08 +0200
Message-ID: <87a5ffng93.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@lst.de> writes:

> Requesting a module either succeeds or does nothing, return an error from
> this method does not make sense.
>
> Also move the load_module after the store method in the struct
> declaration to keep the important show and store methods together.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

