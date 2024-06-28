Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4E1514DD;
	Fri, 28 Jun 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577448; cv=none; b=ls8i2lZe3GKoHACu4TcIUPoyFlxeF3u4Him+h6/7bl2xQb0WIqLpWSKOkkYRAh6q7UXwZhpPmkAGWOCL4yWl9z/d7P0ufxOZCGUdFUEJld1qhrilASseV/RU3l7d477b+rDz1U6wc2UK7a0nkxA4VSL0DLk1UGEn9rXH+nVYK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577448; c=relaxed/simple;
	bh=d+r8oOYodumHjWb4/1A1r6mqSgsc+MjymPkD+3M1T4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7adUUuBrfkdhWMqwEBPEKxNNP7p0oOVi8QkRRYKAagzghvqLwe3bcVtHMuX3zA+X0FGks9tOAy+28KSm2k9WTPv78oa3i3QRo1N+UDDAaxbc+ORki200J6fPg0MtT0YJJPnCANpAXTjgBTmBVnZpDj71VpPbfpG4nsoWlipv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sNAdr-000000002r5-3X5l;
	Fri, 28 Jun 2024 12:23:51 +0000
Date: Fri, 28 Jun 2024 13:23:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/4] block: add support for notifications
Message-ID: <Zn6rU-mCYQcyCkGT@makrotopia.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
 <Zn4_-alKtxuZ6zNt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn4_-alKtxuZ6zNt@infradead.org>

On Thu, Jun 27, 2024 at 09:45:45PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 27, 2024 at 09:50:50PM +0100, Daniel Golle wrote:
> > Add notifier block to notify other subsystems about the addition or
> > removal of block devices.
> 
> Notification for what?  I really hate the concept of random modular
> code being able to hook into device discovery / partition scanning.

Adding a dedicated notification interface (instead of using block
internals in the nvmem driver) has been requested in a previous review
by Bart Van Assche:

https://patchwork.kernel.org/comment/25771998/

Quote from that previous review comment:
>>> Why to add this functionality to the block layer instead of somewhere
>>> in the drivers/ directory?
>> 
>> Simply because we need notifications about appearing and disappearing
>> block devices, or a way to iterate over all block devices in a system.
>> For both there isn't currently any other interface than using a
>> class_interface for that, and that requires access to &block_class
>> which is considered a block subsystem internal.
>
> That's an argument for adding an interface to the block layer that
> implements this functionality but not for adding this code in the block
> layer.
---

So that's what I did consequently. Using the notification interface
the NVMEM driver can live in drivers/nvmem/ and doesn't need to be
using block internals.

> And not actually having a user for it is a complete no-go.
> 

The user will be the nvmem provider, you can see the code in earlier
versions of the patchset where I had included it:

https://patchwork.kernel.org/project/linux-block/patch/96554d6b4d9fa72f936c2c476eb0b023cdd60a64.1717031992.git.daniel@makrotopia.org/

Being another subsystem I thought it'd be better to deal with the
block related things first, and once that has been sorted out I will
move on to add the NVMEM driver and make the necessary changes for
using it on eMMC.


Thank you for taking a look at this. Let me know if anything else
is not clear or needs to be changed.


Cheers


Daniel
