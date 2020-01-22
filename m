Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647AC3F68F
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6B324683
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="JqTKdqIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAVMwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:52:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36814 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgAVMwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 07:52:16 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so6514849iog.3
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2020 04:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyEqoE1cBRj4Tnu9o17cDo7KOBzKfVc7rH8CRyHUH6M=;
        b=JqTKdqISTmyQnas3GxL8Fk/lQG/f4qinU1zIb0g2IpyFunWwUZvsW/EvsYvdjVM+Bv
         nu3V2Rc4n2uDBlx4RTvIE96wo0/MVNXhg7rLoygcV4K0T8wtrSNwHF+xTtzI0Nk0P22a
         eZnLXT2r1JBOxZlt5sK3eDR0FDjA3TG++1N51T70IJMlF+USOcHppVHsxGSTwDqEkbRK
         Gviw9c19oPSeFJqJujGAgEqlCMp+uyrzCwpDAAAr6LM3QSjFd5+1JYX/P6icU23c0eMz
         mnxCsc/2L6IPfpsS9ic+BZ7zExWKDBlQcLAoPCYFJwI5IVaLVB1fGZqu2c5MeycWKGyF
         +gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyEqoE1cBRj4Tnu9o17cDo7KOBzKfVc7rH8CRyHUH6M=;
        b=MvIPajK4E6iTap70H+z6hHxKRvoVTCtKXNnVYdOcvuRnh203lk+4zHvoh93/bmNeSc
         6ZO+Pzp9Ki4SV4CmYv8r6M4CIVstBOGSd4H42RhEyNLlZyx0lBiz6lZo3XSGVtxv1WbN
         rkQqCKuQwnht4+Fg5w4KIKwceycIvu7EFApu+A386HnJbfaxzzGQVUifpAfMRvlXfhGl
         LJ+/wzPvEkkMX9XgbdtPvfyRygXfAF/FChXc7sqOTONifI+NipRN4Ic5q92Y67xvfQBt
         WbLVLAUL3UWOtvc+BlQYHnRwqxFvtsQLTu2kV2Si7Qrsajjfi3aFdfwYiGm6wUc/aOl5
         Dj9w==
X-Gm-Message-State: APjAAAVJ/J6VwuCJeIFBDGsWV6ftTGW4EP5zdHTNWpVsvu1U3MwrZxNP
        mZRrKOorsIkSri9qeKYIhuIBh5tvIW6J5HgmyFmOV399v1A=
X-Google-Smtp-Source: APXvYqxID7Q54LszheaS02fViYtPI2sHLFaFa53vmLJsRK30UqbYvBxn+oKpLOtdx004tpasSf7dszUamb48MDjNhLY=
X-Received: by 2002:a6b:600f:: with SMTP id r15mr6548900iog.54.1579697534119;
 Wed, 22 Jan 2020 04:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal> <CAMGffE=+wX2h6bSp+ZwTowWq8NOutVnCfXFqxMupZNCGGOh0sg@mail.gmail.com>
 <20200122123119.GC7018@unreal>
In-Reply-To: <20200122123119.GC7018@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 22 Jan 2020 13:52:03 +0100
Message-ID: <CAMGffEn_q9862+CwfRb3WjWzuy6wnCwdgqmtHOoAfqNVeGC-2w@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > > Please no vertical alignment in new code, it adds a lot of churn if such
> > > line is changed later and creates difficulties for the backports.
> > It does look nicer when it can be aligned. I don't get why backport is
> > an argument here.
>
> The backport thing will be problematic once some fix is needed which
> will require addition of extra variable.
>
> Imagine such situation, where you will need to add such variable.
>
>      struct rnbd_clt_dev *dev        = rq->rq_disk->private_data;
>      struct rnbd_clt_session *sess   = dev->sess;
> +    struct rnbd_clt_session *sess_very_long_variable = ....;
>
> You will need to update vertical alignment for all variables and it
> can create huge churn out of nowhere. The standard approach is to
> avoid vertical space alignments from the beginning.

Thanks for the explanation,  I get your points now, but in that case,
you can also choose a not so
long name to keep the alignment. Even you have no choice for a shorter name,
breaking the alignment is the last thing we have to worry about.
