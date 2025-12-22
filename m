Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC3342505
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411443; cv=none; b=lBbb8mMANS2cR129e2zQRg40iiJGXsRtzDd8P9mtubaQq08QMMqxCF/RUyybTNl5SU+TvLkFI49yU6JwxxtSZE3STFmBsjuk+VmZ6kDni2l8uNE5gvusFCjQcuVEYEZbggdNt3Lnw6ib3jEopiEaTSc397vZA9crSw64JQs13qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411443; c=relaxed/simple;
	bh=2mkfWoBzv/4PUE5EH+qWjzwB6FuUxR5nefaQKiU8XZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYcODaWDvWs657lAqf5h+cTTlBUMEFoAypYd2wfy6AuNOnawV9tUzg9dST6ZSXxKbMHhI6w6Hhq7jJenT7CJH+McYifnrqnRxWT2pKtUAlsn8g18VvqYFqKEKE+EuCYdwO6+0U1E3Qh7Mh8/S5d/YAk5LDdtX+FwjgJ+s+3aBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NneD5XC7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NneD5XC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766411440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uLKaS9M6XCJacGAVbbW+GpokR6maSQb3iL9Idz2WJ0=;
	b=NneD5XC76rVZ5JitAW6sTRSlFk5+bLri6hwZbNY/uv+8cZVkMpMjFSL1olo8fE04j2p6u6
	20aoRb6yMk9kpBItE7JzMGWGXuEeRij1E2r2RPWOLMIknMKfCWuCVMlkNPcvyg4YKgBkzh
	ZGVtQvohuHAPp+UU5uHv2+0adfnUshE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-liCqbJhBNCGzhhjeY3h5XQ-1; Mon,
 22 Dec 2025 08:50:37 -0500
X-MC-Unique: liCqbJhBNCGzhhjeY3h5XQ-1
X-Mimecast-MFC-AGG-ID: liCqbJhBNCGzhhjeY3h5XQ_1766411436
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91E6A1800637;
	Mon, 22 Dec 2025 13:50:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65730180045B;
	Mon, 22 Dec 2025 13:50:28 +0000 (UTC)
Date: Mon, 22 Dec 2025 21:50:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: Re: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in
 group_cpus_evenly
Message-ID: <aUlMlf8P5xYOOsWr@fedora>
References: <20251020124646.2050459-1-ming.lei@redhat.com>
 <20251221112354.3a0ee9e1824f2cac9572d170@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221112354.3a0ee9e1824f2cac9572d170@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Dec 21, 2025 at 11:23:54AM -0800, Andrew Morton wrote:
> On Mon, 20 Oct 2025 20:46:46 +0800 Ming Lei <ming.lei@redhat.com> wrote:
> 
> > When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
> > from different NUMA nodes to the same group due to the wrapping logic.
> > Then poor block IO performance is caused because of remote IO completion.
> > And it can be avoided completely in case of `numgrps > nodes` because
> > each numa node may includes more CPUs than group's.
> 
> Please quantify "poor block IO performance", to help people understand
> the userspace-visible effect of this change.

It is usually a bug, given fast nvme IO perf may drop to 1/2 or 1/3 in case of
remote completion. queue mapping shouldn't cross CPUs from different numa
nodes in case of nr_queues >= nr_nodes.

> 
> > The issue occurs when curgrp reaches last_grp and wraps to 0. This causes
> > CPUs from later-processed nodes to be added to groups that already contain
> > CPUs from earlier-processed nodes, violating NUMA locality.
> > 
> > Example with 8 NUMA nodes, 16 groups:
> > - Each node gets 2 groups allocated
> > - After processing nodes, curgrp reaches 16
> > - Wrapping to 0 causes CPUs from node N to be added to group 0 which
> >   already has CPUs from node 0
> > 
> > Fix this by adding find_next_node_group() helper that searches for the
> > next group (starting from 0) that already contains CPUs from the same
> > NUMA node. When wrapping is needed, use this helper instead of blindly
> > wrapping to 0, ensuring CPUs are only added to groups within the same
> > NUMA node.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  lib/group_cpus.c | 28 +++++++++++++++++++++++++---
> 
> The patch overlaps (a lot) with Wangyang Guo's "lib/group_cpus: make
> group CPU cluster aware".  I did a lot of surgery but got stuck on the
> absence of node_to_cpumask, so I guess the patch has bitrotted.
> 
> Please update the changelog as above and redo this patch against
> Wangyang's patch (which will be in linux-next very soon).

Please ignore this patch now because I can't reproduce the original issue
on both v6.18 and v6.19-rc.

> 
> Also, it would be great if you and Wangyang were to review and test
> each other's changes, thanks.

OK.


Thanks,
Ming

