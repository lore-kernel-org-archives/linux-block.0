Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2B5FEE6
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732089; cv=none; b=SzVKE9vW5sVgzPNUrIdTguCc+5SWo7pUBwcnO1zNnkqJgIMkSCIwApOVvpwGADtME+49jQzzrrgl0zPIaJHMU3tnQpj8Ju3c3YNslbFtHFoEJIirb2kT2xcQyM9fFFLjiJJCJNm1BBGxbjXM1UmhxolBSyd6PG53s6QIyX66aLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732089; c=relaxed/simple;
	bh=8tHp2bcmzAdPHlk42ytLlv7W0Bjm4XIIZeeKqiWKb4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/caloheUp4dBZ/w9u5DAvpG12uEIotfbngMZvZit2Lds9r14AnruF/6ZWqs7ydLMBIXWrMrB/pBGUAjXZxKfmr+WPgGIY0FGeczE/Llk3hopaT2MWcBGXCDGlvAoudiQoRUjE9hQDEn8SjySCN1o2y9BnpTkWFKBAxwHIlhAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90CE068AA6; Mon,  9 Dec 2024 09:14:43 +0100 (CET)
Date: Mon, 9 Dec 2024 09:14:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yang Erkun <yangerkun@huawei.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	yangerkun@huaweicloud.com
Subject: Re: [PATCH] block: retry call probe after request_module in
 blk_request_module
Message-ID: <20241209081443.GA25304@lst.de>
References: <20241209022033.288596-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209022033.288596-1-yangerkun@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 09, 2024 at 10:20:33AM +0800, Yang Erkun wrote:
> Before commit e418de3abcda ("block: switch gendisk lookup to a simple
> xarray"), open loop0 will success. lookup_gendisk will first use
> base_probe to load module loop, and then the retry will call loop_probe
> to prepare the loop disk. Finally open for this disk will success.
> However, after this commit, we lose the retry logic, and open will fail
> with ENXIO. Block device autoloading is deprecated and will be removed
> soon, but maybe we should keep open success until we really remove it.
> So, give a retry to fix it.

This looks sensible.  But can we clean the logic up a bit by adding
a helper to make it easier to understand?  Something like the untested
patch below:

diff --git a/block/genhd.c b/block/genhd.c
index 6fcb09b8371d..654c2cc5d8e5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -797,7 +797,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 }
 
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
-void blk_request_module(dev_t devt)
+static bool blk_probe_dev(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -807,14 +807,26 @@ void blk_request_module(dev_t devt)
 		if ((*n)->major == major && (*n)->probe) {
 			(*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return true;
 		}
 	}
 	mutex_unlock(&major_names_lock);
+	return false;
+}
+
+void blk_request_module(dev_t devt)
+{
+	int error;
+
+	if (blk_probe_dev(devt))
+		return;
 
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
+	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
+	/* Make old-style 2.4 aliases work */
+	if (error > 0)
+		error = request_module("block-major-%d", MAJOR(devt));
+	if (!error)
+		blk_probe_dev(devt);
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
