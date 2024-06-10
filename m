Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C187482;
	Mon, 10 Jun 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045593; cv=none; b=lkqNrNJic545D1fpj/47H8pXBK1WrEqD6DNDr94WLm0ORmZn7WegIfKWKvJir6yxSD3hILrf3bxNH6i9GtTQR8YPZS8B//cLUqOvcdwqxFEUg1kNPTseRT1BPEuN3l/rXirnCcT5KRqs1/sLA6VsRFWmNiyyLaxRRn3zermiw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045593; c=relaxed/simple;
	bh=I98Y7QWonOUW8VtV8Ziw+2/VviXGTMMP9IFQ+8hdMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzKPMhxoL44xI9E+Lq2lo2Sh4aRESNKgE5W/pH5vVS1eekr+96EhG3SX49ajUrsbhES/54UFpFJ9FVjUaWmF6bPmgajVTqV9VXJJg2mogMQkCPR0vb3iEajj4BQ4MrDHaxI8XU9gVY79LpDXBRBRq769iCI1/zY6VcxmQ6S/uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF1dyYyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF1dyYyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BA1C2BBFC;
	Mon, 10 Jun 2024 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718045592;
	bh=I98Y7QWonOUW8VtV8Ziw+2/VviXGTMMP9IFQ+8hdMEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF1dyYyBlQXhXzGrzE9Q8qLqzLpVrIPx7UXUGQ0gkQdeTfGIcBgXsajqXjYhDQmY9
	 VS+XAtbCfcZr8bR+7dRQ8vhkd+Hm8JBajhV1Qzi/jygW1VZKQqU3wA1nTQnKnolOFe
	 RbXDw58KdHM3ElK330jq7qK8N2E4QX5RrknLDrqPVxfJStj+mJHc7o9xgOXFRijsOU
	 YiyMdQ3GnvMMQijmMaYh0wyqPv7Cnm1LZCrfBiMbppwpw2gQ29LX2Ek/sTuTPxnP+0
	 AKkISnLHG/y+QUJUP1VBq3p0WI1xdWTJqG3NcnvQ2LyGZem6z4ZcoL4pB3Z3jp94wg
	 oi8neoB3IIfiw==
Date: Mon, 10 Jun 2024 12:53:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: sagi@grimberg.me, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>

On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> 
> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.

My mistake. The namespace remove list appears to be getting corrupted
because I'm using the wrong APIs to replace a "list_move_tail". This is
fixing the issue on my end:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7c9f91314d366..c667290de5133 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_splice_init_rcu(&ns->list, &rm_list,
-					     synchronize_rcu);
+		if (ns->head->ns_id > nsid) {
+			list_del_rcu(&ns->list);
+			list_add_tail_rcu(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
--
