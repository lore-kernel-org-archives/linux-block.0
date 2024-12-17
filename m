Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCA2BAF7;
	Tue, 17 Dec 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418582; cv=none; b=mOzYYGT7FfGV+cUUdDGeYl4RnawrcjgxG7Ig1BB0EBn2YCasGnHAzdE43OxV7qIffvbp0phnyudpRN8Uay3Fl/t5vzUCA1e8FuQylLME/3WD5Y5/ijL9uo3IChEjYSSDPi6XlzAl1VCXxXFO9p5JZ8xTG7shd8RODuX+nZrK8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418582; c=relaxed/simple;
	bh=Vv7cmOIdxqoOHdgef+zWE9MDGSMfxeMMLKxfAkD2Vqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF61nXoynSdkKL2Fj/y2dCh01K9BvJJOmJoeesK7D5cfzv08Ue/i82pGfhttrKISQLiwpgZ2r0gVEccspQilsz8UTrc8CUBVNVkiDfuSwX0Up7+lSuYyEBKPHnth6O+dU/piKqUFqCsYsP1OtNUFWLJbGQpiW91cVCaN1L/zuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E725668B05; Tue, 17 Dec 2024 07:56:14 +0100 (CET)
Date: Tue, 17 Dec 2024 07:56:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241217065614.GA19113@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de> <20241217045527.GA16091@lst.de> <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 02:55:23PM +0800, Oliver Sang wrote:
> from below information, it seems an 'ahci' to me. but since I have limited
> knowledge about storage driver, maybe I'm wrong. if you want more information,
> please let us know. thanks a lot!

Yes, this looks like ahci.  Thanks a lot!

