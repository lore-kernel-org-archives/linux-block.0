Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E43224D2;
	Fri, 28 Jun 2024 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549965; cv=none; b=n5gNzOqLSjthJSJ+NnI0IuRz79eC5GpVX0kaHWB6CroUg5FybSxThwZeHIGrYUEgE9sqjn4wqvOp+3lwlsF5K7PmeICNBFZBsZgJpZj6W4G/ndfjw5Sa2f9MbQIwikOVODjEiG7QaiZRa01/NLMfM1vpn7YQ3jHFxpeXCpcVX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549965; c=relaxed/simple;
	bh=TZaytH0FOBjY2yQDNKE2k83Kg5kahh8jLSo707GKNUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEE7Y+KSiBqgJBxFIleVXVpWP5GTjgrVc32elR2la+OXRozCII2bPrpvKZH1pfO56HKRF91a88zLPqRs+mWq0bKY08J7I8M/UO5fWEKZ6Mcy7WTU8VMEPSO1C56yhtdGn/u3DY+YQhWQpDl//TddKnlygzZhv/6vOIs/UDL1Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lr48Y3e8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lr48Y3e8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OWENhf3IvxmXVRFf5yQMQm7YyD2+KzXnZP3WnXTnfoI=; b=lr48Y3e8PTQJ+nEQ/sSUctbZ6s
	TALaGDeZKcMePZdFl4XK9saGMPyX87Lz9o/t+6Zoh7RnCqrrdJQ4pQ3MmTL1+b+kuuEilA2fqN/n7
	vdDh7ozE+Lkm95Sh19a7+E+MS2pEh0/+v/C6qegF3V0in2wBZHWBWA33pqS4wKNFW9OOfAMNH6W5d
	725QV5o6I1blGT+XTEzrqZeILkCQqvSTSHInsj9c8wVmgRYPFdIljcRVMOMt7oedBeDT/NyQp2/ql
	oLZjl2HrupBoN6ZRygslTiH856XMeJXvXE2SKL2rHBeIa467teJbC/u6mvGZ4DrVr6MR+3bjEblB9
	fXwfHLdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN3UX-0000000CYSN-3JQs;
	Fri, 28 Jun 2024 04:45:45 +0000
Date: Thu, 27 Jun 2024 21:45:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <Zn4_-alKtxuZ6zNt@infradead.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebef78f07ff1ea4d553c481ffa9e130d65db772.1719520771.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 27, 2024 at 09:50:50PM +0100, Daniel Golle wrote:
> Add notifier block to notify other subsystems about the addition or
> removal of block devices.

Notification for what?  I really hate the concept of random modular
code being able to hook into device discovery / partition scanning.
And not actually having a user for it is a complete no-go.

