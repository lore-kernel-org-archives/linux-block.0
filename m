Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99336CD98C0
	for <linux-block@archiver.kernel.org>; Tue, 10 Oct 2023 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjJJWm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJJWmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2023 18:42:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D891
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2023 15:42:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so999316a12.2
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977771; x=1697582571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=CvU9EPj1lUJQyOfAGhYeGOjHZqZh94H8624ZCxtj/g4utxU07Pzp9HavSi9mU6cImZ
         p8KwpzKyS38reVcjErdfotvGWGeX62qduqXmHaCwNdXi9MaP0w2ZdfAcvbDL/66LhvoA
         Rnqj9gBEYjcg319GJ4vHBeHraFRVuGXeDWdU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977771; x=1697582571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=BPUiJbpo0HjyK/194j5cZ7UxNB+XR6v9TcJ4VBrEkBHcvrA5o5ieYUJfSq4u++lUzv
         78ePPIIx1DIJuzTYoYiP9gVyEG15IGxVSyvq20rxxfQ5e/MDuhO/6BYSc5PrgTm1L5dZ
         sAmPESVuHXJIpNOuMDTB9IjdqwCed8KOru3CfPBVFp09qYIVRHvXdGXqg/976Xg1iTUk
         Zyj4NO4zhYBHGu4kRYOwFgFGJhCOewjViAqfJRm7oTc4+GDvGHFtck3mvpFBw2dbsmSm
         Iq885t7YVrgZUMPI9s9Neirm2ftBa7M77hiri7Z36stjL9Z6U/5XALVkbbvLNG45tJuc
         qHng==
X-Gm-Message-State: AOJu0Yyuma9FMgFGh7cObpUKe0F5SUpXpwjo1U+n8Q/qStNDtEVvFEuR
        n9xNBhUtEMFPwxoML93g9tFp0ihbGfSQ4gtrwY/XfA==
X-Google-Smtp-Source: AGHT+IHovl1AnfLJUnwNPKM37IAziJkKti9gYfE82FUNcROx92edpN/rECBAy7Ui9Lg+Iqjm2+QUlHjRja83n7tAqZI=
X-Received: by 2002:a17:906:9a:b0:9b2:b149:b818 with SMTP id
 26-20020a170906009a00b009b2b149b818mr17960595ejc.70.1696977771190; Tue, 10
 Oct 2023 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org> <ZSM64EOTVyKNkc/X@dread.disaster.area>
In-Reply-To: <ZSM64EOTVyKNkc/X@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 10 Oct 2023 15:42:39 -0700
Message-ID: <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
To:     Dave Chinner <david@fromorbit.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 8, 2023 at 4:27=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > annotate unshare requests to underlying layers. Layers that support
> > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > fallocate() mode to use.
> >
> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-lib.c           |  6 +++++-
> >  block/fops.c              |  6 ++++--
> >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> >  include/linux/blk_types.h |  3 +++
> >  include/linux/blkdev.h    |  3 ++-
> >  5 files changed, 43 insertions(+), 10 deletions(-)
>
> I have no idea how filesystems (or even userspace applications, for
> that matter) are supposed to use this - they have no idea if the
> underlying block device has shared blocks for LBA ranges it already
> has allocated and provisioned. IOWs, I don't know waht the semantics
> of this function is, it is not documented anywhere, and there is no
> use case present that tells me how it might get used.
>
> Yes, unshare at the file level means the filesystem tries to break
> internal data extent sharing, but if the block layers or backing
> devices are doing deduplication and sharing unknown to the
> application or filesystem, how do they ever know that this operation
> might need to be performed? In what cases do we need to be able to
> unshare block device ranges, and how is that different to the
> guarantees that REQ_PROVISION is already supposed to give for
> provisioned ranges that are then subsequently shared by the block
> device (e.g. by snapshots)?
>
> Also, from an API perspective, this is an "unshare" data operation,
> not a "provision" operation. Hence I'd suggest that the API should
> be blkdev_issue_unshare() rather than optional behaviour to
> _provision() which - before this patch - had clear and well defined
> meaning....
>
Fair points, the intent from the conversation with Darrick was the
addition of support for FALLOC_FL_UNSHARE_RANGE in patch 2 of v4
(originally suggested by Brian Forster in [1]): if we allow
fallocate(UNSHARE_RANGE) on a loop device (ex. for creating a
snapshot, similar in nature to the FICLONE example you mentioned on
the loop patch), we'd (ideally) want to pass it through to the
underlying layers and let them figure out what to do with it. But it
is only for situations where we are explicitly know what the
underlying layers are and what's the mecha

I agree though that it clouds the API a bit and I don't think it
necessarily needs to be a part of the initial patch series: for now, I
propose keeping just mode zero (and FALLOC_FL_KEEP_SIZE) handling in
the block series patch and drop this patch for now. WDYT?

Best
Sarthak

[1] https://patchwork.ozlabs.org/project/linux-ext4/patch/20230414000219.92=
640-2-sarthakkukreti@chromium.org/#3097746




> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
