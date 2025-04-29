Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD372BD1B
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887997; cv=none; b=sx4Px3Ev4ZqaWHVMuyWsBwvhn4j10+3OagtO3znGlwoQc/GqF/8wWI/Dmiw8UOFi9WxEn1Hgn+V8rRtK+7n/+grl86Ar3KemmhICA6UPSFhY4thx2Yyx/2DxJYzUZLXQneGTg72rivWeeJAfps5iTVTswuuBH0XwgHT9rg4PVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887997; c=relaxed/simple;
	bh=jN5z3di/2I+nferXUT3xTReBENiUCnOB9Ddz/lBiEGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSpAkDaiXZM+h4+bxO2fvVJAm6Eke7n1u6100sPvR0ko1bC2b/sAmg9e92kGb0L/6b3k2RBnwBfQF8lh692w0yu/ihjw+TKQhevM87sjgniZ++3RUZ4TvG8ldkP7gs7cfzOe8bUCmN8G1PrbD/OCAUctXk0g7xKQ/V2xmhOhJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsjoNjBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsjoNjBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745887994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1dMzHXlp8PZoZTKfEGh/U2quvrU1Sckx8n38spAR64=;
	b=HsjoNjBnZGtZ4BdSysvo32vB4aE5VxfZ62YvNIrRua+L0kVYcD0HJnymJoRhoYNDetH2/F
	aIKQxn+6PiMuJ4iy0QWXejksnvS6LYDwTBgeKlNJfuSw4TOE3hOPNKCASrgeBPbjx0u3UQ
	UuzaWdAJLxyhEtAI5zbS0TmRRGoM1XQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-iQXeGGzxN--fkcZyPUYFDA-1; Mon,
 28 Apr 2025 20:53:10 -0400
X-MC-Unique: iQXeGGzxN--fkcZyPUYFDA-1
X-Mimecast-MFC-AGG-ID: iQXeGGzxN--fkcZyPUYFDA_1745887989
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59A181956088;
	Tue, 29 Apr 2025 00:53:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB2A180047F;
	Tue, 29 Apr 2025 00:53:05 +0000 (UTC)
Date: Tue, 29 Apr 2025 08:53:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6.15 1/3] selftests: ublk: fix UBLK_F_NEED_GET_DATA
Message-ID: <aBAi7GdSjMf-Latb@fedora>
References: <20250427134932.1480893-1-ming.lei@redhat.com>
 <20250427134932.1480893-2-ming.lei@redhat.com>
 <CADUfDZqd_9c191pfNSmkm2Oz544V1auOcsCJtMnpj03Y-3vohA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqd_9c191pfNSmkm2Oz544V1auOcsCJtMnpj03Y-3vohA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 28, 2025 at 08:51:03AM -0700, Caleb Sander Mateos wrote:
> On Sun, Apr 27, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
> > support UBLK_F_NEED_GET_DATA for covering recovery feature, however the
> > ublk utility implementation isn't done correctly.
> >
> > Fix it by supporting UBLK_F_NEED_GET_DATA correctly.
> >
> > Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.
> >
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile         |  1 +
> >  tools/testing/selftests/ublk/kublk.c          | 20 ++++++++++------
> >  tools/testing/selftests/ublk/kublk.h          |  1 +
> >  .../testing/selftests/ublk/test_generic_07.sh | 24 +++++++++++++++++++
> >  .../testing/selftests/ublk/test_stress_05.sh  |  8 +++----
> >  5 files changed, 43 insertions(+), 11 deletions(-)
> >  create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > index ec4624a283bc..f34ac0bac696 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -9,6 +9,7 @@ TEST_PROGS += test_generic_03.sh
> >  TEST_PROGS += test_generic_04.sh
> >  TEST_PROGS += test_generic_05.sh
> >  TEST_PROGS += test_generic_06.sh
> > +TEST_PROGS += test_generic_07.sh
> >
> >  TEST_PROGS += test_null_01.sh
> >  TEST_PROGS += test_null_02.sh
> > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> > index e57a1486bb48..3afd45d7f989 100644
> > --- a/tools/testing/selftests/ublk/kublk.c
> > +++ b/tools/testing/selftests/ublk/kublk.c
> > @@ -536,12 +536,17 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
> >         if (!(io->flags & UBLKSRV_IO_FREE))
> >                 return 0;
> >
> > -       /* we issue because we need either fetching or committing */
> > +       /*
> > +        * we issue because we need either fetching or committing or
> > +        * getting data
> > +        */
> >         if (!(io->flags &
> > -               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
> > +               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_NEED_GET_DATA)))
> >                 return 0;
> >
> > -       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> > +       if (io->flags & UBLKSRV_NEED_GET_DATA)
> > +               cmd_op = UBLK_U_IO_NEED_GET_DATA;
> > +       else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> >                 cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> >         else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
> >                 cmd_op = UBLK_U_IO_FETCH_REQ;
> > @@ -658,6 +663,9 @@ static void ublk_handle_cqe(struct io_uring *r,
> >                 assert(tag < q->q_depth);
> >                 if (q->tgt_ops->queue_io)
> >                         q->tgt_ops->queue_io(q, tag);
> > +       } else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
> > +               io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
> > +               ublk_queue_io_cmd(q, io, tag);
> >         } else {
> >                 /*
> >                  * COMMIT_REQ will be completed immediately since no fetching
> > @@ -1313,7 +1321,7 @@ int main(int argc, char *argv[])
> >
> >         opterr = 0;
> >         optind = 2;
> > -       while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
> > +       while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:gaz",
> >                                   longopts, &option_idx)) != -1) {
> >                 switch (opt) {
> >                 case 'a':
> > @@ -1351,9 +1359,7 @@ int main(int argc, char *argv[])
> >                                 ctx.flags |= UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE;
> >                         break;
> >                 case 'g':
> > -                       value = strtol(optarg, NULL, 10);
> > -                       if (value)
> > -                               ctx.flags |= UBLK_F_NEED_GET_DATA;
> > +                       ctx.flags |= UBLK_F_NEED_GET_DATA;
> 
> The help text in __cmd_create_help() should be updated accordingly.

Good catch!

> 
> >                         break;
> >                 case 0:
> >                         if (!strcmp(longopts[option_idx].name, "debug_mask"))
> > diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> > index 918db5cd633f..44ee1e4ac55b 100644
> > --- a/tools/testing/selftests/ublk/kublk.h
> > +++ b/tools/testing/selftests/ublk/kublk.h
> > @@ -115,6 +115,7 @@ struct ublk_io {
> >  #define UBLKSRV_NEED_FETCH_RQ          (1UL << 0)
> >  #define UBLKSRV_NEED_COMMIT_RQ_COMP    (1UL << 1)
> >  #define UBLKSRV_IO_FREE                        (1UL << 2)
> > +#define UBLKSRV_NEED_GET_DATA           (1UL << 3)
> >         unsigned short flags;
> >         unsigned short refs;            /* used by target code only */
> >
> > diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/testing/selftests/ublk/test_generic_07.sh
> > new file mode 100755
> > index 000000000000..e3ad36ef7b9a
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_generic_07.sh
> > @@ -0,0 +1,24 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID="generic_07"
> > +ERR_CODE=0
> > +
> > +_prep_test "generic" "test UBLK_F_NEED_GET_DATA"
> > +
> > +_create_backfile 0 256M
> > +dev_id=$(_add_ublk_dev -t loop -q 2 -g "${UBLK_BACKFILES[0]}")
> > +_check_add_dev $TID $?
> > +
> > +# run fio over the ublk disk
> > +_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
> 
> I thought you were planning to add a _have_program fio check?

Indeed, don't know how the check wasn't added, :-(


thanks,
Ming

