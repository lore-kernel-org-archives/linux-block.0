Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F123101A0
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331221; cv=none; b=OexVmP02j86rkoRhh6+QdOhd9u70oHm5/K5S8SNuSUfxln9NTUfof96lKgGVCFmWJZdoLBsOrXmDQ2NI5kRjr84ojxsBBB29J5w8bd5cVddekN+RODC590TDhkolbpVbiiaOrf0CAMg/pPoOoHGjAJguMV2PzhNVjM042yga8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331221; c=relaxed/simple;
	bh=UvNKOxVmGKTvlIu+GM9TmDf8rabOlBzB0gVbwpCy9yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap6bgU5y/2bxrJZRny4doMt0wzLFJq4EQcgpEwwbQ1ceUcPorYevM/Sn6COK3Z60xVcaC5jROTjee5JSBooAGrPgCM6+4aQRrc90cwGwDwzoZnFTvox5uuNf9Ed2GT++uxXXynI7OPDf+J2JRKgyPO2LW9kW1fXDd601HgNDJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRaNuf5L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRaNuf5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764331217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJsAMyGAizUKkzF4TTtjRfSuaknHuSKEas6AsbUwVOA=;
	b=TRaNuf5LoSaQ8RK6d1gFr8zTYOLt2dhwT6Kr3bPb1GC+9kimJogm/K1qdceMieIGIu/+ki
	vi5V0bfeYfRB6FHbxSmJ4SxCU1eh1TBCihBycV+MOpSDPvkCVnELgNXIFmkk1hjk1YQC+l
	GFYkf8tozPmbpkFs6EqfpUsrNTxK6Xw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-qmCk21wjNOe292cDS-0eeQ-1; Fri,
 28 Nov 2025 07:00:14 -0500
X-MC-Unique: qmCk21wjNOe292cDS-0eeQ-1
X-Mimecast-MFC-AGG-ID: qmCk21wjNOe292cDS-0eeQ_1764331212
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40B9D1955DC1;
	Fri, 28 Nov 2025 12:00:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B44A180087B;
	Fri, 28 Nov 2025 12:00:03 +0000 (UTC)
Date: Fri, 28 Nov 2025 19:59:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
Message-ID: <aSmOu6b2mG-N0aE7@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Nov 21, 2025 at 09:58:22AM +0800, Ming Lei wrote:
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
> V4:
> 	- fix handling in case of running out of mshot buffer, request has to
> 	  be un-prepared for zero copy
> 	- don't expose unused tag to userspace
> 	- replace fixed buffer with plain user buffer for
> 	  UBLK_U_IO_PREP_IO_CMDS and UBLK_U_IO_COMMIT_IO_CMDS
> 	- replace iov iterator with plain copy_from_user() for
> 	  ublk_walk_cmd_buf(), code is simplified with performance improvement
> 	- don't touch sqe->len for UBLK_U_IO_PREP_IO_CMDS and
> 	  UBLK_U_IO_COMMIT_IO_CMDS(Caleb Sander Mateos)
> 	- use READ_ONCE() for access sqe->addr (Caleb Sander Mateos)
> 	- all kinds of patch style fix(Caleb Sander Mateos)
> 	- inline __kfifo_alloc() (Caleb Sander Mateos)

Hi Caleb Sander Mateos and Jens,

Caleb have reviewed patch 1 ~ patch 8, and driver patch 9 ~ patch 18 are not
reviewed yet.

I'd want to hear your idea for how to move on. So far, looks there are
several ways:

1) merge patch 1 ~ patch 6 to v6.19 first, which can be prep patches for BATCH_IO

2) delay the whole patchset to v6.20 cycle

3) merge the whole patchset to v6.19

I am fine with either one, which one do you prefer to?

BTW, V4 pass all builtin function and stress tests, and there is just one small bug
fix not posted yet, which can be a follow-up. The new feature takes standalone
code path, so regression risk is pretty small.


Thanks,
Ming

