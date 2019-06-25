Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE0C48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADBC2080C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="OwjJ6MI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFYQxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:53:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42369 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfFYQxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:53:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id x144so5701716lfa.9
        for <linux-block@vger.kernel.org>; Tue, 25 Jun 2019 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vHHgb54Q0BfAs8YIgZACGl/29xaSx7l4ApCtXBFbfN4=;
        b=OwjJ6MI5fFr6MREqqCFmqZIKon79e5NOLq/VxpW1LVnpQzj0dwCFqePPRTogYiBhby
         r32JOo+dOfsXvukpJTWY1IPSf31g8UoBj0ehc1OXlIgvPaVQdtmbCgqXqxJXGdfJuXai
         NEuh0A+ak/VC3phXrNBXTREO9w1J2GqhC5JV+wiQN07JDZufLRNe3QRfjXWWLgRewhH7
         wZQ5z0MVX0KejwbCkHRHUSEY8buIxdhhLa7A6gJEmRadxcoUvwpnIEkRvVvFjbFjAqwa
         TvSMAH4KS+K5mx5D/BITgHTL0G5zurhcROtdK7aR2X8CGaMYQR+wxSlzfC6RBou1+R/k
         b0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vHHgb54Q0BfAs8YIgZACGl/29xaSx7l4ApCtXBFbfN4=;
        b=Fm230VZIy4RggQzeFUuXNHlB4iyOD94STrtL/jfjmjmuahaBJ/6V7DYzduz7oFSY/l
         ImGLUPZMMmHgZksEcTW93QTqML7Vqpv+53Q1UbwhxwhLzzfeoEFLX2GR31xdH/5aL1cy
         Y450tgobg9OvgXKMWqX0y3hBn7ADSfz5W0oRuP7eag8NOfjKOGAaNcYASBoQLXD3nj0i
         dn7QPafMmNQnJvxtezosHlkkkSHO5GkyCfVIWjGS/rlO7fliLGD1SLElfwlukd8FYPjI
         c5Gt2YDmCZDcf/2KSn7oDF6btNAb5pD7SOFWsAN5+hpWrkcGNUmvfZTxVa0Suu7aTMKe
         SH6w==
X-Gm-Message-State: APjAAAXbchpVX/fsDPCfgtOfdVgZGKiPVON54j5AP9up3bKXFAawZBlq
        mu7T6jP+3oI8jJ6sTeWxWt65II0cnxyCMnQz/pe3uw==
X-Google-Smtp-Source: APXvYqx4NQnRORQnh6ff+Ahw2viJbUdzU4BvtAuyZw0wXevtQnU5aeLgOfwn81Z6lx4mhq2CtclLuDk/LYedTG6dyeU=
X-Received: by 2002:a19:22d8:: with SMTP id i207mr24053341lfi.97.1561481624939;
 Tue, 25 Jun 2019 09:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190621130711.21986-1-mb@lightnvm.io> <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org> <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
 <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io> <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
 <BYAPR04MB5749977B2FFB5CDC8A254F5A86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749977B2FFB5CDC8A254F5A86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Date:   Tue, 25 Jun 2019 18:53:34 +0200
Message-ID: <CAOA7RkP83-6PgsKxzoa3i0bY7RW1R3Jh2zhLkywKsYJSnA3AMw@mail.gmail.com>
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 25, 2019 at 6:51 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 06/25/2019 08:56 AM, Bart Van Assche wrote:
> > On 6/25/19 3:35 AM, Matias Bj=C3=B8rling wrote:
> >> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:
> >>> On 6/24/19 12:43 PM, Bart Van Assche wrote:
> >>>> static inline bool op_is_write(unsigned int op)
> >>>> {
> >>>>      return (op & 1);
> >>>> }
> >>>>
> >>>
> >>
> >> The zone mgmt commands are neither write nor reads commands. I guess,
> >> one could characterize them as write commands, but they don't write an=
y
> >> data, they update a state of a zone on a drive. One should keep it as
> >> is? and make sure the zone mgmt commands don't get categorized as eith=
er
> >> read/write.
> >
> > Since the open, close and finish operations support modifying zone data
> > I propose to characterize these as write commands. How about the
> > following additional changes:
> > - Make bio_check_ro() refuse open/close/flush/reset zone operations for
>                                           ^
> Since finish also listed above which supports modifying data do we need
> to add finish here with flush in above line ?
>
> > read-only partitions (see also commit a32e236eb93e ("Partially revert
> > "block: fail op_is_write() requests to read-only partitions"") # v4.18)=
.
> > - In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ"
> > into something that uses blk_op_str().
> Good idea, I've a patch for blk_op_str() and debugfs just waiting for
> this to merge. Does it make sense to add that patch in this series ?

Ship it off separately. Your patches can go in first.

> > - Add open/close/flush zone support be added in blk_partition_remap().
> same here for finish ?
> >
> > Thanks,
> >
> > Bart.
> >
>
