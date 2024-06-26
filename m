Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C01922E4;
	Wed, 26 Jun 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431908; cv=none; b=mR46wDLdKEu09ccWBWBVcWK7qS9szsK1WJ0xAiZq3uHGdHBrQ28h3FIAIdDnwI3BdtQEyqvgncDZvXQSTZwMaYRQgg+xMlkMRUemdYnvMCkXOSXZyHsHX6tcWSsmkyLSgRHFkBY1CXTxYckS09ce5ARKNXmQ/g5xEksTlUh7D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431908; c=relaxed/simple;
	bh=EyhqgFbzB9i7k5aZ3sB31jwPSxLd9I7EskaB7u0dibo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2fSebk0rPbbdwqEly3I5BU7eBEDpebOxTRPhIF6LazcCNd6qqgNBrNdFPW0kx3plMRsXLoNLzHcWmzayIhwGC84lfWttpqxkGIASA4TGvEBuIpyI1AKlZP2I4CE+yRs7C2gRWAMhJ57KubdnSLKodf5+lfzsvpZf4MPj8w7p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMYmS-000000001kg-3CTF;
	Wed, 26 Jun 2024 19:58:12 +0000
Date: Wed, 26 Jun 2024 20:58:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH v3 2/4] block: partitions: populate fwnode
Message-ID: <Znxy0BJNTE79MrCq@makrotopia.org>
References: <cover.1719368448.git.daniel@makrotopia.org>
 <afa870ec6ac1027561d1c002205ab1e05358a46c.1719368448.git.daniel@makrotopia.org>
 <2de992b3-d71c-40f2-ad68-76a9f48338d4@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de992b3-d71c-40f2-ad68-76a9f48338d4@kernel.dk>

On Wed, Jun 26, 2024 at 01:43:49PM -0600, Jens Axboe wrote:
> On 6/25/24 8:50 PM, Daniel Golle wrote:
> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index ab76e64f0f6c..f88829e254e6 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/ctype.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/raid/detect.h>
> > +#include <linux/property.h>
> > +
> >  #include "check.h"
> >  
> >  static int (*const check_part[])(struct parsed_partitions *) = {
> > @@ -281,6 +283,42 @@ static ssize_t whole_disk_show(struct device *dev,
> >  }
> >  static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
> >  
> > +static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
> > +{
> > +	struct fwnode_handle *fw_parts, *fw_part;
> > +	struct device *ddev = disk_to_dev(bdev->bd_disk);
> > +	const char *partname, *uuid;
> > +	u32 partno;
> > +
> > +	fw_parts = device_get_named_child_node(ddev, "partitions");
> > +	if (!fw_parts)
> > +		fw_parts = device_get_named_child_node(ddev->parent, "partitions");
> > +
> > +	if (!fw_parts)
> > +		return NULL;
> 
> That last if check should to inside the previous one.

Actually the previous one should have been removed entirely. I somehow
forgot to 'git add' that change.

> 
> > +	fwnode_for_each_child_node(fw_parts, fw_part) {
> > +		if (!fwnode_property_read_string(fw_part, "uuid", &uuid) &&
> > +		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_UUIDLTH ||
> > +		     strncmp(uuid, bdev->bd_meta_info->uuid, PARTITION_META_INFO_UUIDLTH)))
> > +			continue;
> > +
> > +		if (!fwnode_property_read_string(fw_part, "partname", &partname) &&
> > +		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_VOLNAMELTH ||
> > +		     strncmp(partname, bdev->bd_meta_info->volname,
> > +			     PARTITION_META_INFO_VOLNAMELTH)))
> > +			continue;
> 
> This is pretty hard to make sense of...

I'll add comments explaining it. Or should I use another syntax, e.g. several
nested if-clauses, instead?
