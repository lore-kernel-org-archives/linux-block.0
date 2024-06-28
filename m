Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04520DC4;
	Fri, 28 Jun 2024 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549922; cv=none; b=if1HGPNS6FX46RGSN7dxy7c0wjX610wVC24gh4ltCzjYufk4V9gPG5W8bt48tco0330EaUp13+VvOiWyBJUxfj49RhQYzH1CF5YPHdWhwOjfDMIF3K0LoQgG3DKFA9hfhnq9mNCRCvhsUw8YWXnlyJAJcAkJazR7sBsk608NLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549922; c=relaxed/simple;
	bh=OcpG87jtg7Dv0PAMKSGRgGXu/GawmMhztBU/EXz1nUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFDl/M04vAzhBHulXnCaaKF58ei56Pk8XcaXdmWyAgrvmi0xAnXJs/hAGVnIDXODB65oIM1Fjt6F89joxsHZ88iIicpv4t3BaVHARtFU2LRaRPTg3PmIbJLhaN94UhifSdhd5p14TpolmCW49gTKz877Ka7XHmGvOTlY9fuAIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b4zHeiiW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4zHeiiW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AuGXcFp46j8hEZLTqyhcBDETCrdK2Us76EDIl8uIXno=; b=b4zHeiiWw24VTy2jJCaHz/9CRf
	sVRawGO7UzIJzziRBzKLuzMs6c15UI/JDa0suxHGYeIKp61TlpBBHc/gztTmn1d3hKreND0o+eLld
	U1NxC3hZ+pmbceurTA4QZZQUMwDDcaW6QuugY2yQH1uJmhnq1LZxGjPpCRd0p+aPsI1nxE0DarFRJ
	3ghBiYVAXvLBUKNAVj1+fFIPHQppTmzX48Xlzjs2tO9KmxQINIciDTT+iLZnRP+nr/gBGHrhr7yzc
	UVpllbjov36mEGswdYCYEv8Yfkd+g6zY9DDaarGXYn2wI/8bnfT2z3LI8Go2jlbIKAxgmXm4Q1vI+
	lMfetGRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN3TI-0000000CYIG-257i;
	Fri, 28 Jun 2024 04:44:28 +0000
Date: Thu, 27 Jun 2024 21:44:28 -0700
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
Subject: Re: [PATCH v4 2/4] block: partitions: populate fwnode
Message-ID: <Zn4_rMJVm6cpIEZV@infradead.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <6acc459a392d562abc58f7e55c6f04dba8073257.1719520771.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acc459a392d562abc58f7e55c6f04dba8073257.1719520771.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 27, 2024 at 09:50:39PM +0100, Daniel Golle wrote:
> +		/*
> +		 * In case 'uuid' is defined in the partitions firmware node require
> +		 * partition meta info being present and the specified uuid to match.
> +		 */

Overly long lines, which is really annyoing for block comments.

> +		got_uuid = !fwnode_property_read_string(fw_part, "uuid", &uuid);
> +		if (got_uuid && (!bdev->bd_meta_info ||
> +				 !part_meta_match(uuid, bdev->bd_meta_info->uuid,
> +						  PARTITION_META_INFO_UUIDLTH)))

Can we please not use the crazy part_meta stuff for anything new?
We should never have merge it, and right now it is at least isolated
to the boot time root dev_t partsing, and I'd really prefer to keep it
in that corner.

