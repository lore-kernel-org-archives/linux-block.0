Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E3C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3263420833
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGnDMBWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDIJ3z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:29:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33378 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfDIJ3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:29:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so14955419otq.0;
        Tue, 09 Apr 2019 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/lPkJNKAbh4YluUe8wkzivO7jBarzDZkEmu1FMVG3GQ=;
        b=aGnDMBWtmpLTdQTm9E6aK+e7QRyTXyCpmqfp9w1FOho/D+h9pMERi+bbOX1sRHSHtg
         SRGD80dLCHWLD18WCy//UP4tepcwUJrf9p/1maM74Uz1zQJvlz/GRz3nrG6lWGeQp8Jv
         BsA89mVR3O7O/o/SqiQkzn3pzWVZO7GcCJQoR6f3pt14w7UHH/l01bGlolaq21QtmB7G
         fa/hIKlQL50cf3jd6ZKlsqOMhx00zpYsHrpGbN8RZJeLyzfWcMUwW9dWAwU0DGz61HU7
         PukIMJK1/mMeLluV4DbJYkaM2fQ/QSnGtsbc0N8oy/OpvN2okLB2NSfrDnNCt6DKWst/
         NxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/lPkJNKAbh4YluUe8wkzivO7jBarzDZkEmu1FMVG3GQ=;
        b=FozpherMoKIkVp3xRzLOKJQveJdMv32NoKBLb4nYv7XLFKv6FqmDHgdwSmLK2G++o1
         LEXjW2V7IjKJGdUIRRS4Rr7IZfU0O1NbKP7Be9/BTRXYK8avNJWgppMHzEAZanPnJLtQ
         jrURbZZHq5DvUpdlqhlDHeeP/8f831KCzoTJRwR8KnoK/vpqm3x5DKK+q9u9gDdK8sLD
         67DQTC2iGiN45gBOed9q+CrowtWlQM7+Yi5lslC5NubV9k5ul1CESQP+nNIzz+tWu7MZ
         yEeS7hgoI70+EI6Icxrdw34itEzs06m5E7xiug81FKRvIA+us8+G2xcapDEQpJVCrji9
         Ex4w==
X-Gm-Message-State: APjAAAVSFB+TZXZAaYp0LUEQBC4eDmv0glWGuhTFl98iO4uB4lHhnMOL
        Hr1TqyhOFsuf16xEsfWsqj1ZshqHZFFkIjyDeNo=
X-Google-Smtp-Source: APXvYqyyVxeJFmcXe1tajnKk3eMMkpvqF0BmL0LkUcQFBdssEWr5RsoTCo4nEn4dyUWhse8FJEHXLDSRlTe+EG37mX8=
X-Received: by 2002:a05:6830:183:: with SMTP id q3mr23049815ota.204.1554802194207;
 Tue, 09 Apr 2019 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190409090828.16282-1-bob.liu@oracle.com>
In-Reply-To: <20190409090828.16282-1-bob.liu@oracle.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Tue, 9 Apr 2019 11:29:42 +0200
Message-ID: <CAD9gYJKYu15b7ZuAvud-BzG5fRP=B33yPJuEq84nsN_8y3EC1Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze sequence
To:     Bob Liu <bob.liu@oracle.com>, r.peniaev@gmail.com
Cc:     linux-block@vger.kernel.org, shirley.ma@oracle.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bob Liu <bob.liu@oracle.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:11=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch was proposed by Roman Pen[3] years ago.
> Recently we hit a bug which is likely caused by the same reason,so rebase=
d his
> fix to v5.1 and resend.
> Below is almost copied from that patch[3].
>
> ------
> Long time ago there was a similar fix proposed by Akinobu Mita[1],
> but it seems that time everyone decided to fix this subtle race in
> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
> patchset was not applied).
>
> The following is a description of a hang in blk_mq_freeze_queue_wait() -
> same fix but a bug from another angle.
>
> The hang happens on attempt to freeze a queue while another task does
> queue unfreeze.
>
> The root cause is an incorrect sequence of percpu_ref_reinit() and
> percpu_ref_kill() and as a result those two can be swapped:
>
>  CPU#0               CPU#1
>  ----------------    -----------------
>  percpu_ref_kill()
>
>                      percpu_ref_kill() << atomic reference does
>  percpu_ref_reinit()                   << not guarantee the order
>
>                      blk_mq_freeze_queue_wait() << HANG HERE
>
>                      percpu_ref_reinit()
>
> Firstly this wrong sequence raises two kernel warnings:
>
>   1st. WARNING at lib/percpu-recount.c:309
>        percpu_ref_kill_and_confirm called more than once
>
>   2nd. WARNING at lib/percpu-refcount.c:331
>
> But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
> which waits for a zero of a q_usage_counter, which never happens
> because percpu-ref was reinited (instead of being killed) and stays in
> PERCPU state forever.
>
> The simplified sequence above can be reproduced on shared tags, when
> queue A is going to die meanwhile another queue B is in init state and
> is trying to freeze the queue A, which shares the same tags set:
>
>  CPU#0                           CPU#1
>  ------------------------------- ------------------------------------
>  q1 =3D blk_mq_init_queue(shared_tags)
>
>                                 q2 =3D blk_mq_init_queue(shared_tags):
>                                   blk_mq_add_queue_tag_set(shared_tags):
>                                     blk_mq_update_tag_set_depth(shared_ta=
gs):
>                                       blk_mq_freeze_queue(q1)
>  blk_cleanup_queue(q1)                 ...
>    blk_mq_freeze_queue(q1)   <<<->>>   blk_mq_unfreeze_queue(q1)
>
> [1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
> [2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
> [3] https://patchwork.kernel.org/patch/9268199/
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>

Replaced Roman's email address.

We at 1 & 1 IONOS (former ProfitBricks) have been carried this patch
for some years,
it has been running in production for some years too, would be good to
see it in upstream :)

Thanks,

Jack Wang
Linux Kernel Developer @ 1 & 1 IONOS
