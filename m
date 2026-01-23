Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9738A712
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135125; cv=none; b=WnsGBgMD82JVN3ZuQ6KlvcWNgfOMyyu/RE7QTwZPH5AQuAh/5tf8Qw4UAyyl7RMZRgxrCU20PFDFHvEDgt3oVqnKcwWC8XYbfSr/0/ZkOXsAI8n/HJoiaGqIvgFe2d9JmygBLp/siT8MPq5cabNpUzDv924mAMXW0t4LjBOfqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135125; c=relaxed/simple;
	bh=LgxGsmdSuD1aeMYqYDZfDD9wY9ETSzWWmo5bM9Vzrwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeVU/Z0yh6sQcaoSWij0RCzgSnaHgCVqeOMhmHjfhX3zjQaUapLcO6Neel9He5t7bPMJFAUPH+XtaBVD6P9LHdq5F4BmPsFlCu0s5pPFVeiOY9QXqKlYAbxnGyodqRs8QsZc01PvPXKw0Y1TJK3AEwg85ZiGFk567I90fI50pEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpqNV/Mu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpqNV/Mu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769135102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E61B803whC+FXll4LYXkMBXmVjcgAWIkEGKZoZC838=;
	b=dpqNV/MuxU3/TlkQ8P5uuPzo2nv3Zs/1EZsGYBnV2G2WssfBJt7ZIufLrBsjHbOK1ZS8Jl
	MfV+KDgRwn0hERL/Dw/O4CHyBMoRAx+8Mc2zEDdYRlbV2MjBzIuYPYbXGtwNOjE+MFkjAy
	ti4nAaumB5m5WmDU+aLCgV5fGUTTcok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-o22PJCWTPLKkhWld3m1bJQ-1; Thu,
 22 Jan 2026 21:24:58 -0500
X-MC-Unique: o22PJCWTPLKkhWld3m1bJQ-1
X-Mimecast-MFC-AGG-ID: o22PJCWTPLKkhWld3m1bJQ_1769135097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C2BB1800451;
	Fri, 23 Jan 2026 02:24:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4608D1800993;
	Fri, 23 Jan 2026 02:24:53 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:24:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V6 00/24] ublk: add UBLK_F_BATCH_IO
Message-ID: <aXLb8PwEsyszFuiz@fedora>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jan 16, 2026 at 10:18:33PM +0800, Ming Lei wrote:
> Hello,
> 
> This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
> server in batching way:
> 
> - Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os
> 
> - Batch processing: Multiple I/Os are handled in single operation
> 
> - Multishot commands: Use io_uring multishot for reducing submission overhead
> 
> - Flexible task assignment: Any task can handle any I/O (no per-I/O daemons)
> 
> - Better load balancing: Tasks can adjust their workload dynamically
> 
> - help for future optimizations:
> 	- blk-mq batch tags free
>   	- support io-poll
> 	- per-task batch for avoiding per-io lock
> 	- fetch command priority
> 
> - simplify command cancel process with per-queue lock
> 
> selftest are provided.
> 
> 
> Performance test result(IOPS) on V3:
> 
> - page copy
> 
> tools/testing/selftests/ublk//kublk add -t null -q 16 [-b]
> 
> - zero copy(--auto_zc)
> tools/testing/selftests/ublk//kublk add -t null -q 16 --auto_zc [-b]
> 
> - IO test
> taskset -c 0-31 fio/t/io_uring -p0 -n $JOBS -r 30 /dev/ublkb0
> 
> 1) 16 jobs IO
> - page copy:  			37.77M vs. 42.40M(BATCH_IO), +12%
> - zero copy(--auto_zc): 42.83M vs. 44.43M(BATCH_IO), +3.7%
> 
> 
> 2) single job IO
> - page copy:  			2.54M vs. 2.6M(BATCH_IO),   +2.3%
> - zero copy(--auto_zc): 3.13M vs. 3.35M(BATCH_IO),  +7%
> 
> 
> Links: https://lore.kernel.org/linux-block/20251202121917.1412280-1-ming.lei@redhat.com/
> Links: https://lore.kernel.org/linux-block/20251121015851.3672073-1-ming.lei@redhat.com/
> Links: https://lore.kernel.org/linux-block/20251112093808.2134129-1-ming.lei@redhat.com/
> Links: https://lore.kernel.org/linux-block/20251023153234.2548062-1-ming.lei@redhat.com/
> Links: https://lore.kernel.org/linux-block/20250901100242.3231000-1-ming.lei@redhat.com/
> 
> 
> This patchset is based on for-7.0/block with the following two patches:
> 
> 	[PATCH v4] ublk: fix ublksrv pid handling for pid namespaces ( https://lore.kernel.org/linux-block/20260115025952.2321238-1-sconnor@purestorage.com/ )
> 
> 	[PATCH 0/3] selftests/ublk: three bug fixes ( https://lore.kernel.org/linux-block/20260113085805.233214-1-ming.lei@redhat.com/ ) 
> 
> 
> V6:
> 	- rebase on for-7.0/block
> 	- fix ublk_handle_non_batch_cmd() (Caleb Sander Mateos)
> 	- add `ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()` (Caleb Sander Mateos)
> 	- add `ublk: fix batch I/O recovery -ENODEV error`
> 	- increase selftest timeout for running more things in some generic tests
> 	- fix kublk utility wrt. ->cmd_inflight accounting for BATCH_IO
> 	- pass all selftest after applying the io_uring cancel fix

Hi Jens,

Any chance to queue it for-7.0/block? And it is applied cleanly.



Thanks,
Ming

