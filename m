Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0D1DFF7;
	Fri, 28 Jun 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577024; cv=none; b=ng/pf89OhO9TaAGd1e+XKLtgUzBi5GQa3tWBaQ5CTC9Fwh09b/Kg58zVq+hX3Zr0uoeF54d7kLaSAMuLekAJ+smx6Moxgruy7FAS3Qs1uoPEf3tR4d3nmwCuo4xJqH+Mf3jwPKt8n++mHJulgKYR/F7Ku2NIQc8KaemtgnWY8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577024; c=relaxed/simple;
	bh=TFtNw1QJxkB2xWynZD+N88ma/reysTzvF3rsH+P5DIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDfCgGJg6Ht1ohNMVJl7mbtJGrUpZqOeoVzKxHLNLeCF0+d7lr8qfCm2su/vxma1BRzDJWLG/pm6iV61TntMNX+MsjShefnpqRo72XNKpASq/DzE4yRmr3tGy5MVI+opRI8xTf+KZ1XHiNRTuwbgJBv7dON3xwQiaEEK3farfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sNAWa-000000002oo-2LIO;
	Fri, 28 Jun 2024 12:16:20 +0000
Date: Fri, 28 Jun 2024 13:16:13 +0100
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
Subject: Re: [PATCH v4 2/4] block: partitions: populate fwnode
Message-ID: <Zn6pje4DcAYEk6Kw@makrotopia.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
 <6acc459a392d562abc58f7e55c6f04dba8073257.1719520771.git.daniel@makrotopia.org>
 <Zn4_rMJVm6cpIEZV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn4_rMJVm6cpIEZV@infradead.org>

Hi Christoph,

thank you for reviewing.

On Thu, Jun 27, 2024 at 09:44:28PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 27, 2024 at 09:50:39PM +0100, Daniel Golle wrote:
> > +		/*
> > +		 * In case 'uuid' is defined in the partitions firmware node require
> > +		 * partition meta info being present and the specified uuid to match.
> > +		 */
> 
> Overly long lines, which is really annyoing for block comments.

Should I use 80 chars as limit everywhere?

> 
> > +		got_uuid = !fwnode_property_read_string(fw_part, "uuid", &uuid);
> > +		if (got_uuid && (!bdev->bd_meta_info ||
> > +				 !part_meta_match(uuid, bdev->bd_meta_info->uuid,
> > +						  PARTITION_META_INFO_UUIDLTH)))
> 
> Can we please not use the crazy part_meta stuff for anything new?
> We should never have merge it, and right now it is at least isolated
> to the boot time root dev_t partsing, and I'd really prefer to keep it
> in that corner.
> 

At least up to my understanding there isn't any other to know a
partitions UUID or volume name.

If there is another way to access this information I'd happily make
use of it, but I couldn't find any.
