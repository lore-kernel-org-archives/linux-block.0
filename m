Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A4FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3F960FBF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhJYBaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhJYBaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 21:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635125261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfkuE2GSngTvVIbgYVUow9+cdtg7NZ8yahgFLtf5rzA=;
        b=JPXn7Pi81VJzN0wEtncXE9aVtuMCulPGqEWY/3XzRqGqvrrbsCgcSUxKXa3jK03dBUpQ6R
        pliZWGcg84OaBbpuD3f9ymeI/ybBxeQf8uv0f53XLg2YO87XMObG2tmHgmjSByXKkiGdR3
        GR/2kCexEFydm1V85dMhzC07yOMGh6c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-zhj-178_NkmD5umt3t3CHA-1; Sun, 24 Oct 2021 21:27:39 -0400
X-MC-Unique: zhj-178_NkmD5umt3t3CHA-1
Received: by mail-yb1-f199.google.com with SMTP id s7-20020a25aa07000000b005bfb84d2315so15201683ybi.0
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 18:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfkuE2GSngTvVIbgYVUow9+cdtg7NZ8yahgFLtf5rzA=;
        b=5yoxF8b2unXJCr/YNH0FT9ddCzrzP3+jN88VPwwpN2z0qrw2nINs7NmczfK8rxFDwi
         H63uL931ikpynYBs+JOJVFfxJ3SsW0V9bT8Arz1qPEWsBSMA2CJo1VsW3ZF5npmf1ntA
         Rfmk7xNn+rROI58YNUxxItdEMEOGWFzFnkCk/VtMhJPgdZn787dano60aduKA36o2/ld
         KfBIs6Ct6YT0yjS4VyBjq5yRvuH+ySCtoHVcYCEKPACzSuf9ZABoSolkQ4cnUxdD3OYe
         GtJigVeTyWlBahLPioHzGNILOWE4cH/ey19qA8MYLtcCoDd+J698iQ9M6LvOhNIkfFW/
         zxuA==
X-Gm-Message-State: AOAM531TspttDeH1MM3w0mGbv74ElkGY8sGNvn2EBQyE6JcEYGaUzryj
        iSamJllVjzb88Ovwsulc+Edne01w3iAEE7mNRZzwwQE5EXuIMv336dB44IacOP5Ti9OTR4Rnyiu
        t4yMa/meuIh6iEHgSuChMGy089Cgo974AlH8PmWQ=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr14459122ybl.308.1635125258938;
        Sun, 24 Oct 2021 18:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSgq4TjOxHxwxx9+ybbLtr+uyEXMdxVfRtZGp2oveLdUTfJaOH50IA3zK/YEe+wlRzj55ngPH5943lA1RDDkA=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr14459105ybl.308.1635125258665;
 Sun, 24 Oct 2021 18:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211024124258.26887-1-yi.zhang@redhat.com> <e1740f8a-07d4-0c7f-4099-2d6a37dfb899@acm.org>
In-Reply-To: <e1740f8a-07d4-0c7f-4099-2d6a37dfb899@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 25 Oct 2021 09:27:27 +0800
Message-ID: <CAHj4cs-2Qc7fMmCDEV7VYCh_KGTe+_=Y6z=tTnYwJTJ9MC+DuQ@mail.gmail.com>
Subject: Re: [PATCH blktests V3] tests/srp: fix module loading issue during
 srp tests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 5:22 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/24/21 05:42, Yi Zhang wrote:
> > The ib_isert/ib_srpt modules will be automatically loaded after the first
> >   time rdma_rxe/siw setup, which will lead srp tests fail.
> >
> > $ modprobe rdma_rxe
> > $ echo eno1 >/sys/module/rdma_rxe/parameters/add
> > $ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
> > ib_srpt               167936  0
> > ib_isert              139264  0
> > iscsi_target_mod      843776  1 ib_isert
> > target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
> > rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> > ib_cm                 344064  2 rdma_cm,ib_srpt
> > ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm
> >
> > $ ./check srp/001
> > srp/001 (Create and remove LUNs)                             [failed]
> >      runtime    ...  3.675s
> >      --- tests/srp/001.out    2021-10-13 01:18:50.846740093 -0400
> >      +++ /root/blktests/results/nodev/srp/001.out.bad 2021-10-14 03:24:18.593852208 -0400
> >      @@ -1,3 +1 @@
> >      -Configured SRP target driver
> >      -count_luns(): 3 <> 3
> >      -Passed
> >      +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
> > modprobe: FATAL: Module iscsi_target_mod is in use.
> >
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >   tests/srp/rc | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/srp/rc b/tests/srp/rc
> > index 7239d87..b3dfd4d 100755
> > --- a/tests/srp/rc
> > +++ b/tests/srp/rc
> > @@ -497,7 +497,7 @@ start_lio_srpt() {
> >       if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
> >               opts+=("rdma_cm_port=${srp_rdma_cm_port}")
> >       fi
> > -     insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
> > +     unload_module ib_srpt && modprobe ib_srpt "${opts[@]}" || return $?
> >       i=0
>
> The "&&" above seems wrong to me. It is not guaranteed that the ib_srpt
> kernel mode has already been loaded before this code runs. I propose to
> use the following code instead:
>
>         unload_module ib_srpt
>         modprobe ib_srpt "${opts[@]}" || return $?

Thanks Bart, send v4 for this change.

>
> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

