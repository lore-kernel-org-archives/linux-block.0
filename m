Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD32F691B
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571021; cv=none; b=NufZJ5yPyHj//VYa1iZp/p8LjWL+4td+LKbaD48BIcOAo/txYfNq889QQ55WvUvvLdaB21gfPCyOeoPk6U4MawecIZBnH3+zc4xaBnGeY1Ig1zrRi0ZW6BodiEwxMuaQsCXg2mBtnAH2Dy5leEA3/rHZJ0Sl92gluto/qE1Bxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571021; c=relaxed/simple;
	bh=i/tqtLHwRXy4TGbzogaANNSAIeuWEHfCiNP12W5X6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZtkjndhCkfY7f6UwGVx/CP61AHARG6WJxJFZeX0rgAu93pWad8spWyJvxhPi3UQ4fDir6D2e5aMIQjEV96GIB2skb6vIwbLTHt7ft6uxyou8z834c5GKrTZncV83Qpe7oLo91mp4BaeZSsSo38ohpSa2pXeyPyIZq/vO1tYgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emMshKLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emMshKLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A7FC4CEF5;
	Wed, 19 Nov 2025 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763571020;
	bh=i/tqtLHwRXy4TGbzogaANNSAIeuWEHfCiNP12W5X6TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emMshKLKeeYh1CMHFhWgSW7OA6gL93esq9b2yElSW43t4yVPnZ3uEbJlBgRowMwuI
	 xbcCLjgyLBdXkrflj0p6h+eBFVfmezMaE4lw0SwyRDHcMY8AL/dTDDDlXMToyN7bue
	 WG4WzULEkqOB2TsG7E9ehQOH6Kr9WwCJnoIuMwIgtHqHYn07BLvJ1h8rVqYv7MuWI6
	 AU0C0mNsx5TowFQtU9QUSbnMsVWwf31ZaIOWWWJKTXZqbXmnXyqsd44nLFLrTPbX4p
	 V2ppiwW5OemOElBrTKMq+If2XS9Jmz2QfqjR61Rii/kP2Ol65nudKl7TdzGnwkI1RX
	 zxZ6z+XTscG6g==
Date: Wed, 19 Nov 2025 09:50:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] io_uring user metadata offset test
Message-ID: <aR31SloN2N15LodB@kbusch-mbp>
References: <20251107231836.1280881-1-kbusch@meta.com>
 <5d630378-6653-4b2b-b3ec-946bf2671849@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d630378-6653-4b2b-b3ec-946bf2671849@nvidia.com>

On Sat, Nov 08, 2025 at 02:09:33AM +0000, Chaitanya Kulkarni wrote:
> On 11/7/25 15:18, Keith Busch wrote:
> 
> this requires a specific kernel version or higher for
> IO_URING to have this metadata support ? OR any version
> of kernel would work ?

It does require io_uring pi attributes, which was introduced in 6.13.
