Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E5C34056
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582224656
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjlV42MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:54:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40094 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSRyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 12:54:43 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so1530636iop.7
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVM5w8pWHIZ/EotHHbfztVooGI8DcUzurZWsF1GVlv8=;
        b=DjlV42MRt2LwvsGMIDSNfx2AlWBIF4tJPASkfQu/VLpaQu1yL754QGU09InNr6NAgu
         8g5fJpIsH7COZk6EB0zw9/ige/4dde1ABsmKYLgBVu/sSXqHOe+gja1sJDFqOpL9WNFv
         526qHK1l63cPNl2V1Nu/KQqfb2fSFZhFc7uAd7yb116KZFlpmb3P3fHT/jxuUtzSavc/
         sKbiVxVfwUbPfYuxoX7dGZfaWG6ZGVSzyoUD6b1+cmHdDgfzJVqHfuOEUqzSPU6M4gm1
         Ln42OI5fF0o8b5vsQpoESRmVpSwuIBs95MtyHTVicm5IeehmlyEC5ip8PQjf2Wwh6zuK
         /C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVM5w8pWHIZ/EotHHbfztVooGI8DcUzurZWsF1GVlv8=;
        b=W8HJw3x2Jy8jLcIZ60Bpu22LmNpX0jKNEWeWNTDh7bsSjpjvgvHp4LzxmNgp0+SB40
         Z1UmuOywYQLiDSgPjlWXzTmc88RCKVyxp6czT3a0fUCgYs716DX9eM27sDzY2XUti3Wm
         x6CgRo8/GwIs1rEICupPQUze/NAjrj0GnF6BkL0bxP31HoRUEfD0RUq6LmdwHOsg2EUY
         ZIOQlIQ0C9FFQALD/4S9i/q7wkhN1nBjppU0TCycDaKPFLN/r8e85yRjmL/7ReB1ngdF
         CNBk22YfGV4DRa3Fl+8nZ0+Bq9jOUecY7xKapo+ga1S2sBKoavzEdg6DbLP+SoH8oKm/
         6aqg==
X-Gm-Message-State: APjAAAURvKB1qStwa2O+Ik5rQrzf2s6Y6oh/k+cmP75ZUvSYH3ZghvyV
        9FWoRlHYlelSDAwhE2c7bW8Qc8JPFhrBQfc3ZO2SZQ==
X-Google-Smtp-Source: APXvYqyEGn6UgaT8QtFCfYkVsiskjTsIBKforpsX1D9r0PUsg1QeeVDhcVZuIx+0X0pl880b5xsgT9bsErLOym9p26Q=
X-Received: by 2002:a02:a48e:: with SMTP id d14mr21577724jam.30.1582134882789;
 Wed, 19 Feb 2020 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org> <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
 <20200215034652.GA19867@ming.t460p> <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
 <20200219025456.GD31488@ming.t460p>
In-Reply-To: <20200219025456.GD31488@ming.t460p>
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 19 Feb 2020 09:54:31 -0800
Message-ID: <CAKUOC8UceQ_cDQC8ckvUio0AZHhasi7Np-PQ09e-dQ3fechKoA@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 18, 2020 at 6:55 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 08:11:53AM -0800, Jesse Barnes wrote:
> > On Fri, Feb 14, 2020 at 7:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > What are the 'other operations'? Are they block IOs?
> > >
> > > If yes, that is why I suggest to fix submit_bio_wait(), which should cover
> > > most of sync bio submission.
> > >
> > > Anyway, the fix is simple & generic enough, I'd plan to post a formal
> > > patch if no one figures out better doable approaches.
> >
> > Yeah I think any block I/O operation that occurs after the
> > BLKSECDISCARD is submitted will also potentially be affected by the
> > hung task timeouts, and I think your patch will address that.  My only
> > concern with it is that it might hide some other I/O "hangs" that are
> > due to device misbehavior instead.  Yes driver and device timeouts
> > should generally catch those, but with this in place we might miss a
> > few bugs.
> >
> > Given the nature of these types of storage devices though, I think
> > that's a minor issue and not worth blocking the patch on, given that
> > it should prevent a lot of false positive hang reports as Salman
> > demonstrated.
>
> Hello Jesse and Salman,
>
> One more question about this issue, do you enable BLK_WBT on your test
> kernel?

It doesn't exist on the original 4.4-based kernel where we reproduced
this bug.  I am curious how this interacts with this bug.

>
> Thanks,
> Ming
>
