Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2534B1AD
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845078; cv=none; b=OIMQQeeMnuwAYKVVp2YQHvIdukI4Ceqlh836oRDoAwoj6jxRsLirt9wmTJYKZ/wbIc6ylIuBLldcB2y/FiocvbuLIPOnxx7JtvFRD/DAcPoTyv9vj/YRXojuPKZacNkqltOoj6w4Tw7SaKNMlEusFZ5TAnqQOd51QQ8amT9GK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845078; c=relaxed/simple;
	bh=sL5ZIv0hilEqXlEg+csnJcEzahotN73awmP4RoU9wjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTr/1vdV6k+iJTtXlstgNfVav8BaQwV5tNGsJPv0fAyIAIcAzytAleowIiC7dZ5nPPNWqLCVUi2RUX7Qo259GvPS2EYoE23DmKrdfWsV7HmBKDhRcfkqaWZOKOfvaWcxIxknSSLHUqKRe9wSG8eBjs4HU8xeKl/kX+IQp5or3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifuEagUG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifuEagUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903D3C4CEFB;
	Tue, 11 Nov 2025 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845078;
	bh=sL5ZIv0hilEqXlEg+csnJcEzahotN73awmP4RoU9wjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ifuEagUGqANmbxY9ymj1DhoqlmBY/J6s3nvzhkFl46lxchuXl/wIupFusn40FAxa1
	 Tux76JBnCSSHJRJoeSEG3dWHFX6xMcRvzrNewJvXlenU62ynb4Rh+NURp+ror2rJvP
	 HJWKc5jsSK4qMX4PbDoNRFPQMnIRcQahwjiU645R3JVYeiTLmNOuUXrhGXjqPD8HaA
	 OFHmlZBs9hLD3fUIWny3NVrip+hgK+7cGldbu5EB8OfwjPnXWmJxN5NDYibha9Sq1i
	 T6NG1KdLaiF0OoMWJ0mzhMYqgy4Z/TE4x+d2/oEa0jcXgGFckkkVTKneC1KDZFWaGB
	 wDSpXdpEfHB+A==
Message-ID: <14500125-96ad-4839-ab91-2302939ecfef@kernel.org>
Date: Tue, 11 Nov 2025 16:07:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] blk-zoned: Document
 disk_zone_wplug_schedule_bio_work() locking
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-3-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251110223003.2900613-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 7:30 AM, Bart Van Assche wrote:
> Document that all callers hold this lock because the code in
> disk_zone_wplug_schedule_bio_work() depends on this.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
