Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857741A562;
	Thu, 16 Jul 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201332; cv=none; b=g+aZpKpANAfK0FaDWic8ccguMolKQb76Ra3eMMVkczg5oLoEKjFpsbaniVeNDWOqsJ2zpeY8WtyvmXhn3fOLkpeQVRaAhqHipMfDyQ3giMAhetCD47Cqn+6hASa331haAOFZi1P1WCspFY7zwkcv3NgwHgISlmu+7KkXs0DrHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201332; c=relaxed/simple;
	bh=lW3RFsHlNXrEQm67lm/4jQ+2itTgzCj1lHt2RyEw7Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXyKLqQ570uSJN4AXymR70iBACBBfL0BBXE/6p0jS0tCs2cyW6xJER+MILe+bEylYOnYC9kv5b+2WwqnMMjBFQLsxktDHTa9d/ddF2Khog3gmf6DINMtNaldatLqcgWwhl+LyZ2Jpt5X+jkAQXh/DGhmrlfJUwkI2SRqNhkAaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AELD3qTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AELD3qTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DB1F000E9;
	Thu, 16 Jul 2026 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201331;
	bh=abOvjguWTQgN2HW1IU5+xHAgXBrcFH7QmzlzdLDiPFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AELD3qTE7GmhJEmZJd5FsskzS6jivJuY1Sjg5nCkzG6uz+MAgnAXnvIYZG8LwHuj4
	 dPAu7KBNkj4cdRFkXkk+ebOEgF6lRA3mtww0/dwg2NYQw1fYR+/MuLFcUsT5sBjTRN
	 K+EfztYmtacQwfrelkN1EeORT/Sk/ZGJBVX4uNJXtlwcEpx6WvI2gJrFoiikNLJ5k9
	 q2VZDOfahU8MkScoTrpd3V3Jcp8rfDoWM8MO4GGxdFD26iq/cCc6m0BnrQoVAPBUwj
	 3kDNkXGV9rNPsnWV6VTnk/XlB+YAXyIG8Icjnoj7HUSuhkaszn2+pw2hxymI15qMtP
	 tFtujk2csaROg==
Message-ID: <fa6ec3cd-e6c9-4368-804d-3017653f4754@kernel.org>
Date: Thu, 16 Jul 2026 20:28:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] block: remove blk_zone_wplug_handle_zone_mgmt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> blk_zone_wplug_handle_zone_mgmt now only checks that zone reset and
> zone finish operations are directed to a sequential write required
> zone.  This has nothing to do with zone write plugs and is better
> handled with other bio validity checks in submit_bio_noacct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
