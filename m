Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8918B473;
	Tue, 30 Jul 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367639; cv=none; b=H2zojT0S4OdwLk8YnQy7DknEpWWhN9qnSHBX6lZyEOQ8GhvL/A9ppGv7VR0UdE67aEapayjKfH2YfDDTCy94qiMMCNCZnlObYg45G536nJNa1fu2BniUvXb96969vI+md+Qxpac4qCudHqTNmANg6DynGrUbYaAdaItOVlOcURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367639; c=relaxed/simple;
	bh=L8zusH9t9xhimicb6WVbLo8ISzabexbaDpqexqASPiM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk0lGV+3CCG8DogMfXe2cptbhdklRp86NiYoAsbnEcgGmUZ2nKPLCV3w/eXRZe1BRGdegFRZyCLFDHFFomcwGA3P8b4ItWPx0+SfBNCv8OIn0DWYWCY7IC1MiA2QclRG3j8xmDiuq8kR6+t1xO27RgxIaH+Fn4nzNCcigHd83yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYsV4-000000003Eu-3WXT;
	Tue, 30 Jul 2024 19:27:10 +0000
Date: Tue, 30 Jul 2024 20:27:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tianling Shen <cnsztl@immortalwrt.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v5 4/4] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <311ea569c23ce14e2896cd3b069dc494c58c49c2.1722365899.git.daniel@makrotopia.org>
References: <cover.1722365899.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722365899.git.daniel@makrotopia.org>

Add new flag to destinguish block devices which may act as an NVMEM
provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f871158d2860..cab689851211b 100644
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
