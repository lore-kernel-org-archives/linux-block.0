Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626284FA9
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065289; cv=none; b=joZMd5bj7CCH4L+sMfUT1LkjHdCUQMLOtlRgURO7mL2/pEkHJAiCirkcZd3QH32U2FslnZS034+2kB91aGg7gTPexvWgXJfo77i5nLzAYbPiQ9Apzn8Rmbw2fZZBOmnNLibbkYwjYALLjj2KaS9bG8OXS62lPiADupaQvxqZq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065289; c=relaxed/simple;
	bh=LJRp/o/snXbteNfIzYceTw49QE5yUFX2M9jHONkQAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8VIVWa0Ettb3lZyWu044Foq0ghVjw3JWaY/EXrRFMIH61bCsck5j3zsB8WbVTjnj+BUqwpEp5aXrMONI/9JgfOqRhZoDJHfkxLiYjqxCOAujFydWlK0SpT9B0Q2193XrBvpMUCdAJ5YeYiqL2P5oWUsFm5LKaQZ7AUGsLOJWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3065D68BFE; Tue,  2 Apr 2024 15:41:23 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:41:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Oddities in brd queue limits
Message-ID: <20240402134123.GA32562@lst.de>
References: <0cba8c5d-f014-4e48-9a6f-7724cf939c5c@suse.de> <20240402131822.GA32081@lst.de> <985db17d-691a-4674-8e2d-962ac9a8af1f@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985db17d-691a-4674-8e2d-962ac9a8af1f@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 02, 2024 at 03:21:00PM +0200, Hannes Reinecke wrote:
> So is it a hard limit (as in: we cannot send I/O smaller than that)
> or a soft limit (as in: we should not send I/O smaller than that)?

It is a completely soft hint that isn't used by anything in the
kernel I/O path.

(as a quick grep would tell..)
