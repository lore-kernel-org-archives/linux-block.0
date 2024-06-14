Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A913213E;
	Fri, 14 Jun 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343941; cv=none; b=Nsw2HoYdpvZ2vYfgOOMXjMF3NDiuhbGtwBGxRXIV4ldKS47tH6jrs2oHfonEizVOKNLT4UEgVSfeL7n9qr13ZdJT+sP7MMFLmfRu37xXalNrrxwzEBj6QmuQ4LfpkdStdCZCMwwha6Dhbd6MiLhMf6ryWcA3cmSrq27SKmp+lFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343941; c=relaxed/simple;
	bh=6o1eZepDhm9E7Wauk1FQ+44IVCpgwBbLrxaxIKggJwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNDRIxIIPU0FxxDA24o9LARmX7p6dd4HZCDgiz+ehmyAlbFt/iJBfwV4tSCGwUaE8o73Jk4u+/HDjKFgilMsHsM2ov4Kz67TGqbDszqivhzSIWj6dBu/Z65sR7Bf8PDsqfbpS688+0mpIRagPcUTlmU+uy/8Pgcvm1Q/7u8+6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D008868CFE; Fri, 14 Jun 2024 07:45:34 +0200 (CEST)
Date: Fri, 14 Jun 2024 07:45:34 +0200
From: "hch@lst.de" <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
	"lkp@intel.com" <lkp@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240614054534.GA9969@lst.de>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com> <202406112130.a572f72-oliver.sang@intel.com> <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 13, 2024 at 09:10:37PM +0000, Gulam Mohamed wrote:
> I looked at the LTP test case failure and also the function tst_detach_device_by_fd() which failed. Our kernel patch will defer all the attempts to detach a loop device to the last close, to fix an issue.
> The tst_detach_device_by_fd() in LTP test case will open the loop device and repeatedly checks for error code ENXIO. As the new approach, as I mentioned above, will defer the detach to last close and the last close happens *only* when the LTP test function tst_detach_device_by_fd() returns, the test will obviously fail. So, Can you please modify the LTP test case to accommodate the new behaviour of kernel code for loop detach?
> Please let us know your comments.

I still think simply setting the rundown state is the better approach..

