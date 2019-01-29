Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB672C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4722175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkLWIEx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfA2P47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:56:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32987 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2P46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:56:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so16578111oib.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+ualDrjSyizPrqxS3pbpuZkz7CdmnwB7wIUPH8aloA=;
        b=YkLWIEx7o0wF33nQ3P9Qbzq9GXmzFAVHfmCEVivBei5qscAHZO8UE4MgF2ihbqUT7X
         uQ4IP05SoxIofogSDX/8TRlYur5BP5E9dW3WhDO+x4V0o2iP6YVbp3zblPPPWRDcitsE
         UhJ5z2/N0oC04UApvTNRoOVChNROf154MFoMNV0ACDD6jkj71BI1fyNOzlKvRmTNDc2/
         g8vD65+j4H64Dd7dWzVSjOxtDjA4rbDNghmTjJjHx42zRrXzJQN0mv7QSLR294zs73e0
         QttHi4GDlmRNpp812H4cNATsyt3KRyTkHE8/juAIu9efy7gCOoSqceXi7e0n9xsH6W+I
         gPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+ualDrjSyizPrqxS3pbpuZkz7CdmnwB7wIUPH8aloA=;
        b=uFXsxGnEHPbt5EOg9bpO26KJkpeygbkNYPioloKQCFisMl6bU58wvJd5DfvIZ+fnSV
         jJwJFcjU7o5XEmSQ5ijLOimRlPcmJYBRH7wnqcehToLiDAG8LgO9NwNQWgnUt4UpkvQx
         JHefk+Y9ddaaFO7SDRaLkj5rF/GK1a/Z5EXYarq0eI0gYKyshx8riT8sYvTFyUBRmT4X
         XpO/jVdn9gfol5seXesmDLIYrJyf6tZ34Igna34PgCijj4gkYptia5RtCjdkcYzjOs45
         do8QUTkMUqSQESzu950tyFrxb15gUeW7eeQ6pk1E4jnESzO9nXCLOCD49D1cG1UQPU5m
         HuuQ==
X-Gm-Message-State: AHQUAuatg8aNcWonLIF+sj/U+nlMhUFcJruHovdYVzbAvz7ru0Or0OxB
        rsASk7oOEcNlqp7EmysdqcyiqyjvCmH9fD5HEUMamA==
X-Google-Smtp-Source: AHgI3IYFI+2gwp8p1ycW0uhwVYrKTRYj/lic4Hk/xoatM9a6FOlM6kf8lInCRDhQBbbFDToRqFjDQA6kqjucJXWpTAM=
X-Received: by 2002:aca:d8c1:: with SMTP id p184mr9913784oig.22.1548777417645;
 Tue, 29 Jan 2019 07:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
 <CAG48ez1Ms+NPTXPj_UiQyv=2aMaMR3akCdp5SdDL3x7x7gd_ig@mail.gmail.com> <b5902860-30a9-3dc9-b513-3d892afdc51b@kernel.dk>
In-Reply-To: <b5902860-30a9-3dc9-b513-3d892afdc51b@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 16:56:31 +0100
Message-ID: <CAG48ez0sNBjgW7ynpNC+sir-_AuccY1sKguiD+VAXvL9-j4iag@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 4:46 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/28/19 7:21 PM, Jann Horn wrote:
> > Please create a local copy of the request before parsing it to keep
> > the data from changing under you. Additionally, it might make sense to
> > annotate every pointer to shared memory with a comment, or something
> > like that, to ensure that anyone looking at the code can immediately
> > see for which pointers special caution is required on access.
>
> I took a look at the viability of NOT having to local copy the data, and
> I don't think it's too bad. Local copy has a noticeable impact on the
> performance, hence I'd really (REALLY) like to avoid it.
>
> Here's something on top of the current git branch. I think I even went a
> bit too far in some areas, but it should hopefully catch the cases where
> we might end up double evaluating the parts of the sqe that we depend
> on. For most of the sqe reading we don't really care too much. For
> instance, the sqe->user_data. If the app changes this field, then it
> just gets whatever passed back in cqe->user_data. That's not a kernel
> issue.
>
> For cases like addr/len etc validation, it should be sound. I'll double
> check this in the morning as well, and obviously would need to be folded
> in along the way.
>
> I'd appreciate your opinion on this part, if you see any major issues
> with it, or if I missed something.

The io_sqe_needs_user() checks still look racy. If that helper sees a
IORING_OP_READ_FIXED, but then __io_submit_sqe() sees a
IORING_OP_READV - especially if this happens in io_sq_wq_submit_work()
-, I think you could potentially end up in places like
io_import_iovec() without having done the set_fs(USER_DS) and
use_mm(), causing the access to potentially occur with KERNEL_DS and a
lazy mm.
