Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738C192B9E;
	Thu, 27 Jun 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521477; cv=none; b=MuW3YKHH7pg6iX4KkOEayko/mpHD2z86ixM1OjveQK7HekYGXKRg7ZcUsIn6+ZjtJvROhDOvzUFFK1/PLKxPLRyMEeFdiyiGY/J6+cPFmL7o4MvyK6X8KLq70TJT7AmDE4Jt2triFAWioD8XepMYMfZK+9TuLsK5oko/LS4rAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521477; c=relaxed/simple;
	bh=uqAhbQZYET81rCRu7sX1ilbaIKFmqTjiPhVASe0KHaY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLQH4oK5aDgYRHg46rtCgSGK/S6oCPIfxqvRtHPVbK0UWT8HoetsITpB0FyCeKkDNq2RPYb0qlZH8RB8pNhZbGcz9g9sFSIpuhJXOXL4uy41UXxQ3Jf8+pUiO+Qb40F/10iucseg9YpmdgXuI96uWkOHrJ0s2PC9gzeJfQBAq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMw5B-000000007nd-0uTX;
	Thu, 27 Jun 2024 20:51:05 +0000
Date: Thu, 27 Jun 2024 21:51:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
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
Subject: [PATCH v4 4/4] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <564a69c6e6e75d66268ae5fcf61972145d4108c7.1719520771.git.daniel@makrotopia.org>
References: <cover.1719520771.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719520771.git.daniel@makrotopia.org>

Add new flag to destinguish block devices which may act as an NVMEM
provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c6e9fb16f76e..c6c6153dbede 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -81,11 +81,13 @@ struct partition_meta_info {
  * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
  * scan for partitions from add_disk, and users can't add partitions manually.
  *
+ * ``GENHD_FL_NVMEM``: the block device should be considered as NVMEM provider.
  */
 enum {
 	GENHD_FL_REMOVABLE			= 1 << 0,
 	GENHD_FL_HIDDEN				= 1 << 1,
 	GENHD_FL_NO_PART			= 1 << 2,
+	GENHD_FL_NVMEM				= 1 << 3,
 };
 
 enum {
-- 
2.45.2
