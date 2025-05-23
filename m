Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57F2576
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006314; cv=none; b=SE4wY+pYz3lcB6+JBcBE3cklVYhGCfi+aoZ8ZoNI1LTaWoinJNEAdQmkZB4+M6vHD/gvmtM0cSCVKbGzBjJ/qV1uzMjgMNOKqOVWaRCvVap2tWalBJgo0nHrI+ea1ub0l1VSnHiPXDghMfsT2uGRAzUPWd2QV7KUI3RTjaiUCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006314; c=relaxed/simple;
	bh=uZKGmC5FguoJFrYdsaVtbCcUFfWCpF4q0KOFjmWwkW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssRsrEX1qLDwzXZUB1TGCAllsiKpy9V30QQ63MAhhDBiaM2N/oAVBKcv4zpELWLJ9Disr5H/DcWt6r85uS6oUZtE/Z/2acnvitvaZ8D8Ostr+fHRDlM4kbi06PmXhQqFXTV8T1EktdFBG2wOBK9f0ucNBqqYz4AB1AdU501pIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E0Pe1Ky+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0Pe1Ky+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FjIVkrvWcGJqrRoEHsAxET1vwF+UKwgZFhzlHuLr1zM=; b=E0Pe1Ky+ZPxdXJfZatbIuXWjqt
	if7aVi4csRYPs0vaLsyVdT58pjS843OS7VbUGuObvEsHQgaU0UmG9waVvNEvJ/cu76PDd3UUOxKPu
	flQQ5OoiHWepvg+59gYogTblT53MiCmMp8jlpPbJM7cpeq2/YKcKq1vJz3D01GeHQgtH/rqPeRasa
	TmjJrRd13oHDWvfSAxUGyb8GlU4b6eLmv/MLA2bL9Rtr42vRtqsgKnjFHZQHh31mrUJIu2pDage76
	WAMERtKvbzkGVP8ZmWsdP1wyvGJ9OwsWUhDx368hl3JjNO6/YVhCII6S+F4Jb84WO2HVA/g294eHd
	jiDAYz9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISIC-00000003vdQ-05C1;
	Fri, 23 May 2025 13:18:32 +0000
Date: Fri, 23 May 2025 06:18:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDB1p8XIhsauGFhc@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-6-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 03:31:07PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme block device target type does not have any particular limits on
> copy commands, so all the settings are the protocol's max.

I need this additional bit so that the host code actually see the
copy support:

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c7317299078d..355cb67a8b74 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -734,7 +734,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES |
-			NVME_CTRL_ONCS_RESERVATIONS);
+			NVME_CTRL_ONCS_RESERVATIONS |
+			NVME_CTRL_ONCS_NVMCPYS);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
