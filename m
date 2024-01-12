Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34151399
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB1byrQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7CAC433F1;
	Fri, 12 Jan 2024 03:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705028747;
	bh=7F4lPbM4glnQ1WhTY4k/Nyg28ifeaJTdz7hV/nwWi2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cB1byrQWODg8L7v/CB7CtewBFAsUE9RIc2+9EhNTfIo6K6s4psEAkXu2w/952PywI
	 Ws3RXMKd0RzU2N9Nua0dFxKf9ZYr7/6I4uoP7X8ftxqy3+fwUzlVD2h/R2OnIHSe4z
	 REQeyMMlHxXjeHhnPe67/14ls7ZACa6L68S7N0LDI1xE0ZOffuitspSlMC6sIgRXaq
	 RG9NzIA9WQ3/vn3PyeswfpPyLQXaKiOVUSK+KcUJnHHAmwuxP549dh50Wk7NAOj44G
	 vvT9vqJW5uXwPnQAlajszYb/K+k8yr1T6CZ+locaHK9oRFfQ1AlIUxh9ocv/W2Pycn
	 L+iTcM5pO6EBQ==
Message-ID: <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
Date: Fri, 12 Jan 2024 12:05:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <ZaCSOH7L+Nm6PvcN@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZaCSOH7L+Nm6PvcN@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 10:13, Ming Lei wrote:
> Hello Damien and Guys,
> 
> Yi reported that the following failure:
> 
> Oct 18 15:24:15 localhost kernel: nvme nvme4: invalid zone size:196608 for namespace:1
> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, opened
> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, NETAPPX4022S173A4T0NTZ, S/N:S66NNE0T800169, FW:MVP40B7B, 4.09 TB
> 
> Looks current blk-zoned requires zone->len to be power_of_2() since
> commit:
> 
> 6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")
> 
> And the original power_of_2() requirement is from the following commit
> for ZBC and ZAC.
> 
> d9dd73087a8b ("block: Enhance blk_revalidate_disk_zones()")
> 
> Meantime block layer does support non-power_of_2 chunk sectors limit.

That is not true. It does. See blk_stack_limits which ahs:

	/* Set non-power-of-2 compatible chunk_sectors boundary */
        if (b->chunk_sectors)
                t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);

and the absence of any check on the value of chunk_sectors in
blk_queue_chunk_sectors().

> The question is if there is such hard requirement for ZNS, and I can't see
> any such words in NVMe Zoned Namespace Command Set Specification.

No, there are no requirements in ZNS for the zone size to be a power of 2 number
of sectors/LBAs. The same is also true for ZBC and ZAC (SCSI and ATA) SMR HDDs.
The requirement for the zone size to be a power of 2 number of sectors is
entirely in the kernel. The reason being that zoned block device support started
with SMR HDDs which all had a zone size of 256 MB (and still do) and no user
ever wanted anything else than that. So everything was coded with this
requirement, as that allowed many nice things like bit-shift/mask arithmetic for
conversions between zone number and sectors etc (and that of course is very
efficient).

> So is it one NVMe firmware issue? or blk-zoned problem with too strict(power_of_2)
> requirement on zone->len?

It is the latter. There was a session at LSF/MM last year about this. I recall
that the conclusion was that unless there is a strong user demand for non power
of 2 zone size, we are not going to do anything about it. Because allowing
non-power of 2 zone size has some serious consequences all over the place,
including in FSes that natively support zoned devices. So relaxing that
requirement is not trivial.


-- 
Damien Le Moal
Western Digital Research

