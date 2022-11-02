Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF0C43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 03:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKBDCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 23:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBDCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 23:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2A22B3D
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 20:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667358078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxsJfgxUO96uyXOHLwu0i2uIkH92Qj2gLuYriNndNDs=;
        b=dpy6QL+C+nSW0gzLtVqc+qarCB4r44r8DoyVWeO1NlwsJi76ZCSrzVNCZBl38nwbpbz3eD
        sp2ZVe9h4uZHfjbZY0yskOIwCNElalNpOUe5y/sm4lRrx8R85z6al3KkbllvcRW2MHJyZt
        0TMknCkRb8dVIF+nDSM7kpHXW6EYyjo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-rLVTqh2_ODaQmNZhV-vnIQ-1; Tue, 01 Nov 2022 23:01:16 -0400
X-MC-Unique: rLVTqh2_ODaQmNZhV-vnIQ-1
Received: by mail-pf1-f199.google.com with SMTP id o14-20020a056a00214e00b0056238ef46ebso8311885pfk.2
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 20:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxsJfgxUO96uyXOHLwu0i2uIkH92Qj2gLuYriNndNDs=;
        b=PXumavx33FSM/pcrGVrporBFlb3LSxCQjhAkayuLA2BDxSStEJC7TpaGfbhfJg1gML
         ANMO53RDCCdfl0nC5dUDAGTut8z9dIuAZY0yDK67FgrleH55Y8u4AP/euzRMv9op0Bpk
         UiEaciU6JxeemggoidUqJ0MAkYfYc0E9WchRhMOt9KdmbbYwq+2UA5L98OzLLnqmkKog
         KwvPtPSgE135NIEuePtpoEq8FetxqMWD8gNfLb/IY5AKa0FfFym8t3qWg77cFBcR4tlP
         OiPLV/mDucXq0oPh4WmZM9d4aSwbrIhZUu+SsXk7DSoBSmyk1Z92THWt35A/n46NtHUX
         OG0A==
X-Gm-Message-State: ACrzQf16JQ/DxXPeDH7HNUz3G23PX+natCJi2bzKXQwzayeqS5ZkryV5
        F76wWTTy61EHAIGzrD79Z7GnJA6nlK7Uf0dQSr/qlF9uMZKJD/hqXOHjF7ibwAAzJtUDjKY8ZJB
        xG6IJBa0UR8RKmvP4IyPIrLSfzfAaBFuv8sMeCVc=
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr22592504plb.7.1667358075653;
        Tue, 01 Nov 2022 20:01:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ig11U11ttILhB0J76Fy4T5WxPJkX+mJqqQRIOkqCPqufnyqv9duUeT5Iv2a7OiIRXip9Nh4geD1Pz1UxC4j0=
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id
 jm10-20020a17090304ca00b00179d21ff04bmr22592485plb.7.1667358075371; Tue, 01
 Nov 2022 20:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221024061319.1133470-1-yi.zhang@redhat.com> <20221024061319.1133470-3-yi.zhang@redhat.com>
 <20221025022906.v6lld4proe2dic52@shindev>
In-Reply-To: <20221025022906.v6lld4proe2dic52@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 2 Nov 2022 11:01:02 +0800
Message-ID: <CAHj4cs8Xx6bnfSmGUz-bmtwmA8ujy3oxhY5bGM6EV5aWN4dMBg@mail.gmail.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add one function to get test dev
 size in mb
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 10:29 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 24, 2022 / 14:13, Yi Zhang wrote:
>
> Short explanation will help to understand why we do this: something like,
>
>   nvme/035 has minimum TEST_DEV size requirement. Add a helper
>   function to check it.
>
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >  common/rc | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index e490041..847be1b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -324,6 +324,14 @@ _get_pci_parent_from_blkdev() {
> >               tail -2 | head -1
> >  }
> >
> > +_get_test_dev_size_mb() {
> > +     local test_dev_sz
>
> Nit: one empty line will make it easier to read.
>
> > +     test_dev_sz=$(blockdev --getsize64 "$TEST_DEV")
> > +
> > +     echo $((test_dev_sz / 1024 / 1024))
> > +
>
> Nit: an empty line not needed.
>
> > +}
> > +
>
> I suggest to improve this new function to _require_test_dev_size_mb(). It takes
> 1st argument as the minimum size size in MB, and if TEST_DEV size is smaller
> than that, it set SKIP_REASON and return 1. We can add device_requires() to
> nvme/035 to call _require_test_dev_size_mb(). This will skip the test case when
> the TEST_DEV is small, and do not report it as a failure.
>
> I also suggest to include nvme/035 change for the size check in this patch. I
> think one shot change for function addition and function call will be simpler
> for this charge.

Yeah, that looks better, I already send V2 to fix it, thanks.

>
> >  _require_test_dev_in_hotplug_slot() {
> >       local parent
> >       parent="$(_get_pci_parent_from_blkdev)"
> > --
> > 2.34.1
> >
>
> --
> Shin'ichiro Kawasaki
>


-- 
Best Regards,
  Yi Zhang

