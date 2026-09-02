Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645449B1F4;
	Wed,  2 Sep 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357486; cv=none; b=cDtMlaY12NeO+8LjBbsDjUg0pwXdr9ziiLkarPeFsBvCsrUEQpL4Notu7bxa9E89QAOPMy2fG1FixXc3CxXHUrgFP5YVRJsngbySm4Wsfz0bcrp39CQBb7lC3dsNzAXSNws+AvQs6wX+YtzzRkV7elBqJB4AcjjdJQgRUOIx1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357486; c=relaxed/simple;
	bh=N7OuYqcuY6r8Xi5J4Kw9RxT0K2uHh3C6eJwxCfYal34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZFyJ2N888OFW6gzgVfkF77GA8CW6KKIJbOzO4bRndq8FfhlC3AJCdJUzA67G59IMFb0asaAOH1XhUiYJDpLKOHYzD9iyEgdsrtvBl7kO63xTwaNtWn3pRTohXZUUYGj/kO3DjdsBDWf01St1AM07JOVPBgCFuDDd29wuRtYh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1EA46732A; Wed,  2 Sep 2026 15:58:00 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:58:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v2 for-next 1/3] block: reject unknown status tags in error
 injection rules
Message-ID: <20260902135800.GA22743@lst.de>
References: <20260830012002.80275-1-haris.iqbal@linux.dev> <20260830012002.80275-2-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830012002.80275-2-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Aug 30, 2026 at 03:20:00AM +0200, Md Haris Iqbal wrote:
> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
> tag it does not recognise, so a caller cannot tell the two apart.
> match_status() leaves *status at BLK_STS_OK for an unknown tag and relies
> on error_inject_add() rejecting BLK_STS_OK.

There is no *status yet.

> That holds only while a rule without a status is meaningless.  The delay

This reads a lot like AI slop.  Can you please self-write a short and
descriptive commit message?

> -	 * Return BLK_STS_OK for mismatches as this function is intended to
> -	 * parse error status values.
> -	 */
> -	return BLK_STS_OK;
> +	return -EINVAL;

No need for an int return here, this can easily be done with a bool.


