Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1D139CE2;
	Thu, 13 Jun 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313016; cv=none; b=R+LgeZeAZeRwqKc6K+P6kZsu/LOY36KsD+hNyJXpcbOhe84sNAIiUz/MrOsrmX8NO3jgY53kBrlLgQhSI6aql9aEghcSlvrLM0aAz43GItNz7X7Y0JvH26qlzstBIZCPeo/6Qa+kjeDOgQrNhvHB9D5M6eavHfWzTZQ6127voO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313016; c=relaxed/simple;
	bh=1J4WLBtZ95L8XtXYwCU1lBJTRVbRe4D591TuQlCYEHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HnrjlAuleO0nRK4dPAt1Y3F5lKR8qMtYWsNK2Q6HRogDTwDnJay4YN8Lwg9hTlt8xthdTgv9i2nA4eoArFTntde5zGGiFi4o/hf2MuA7Dg6LVCIbNuLLFT7b37xsHs1Uy4iiyXXc+dmqupQlDjEhDQGYAOOthEkzMaZ5c18amuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=sivM0bTx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="sivM0bTx"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W0Zmy33WLz9sPq;
	Thu, 13 Jun 2024 23:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1718313010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf/D0AMDmsG7+mRQtcpHFjZ6BvLst9hXH1WNYtGV8o0=;
	b=sivM0bTxsqdxmFANQaTA5jst3UhQRRoBhxKaU4DCdHIjOp5u+0tVO/l4/8oPPdfXBuy0su
	q+0bDukQL6xZ7573zc92yW924ivLssKZ/Q8gC3PFvj28t3GYmeC8IMJGYwB4MoH4LEUsNL
	l9OC6FT83P2hXD0KbUyBkf3gETKgGWi2HWrwOtOII/lpj250pXPiKG+4xjzlaZ4xTwPSQI
	0paINADGZDr8vTYHVc6eFPgXFa8L5N1mNNeL8MI7oBI9UE2negABMB8ecTyrhtuM2UYUX3
	DnxZvp8BhZvWQCqLDhPup9ze6paM7fLaxfvKXM+6k7zHTas63jgmI63sCx6XiA==
Message-ID: <93428cdd-301a-46d7-84ef-e5c8ad42f495@hauke-m.de>
Date: Thu, 13 Jun 2024 23:09:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/9] block: partitions: populate fwnode
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jens Axboe <axboe@kernel.dk>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Hannes Reinecke <hare@suse.de>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1717031992.git.daniel@makrotopia.org>
 <3329bf2fa25695934b392944ff977ae95dc8c02d.1717031992.git.daniel@makrotopia.org>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <3329bf2fa25695934b392944ff977ae95dc8c02d.1717031992.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4W0Zmy33WLz9sPq

Hi Daniel,

On 5/30/24 04:13, Daniel Golle wrote:
> Let block partitions to be represented by a firmware node and hence
> allow them to being referenced e.g. for use with blk-nvmem.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   block/partitions/core.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index ab76e64f0f6c..93d109409905 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -10,6 +10,8 @@
>   #include <linux/ctype.h>
>   #include <linux/vmalloc.h>
>   #include <linux/raid/detect.h>
> +#include <linux/property.h>
> +
>   #include "check.h"
>   
>   static int (*const check_part[])(struct parsed_partitions *) = {
> @@ -281,6 +283,43 @@ static ssize_t whole_disk_show(struct device *dev,
>   }
>   static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
>   
> +static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
> +{
> +	struct fwnode_handle *fw_parts, *fw_part;
> +	struct device *ddev = disk_to_dev(bdev->bd_disk);
> +	const char *partname, *uuid;
> +	u32 partno;
> +
> +	fw_parts = device_get_named_child_node(ddev, "partitions");
> +	if (!fw_parts)
> +		fw_parts = device_get_named_child_node(ddev->parent, "partitions");

Could you please explain why you try to get the node from the device and 
the parent when it is not available? I think this should go into the 
commit description.

> +
> +	if (!fw_parts)
> +		return NULL;
> +
> +	fwnode_for_each_child_node(fw_parts, fw_part) {
> +		if (!fwnode_property_read_string(fw_part, "uuid", &uuid) &&
> +		    (!bdev->bd_meta_info || strncmp(uuid,
> +						    bdev->bd_meta_info->uuid,
> +						    PARTITION_META_INFO_UUIDLTH)))

I think you should check that the uuid provided in the device tree is 
not longer than PARTITION_META_INFO_UUIDLTH. Same for the volume name.

> +			continue;
> +
> +		if (!fwnode_property_read_string(fw_part, "partname", &partname) &&
> +		    (!bdev->bd_meta_info || strncmp(partname,
> +						    bdev->bd_meta_info->volname,
> +						    PARTITION_META_INFO_VOLNAMELTH)))
> +			continue;
> +
> +		if (!fwnode_property_read_u32(fw_part, "partno", &partno) &&
> +		    bdev_partno(bdev) != partno)
> +			continue;
> +
> +		return fw_part;
> +	}
> +
> +	return NULL;
> +}
> +
>   /*
>    * Must be called either with open_mutex held, before a disk can be opened or
>    * after all disk users are gone.
> @@ -355,6 +394,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>   			goto out_put;
>   	}
>   
> +	device_set_node(pdev, find_partition_fwnode(bdev));
> +
>   	/* delay uevent until 'holders' subdir is created */
>   	dev_set_uevent_suppress(pdev, 1);
>   	err = device_add(pdev);

Hauke

