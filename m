Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BA3D57A;
	Thu, 30 May 2024 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035350; cv=none; b=T5EU8eGdqALO0cHJWc7VJTSu3gIC/odDEzZ53MNGVzCuiH5Wuag2DBjuql3tLKt5F+/prTaNcQzZWrty4sWy1CVYgHs9WOKOrNuNxKeu3fh9PrF/gBo9ZKXlC5FLykVjIpCeyDTOOvWSdTJQf34o6B/2pVJ7TX8i1c2Bl3dvvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035350; c=relaxed/simple;
	bh=jUdRJVyoIcjUb4yayy/yqSHIWyvEbd3XvWtltACDs4w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV+ThJ1aRtEY+hFtAm16c13e1KrDc89GimVNu2mhRUX/OJKTyYuFKKi/TnSjFY+gRBYFUltPWknPQ8M+FP/tWEZAkDW29UuWyUTSG10ZJ4bydvSEPZyIjFmIMJgEg4GXKb2fum6ttJ6WmhNwVOVyTCjGXj1qgQUr12ykLxInRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVKO-000000004is-1sla;
	Thu, 30 May 2024 02:15:40 +0000
Date: Thu, 30 May 2024 03:15:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
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
Subject: [PATCH v2 8/9] mmc: block: set fwnode of disk devices
Message-ID: <ee24b739d469db1567e10258f694550c5d297b47.1717031992.git.daniel@makrotopia.org>
References: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717031992.git.daniel@makrotopia.org>

Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
the mmc-card. This is done in preparation for having the eMMC act as
NVMEM provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 367509b5b646..cd3ee6d69aaa 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2463,6 +2463,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      int area_type,
 					      unsigned int part_type)
 {
+	struct fwnode_handle *fwnode;
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
@@ -2559,6 +2560,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
+	fwnode = device_get_named_child_node(subname ? md->parent->parent :
+						       md->parent,
+					     subname ? subname : "block");
+	if (fwnode)
+		device_set_node(disk_to_dev(md->disk), fwnode);
+
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	pr_info("%s: %s %s %s%s\n",
-- 
2.45.1
