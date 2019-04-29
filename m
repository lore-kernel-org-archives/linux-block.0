Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE4C43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 11:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75AF2087B
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 11:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="TS4HdT5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfD2LNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:13:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42645 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 07:13:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id r72so4592118ljb.9
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2019 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wnGwLl0JPrexqdzwboidg01aM/JzVSKvEZRFwCgiSIM=;
        b=TS4HdT5AFTmGjwDpY/uP5NncYFALYG/8X6w7YUMfcxXvZEnDlClQLL/d6oCPDr+dQK
         0EKXtL2jdsE1LfZ1CvUy3Do4RVXcb5UMEL8rddn6JD5W0BNoGT7hZmr1bWA2sw4hbmM9
         q2dPXhMHBMWfpETuLI5VkeZZD8UvJlxWk9BcqqsmjZ8lW+unjUV2/0cmOzq3KE9b10k+
         FP37Phw1lCDkwM20lgN0crCTp9h62oYU6Mnt0KUQ0mhnceEow+aGMGK67LqMurMuO7Mm
         CivUYM9U2n8B/MLT9X/jPOCyobPVRFFGFjnwt+p4HCJNeHnt770j25UEa4QVoicZISpV
         zHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wnGwLl0JPrexqdzwboidg01aM/JzVSKvEZRFwCgiSIM=;
        b=IcROh1yjVtU8bvpVO3GJcZcUjYlW+CNX/7Zxz8fkfUHLOulfL4VjXYvVpST0HolmZN
         Akp/BRJXMHgCxe7RLVqdzjmB24dTCpy6mYW77ikUUCesPDVWLTDhA79vAGPBUGG5fUmu
         U3xsfe5OZQp2DSjQnvnOnOLU08rKfWXfi/8Zx/Q76AAa21kfIdqK2ofTTZwxVDSTh381
         7kvtz8zidRHEIsQRxt0VruGXpIO8ttjuGbGpUlvXkrVCZ38S+4BNXAzFiYR5WPIKWGOY
         Chw+1XoUmeGRofybg87IKJ4IYW48BTSM7F9VJdZyCwPkamTHZRfLLJMvnusttCKk8SN4
         wzog==
X-Gm-Message-State: APjAAAUyc3+zimeRfWQckI3SctEqCCl5TquhSDQRzG09209Wc5hsAvxA
        bpO5L/Q+LQBHLNtRq4P9/h9f69R0uYCsDIpyp+J84Q==
X-Google-Smtp-Source: APXvYqyJ+Cc41ifg25IUw7XdZkRvWFCvdUUUyrfKjMD7fLewU4lWnxgpd6X8CN+VsGzAWbzD5IaoZwTt6CnP5p4SUhg=
X-Received: by 2002:a2e:9a18:: with SMTP id o24mr3406381lji.18.1556536415012;
 Mon, 29 Apr 2019 04:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190426133513.23966-1-igor.j.konopko@intel.com> <087e8d6e-8cdc-87ff-6e2f-cb1fa2fd0396@lightnvm.io>
In-Reply-To: <087e8d6e-8cdc-87ff-6e2f-cb1fa2fd0396@lightnvm.io>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 29 Apr 2019 07:13:24 -0400
Message-ID: <CANr-nt0c-4H5PfaH=b-CPrLbMhs=r4skr-oskOGQsyNB=gOMug@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] lightnvm: next set of improvements for 5.2
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 3:54 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> Thanks Igor. I've picked up 1 + 2.
>
> The third I'm still noodling on. I think maybe one should bump the disk
> format, since it's changed. Also, if it is, it should be a static setup
> (i.e., 1,2,3), and not user configurable. Although, I do expect the
> separate parallel units to have enough device-side redundancy to provide
> adequate UBER.

The change is backwards- and forwards-compatible (a disk written with
both an older and a newer
kernel would be readable, since smeta sectors are marked as ADD_EMPTY)
 as far as I can tell,
buy did you test this Igor?

I think we might as well bump SMETA_VERSION_MINOR anyway, so we can keep
track of this format change for the future(i.e if we build an offline
recovery tool)

Thanks,
Hans
>
>
>
> On 4/26/19 3:35 PM, Igor Konopko wrote:
> > This is another set of fixes and improvements to both pblk and lightnvm
> > core.
> >
> > Changes v4 -> v5:
> > -dropped patches which were already pulled into for-5.2/core branch
> > -rebasing of other patches
> > -multiple copies of smeta patch moved into last position in series
> > so it would be easier to pull only previous patches if needed
> >
> > Changes v3 -> v4:
> > -dropped patches which were already pulled into for-5.2/core branch
> > -major changes for patch #2 based on code review
> > -patch #6 modified to use krefs
> > -new patch #7 which extends the patch #6
> >
> > Changes v2 -> v3:
> > -dropped some not needed patches
> > -dropped patches which were already pulled into for-5.2/core branch
> > -commit messages cleanup
> >
> > Changes v1 -> v2:
> > -dropped some not needed patches
> > -review feedback incorporated for some of the patches
> > -partial read path changes patch splited into two patches
> >
> >
> > Igor Konopko (3):
> >    lightnvm: pblk: simplify partial read path
> >    lightnvm: pblk: use nvm_rq_to_ppa_list()
> >    lightnvm: pblk: store multiple copies of smeta
> >
> >   drivers/lightnvm/pblk-core.c     | 159 ++++++++++++++----
> >   drivers/lightnvm/pblk-init.c     |  23 ++-
> >   drivers/lightnvm/pblk-rb.c       |  11 +-
> >   drivers/lightnvm/pblk-read.c     | 339 ++++++++++--------------------=
---------
> >   drivers/lightnvm/pblk-recovery.c |  27 ++--
> >   drivers/lightnvm/pblk-rl.c       |   3 +-
> >   drivers/lightnvm/pblk.h          |  19 +--
> >   7 files changed, 252 insertions(+), 329 deletions(-)
> >
>
