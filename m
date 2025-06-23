Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AB231832
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668898; cv=none; b=O5PNke5UAe+2D0pcL+ptyX6t1TnDMMKF0MJpTsSh1LScN+HJ5qgFaJIt57cf/MfNPjqKmzCdGds98NDLPtOCY0p2OkqbaruVduDOpOcJuNPQwNiDW15wX5mhMbAyjK4IRfSQ2e/1TVvc2AD2zaHkoxzE2EWLzurAzF93G+Gi6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668898; c=relaxed/simple;
	bh=lY2QS4dQb2iYp5v1xQS0WMPryqi+ThmF7cUhLG85Ap0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGsyPfIRAaP+bQqD1OsiGrY00BXhbeoRDkCLEUAagjtnvy2ITC2bMHjnj3u6dV2BVyS80g9Vbve32NDAqTxS3h+FJXJ0R8f9THwLDjHSGygjbfKXFvHQMSrQQGXmDNZtHRImy7ibN1eIEwK+I7B+S09fGK9Q/4L2/PSV/DDHzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoX4iEtg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoX4iEtg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750668895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXbelryVBx/8q6dFqPAgas4iiuOu8DdXNurnM1JuKEk=;
	b=DoX4iEtgVy+jTjG61yxQ17pmZe1tqmHoHFTlgJqta8ztAWnzMRqsvQ6nbvY8q5gyaBK6tz
	Bg2fUGJNw9DgBTx4Mdct9J/CHK9tRLcwR8AXIzfErbcEN7arb86O82mazBd3mpE9mS8U6K
	Fd+jAPpGpadCcdnSeoIIJExWd4xT6yc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Ew4j2IMKPzGk9cqqtobp7g-1; Mon, 23 Jun 2025 04:54:53 -0400
X-MC-Unique: Ew4j2IMKPzGk9cqqtobp7g-1
X-Mimecast-MFC-AGG-ID: Ew4j2IMKPzGk9cqqtobp7g_1750668892
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31cc625817so3038411a12.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750668892; x=1751273692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXbelryVBx/8q6dFqPAgas4iiuOu8DdXNurnM1JuKEk=;
        b=BeRPQB47JCr699iil/1ZNfr5GSWDA9YOIFspBZFPABUVajPsEXDZwuRXIIgLzZkB7Z
         kB5ZgmUoNPs0IjXoTdE9tJm1hsJaHyyu5Kc+8qDH4I6QhikYQayEk0ewSPG01rBbYMEQ
         RrVq87b1JG374leDwV6m5QRv5vktHh6zGsRWCnjuXM6I2sdupbLJSHZ8xrpYWWvHvWyW
         NAG0X+ngnAQjH6L07PXBxTGqEv/fxgjClbs5t2rsrI9WFM9RjrKgMJtf8gA0psQILJuU
         WresauMAeJskJYm+xerWuv57Rthjrgcut20ll/PN8eUVj2yWs7DyCR+t3j3HhLCDPoks
         eF7A==
X-Gm-Message-State: AOJu0YyiF74slVGJejxUzTRW140ITh1gnhiqXqtUF8cPnP114YdsIJDc
	nAvpAAV+2x0dgBNd54WV9LRT+Hdk/aYbvn4WJWDkEpLa1dCTCg6nDDjlEyV1tzxL9GgTL2QFbNh
	DaehAii/l94si3w6hykuWjaqk/lizeuBt0YaUcw9zSrNHH9mWDTJVgqrBVdZ/ah5YrQBgV6c2Pq
	EQVI8NFbX4PlTy18fnVOYZhr96Gi1AF5p8KEGi0VO/zo1lu/A=
X-Gm-Gg: ASbGncsLtPMJKLjR6kCQaoHKrIyFxsPLkgJ8PCBdDoJzetmLZNlbpn8WZctqWm8+gOg
	DjIXpyZss8BTL3bcwYoIhREF6mzO1Auwz/i3molcN9eP2NrF/s+iKvzTC9txJRqhqSOGcarLaMS
	Vhg6kv
X-Received: by 2002:a17:90b:3850:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-3159f46cf94mr14961298a91.6.1750668891838;
        Mon, 23 Jun 2025 01:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPWecigVWaXCnZFJhBNVfm0oP/qdN8Q9W+faRtvENy9ek/7Vwj4aY+6LHaA1VA2VQAgFt/nKwMAj23lfeGUSo=
X-Received: by 2002:a17:90b:3850:b0:311:b5ac:6f7d with SMTP id
 98e67ed59e1d1-3159f46cf94mr14961265a91.6.1750668891350; Mon, 23 Jun 2025
 01:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
 <aFjR1M2RwGn8y9Rs@fedora> <CAGVVp+UEQ2XWrNpAz4-+SuyoHybrQ3-Uv5hE-SLQAdSpVw-kgQ@mail.gmail.com>
In-Reply-To: <CAGVVp+UEQ2XWrNpAz4-+SuyoHybrQ3-Uv5hE-SLQAdSpVw-kgQ@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 23 Jun 2025 16:54:39 +0800
X-Gm-Features: Ac12FXz0BgFETc9AdmEsTuBE3-bisP_vqmJRVMv0q4odJxksqAg6g1K1ZulySLY
Message-ID: <CAGVVp+WVm-9YNM9rK2_87KKsF59vpi+gO2weLywiqs-ayDQ9wA@mail.gmail.com>
Subject: Fwd: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000001
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, Jun 23, 2025 at 4:48=E2=80=AFPM
Subject: Re: [bug report] BUG: kernel NULL pointer dereference,
address: 0000000000000001
To: Ming Lei <ming.lei@redhat.com>


On Mon, Jun 23, 2025 at 12:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Changhui,
>
> On Mon, Jun 23, 2025 at 10:58:24AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > the following kernel panic was triggered by ubdsrv  generic/002,
> > please help check and let me know if you need any info/test, thanks.
> >
> > commit HEAD:
> >
> > commit 2589cd05008205ee29f5f66f24a684732ee2e3a3
> > Merge: 98d0347fe8fb e1c75831f682
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed Jun 18 05:11:50 2025 -0600
> >
> >     Merge branch 'io_uring-6.16' into for-next
> >
> >     * io_uring-6.16:
> >       io_uring: fix potential page leak in io_sqe_buffer_register()
> >       io_uring/sqpoll: don't put task_struct on tctx setup failure
> >       io_uring: remove duplicate io_uring_alloc_task_context() definiti=
on
>
> The above branch has been merged to v6.16-rc3, can you reproduce it with =
-rc3?
>
> I tried to duplicate in my test VM, not succeed with -rc3.
>

Hi=EF=BC=8CMing

I hit this issue with repo
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?=
h=3Dfor-next.
it is not a 100% reproducible issue. I triggered it in the run
T=3Dgeneric as loop,  =E2=80=98for i in {0..10};do make test T=3Dgeneric; d=
one=E2=80=99

and later I tried it with repo https://github.com/torvalds/linux,
branch v6.16-rc3, but have not been able to reproduce it  so far.

> ...
>
> > [ 7044.064528] BUG: kernel NULL pointer dereference, address: 000000000=
0000001
> > [ 7044.071507] #PF: supervisor read access in kernel mode
> > [ 7044.076653] #PF: error_code(0x0000) - not-present page
> > [ 7044.081801] PGD 462c42067 P4D 462c42067 PUD 462c43067 PMD 0
> > [ 7044.087488] Oops: Oops: 0000 [#1] SMP NOPTI
> > [ 7044.091685] CPU: 13 UID: 0 PID: 367 Comm: kworker/13:1H Not tainted
> > 6.16.0-rc2+ #1 PREEMPT(voluntary)
> > [ 7044.100991] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> > 2.22.2 09/12/2024
> > [ 7044.108565] Workqueue: kblockd blk_mq_requeue_work
> > [ 7044.113374] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
>
> Can you share where the above line points to source line if it can be
> reproduced in -rc3?
>
> gdb> l *(__io_req_task_work_add+0x18)
>
>

vmlinux is compiled by repo
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
=EF=BC=8Cbranch for-next=EF=BC=8C

(gdb) l *(__io_req_task_work_add+0x18)
0xffffffff819075e8 is in __io_req_task_work_add (io_uring/io_uring.c:1251).
1246            io_fallback_tw(tctx, false);
1247    }
1248
1249    void __io_req_task_work_add(struct io_kiocb *req, unsigned flags)
1250    {
1251            if (req->ctx->flags & IORING_SETUP_DEFER_TASKRUN)
1252                    io_req_local_work_add(req, flags);
1253            else
1254                    io_req_normal_work_add(req);
1255    }
(gdb)

> Thanks,
> Ming
>

Thanks=EF=BC=8C
Changhui

