Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38F1B81D3
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379473; cv=none; b=GUclw7/Ul0OeluPNIuW/Vnkrje+FqDpB0HC1om7iQ+IIKoqJXfO/FUOITKs0BH/ldL/B0016wwjnLuoh4W0erc0W8shWkGbe6ZB+OvlkGnbS9AzmleEvPGsZuV5uvKJ6u3+PET0lEZSealXeFCd9GYkKJUqezSTbFwcbzdcfkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379473; c=relaxed/simple;
	bh=fKmO0gkMQZKIkFZu46Y9A1AVHjRq86wJPsx/aQT+9bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPf8ToZOa4u4fm09NiZdXuZg1AZPPHOJU64KWxXcO38eVp0bqI4mNETG7Uan3lYbZOnVFo0eyYH1dipOb3pHxYfTeyTNjvUFZsL9hITTRbZk1BFVuRbPOa9i6VqP/K1ldtULDh8T+aZXuVDultXB2y+8lob1Tjr20T+G2dFEIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVgOdvgw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVgOdvgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764379466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3Qayl8So1dq0GNPzxktpaPh7bHLy1kISP6P4M47rCA=;
	b=EVgOdvgwuH5aEPSBpA12IVjGAPa5fgWw9iyRbzmZ0q1VDcokTIepBNI3vWsNUbs3khacT9
	iE7JjGSlwtB1gpqznCoSEzrv/k+HqagTC4uyxAeKcoKbtgWXkV6C6JyrMaVRAwRboMAMNe
	8fK4pYfRQyLG+6Falw6OMjJ4XxJPRRA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-RXdq3ehqNqCiEpfnUaTMMg-1; Fri,
 28 Nov 2025 20:24:21 -0500
X-MC-Unique: RXdq3ehqNqCiEpfnUaTMMg-1
X-Mimecast-MFC-AGG-ID: RXdq3ehqNqCiEpfnUaTMMg_1764379460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C0E180034A;
	Sat, 29 Nov 2025 01:24:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A0FA1800367;
	Sat, 29 Nov 2025 01:24:12 +0000 (UTC)
Date: Sat, 29 Nov 2025 09:24:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
Message-ID: <aSpLN3xPwCqToYrZ@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <aSmOu6b2mG-N0aE7@fedora>
 <f60b4e02-7950-4fb4-908e-802a9a90ed54@kernel.dk>
 <CADUfDZoZ4Atind4x=GFsJ=H0TpSPFW2Ys2c5AQOMH3LnguSthw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoZ4Atind4x=GFsJ=H0TpSPFW2Ys2c5AQOMH3LnguSthw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Nov 28, 2025 at 11:07:17AM -0800, Caleb Sander Mateos wrote:
> On Fri, Nov 28, 2025 at 8:19 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 11/28/25 4:59 AM, Ming Lei wrote:
> > > On Fri, Nov 21, 2025 at 09:58:22AM +0800, Ming Lei wrote:
> > >> Hello,
> > >>
> > >> This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
> > >> server in batching way:
> > >>
> > >> - Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os
> > >>
> > >> - Batch processing: Multiple I/Os are handled in single operation
> > >>
> > >> - Multishot commands: Use io_uring multishot for reducing submission overhead
> > >>
> > >> - Flexible task assignment: Any task can handle any I/O (no per-I/O daemons)
> > >>
> > >> - Better load balancing: Tasks can adjust their workload dynamically
> > >>
> > >> - help for future optimizations:
> > >>      - blk-mq batch tags free
> > >>      - support io-poll
> > >>      - per-task batch for avoiding per-io lock
> > >>      - fetch command priority
> > >>
> > >> - simplify command cancel process with per-queue lock
> > >>
> > >> selftest are provided.
> > >>
> > >>
> > >> Performance test result(IOPS) on V3:
> > >>
> > >> - page copy
> > >>
> > >> tools/testing/selftests/ublk//kublk add -t null -q 16 [-b]
> > >>
> > >> - zero copy(--auto_zc)
> > >> tools/testing/selftests/ublk//kublk add -t null -q 16 --auto_zc [-b]
> > >>
> > >> - IO test
> > >> taskset -c 0-31 fio/t/io_uring -p0 -n $JOBS -r 30 /dev/ublkb0
> > >>
> > >> 1) 16 jobs IO
> > >> - page copy:                         37.77M vs. 42.40M(BATCH_IO), +12%
> > >> - zero copy(--auto_zc): 42.83M vs. 44.43M(BATCH_IO), +3.7%
> > >>
> > >>
> > >> 2) single job IO
> > >> - page copy:                         2.54M vs. 2.6M(BATCH_IO),   +2.3%
> > >> - zero copy(--auto_zc): 3.13M vs. 3.35M(BATCH_IO),  +7%
> > >>
> > >>
> > >> V4:
> > >>      - fix handling in case of running out of mshot buffer, request has to
> > >>        be un-prepared for zero copy
> > >>      - don't expose unused tag to userspace
> > >>      - replace fixed buffer with plain user buffer for
> > >>        UBLK_U_IO_PREP_IO_CMDS and UBLK_U_IO_COMMIT_IO_CMDS
> > >>      - replace iov iterator with plain copy_from_user() for
> > >>        ublk_walk_cmd_buf(), code is simplified with performance improvement
> > >>      - don't touch sqe->len for UBLK_U_IO_PREP_IO_CMDS and
> > >>        UBLK_U_IO_COMMIT_IO_CMDS(Caleb Sander Mateos)
> > >>      - use READ_ONCE() for access sqe->addr (Caleb Sander Mateos)
> > >>      - all kinds of patch style fix(Caleb Sander Mateos)
> > >>      - inline __kfifo_alloc() (Caleb Sander Mateos)
> > >
> > > Hi Caleb Sander Mateos and Jens,
> > >
> > > Caleb have reviewed patch 1 ~ patch 8, and driver patch 9 ~ patch 18 are not
> > > reviewed yet.
> > >
> > > I'd want to hear your idea for how to move on. So far, looks there are
> > > several ways:
> > >
> > > 1) merge patch 1 ~ patch 6 to v6.19 first, which can be prep patches for BATCH_IO
> > >
> > > 2) delay the whole patchset to v6.20 cycle
> > >
> > > 3) merge the whole patchset to v6.19
> > >
> > > I am fine with either one, which one do you prefer to?
> > >
> > > BTW, V4 pass all builtin function and stress tests, and there is just one small bug
> > > fix not posted yet, which can be a follow-up. The new feature takes standalone
> > > code path, so regression risk is pretty small.
> >
> > I'm fine taking the whole thing for 6.19. Caleb let me know if you
> > disagree. I'll queue 1..6 for now, then can follow up later today with
> > the rest as needed.
> 
> Sorry I haven't gotten around to reviewing the rest of the series yet.
> I will try to take a look at them all this weekend. I'm not sure the
> batching feature would make sense for our ublk application use case,
> but I have no objection to it as long as it doesn't regress the
> non-batched ublk behavior/performance.
> No problem with queueing up patches 1-6 now (though patch 1 may need
> an ack from a kfifo maintainer?).

BTW, there are many good things with BATCH_IO features:

- batch blk-mq completion: page copy IO mode has shown >12% IOPS improvement; and
	there is chance to apply it for zero copy too in future

- io poll become much easier to support: it can be used to poll nvme char/block device
  to get better iops

- io cancel code path becomes less fragile, and easier to debug: in typical
  implementation, there is only one or two per-queue FETCH(multishot)
  command, others are just sync one-shot commands.

- more chances to improve perf: saved lots of generic uring_cmd code
  path cost, such as, security_uring_cmd()

- `perf bug fix` for UBLK_F_PER_IO_DAEMON, meantime robust load balance
  support

	iops is improved by 4X-5X in `fio/t/io_uring -p0 /dev/ublkbN` between:
		./kublk add -t null  --nthreads 8 -q 4 --per_io_tasks
		and
		./kublk add -t null  --nthreads 8 -q 4 -b

- with per-io lock: fast io path becomes more robust, still can be bypassed
  in future in case of per-io-daemon 


The cost is some complexity in ublk server implementation for maintaining
one or two per-queue FETCH buffer, and one or two per-queue COMMIT buffer.


Thanks,
Ming

