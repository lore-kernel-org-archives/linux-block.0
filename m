Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98153BE;
	Fri, 13 Dec 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100352; cv=none; b=uDiGQ3MSZD/UKeMVyeyASNTdF7dULfly6zokc6IafkO3dRgxaCNam3CMiJgdaUDzSut4wV3j3OZ6x9NCkqOn0pSPMYBlWMk0NYhoTpS4enqm148QaWypiakJ8dq5qoGjuWg/0l0giai/CZxBk+Bl3hsSzuUvn8vS5l6KBkexP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100352; c=relaxed/simple;
	bh=54OcNMBybF+2eT6jBOQ1+NbFOErP7vQScU+RY88GHSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1h4rrxsCgu0L0NR+VlQLa1QB7SzHcEb/xQn1X0jlVyNC0pieuDluMF0lIc9M+IGyIxcjxLQIXrcBVPei0b2nx/oHBgSnESvwaeEMd8QHKgqB34e8B88K9MTc7DEPYNUE+UqSMJawKYEIBIaRHLgnTvrvgMqwpaoxiOZnWkKkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B179268AA6; Fri, 13 Dec 2024 15:32:24 +0100 (CET)
Date: Fri, 13 Dec 2024 15:32:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241213143224.GA16111@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412122112.ca47bcec-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 09:51:45PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:

This sounds like there is some other I/O path that still reorders,
which got messed up.  What storage driver is this using?  The repro
material talks about an ata disk, but I'm still curious if it's ahci
or some other driver, or a SAS HBA?

