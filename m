Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CA17C91
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717189; cv=none; b=BDuQBwFggXI9l8XzRmPDvFAZ2121Vo2FCkZVawOtZTnQsymut+BIHysF/OnIRfMpjmzxN+n2CsNxdDXDFnRIEE6x5sOt1uACgDvjTsJ563XxSLPIH3sJIjw2CwsB351Qlb3hLMy0qcagJ3tufI2LNbpBFrFV/wW4CZqxhdy2r6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717189; c=relaxed/simple;
	bh=LAauA1t2p/T8IfzM3YUFW1sC6Ik7MGlFPYmcBco6lTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQvE2jYkjf3LaoJOopet4uBwLeX4t3d+10lgeuNhUYehZaHIM32nSayo/xNBem4LddWIZMUm8/yXrzW/aDB6iUjlZ5Dt6XLikbM0DrcLcT/t5ioFEb19cddohkImE8XdT6itUmMU0eqAmwfmhUGzZUr6Y2OR39Fhnv8+MK4O9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt4WyB7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt4WyB7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745717185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWBKW94kK3rvtGGVcXAV595CfInb3nXTmlwJBdxCNz8=;
	b=Yt4WyB7XSWsLaxAiWiZN2GqCaKvKj0fGZmn38jQzzNzUAOU3pwfmcuhSaSd/TG8czD0zgD
	zoDOZRxgchtXo8o7o7KLHzbe2NDoQ//GlRXX6iUAgGYQJ33I5y2uwajLAZvJZItIas+aTL
	CKuWHaUlVR5pBPXv1m9792nZAqFQTLE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-S-zGSGT8M36pfKYVPgcAFg-1; Sat,
 26 Apr 2025 21:26:23 -0400
X-MC-Unique: S-zGSGT8M36pfKYVPgcAFg-1
X-Mimecast-MFC-AGG-ID: S-zGSGT8M36pfKYVPgcAFg_1745717182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6720B1800261;
	Sun, 27 Apr 2025 01:26:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE89118002AD;
	Sun, 27 Apr 2025 01:26:18 +0000 (UTC)
Date: Sun, 27 Apr 2025 09:26:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 1/4] selftests: ublk: fix UBLK_F_NEED_GET_DATA
Message-ID: <aA2HtRzfVEVmJeUG@fedora>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-2-ming.lei@redhat.com>
 <CADUfDZobcEmDMOYTJh5E5FFsLdYaio3xK96amLm1_MCtpyv0FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZobcEmDMOYTJh5E5FFsLdYaio3xK96amLm1_MCtpyv0FA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 26, 2025 at 01:15:58PM -0700, Caleb Sander Mateos wrote:
> On Sat, Apr 26, 2025 at 2:41 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
> > support UBLK_F_NEED_GET_DATA for covering recovery feature, however the
> > ublk utility implementation isn't done correctly.
> >
> > Fix it by supporting UBLK_F_NEED_GET_DATA correctly.
> >
> > Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.
> 
> Looks good to me, just a few minor comments.
> 
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> 
> >
> > Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile         |  1 +
> >  tools/testing/selftests/ublk/kublk.c          | 11 +++++---
> >  tools/testing/selftests/ublk/kublk.h          |  1 +
> >  .../testing/selftests/ublk/test_generic_07.sh | 25 +++++++++++++++++++
> >  4 files changed, 35 insertions(+), 3 deletions(-)
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
> > index e57a1486bb48..701b47f98902 100644
> > --- a/tools/testing/selftests/ublk/kublk.c
> > +++ b/tools/testing/selftests/ublk/kublk.c
> > @@ -538,10 +538,12 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
> >
> >         /* we issue because we need either fetching or committing */
> >         if (!(io->flags &
> > -               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
> > +               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_NEED_GET_DATA)))
> 
> Comment could use an update
> 
> >                 return 0;
> >
> > -       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> > +       if (io->flags & UBLKSRV_NEED_GET_DATA)
> > +               cmd_op = UBLK_U_IO_NEED_GET_DATA;
> > +       else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> >                 cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> >         else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
> >                 cmd_op = UBLK_U_IO_FETCH_REQ;
> > @@ -658,6 +660,9 @@ static void ublk_handle_cqe(struct io_uring *r,
> >                 assert(tag < q->q_depth);
> >                 if (q->tgt_ops->queue_io)
> >                         q->tgt_ops->queue_io(q, tag);
> > +       } else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
> > +               io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
> > +               ublk_queue_io_cmd(q, io, tag);
> >         } else {
> >                 /*
> >                  * COMMIT_REQ will be completed immediately since no fetching
> > @@ -1313,7 +1318,7 @@ int main(int argc, char *argv[])
> >
> >         opterr = 0;
> >         optind = 2;
> > -       while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
> > +       while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:g:az",
> >                                   longopts, &option_idx)) != -1) {
> 
> It's a little strange for -g to take an argument since it's basically
> a boolean flag. But it looks like several other flags behave the same
> way.

Yeah, we can make it one bool flag.


> 
> >                 switch (opt) {
> >                 case 'a':
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
> > index 000000000000..5d82b5955006
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_generic_07.sh
> > @@ -0,0 +1,25 @@
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
> > +dev_id=$(_add_ublk_dev -t loop -q 2 -g 1 "${UBLK_BACKFILES[0]}")
> > +_check_add_dev $TID $?
> > +
> > +# run fio over the ublk disk
> > +if ! _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M; then
> > +       _cleanup_test "generic"
> > +       _show_result $TID 255
> 
> Propagate the return code from fio?

OK.

> 
> > +fi
> 
> All the other tests that use _run_fio_verify_io appear to check
> _have_program fio first. Is that necessary here too?

Will add the check.


Thanks, 
Ming

