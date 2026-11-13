Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565883;
	b=VqVMGP2BLOcsM3yezWH1Nx8DauWzwnLeXM8Fe3bR3AkjS1RBOEsdcFRQqAj9xvxkwThK
	 R11LGzGENOWMoAScthMsUqfc0WKB7Wd+3v8Y5L2mudgIcri8VvqxF5c2lrWNsUbMnZ0Qv
	 EePnZYXAGILsA8zlrUFl/lDE6mkfJfq+T0zsZZ6hzohuvL39VfQWNxG5Yl6wpx1rZZFbO
	 QmSWwjdagcxXnpYksfepvYOq+TQ2v8bL9leB1A9t/ZfvMoG/MvxGcJ2XOj21WOA2bv7SS
	 pQu0omj2iy5Ona3iP+HftP/PGY3pKGm+7wnHovtmxCm6dzZuaZcA93sHCstCKyCf1nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565883;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer;
	bh=MhfgKwbasrCVcesvtSIzmyPCwlK0O+X4pOMtLALs5hM=;
	b=CeJjFBe9INAHLdqn3/RAGvuyPsdTDGmD+x9dlUA/aORszV4MsTFB+Z02zFfkupKBEe3h
	 mdGbJh+PabsKBBlY7/DXmM/oqx01GxXNKKsYd7cXC4687pjyh4skaeunlAEJVUBALXAoJ
	 ADYwGtuai7l8KUPYGmf9XJ5Jjp/Ycde5XSQVQonmbsxwUR69njTHoqOHZlYC9c/gSsyO9
	 HEylKBP6MC8h/v1lQTI+zHk5DdFjAHJYW9XHw16eSrWYuCY2sqQ1RQeFIzm0OU4cw+VZS
	 2l4cejFzPsD5JcnodQvN8oy7Dgybg+q45L0VCUOm9WLEmnruAtJriH+n5d37n/QHS+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ0nGwjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B0606A33B;
	Fri, 13 Nov 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ0nGwjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E59E1F000C4;
	Fri, 13 Nov 2026 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565883;
	bh=MhfgKwbasrCVcesvtSIzmyPCwlK0O+X4pOMtLALs5hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZ0nGwjwbFT5/0UqQlQOqloIqVpmJQtyPKbypXiHH4u9UmV35jhvS0moU8HiPhERK
	 OYtkqSX92q69Km9I4E8xNYYOMsxYyYzOmXoSgwzTwneQy18R5aX22/n969sGiVNwUL
	 6SUjKYMS3YUWhkS730JAWOH945Y/h8aFp/ldtTYn9DZ7LL5i9bkSEEiu0YEONnjq3D
	 xBjU3Kng985IW7lsgwiiD5Yt8IncJNsiU+zlT2ZFITzjjNszvDT0Fj1S2FOGNp1Y+p
	 NHoypfS8qMH5/GUnYxyMB7mSIDnAR6qBjDTfSdABUy8fdWSXOA2F2oVUD+QatOiZtK
	 wJ1580x/47tmQ==
Date: Fri, 13 Nov 2026 11:31:17 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Message-ID: <20261113104220.2-da.gomez@kernel.org>
In-Reply-To: <20261103093856.203861-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com> <20261103093856.203861-1-arthur.simchaev@sandisk.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird



On 2026-11-03T11:38:56+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:12PM +0200, Daniel Gomez wrote:
> [...]
> > @@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
> >  	struct request_queue *q = req->q;
> >  	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
> >  
> > +	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
> > +		return true;
> > +
>
> With the flag set this skips all checks. Since each REQ_ATOMIC bio carries
> exactly one RWF_ATOMIC write (blkdev and iomap reject atomic writes that need
> more than one bio), could it instead check every bio of the merged request with
> __rq_for_each_bio(), using the existing size and boundary checks? That would
> keep the safety net described in the comment above the function, at the cost of
> a few comparisons per bio.

I don't think this is really necessary in NVMe. But I agree with the
suggestion to honor the request and potentially other drivers that may
be more strict.

>
> [...]
> > +static bool nvme_mam_compliant(struct nvme_id_ns *id)
> > +{
> > +	if (id->nabspf != id->nawupf)
> > +		return false;
> > +	if (id->nabsn && id->nabsn != id->nabspf)
> > +		return false;
> > +	if (id->nawun && id->nawun != id->nawupf)
> > +		return false;
> > +	return true;
> > +}
>
> This deliberately accepts NABSN == 0 and NAWUN == 0. I assume this is because
> Linux only uses the power-fail values (NAWUPF/NABSPF) for atomic writes? If so,

I'll work on the clarification.

> a comment would help. Still, NVM Command Set 1.1 Figure 9 requires NABSN to
> equal NAWUN (or AWUN when NAWUN is not reported) and NABSPF in MAM. NABSN == 0
> means no boundary for normal operation while the device claims MAM, and NAWUN ==
> 0 would need NABSN == AWUN, which the driver does not track today. Would it be
> safer to treat both as inconsistent, as your QEMU series does?

I'd need to double check this.

>
> [...]
> > +		if (id->nsfeat & NVME_NS_FEAT_MAM) {
> > +			if (nvme_mam_compliant(id))
> > +				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
> > +			else
> > +				dev_warn_once(ns->ctrl->device,
> > +					"Inconsistent MAM parameters, ignoring\n");
> > +		}
>
> Minor: dev_warn_once() uses one static flag per call site, so only the first
> affected controller is reported. Maybe dev_warn() (this runs on namespace scan,
> not in the I/O path), and print the four values to make the report actionable?

Do we need the 4 values when users can check them out with nvme-cli?


