Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86C3EF0D7
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142231; cv=none; b=mTrg6TmJ9w3wuJmirSw4OCpbGmaUDmw7Y61P1RXvBInwAGLzRTSx1+K/yy7UN8CEzFKCaPBEzMSMSP4/KYMEcRB7rW7bvRhko5sk01q0FtpR+ZSRF4kRtIsqyEJNp+KkcP+Qh1icZmcWwI8Evlk8huND50OT+Ub1ZyEKn95Xq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142231; c=relaxed/simple;
	bh=Wwmx1R4DTqmeZswVL7NUu7MxIwXoadU9zu7zpbjwlTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyt7bvxXq7H0MOUtLS/nYQYcIZOirmiYYbyh5BPtWveh8Pn8n3fdt8eryiAWbDJN5Lz/6Yg+hSHFN/Ce0ohHDpWcqY9T9vYB4v8tzXGa3FKfoWJ1Uzb2CcPc0KAEmnY0M/XSDwWfpI7OOd/RnR9H03gtyFHDThbuUmbU8ZpSzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD+hgjsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD+hgjsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AFFC116C6;
	Thu,  2 Apr 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775142230;
	bh=Wwmx1R4DTqmeZswVL7NUu7MxIwXoadU9zu7zpbjwlTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JD+hgjsp1whXMdxzZfy+/hdwM6DT81RV0I46vXYJ9kb5uGigMLommozxBsiTPINbF
	 dBo6x6JtgIfNaBszqIxzbIpaAy7uBKLoPM2kw+KvFICVRFgRGwB3nW8+E2im8Gv2au
	 U7vzxsNAg6J2fKCCKmTgtZDqHgpza4Hlu4CTp70vhDvzNBri5hbT0f62Xuxoo5X3tg
	 rSun/3FrPmmrgN4keqNtoPmTV2Qfzny30ICppKvYHaE2sqG4r4VRPbkUguEO1QgHha
	 ptwO87SHsBHEI4xKq6JcGzoTiTxJb6Ce9VKwpBN4beAyfSDSj7Sx72GWWX9dVmUZNp
	 A5nhTai+s79hQ==
Date: Thu, 2 Apr 2026 09:03:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Friedrich Weber <f.weber@proxmox.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mira Limbeck <m.limbeck@proxmox.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <ac6FVPT3ZCDoVtb7@kbusch-mbp>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
 <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
 <9bf5286c-bac7-4cb7-9bfe-f47195e18b79@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf5286c-bac7-4cb7-9bfe-f47195e18b79@proxmox.com>

On Thu, Apr 02, 2026 at 04:33:47PM +0200, Friedrich Weber wrote:
> We only have limited access to the test machine, so testing this is not
> trivial. If I understand correctly, there is a lead pointing in the direction
> of mpt3sas [1], so I'd postpone this test for now. But if needed, we're happy
> to look into it.

Yeah, the mpt3sas driver isn't using an appropriate sized buffer for
nvme prp handling. The easy option is just force the block layer to
split requests so the driver never sees anything bigger than what it can
currently handle. This should do it. I don't have any such device to
test on, though.

---
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff7885572942..c76f5b958c56f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2739,7 +2739,10 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
 				pcie_device->connector_name);
 
 		if (pcie_device->nvme_mdts)
-			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
+			lim->max_hw_sectors = min(pcie_device->nvme_mdts / 512,
+						(SZ_2M / 512) - 8);
+		else
+			lim->max_hw_sectors = (SZ_2M / 512) - 8;
 
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
--
