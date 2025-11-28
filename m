Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077C285058
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356852; cv=none; b=Wkr/ziUf96pfhg230p9U7vLXRpLfR5ZseXfR3jHBOrSSUquFxdF0S54897CKE78GOfkS94u1B/XCuSbuaquDF/lCKWTdbsuFmIysu/vg6zq/qJlO7h9QjLJBoaweDPkv5YgRK6Wxuy+rdDKSctjFhH5vKWpdMzfIb5J7EeWJwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356852; c=relaxed/simple;
	bh=5OaqV/ymOluiytKUTqnK2P9Lsl+op1Wq78jwPlH9GBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JP/OsV/GwsCjEKC4dKaPlWfmeZ1ozQI30UfH5KZXdW4WsFomcFZaneK9TKmry8UaYpj7RL4GllFTTdkAO9z6Ks6/esITAMBlqV7vu5mdtWDKJdeeuAsq/zBp/eKPSOxlBVB40fj+xcyJF/22URT0Ljlol56D4Pbvrjf4TG9qRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TVqkfAS9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TVqkfAS9"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so152680b3a.1
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764356850; x=1764961650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKcpaE/XVjalMM6aU/vJDY4a2ZpWWdASieHCGdaIqe4=;
        b=TVqkfAS9sonfGdpCKIU4WiF39JqDrkYs5MCJJ9iJLX47V35BZAhe8lyf33L0nzhbSl
         aGZKY8Q4Nn/iyU5mODPrG5IkglmSpqLgikAblPu3iCl642hG/Jtp2MgfJvkX5SISeLB9
         xM7B+UWEGmQxSgAuXG//uh8674wMv5tIkliqddPIgBFg+/FnrsgK+vrzSg2+B0EZhcyV
         eSGv5WSZa9Q56eZOBz5wPklcWD1tIXDru1OCcvpdeBv1kAUtZFoZ03Mn5yTviyNfymSp
         ApzAReW+sccAwAQX0Ct6anWdtpIa7k4u+D1veYyRUYncS3y6KZdUDROsOgxxX8RGTGQN
         7d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764356850; x=1764961650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pKcpaE/XVjalMM6aU/vJDY4a2ZpWWdASieHCGdaIqe4=;
        b=c1Yc34VVVkxSdF+fuabfZi5VPzA1FH5G+zGJPDWf2er8z73Uy10CjoLpNC2L7vM8RQ
         0fUSI6Q1jb4H5viXAPMI92XCfq1/xPF3WS89bGhrAAQPTZoQLeNRrT+OXs5Mjm/GvCGF
         JVcy+eXH3LuF0p0esGN7oRPO19Kn/2Ca978iiOeGXxT0+syZ0QCdhU3CFvPmRQULHzqt
         mB+Kui145QXVnqvDxA9tBjK13qL2L/Cnj9GeeCpKgIy+eHDbxC3wRM3Zi9p9hMf+32ZX
         3ISUg37xZl6yuk+74XbbMWosM8AmFjG1Lw3UpUkHO0hdqr1b0p36fSQAR+N5hicVUj7L
         nV8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWCK3tvkRt0JjX6+xvXMi3nRRICtzZimB+KmOTFn2njFH18fECmq46bEpL8tzMPV+SVRPlTixx13l2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGRFKPFHoTER9hm10uBuu4HPBmyUv4ABX1ZMA6RiB6mU2nmZX
	omw5HShBQCiwgaEzt5/4OgyeghQ5e1WB9dLwZYoAdUmg7bVPyGy18lrP/XvB1tVp1KswzXYlzmL
	4mUNx3IlFp7kexSIjHyR9Vz5ptXY3Kv9WIZmyYISmgA==
X-Gm-Gg: ASbGncuoa+Cxq45kOLV/av8rR1RA2I/RbM7+u/9dXn5hqm9Buo0QCfqmEXi/2wZsHBD
	69hn1XYyfbO19OSLIQGh0gl1QU40KejaTskYP7fgmDyM1X1qM2iSZI+BqmvzXdekllwN250v6SU
	3ViGLzFWUpbBKg/9ETlDmyE/WLpgPFyclIEsQCBq5vmBrRt9vMoB7XmHPaK5zdAkwsQZLyHefsN
	Z41HJzhRr8SPM3RsFF2tilu6kXCBLhUS5Q5GBO87GlhgzjpAwEdHC4w4Q8Vm4o5yHxBqFhZ
X-Google-Smtp-Source: AGHT+IGpWv62fr/1XzvTIyQVfoTYqb5PP9VVYCRNWZrsOObXUMgBqO2xnK/lcof/5VI1pH0WybEpUrIT2+/s8YAZB6M=
X-Received: by 2002:a05:7022:ea48:10b0:11b:aff2:4cd5 with SMTP id
 a92af1059eb24-11c9d717ef2mr12949477c88.2.1764356849719; Fri, 28 Nov 2025
 11:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <aSmOu6b2mG-N0aE7@fedora>
 <f60b4e02-7950-4fb4-908e-802a9a90ed54@kernel.dk>
In-Reply-To: <f60b4e02-7950-4fb4-908e-802a9a90ed54@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Nov 2025 11:07:17 -0800
X-Gm-Features: AWmQ_blncTvdEgl7K15sH-1jCdGuvOcpjUXRdMa5yLIQ4TDuZphLKgygbTG9k0E
Message-ID: <CADUfDZoZ4Atind4x=GFsJ=H0TpSPFW2Ys2c5AQOMH3LnguSthw@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:19=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/28/25 4:59 AM, Ming Lei wrote:
> > On Fri, Nov 21, 2025 at 09:58:22AM +0800, Ming Lei wrote:
> >> Hello,
> >>
> >> This patchset adds UBLK_F_BATCH_IO feature for communicating between k=
ernel and ublk
> >> server in batching way:
> >>
> >> - Per-queue vs Per-I/O: Commands operate on queues rather than individ=
ual I/Os
> >>
> >> - Batch processing: Multiple I/Os are handled in single operation
> >>
> >> - Multishot commands: Use io_uring multishot for reducing submission o=
verhead
> >>
> >> - Flexible task assignment: Any task can handle any I/O (no per-I/O da=
emons)
> >>
> >> - Better load balancing: Tasks can adjust their workload dynamically
> >>
> >> - help for future optimizations:
> >>      - blk-mq batch tags free
> >>      - support io-poll
> >>      - per-task batch for avoiding per-io lock
> >>      - fetch command priority
> >>
> >> - simplify command cancel process with per-queue lock
> >>
> >> selftest are provided.
> >>
> >>
> >> Performance test result(IOPS) on V3:
> >>
> >> - page copy
> >>
> >> tools/testing/selftests/ublk//kublk add -t null -q 16 [-b]
> >>
> >> - zero copy(--auto_zc)
> >> tools/testing/selftests/ublk//kublk add -t null -q 16 --auto_zc [-b]
> >>
> >> - IO test
> >> taskset -c 0-31 fio/t/io_uring -p0 -n $JOBS -r 30 /dev/ublkb0
> >>
> >> 1) 16 jobs IO
> >> - page copy:                         37.77M vs. 42.40M(BATCH_IO), +12%
> >> - zero copy(--auto_zc): 42.83M vs. 44.43M(BATCH_IO), +3.7%
> >>
> >>
> >> 2) single job IO
> >> - page copy:                         2.54M vs. 2.6M(BATCH_IO),   +2.3%
> >> - zero copy(--auto_zc): 3.13M vs. 3.35M(BATCH_IO),  +7%
> >>
> >>
> >> V4:
> >>      - fix handling in case of running out of mshot buffer, request ha=
s to
> >>        be un-prepared for zero copy
> >>      - don't expose unused tag to userspace
> >>      - replace fixed buffer with plain user buffer for
> >>        UBLK_U_IO_PREP_IO_CMDS and UBLK_U_IO_COMMIT_IO_CMDS
> >>      - replace iov iterator with plain copy_from_user() for
> >>        ublk_walk_cmd_buf(), code is simplified with performance improv=
ement
> >>      - don't touch sqe->len for UBLK_U_IO_PREP_IO_CMDS and
> >>        UBLK_U_IO_COMMIT_IO_CMDS(Caleb Sander Mateos)
> >>      - use READ_ONCE() for access sqe->addr (Caleb Sander Mateos)
> >>      - all kinds of patch style fix(Caleb Sander Mateos)
> >>      - inline __kfifo_alloc() (Caleb Sander Mateos)
> >
> > Hi Caleb Sander Mateos and Jens,
> >
> > Caleb have reviewed patch 1 ~ patch 8, and driver patch 9 ~ patch 18 ar=
e not
> > reviewed yet.
> >
> > I'd want to hear your idea for how to move on. So far, looks there are
> > several ways:
> >
> > 1) merge patch 1 ~ patch 6 to v6.19 first, which can be prep patches fo=
r BATCH_IO
> >
> > 2) delay the whole patchset to v6.20 cycle
> >
> > 3) merge the whole patchset to v6.19
> >
> > I am fine with either one, which one do you prefer to?
> >
> > BTW, V4 pass all builtin function and stress tests, and there is just o=
ne small bug
> > fix not posted yet, which can be a follow-up. The new feature takes sta=
ndalone
> > code path, so regression risk is pretty small.
>
> I'm fine taking the whole thing for 6.19. Caleb let me know if you
> disagree. I'll queue 1..6 for now, then can follow up later today with
> the rest as needed.

Sorry I haven't gotten around to reviewing the rest of the series yet.
I will try to take a look at them all this weekend. I'm not sure the
batching feature would make sense for our ublk application use case,
but I have no objection to it as long as it doesn't regress the
non-batched ublk behavior/performance.
No problem with queueing up patches 1-6 now (though patch 1 may need
an ack from a kfifo maintainer?).

Thanks,
Caleb
>
> --
> Jens Axboe
