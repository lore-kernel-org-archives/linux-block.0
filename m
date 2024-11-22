Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC42AE96
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277316; cv=none; b=pFqdOkGW6Df9Eky+MxuFxTRZCRHBXzkr9cE+MUepDVMApcl0+lervO2lkJSRzDergqNZubbbgE/LG5p7trz5BsPB+MHXwg7WFbeWfv0aaffgPp/zDbvI7HucsrSJ2j6T0IRa7Sz9ELsyJnWx5Cu81TRuuTtF64rwrwlQL8dbcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277316; c=relaxed/simple;
	bh=is/CbQ1NsQwxvbSft8iiL8maW7oc4i5xZ7N3qMXeME8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5Z9lmWHRNNLFna7XHOuavD2hRDg7wJKjkzVocPrmvTLiaKsY+di/nZ5qQbgX+gSHr6VXLrF7lrIe0CX1Ga1aHVaLXRUlx1F78UY0ZgbKWUrxj47hUJoZoGpfE227T+8K7BmoXASwO2NHOF89RSjcHv35r9XFxaWhvBdqZ5hNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C82368C4E; Fri, 22 Nov 2024 13:08:28 +0100 (CET)
Date: Fri, 22 Nov 2024 13:08:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <20241122120828.GB25707@lst.de>
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085113.2487839-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
> for copying SG list with all zeros. As ZERO_PAGE would not
> necessarily return the virtual-address of the zero page, we
> need to first convert the page address to kernel virtual-
> address and then use it as source address for copying the
> data to SG list with all zeros.
> 
> Using return address of ZERO_PAGE(0) as source address for
> copying data to SG list would fill the target buffer with
> random value and causes the undesired side effect. This patch
> implements the fix ensuring that we use virtual-address of the
> zero page for copying all zeros to the SG list buffers.

I wonder if using ZERO_PAGE() is simply a little too smart for it's
own sake and it should just use kzalloc like a bunch of other identify
implementation..

