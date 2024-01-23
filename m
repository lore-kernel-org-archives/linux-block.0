Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D861EEC2
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000712; cv=none; b=rtEQMlMCq9NrUBiK7MzU+aIZzPD/Z28GXmxcQzc1TNQRKPDbIrUtygCmqgkw9jMBnhF7UCwF14SvonI8FemfMBxb4cHc6wHY7mdvJ6bTzG37bdZc2YVrpPZfJC/Q/9jmhXW9HRce6HmHtUSGhZgcyQZyuuD6fvnfF+M7aLCgxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000712; c=relaxed/simple;
	bh=1U48UgNFGNngSIsKJqnx8ZGkMG74sIx68pFVzZLLEWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR/LoqpUbjQ+FnPATXVIzMb6an27l5OQWMg0cduBy+d4LoRnx/XsNpogSN8qLs2oWK3Fxd6vHm1OzK/+GplGs+f4rZVWB3Z+c7E7XaexFSfsCVbHSL4/bUMrn8v/+GD/vxPA4g8umMT6KsY++zhgSGShF1rDQhkSHsSXMFAx5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0932168BEB; Tue, 23 Jan 2024 10:05:07 +0100 (CET)
Date: Tue, 23 Jan 2024 10:05:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240123090506.GA31535@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com> <20240118072419.GA21315@lst.de> <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 18, 2024 at 09:02:43AM -0800, alan.adamson@oracle.com wrote:
>
> On 1/17/24 11:24 PM, Christoph Hellwig wrote:
>> On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
>>> It has been requested that the NVMe fault injector be able to inject faults when accessing
>>> specific Logical Block Addresses (LBA).
>> Curious, but who has requested this?  Because injecting errors really
>> isn't the drivers job.
>
>
> It's an application (database) that is requesting it for their error 
> handling testing.

Well, how about they then insert it into the real or virtual hardware.
The Linux nvme driver isn't really an error injection framework.

