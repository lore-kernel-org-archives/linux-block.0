Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.152.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698749;
	b=2U8md8BlneUQO6Z2rVPPWTr9RFibGS4HOO1G8UwA9aimflvs/N1kEC/DnEMNADqlVD/a
	 ckAYU5SrGQu0VdIfwRz5wY8TBXLQOJGXKYyi6PQjIFtxe3lfZRl1Ha+0HYeYGnIgdOGXc
	 Ig2mOt9VFHk11R/qoelMvRM7Yx1i9TkdEOGw+dBm/88PaOpski0B1SQRfngoqwdlBjLwL
	 naMkmoPKG2D9yYytxihLalyjkEoSstxUT6mJOmX+oujyMlqNJP4Mq1IxjIYdWSrxkQywX
	 BVyKzE6RyIBXQ98r+bQEguXYDz+oRTV91hf4YkPb9vKGWPH3IWO1SHYUHuPjmvPgQmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698749;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:IronPort-SDR:Received:
	 X-CSE-ConnectionGUID:X-CSE-MsgGUID:SanDiskIronportException:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mSIOrvwCljTuyfqFX+dIixZrw7yR8HkFNXQP1Zue3go=;
	b=r+f5jnantbuPY7FVBy/2p1wPbug0kyhq2aNJXXyvvujIpxOybuJ+/CqK2OpGgNtz3qLw
	 d9dhBr06fK69C7KPIwyZ+7FuVSHiSMPbY9ZgkqmFtc1R722GjqNTos5F/XhKyq8Yr8A/v
	 jaMoAdk1IgvjqzwB0OSfmAk3HHuGe7iMwYK0zJmXjHsiN1PdXvIOH1EAINEq/I0Kstzmi
	 fhvTjrXQURyLTsaWhjBhEycjSO7jf/hm4U3oAC9ksWbLVjMDYNTm2XZUsA3tYHnr6UwN/
	 +6xqLsyuxU+mzbqDV2t4PffuKBwF2cI4FmIJLZqHG1moZMp4/vXMTf9nYutF0YyLaPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=YgDbDKy3;
	arc=none smtp.remote-ip=216.71.152.95
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FD606A330;
	Tue,  3 Nov 2026 09:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611FD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=YgDbDKy3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698749; x=1825234749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zBreZxYH0dOG14vJK5tWIMeKPJMWwqSlb7VxpR6aVnQ=;
  b=YgDbDKy3wYGXBdHtm7QSiuIwxTs+wBu/5EU5YXC5Eo9TB3eiVVRxCgrv
   JAvDZYevEN75euSjAhnxuRcGSRJyFn68PnCKzb64yh+v3mM5vmCP2xSXe
   +VDJfYn2QwVfK87S/LBOloWjlX7rcobnsleOcysBud3v/mc+8HxEpluOL
   3Udf6cEztLXzrSNG3GG4pemvxpmREEk1qUvL3rQEU2Rdc47bW2UU4DH4w
   IBrK+4CFhcFoW8t//UYADF2J3x3GacUr7xBkLl5Qcwf+gUfBiI6ferlvT
   C7C0PrjZhJDzLgVaqBy3fQC8jBdn9jKNTui5bzopOtGnfJR0ISN4/zo2m
   w==;
X-CSE-ConnectionGUID: JOTIdg5wRS+JYvBeLIQ1vA==
X-CSE-MsgGUID: RB63MrBGRFqoNqZOdzKHZw==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:39:03 -0800
X-CSE-ConnectionGUID: dopcpq0vT8aqefEVGkNurg==
X-CSE-MsgGUID: b5fzc2cUSaSlKjYGn1CNcA==
IronPort-SDR: 6ae9abb7_ZW4mTK2QQVt+dQKKigbrWDDfWEttSrWVSkITlPKqTN+IfhE
 4sEWKa4G/VTON3qrGQjLVON5JpBxiSoYZugIHEg==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:39:03 -0800
X-CSE-ConnectionGUID: YyJbVwm8T5OsfVdkoZ50MA==
X-CSE-MsgGUID: I9QSv+peTUeEftWkqLk7pg==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:59 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	GOST <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Avi.Shchislowski@sandisk.com,
	Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 2/2] nvme: enable multiple atomicity mode
Date: Tue,  3 Nov 2026 11:38:56 +0200
Message-ID: <20261103093856.203861-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-2-48dcbe79cece@samsung.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 29, 2026 at 01:17:12PM +0200, Daniel Gomez wrote:
[...]
> @@ -993,6 +993,9 @@ static bool nvme_valid_atomic_write(struct request *req)
>  	struct request_queue *q = req->q;
>  	u32 boundary_bytes = queue_atomic_write_boundary_bytes(q);
>  
> +	if (q->limits.features & BLK_FEAT_ATOMIC_WRITE_MULTI)
> +		return true;
> +

With the flag set this skips all checks. Since each REQ_ATOMIC bio carries
exactly one RWF_ATOMIC write (blkdev and iomap reject atomic writes that need
more than one bio), could it instead check every bio of the merged request with
__rq_for_each_bio(), using the existing size and boundary checks? That would
keep the safety net described in the comment above the function, at the cost of
a few comparisons per bio.

[...]
> +static bool nvme_mam_compliant(struct nvme_id_ns *id)
> +{
> +	if (id->nabspf != id->nawupf)
> +		return false;
> +	if (id->nabsn && id->nabsn != id->nabspf)
> +		return false;
> +	if (id->nawun && id->nawun != id->nawupf)
> +		return false;
> +	return true;
> +}

This deliberately accepts NABSN == 0 and NAWUN == 0. I assume this is because
Linux only uses the power-fail values (NAWUPF/NABSPF) for atomic writes? If so,
a comment would help. Still, NVM Command Set 1.1 Figure 9 requires NABSN to
equal NAWUN (or AWUN when NAWUN is not reported) and NABSPF in MAM. NABSN == 0
means no boundary for normal operation while the device claims MAM, and NAWUN ==
0 would need NABSN == AWUN, which the driver does not track today. Would it be
safer to treat both as inconsistent, as your QEMU series does?

[...]
> +		if (id->nsfeat & NVME_NS_FEAT_MAM) {
> +			if (nvme_mam_compliant(id))
> +				lim->features |= BLK_FEAT_ATOMIC_WRITE_MULTI;
> +			else
> +				dev_warn_once(ns->ctrl->device,
> +					"Inconsistent MAM parameters, ignoring\n");
> +		}

Minor: dev_warn_once() uses one static flag per call site, so only the first
affected controller is reported. Maybe dev_warn() (this runs on namespace scan,
not in the I/O path), and print the four values to make the report actionable?

Regards,
Arthur
