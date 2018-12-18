Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC83C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9342921873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eBh1oYxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeLRSWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:22:11 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:41452 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeLRSWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:22:11 -0500
Received: by mail-io1-f42.google.com with SMTP id s22so13512672ioc.8
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=Li9infbp4ghLmucQL2Rf35ib7365sE4QgmCcEzWeMq0=;
        b=eBh1oYxiIyLQAyKJcjyxc7Ebr/BowLlVPzrgugR3b0Hd8o6+ePiK4XhrCL3ae4n4Jl
         BMFvxtnSJ3TjdDuxoQx583NnKWqtARQuc+L57n7aruKAC5Qr9jnEuTxCrdBgpz6xIaFJ
         UXl+1UsZAS/wYnRisIx9M9i0p2qvxxbg2MITY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=Li9infbp4ghLmucQL2Rf35ib7365sE4QgmCcEzWeMq0=;
        b=LqwushaBZfQpC15i5i/1PwDSyldmaGiV9NhOja4ZzQoluKKJWGIqpw2143daQVuGuT
         UiZO7Ky4CfOLVbCHOFp/2C49q45ciFaMFbI52u1VO6H5RVi5PGB1fQL39SHhTeSx0mfL
         tsY4KIVFgd/t0aYYFuzTLT8Dj/z8KYxMFP0vGpe6yh0VBH0NNv2iYWspOJQEAQSXUkah
         aoH/jSqMpThcFOly7SJk3jR9U5v3lXPuCMQkVdhBF9NX4wiUv1+/AxM2qwmo8JJChZyv
         Zp31Up4dCs3Uo9I1w65r33Pty/WCVUdTzq5Y+k0jAoI9UPJQqoPT0V/+/ccguy+x6x9q
         fllQ==
X-Gm-Message-State: AA+aEWZgOvvI9pO8E64TAY2Q2ckNled5gXhBKSVKEsjEEHrcGXiSBQ98
        6nHm1wJ8wFz9iWnXjHUbDzCXPw/AmlnE6EJOfBoQNCps
X-Google-Smtp-Source: AFSGD/XxHY7+fFVUDQAQYzUSupBb+z0me9DS6J4gstrk3wujRMNiRJHGgydSWlK0jn2GSB5aNgngeVWMiK9poANl3Xs=
X-Received: by 2002:a5e:9511:: with SMTP id r17mr1999813ioj.224.1545157329969;
 Tue, 18 Dec 2018 10:22:09 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org> <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
 <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com> <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
 <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com> <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
 <a9186c0c84f31623a544d73ce9a779d6@mail.gmail.com> <7a2b3fa5-652a-2d43-c93c-be5277b34060@kernel.dk>
In-Reply-To: <7a2b3fa5-652a-2d43-c93c-be5277b34060@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTtuNko6E02tULaIEHowzteDaHmgFdiSnEAolTOMIBv4s1RgHH+RzfAtR0fm4CpRS/1gH7Dy4qAokcrFyjeyxHQA==
Date:   Tue, 18 Dec 2018 23:52:07 +0530
Message-ID: <26fb62ae415185db2df6af3bed159a68@mail.gmail.com>
Subject: RE: [PATCH V2] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >
> > At the time of device removal,  it requires reverse traversing.  Find
> > out if each requests associated with sdev is part of hctx->tags->rqs()
> > and clear that entry.
> > Not sure about atomic traverse if more than one device removal is
> > happening in parallel.  May be more error prone. ?
> >
> > Just wondering both the way we will be removing invalid request from
> > array.
> > Are you suspecting any performance issue if we do it per IO ?
>
> It's an extra store, and it's a store to an area that's then now shared
> between
> issue and completion. Those are never a good idea. Besides, it's the kind
> of
> issue you solve in the SLOW path, not in the fast path. Since that's
> doable, it
> would be silly to do it for every IO.
>
> This might not matter on mpt3sas, but on more efficient hw it definitely
> will.

Understood your primary concern is to avoid per IO and do it if no better
way.

> I'm still trying to convince myself that this issue even exists. I can see
> having
> stale entries, but those should never be busy. Why are you finding them
> with
> the tag iteration? It must be because the tag is reused, and you are
> finding it
> before it's re-assigned?


Stale entries will be forever if we remove scsi devices. It is not timing
issue. If memory associated with request (freed due to device removal)
reused, kernel panic occurs.
We have 24 Drives behind Expander and follow expander reset which will
remove all 24 drives and add it back. Add and removal of all the drives
happens quickly.
As part of Expander reset, <mpt3sas> driver process broadcast primitive
event and that requires finding all outstanding scsi command.

In some cases, we need firmware restart and that path also requires tag
iteration.


>
> --
> Jens Axboe
