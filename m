Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E21DE4E7
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390134; cv=none; b=gJtBqvPeIXrx8wgLDLkF2F6wKTnCeqO4NPzbrM8CtvuptxfWk55lQ7Emvk1tJ2W4qWoOS3NV6OUijGbZfjbje/NIz4wFMkySSqoTLqGxtUoj/AMNNNsKrcXjmgQLGV7VDOojZpFDJK5JL/j8yhWSTjoOJvRrxMZ+waYkMiyiAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390134; c=relaxed/simple;
	bh=LdWtT4VMXyHZ7rQULCNGUKLGTGpd5XC0N8OxyNQHuaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz3yy4RwPi+2bsbb9s3I5NZlCxBDEIi5KDS1dEnbnWHbrZ9FzWv/+9gpdMuQBdZKrQ/q4z+qBt2LLxXU0GRY6vbZg1av+6yTSpn7V0b9Wm42w3z5xksAj+p6EoyN0IN31XdnJydxwT1qzzFEHPYue+7XUTsdJxft8S46c5Q6FxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YxEUmtA/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YxEUmtA/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OuocT9B0/z1/BEcxr/8CqLWaTv/LfMtLcHmjckk81l8=; b=YxEUmtA/nxLRSBFeclh/s21PNy
	O5BZrBYft84WupKYZwZ17vJALG5LOrIEBn36aAD0FvKI9ixDNxE8WwnWNWb5g8FFLIbMlVhm0nhS2
	mfTbkMfaumvo7CzNy5h2f3Gxzqi1zMJLyIvzlHkyZ8zMCXQ6NgqJmLRz1AfdyTZCJijUo6+82YNDG
	pQQ6XOtT6GHKylfrTSFQTfcUxqVv+g32ZRAIzqSbrym3HLYlfnSknUXh46iV5jiC24ufcsDvVwD8O
	8KFU3ndNPVrZEW/qqSSQoWKVX2DJgjlX/bpjN6TikUi82frOmutIgPbls05lyrCmBqxrG1k6sX9H3
	KnNrW9eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Thj-00000009MAS-2Rrc;
	Wed, 23 Apr 2025 06:35:31 +0000
Date: Tue, 22 Apr 2025 23:35:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: linux-block <linux-block@vger.kernel.org>
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
Message-ID: <aAiKM0-1JJulHLW7@infradead.org>
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Holger,

can you try the patch below?  It fixes losing the read-ahead value in
my little test. 

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6b2dbe645d23..4817e7ca03f8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -61,8 +61,14 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	/*
 	 * For read-ahead of large files to be effective, we need to read ahead
 	 * at least twice the optimal I/O size.
+	 *
+	 * There is no hardware limitation for the read-ahead size and the user
+	 * might have increased the read-ahead size through sysfs, so don't ever
+	 * decrease it.
 	 */
-	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
+	bdi->ra_pages = max3(bdi->ra_pages,
+				lim->io_opt * 2 / PAGE_SIZE,
+				VM_READAHEAD_PAGES);
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
 
