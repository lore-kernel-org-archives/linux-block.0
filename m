Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B1208AD;
	Tue,  8 Oct 2024 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425065; cv=none; b=YNDPJ9hJ8h/pF/TYgiqRWyT74E9dt4aNG4MeO18KNnkHRg479EEwf1fCUnTjxnTSn3OqrdMc+5LxroY9e7GiMfHo6tGwCTqdneevgs/CjkoGQyHM5mo2qnvynhNRpOGyQYDJo7XSj5wTRfqf6WVnL9+/KfsKX7oXk5zWg5CgVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425065; c=relaxed/simple;
	bh=iow1JAe/82UMDIUstBevpkrdK9xWZnfdRJ6+IethTys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js9IxkBnOHr56WtGG6dXJEOO2XxfD2gj5W/jcN9Sbhh751j17mbk3s4q6tuxsngHKFnrwNWscEXxYUSdZEBTMuklO83m2vK9W330Pe3/FEZ/lFrzQZNhwSAV+qCrmjiwH0xklk8LWgf7ery6MI6OXwmpY/KPJQSffxFmOnkHPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0wnRx5r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0wnRx5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED1C4CEC7;
	Tue,  8 Oct 2024 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425065;
	bh=iow1JAe/82UMDIUstBevpkrdK9xWZnfdRJ6+IethTys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0wnRx5rjoLNrS4vpGE4v5saqkSKNgOSvij8i+fdhoyS+pQVFuAg+jmBVOicGvjYA
	 ynzvMGBQsfTh6kM+SehJvK38H4isiV/wqpCdpq4L1fWWyJhzFyTOfdaMEiBcyKzC3M
	 zLkBuR/nSuDfkZia0pepICsYBMO7fsUJDklOA/2vxIUI9mGzcR1f5DF4Xsp4SbO/ge
	 q4+CZWSRD2qw2UJy/FHJl4FgCWR5XyQB5r2vrYkj3mRVFe32O6AYlxhAexyKtM5six
	 mBdTgP2alF9lfIdvk8GzrZrRFsJu1XgmOJzsjaH8/jgBcB5kaLTu/M4ZOsX5i7A7L8
	 FcKaZz9Y24E9w==
Date: Tue, 8 Oct 2024 16:04:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <ZwVMLIt4iFX9MUjV@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVMLIt4iFX9MUjV@kbusch-mbp>

On Tue, Oct 08, 2024 at 09:13:48AM -0600, Keith Busch wrote:
> I still hope to see nvmet report this. It would be great to test this
> with HDD backed nvme-loop target.

I took the liberty to write one up. Looks like everything is reporting
as expected.

---
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 954d4c0747704..e167c9a2ff995 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
 
+static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status = nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	id->nstat = NVME_NSTAT_NRDY;
+	id->anagrpid = req->ns->anagrpid;
+	id->nmic = NVME_NS_NMIC_SHARED;
+	if (req->ns->readonly)
+		id->nsattr |= NVME_NS_ATTR_RO;
+	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+		id->nsfeat |= NVME_NS_ROTATIONAL;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -729,6 +758,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_id_cs_indep(req);
+		return;
 	}
 
 	pr_debug("unhandled identify cns %d on qid %d\n",
--
