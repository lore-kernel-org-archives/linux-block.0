Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582705;
	b=45OSMNbtrgoBHS0vqJ+Z4zgRuoOSnNPiR3Ps7g6yfFZWb3+Mw6n8qK/eZEYlSwGqjcuF
	 xQQfITHCuDwQB61xTJWlmSzl51B3XJSgiaTt3nWU7Sd/kP9HSSKUYz7b6T9Ws3gM/gzR7
	 n3E2Hw9/egR1rIXNvfesQeBxad0r4EULMp7Bcr5YgTpHQGjtCUtSrxydsfIBbmdmkyalM
	 87v3asZBpZkYHCpCFWsuJjucVvfFbps0v+ZTZl0G/92B4G9Jo9OxW7tC/O2rWIr6IvTb1
	 pQHTAoOJJrZkDEbg0yTH/dze/HS3YZohsObI1rDOV4mlBrR5J3+Z2JGW+W80Ykp5mSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582705;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=4Ts0Ui5cQbaoxXzxrwfsqcGKfEAcHWFH9/pz1vnV6iA=;
	b=1uZHs493ZWxfUXox6I+iGzDlQj+duQ3GLrzsYYdIXT2BE1YNmYw6sY8HwrWjtDtkfUXx
	 M2aEz/JIkvTgih8ods41WJq3bssCG7hNF2KAHbRGAijp+EaTsl+naI9igBEDenDRCH/ye
	 19ejOEzKEO3dAeJWY0yGA5ogHGx0B8c4BpXxzFN6Rgn+cKUMZ2PcpPwH2gbxVgK2KspC8
	 vvvnIiU1pRXe27KiQYr0wCYyUb6TPrJe7ipBzwLAWir7h6xUvYggMhouSzlGrtli3aSxb
	 KpwUQtGMmYH0fqkBVq0T0Q8L+Ovbgp8wvPrtkMwAzT1TSNcNKNDtznjRXK82SloRMmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A6606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 04:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA30368AFE; Wed, 25 Nov 2026 05:58:20 +0100 (CET)
Date: Wed, 25 Nov 2026 05:58:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/5] blktrace: add ioprio field to struct blk_io_trace2
Message-ID: <20261125045820.GD19878@lst.de>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com> <20261124133553.152463-2-johannes.thumshirn@wdc.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124133553.152463-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 24, 2026 at 02:35:49PM +0100, Johannes Thumshirn wrote:
> Add the UAPI definitions for passing I/O priorities, and with them SCSI
> command duration limit (CDL) hints, to user space:

Before we start encoding this too hard we really need to fix how CDL
is used in the kernel.  The whole idea of the user configures the
CDL descriptor and then the I/O issuers magically knows an I/O
priority maps to it is completely broken.

We need a way for the FS to know or even configure the CDL descriptor
and then use that.

