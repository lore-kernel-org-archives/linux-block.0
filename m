Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9622157B;
	Sun, 21 Dec 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345035; cv=none; b=WLFCq22t/HUcCTzHovOAzYLfZkrVyerN7c/5Q492TTKjmcwp/n3xtzTIVKw6q0ea3Xbe/RFMrGW0UJbj9qwwWYdw6ZpXWVzCg+kEm+vujAHjyzn7RLJEU7A7y7qTXk1BaEOtZ0IWk+q064mlceCseDiyT0wySldXvPztc8e4whM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345035; c=relaxed/simple;
	bh=yDdIfA2M7bhcnIzaQVZ/MR46IH7vReqFIBom6UsPNOk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t0EdAeEIDUBLjWGNfRdId9P2A2Xw8/dHa+pfvPnXCPGcEOyezWZr5aAx67ULMfBSCL7q8ydTStonozaGjEKu1MesVOKh9K3EIOsBNLzntfW3rGOXOAXcmydeR7lAs8rzJbNYVmXzeB73sx/VSKDxvLmWB5rNx/q7u+5g6B5wTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tQgMWruA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tQgMWruA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB63FC4CEFB;
	Sun, 21 Dec 2025 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766345034;
	bh=yDdIfA2M7bhcnIzaQVZ/MR46IH7vReqFIBom6UsPNOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQgMWruAu0PX8i7mHrZYIP/VOJTL6M8TGea6hZJQK6NixcH6P3dMo34xEtj3dMMVX
	 2IIlHOtyxZTAMY8j9WCO8e2bPMfM1HvOinqra/HMQlfv+/MDL0XqV+ygw8hvd5cljh
	 /UoPNbyTlsNnrzg1N4bEcZiksvFFY0RD4CKMOu9E=
Date: Sun, 21 Dec 2025 11:23:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Wangyang Guo
 <wangyang.guo@intel.com>
Subject: Re: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in
 group_cpus_evenly
Message-Id: <20251221112354.3a0ee9e1824f2cac9572d170@linux-foundation.org>
In-Reply-To: <20251020124646.2050459-1-ming.lei@redhat.com>
References: <20251020124646.2050459-1-ming.lei@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 20:46:46 +0800 Ming Lei <ming.lei@redhat.com> wrote:

> When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
> from different NUMA nodes to the same group due to the wrapping logic.
> Then poor block IO performance is caused because of remote IO completion.
> And it can be avoided completely in case of `numgrps > nodes` because
> each numa node may includes more CPUs than group's.

Please quantify "poor block IO performance", to help people understand
the userspace-visible effect of this change.

> The issue occurs when curgrp reaches last_grp and wraps to 0. This causes
> CPUs from later-processed nodes to be added to groups that already contain
> CPUs from earlier-processed nodes, violating NUMA locality.
> 
> Example with 8 NUMA nodes, 16 groups:
> - Each node gets 2 groups allocated
> - After processing nodes, curgrp reaches 16
> - Wrapping to 0 causes CPUs from node N to be added to group 0 which
>   already has CPUs from node 0
> 
> Fix this by adding find_next_node_group() helper that searches for the
> next group (starting from 0) that already contains CPUs from the same
> NUMA node. When wrapping is needed, use this helper instead of blindly
> wrapping to 0, ensuring CPUs are only added to groups within the same
> NUMA node.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/group_cpus.c | 28 +++++++++++++++++++++++++---

The patch overlaps (a lot) with Wangyang Guo's "lib/group_cpus: make
group CPU cluster aware".  I did a lot of surgery but got stuck on the
absence of node_to_cpumask, so I guess the patch has bitrotted.

Please update the changelog as above and redo this patch against
Wangyang's patch (which will be in linux-next very soon).

Also, it would be great if you and Wangyang were to review and test
each other's changes, thanks.


