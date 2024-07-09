Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128C45948;
	Tue,  9 Jul 2024 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503589; cv=none; b=JnjJ30JuC/gF7awxQ/3/q+JGOurPZpR5GaKyDGBmqTqmvq8hSMCTGNaiEfZgTs54ec1+ofeJa1jYUFIeej93RAXDyZBrC4x2lQ7AsnPKP5GlckrsCkhfh3sDUmTFBns78iAtYyb/0N3zmLlk5DREpaDaJJ3ARZ/BhBca4A4IAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503589; c=relaxed/simple;
	bh=zVBEEjwg0WrGFpDCk4dLjRbT1J1JDwLZZAS0PVBD4gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8oxDFyWDb8nWkzN00YVcO9MfHSt/ZO5PtxVpGns/jfvxUO7o4JBlz+Z1A+UGnrKn1Vwtrrvw/2uIgeXEvc5AvtSPwjMpTdtbOWJ8+zQjb99kBOUPNhmiofeHSEaa8BcBu0wlqX/U6p8gLywamKd1kdXHYVqd1oh8lDmu96MB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHjB/xXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHjB/xXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EEDC32782;
	Tue,  9 Jul 2024 05:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503588;
	bh=zVBEEjwg0WrGFpDCk4dLjRbT1J1JDwLZZAS0PVBD4gE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHjB/xXY6xD5c8n6tjRKVvE4rOG5gUe9Nbf1aC7q/B5hjF4j0ipNgbnqzliFMDyHi
	 dGuPQOKg3HNECLSx03WVr4NgV/F/R9x3cVLLEkcTd86SiQVZg3OmvgLWnwq/GnqPiZ
	 8BhOGHFb1NUTSxJ82d/PZNBWNY9XpJwVP2aWYMKZBYlycQpBmHw61KCRzQGtVghoQA
	 pzYbwVddb9Xcho2ynQTfNPKkD9ssM0T0mHw+CZr52tzj5tp7YXwSOfokMIjThMJMxU
	 hE10ZjuV2TF6HipfTtzPEudxvR1T4PQ3k1UqZcnhV6CcOVaI1MbN/8r4g36VrwnCbG
	 sv80iqoLaDJeA==
Message-ID: <b51be09f-6b7b-4f21-98aa-4e6e8d64d00f@kernel.org>
Date: Tue, 9 Jul 2024 14:39:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] loop: Don't bother validating blocksize
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240708091651.177447-1-john.g.garry@oracle.com>
 <20240708091651.177447-6-john.g.garry@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240708091651.177447-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 18:16, John Garry wrote:
> The block queue limits validation does this for us now.
> 
> The loop_configure() -> WARN_ON_ONCE() call is dropped, as an invalid
> block size would trigger this now. We don't want userspace to be able to
> directly trigger WARNs.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

