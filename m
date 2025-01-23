Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC920B22;
	Thu, 23 Jan 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645517; cv=none; b=vEmhCPOoaVdrkBJtkOBh2vXUSajwOku17HyjN0mrXzflVQhvcvOqp1vqIkD+mu6Sto4xZyiFEg9nM765NEisKlzFw3MiFp/INFvg06YeUu/0P2SnwOeCaPn5nIdjI57uNQ7A/dsXPcHJ/za7zLHpmO8lkUc8KBp+covUjL5H3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645517; c=relaxed/simple;
	bh=aLALxX4Hz6Ze8tZAfdiR7S1zyGV+aDIeDxuXlKVSTtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0SbWKUubJMOpIC3ZsDCe4eDpAqyHfwRsxu9WDpV0P+7EFxVab4+Y6mLpJJ9okzw7DrHraFq4L6plQxz9xHiG2aLqIUdyPeia2LYtiR14ltKx0joYOTjALUo1QsBOOfLbyUh4IAvqk06RxcXjezvD7FGhZG4jSpyowTFZrIlIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864AEC4CEDD;
	Thu, 23 Jan 2025 15:18:36 +0000 (UTC)
Date: Thu, 23 Jan 2025 10:18:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, Ming Lei
 <ming.lei@redhat.com>, John Garry <john.g.garry@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: create correct map for fallback case
Message-ID: <20250123101843.1a682cea@gandalf.local.home>
In-Reply-To: <20250123-fix-blk_mq_map_hw_queues-v1-1-08dbd01f2c39@kernel.org>
References: <20250123-fix-blk_mq_map_hw_queues-v1-1-08dbd01f2c39@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 14:08:29 +0100
Daniel Wagner <wagi@kernel.org> wrote:

> The fallback code in blk_mq_map_hw_queues is original from
> blk_mq_pci_map_queues and was added to handle the case where
> pci_irq_get_affinity will return NULL for !SMP configuration.
> 
> blk_mq_map_hw_queues replaces besides blk_mq_pci_map_queues also
> blk_mq_virtio_map_queues which used to use blk_mq_map_queues for the
> fallback.
> 
> It's possible to use blk_mq_map_queues for both cases though.
> blk_mq_map_queues creates the same map as blk_mq_clear_mq_map for !SMP
> that is CPU 0 will be mapped to hctx 0.
> 
> The WARN_ON_ONCE has to be dropped for virtio as the fallback is also
> taken for certain configuration on default. Though there is still a
> WARN_ON_ONCE check in lib/group_cpus.c:
> 
>        WARN_ON(nr_present + nr_others < numgrps);
> 
> which will trigger if the caller tries to create more hardware queues
> than CPUs. It tests the same as the WARN_ON_ONCE in
> blk_mq_pci_map_queues did.
> 
> Fixes: a5665c3d150c ("virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Closes: https://lore.kernel.org/all/20250122093020.6e8a4e5b@gandalf.local.home/
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-cpumap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
