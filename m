Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720421D9A70
	for <linux-block@vger.kernel.org>; Mon,  2 Dec 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162618; cv=none; b=lrewLV9vEMWVpo44ax/9Vv2vZG6OS4dMKCXkBHLuznDcek0xJK+QGyEfzK7+JJ5LzLghIBtspqzJTk26KT5AmRqFmdCZQadas53cepum3MnZcFEc3+oRTV53UZGNxXY+8RgcvvbRTjYw5Lf6qfD/DAf6YmOTlmS6ZfAFbXo7SAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162618; c=relaxed/simple;
	bh=JtNSdM5QDFvtDSUFFPnRuSj8WUL4/yhIRmpd5x6qOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5KBprMT50R7JYgPb2krQ4Tndy0CFDHG1W8wrkixPsmWoaUtnuRJmp5xKzbQ+mLQ+qnzTk/tU72Dv/ZEOR2vtg75H/yJ/GNn3oy+RwGfkIwX4fJPQhwahRWHxLQ6UyNUBO9yB7LyZahmVEVHrN1kAyty3vnGUfIUWuhRgWiyHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quZRxVQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quZRxVQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ABDC4CED2;
	Mon,  2 Dec 2024 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162617;
	bh=JtNSdM5QDFvtDSUFFPnRuSj8WUL4/yhIRmpd5x6qOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quZRxVQ6SqYtDWGy8JcyAYeIvx640p27rYdVOryJ0eVMVpm/poiKLk/Ln7JBx9He8
	 yXDLZX3RP0vTEpgv80Fk97Nt3s+/ztPTTvXfMokBFn8II7121QGKmz8ynHpkTJFtZx
	 urDNK7tlv5iuBe3vV/U4ZT2BR2Axh+k3/YYz5ARz00MmFCkl8raMBhqud/0YAVuhXw
	 ni41iQlDaIsTAS0Nb4EBp+22IxpG8sW8W+sAoVEJjNCunib2vfwX/U3274YGp/+Gac
	 yl56mklvboN17U0p+q2n1+V+Tk8JFO1zcHL7eRbjNQcXduvuuk0gdIIK+gzniBYYF+
	 Ex4MZ01zgmQgA==
Date: Mon, 2 Dec 2024 11:03:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com,
	mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <Z032dx3uDu-m1j9i@kbusch-mbp>
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>

On Sun, Nov 24, 2024 at 06:25:53PM +0530, Nilay Shroff wrote:
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
> SG list with all zeros. As ZERO_PAGE would not necessarily return the
> virtual-address of the zero page, we need to first convert the page
> address to kernel virtual-address and then use it as source address
> for copying the data to SG list with all zeros. Using return address
> of ZERO_PAGE(0) as source address for copying data to SG list would
> fill the target buffer with random/garbage value and causes the
> undesired side effect.
> 
> As other identify implemenations uses kzalloc for allocating a zero
> filled buffer, we decided use kzalloc for allocating a zero filled
> buffer in nvme_execute_identify_ns_nvm function and then use this
> buffer for copying all zeros to SG list buffers. So esentially, we
> now avoid using ZERO_PAGE.

Thanks, applied to nvme-6.13.
