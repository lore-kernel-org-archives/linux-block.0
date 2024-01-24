Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6717C61
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088694; cv=none; b=V6fK7e4RgICVt7HUUPpZ+5EpsrJR+g+rqy+dMqU+5S6a6k1HTORrNbDoRcoWfT9tRAYz77P3dbgWgH8X26PNPrEvElNPOpBT+n5jY0oJ4pGqm+DfF8AorM8F1Wni6kxT6WfaSO9VQYD7A2qJaZMYsjLYY9oFmVT4xSvgaWi0TME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088694; c=relaxed/simple;
	bh=FwHPfQt8PLu/P2cDnyw6TKNZaSPzrLm+xN3XR7B4SZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQztQknzCLAgl6U0a1IWMObBkQQABxU3Oxo4RJ18BF7BVno1wJHk4xkaPibNk1QnkJYgAEOSTdoKXJfLywirB1H5KJeTH7CliiZWzl7yhyALZPNPIAiqwqQzi1DvgLC/UftN1AMMTAwD7EuY8gMMmUZazJw047cmMyfIR95xFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ee/L/bf0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ee/L/bf0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xj3xUN5wkWjR3AYHe3k2qv9/m+TWy+Zx7Q26bimtsHg=; b=ee/L/bf0FVIuMxUIJb2ANDAdj6
	+zseKTDrABOCG/3lnDPuESh77sJ1hiItTW3Zznnv1R2Vz9en6/+TT2RLxvYSt4UekpvA4pLiaPO6v
	i9in1fYSdydIYtkMf/Pvh4mO7lLBSUoMikOPEGcFp0AZyv2jyk4p0hBzQiFrG69Gx4xsycPxaRRYM
	We4EzA+xDvFebCUFagiCjiPDeT7S7oTacX+Xl4QIv+4ZklA9Toh1pZWf11QR44jPrf/C+XKtUmsw1
	dNGM1ERsLnqKQuwfKTW+bjM+11SfYZtZaOBkVaqGaA/4R4xRMVb2J6aj0zvH0vUJq9r2oMeEpfZy3
	GMBG3OTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZbX-002Fj1-2D;
	Wed, 24 Jan 2024 09:31:31 +0000
Date: Wed, 24 Jan 2024 01:31:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Message-ID: <ZbDY80W3Sr4DQHVJ@infradead.org>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-3-axboe@kernel.dk>
 <1c695e25-af8e-41b2-adfe-58c843e7dbc1@acm.org>
 <77209dea-406f-4143-98b7-b034b4d1dfe6@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77209dea-406f-4143-98b7-b034b4d1dfe6@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 12:13:29PM -0700, Jens Axboe wrote:
> On 1/23/24 11:36 AM, Bart Van Assche wrote:
> > On 1/23/24 09:34, Jens Axboe wrote:
> >> +    struct {
> >> +        spinlock_t lock;
> >> +        spinlock_t zone_lock;
> >> +    } ____cacheline_aligned_in_smp;
> > 
> > It is not clear to me why the ____cacheline_aligned_in_smp attribute
> > is applied to the two spinlocks combined? Can this cause both spinlocks
> > to end up in the same cache line? If the ____cacheline_aligned_in_smp
> > attribute would be applied to each spinlock separately, could that
> > improve performance even further? Otherwise this patch looks good to me,
> > hence:
> 
> It is somewhat counterintuitive, but my testing shows that there's no
> problem with them in the same cacheline. Hence I'm reluctant to move
> them out of the struct and align both of them, as it'd just waste memory
> for seemingly no runtime benefit.

Is there ay benefit in aligning either of them?  The whole cache line
align locks thing seemed to have been very popular 20 years ago,
and these days it tends to not make much of a difference.

