Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF298208A9;
	Thu, 30 May 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035304; cv=none; b=MeSXI0NV0E5q37jCEe/SoY+qWJzXnn47eOcXNxW3Ef6yFHvM33uk0VYTSAAchnlpRdpF090uNSWg/B2gUsANFY9+m8Xf8jGFbVxXCeGYlzYTeMzqNVRLYZBAwRpaLj5MhF45JmaLPIr4Deps+tddPIozGiZUZzQCiwAEms8TEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035304; c=relaxed/simple;
	bh=3/qKbynN3yd31VH9tB9RkMiH7LQj1z+unggA4X0foD0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdU6DsmWlVHt6mJd4uCBilVY4dvkqo8L0oCik/mmYK/XNUQ4pZTnl/EmF7bCuGWrS9x6pWiMGRdG20aMLH718hy06seGvmminJNUfjxjlGgIPX5ES1fUush/+Ld0INk6xqacTmE+wu6UGiUKtLy8uo0YjXcD6DOCVqJmOSmk0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVJd-000000004gC-060q;
	Thu, 30 May 2024 02:14:53 +0000
Date: Thu, 30 May 2024 03:14:49 +0100
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
Subject: [PATCH v2 4/9] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <991e1dc3d7a08355a0e746129ecad18df5aa2405.1717031992.git.daniel@makrotopia.org>
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

Add new flag to destinguish block devices which may act as an NVMEM
provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a8c3478a462..c3365856e67b 100644
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
2.45.1
