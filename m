Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0517C77
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784777; cv=none; b=lBuHBYLokjLGUi9YSTGPtmo6dBC/KjWfvG/oRedYhS9hGIwidyT/nibTa3rEX3A0yw8lLateDVoYIxXlKRXjgD0Wms1/8Eo5bHBL5qPxscJVCoPqfL4mVz9atK1j4VWENYqSf6HeX6JXd8+DcMw+c9/txVeCzL6TpA/hx1czBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784777; c=relaxed/simple;
	bh=CnEBZQLAc8cKEsXxRjn2QzGr6G7p5UCV6c+c0O3l0Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4s9cASdWoIJ070WKX/iiBlz9Mtxlu5I15OP1hP6WyvbQmcNf+5aAJJhDd2big6ATKyldNTOe39aRUBvzu9JFXNciwEkTX39Onm8WPZS+HjSBISEFymTGkIZyXRXXPpT67ukqur8v01gKUrocI+wksLanuJsL7OfIxsX0/kpvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrI898Y7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrI898Y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46871C4CEF7;
	Thu, 30 Oct 2025 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784776;
	bh=CnEBZQLAc8cKEsXxRjn2QzGr6G7p5UCV6c+c0O3l0Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrI898Y7tOKBfBa4Wrp2ScPkZXoBjkea2djc++1sf/4MLsNAfTtL1CqzjMQkXSMAM
	 dYSvyRTukX9kZleHnSCdE05yqAOhVu/nZ7BSDMrUVD3NS9sCup4XmbB06/qwWh9RCM
	 mct/bEF8RfLXfZ4fOM83B6r48YkPvMf0fbVZ+DVBroLu/PNBZnfSQ1iMAvUazCfoXL
	 Kv41FiXzsH1W63AJx0/E4T/rOTUG1hsqZiaoYTbLjLbavGMeyuMWpnYxWO4qFJFzwK
	 w89+ESdxUej6J5S2UukWRegMalKqcp1DcsDlFuqJYVNVuGjyy6OFroCcs2yNPEyRxV
	 /Vx1F0aoVEnYA==
Date: Wed, 29 Oct 2025 18:39:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	yzhong@purestorage.com, sconnor@purestorage.com, axboe@kernel.dk,
	mkhalfella@purestorage.com
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQKzxpJp98Po_pch@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029210853.20768-2-cachen@purestorage.com>

On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> 
> Fix this by taking an additional reference on the admin queue during
> namespace allocation and releasing it during namespace cleanup.

Since the namespaces already hold references on the controller, would it
be simpler to move the controller's final blk_put_queue to the final
ctrl free? This should have the same lifetime as your patch, but with
simpler ref counting:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de736..0b83d82f67e75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
         */
        nvme_stop_keep_alive(ctrl);
        blk_mq_destroy_queue(ctrl->admin_q);
-       blk_put_queue(ctrl->admin_q);
        if (ctrl->ops->flags & NVME_F_FABRICS) {
                blk_mq_destroy_queue(ctrl->fabrics_q);
                blk_put_queue(ctrl->fabrics_q);
@@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
                container_of(dev, struct nvme_ctrl, ctrl_device);
        struct nvme_subsystem *subsys = ctrl->subsys;

+       blk_put_queue(ctrl->admin_q);
        if (!subsys || ctrl->instance != subsys->instance)
                ida_free(&nvme_instance_ida, ctrl->instance);
        nvme_free_cels(ctrl);
--
