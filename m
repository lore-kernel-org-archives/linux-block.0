Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E2C433E2
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C5F20739
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvtSjnFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPCuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFPCuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 22:50:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF87C061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 19:50:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d4so435661otk.2
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 19:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/Z+S/o51t7zt1+VYGXbeR4c9L+QsH1pGJXrCoUXwhw=;
        b=NvtSjnFfkKucVm8axdqC83PaHLQHVB+SXZyN5Y8mbuvK2wsoaYO4UtL3/6UlkONDlC
         i3e6lBSHW/vRbgprwSQyz5UyAlg39hLG5Lgnx0wQbRQGQJDdy9kD+lK7Jpf5Ci/qEa5K
         xUiOWVMPGJVnAUGonIH4tWHAbB84nPn+IfRHTB6s3suaKuUBQGL3qmexMPyRjhKPbxJb
         j1dhh2qb06Pcvn4STJtFdHORGkyPpi8+xz9UW1P2pFAq/bK5V8tcvOAfbEFGHasWml4v
         i274CyHGli+x63UDnr+1LrLZ+Nf1f07/1YEEwJnWJkAZHifRcT4jkIWIu+dzrEM3hG4z
         WhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/Z+S/o51t7zt1+VYGXbeR4c9L+QsH1pGJXrCoUXwhw=;
        b=QgMYAMUo45vNzH7nUuxla2HX7bWDxErMJDrll8XK2uUHArCFWgQhOoVihCBTcr9XYV
         Xop9bVeI1gq0cPI0tlhZTrHS/vXeuBI1C2yYz5bmp5/9EqfLqTfPzLD/MALcDgulbOWX
         PnkwLAP52O6VxypubyCE/nyU/j8xkbl7ZsSQ7inwWArXIXJhKtExCEmkEGRrKGy7mlxW
         VSrQW7vXWLhQKLg0mKVsMW65smjXKwns7Q3Y0XJktLWxaA60jnFAI2V8tznoMb17YggR
         WcPwLrOaB1VY7p2GsT4BnU7Bunv1wNqQnqqNBdqBuc2sW5ny0yvEueDyfqWGPGP3/Hed
         +etQ==
X-Gm-Message-State: AOAM532fysupGAUyWzR+3eeXBJwvMlfTjbAR4BbF2wMH5gisFr/f4vvQ
        R4JWb0npDXUzmypn30F+8S5YUw/8xN53GXsyKQQ=
X-Google-Smtp-Source: ABdhPJxMmHXd6XxvmOnl93mHZDSCb+ArqDCDnL8aDbQvLJYJviyqGrGaapUE+AUOI6Pn6kVPDYTTdfw2OcyssnKOjxo=
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr861260otp.14.1592275816225;
 Mon, 15 Jun 2020 19:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com> <20200616024028.GE27192@T590>
In-Reply-To: <20200616024028.GE27192@T590>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 15 Jun 2020 19:50:05 -0700
Message-ID: <CAD+ocbyJ7hfC-UyO5MupgnzbPbVAVO5b1Ff-+xgHLin_FXCE-w@mail.gmail.com>
Subject: Re: [PATCH] block: add split_alignment for request queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the feedback everyone, I totally overlook chunk_sectors and
it sounds like that's exactly what we want. I'll send another patch
where that becomes writable.


On Mon, Jun 15, 2020 at 7:40 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jun 15, 2020 at 05:56:33PM -0700, Harshad Shirwadkar wrote:
> > This feature allows the user to control the alignment at which request
> > queue is allowed to split bios. Google CloudSQL's 16k user space
> > application expects that direct io writes aligned at 16k boundary in
> > the user-space are not split by kernel at non-16k boundaries. More
> > details about this feature can be found in CloudSQL's Cloud Next 2018
> > presentation[1]. The underlying block device is capable of performing
> > 16k aligned writes atomically. Thus, this allows the user-space SQL
> > application to avoid double-writes (to protect against partial
> > failures) which are very costly provided that these writes are not
> > split at non-16k boundary by any underlying layers.
> >
> > We make use of Ext4's bigalloc feature to ensure that writes issued by
> > Ext4 are 16k aligned. But, 16K aligned data writes may get merged with
> > contiguous non-16k aligned Ext4 metadata writes. Such a write request
> > would be broken by the kernel only guaranteeing that the individually
> > split requests are physical block size aligned.
> >
> > We started observing a significant increase in 16k unaligned splits in
> > 5.4. Bisect points to commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> > ("block: enable multipage bvecs"). This patch enables multipage bvecs
> > resulting in multiple 16k aligned writes issued by the user-space to
> > be merged into one big IO at first. Later, __blk_queue_split() splits
> > these IOs while trying to align individual split IOs to be physical
> > block size.
> >
> > Newly added split_alignment parameter is the alignment at which
> > requeust queue is allowed to split IO request. By default this
> > alignment is turned off and current behavior is unchanged.
> >
>
> Such alignment can be reached via q->limits.chunk_sectors, and you
> just need to expose it via sysfs and make it writable.
>
> Thanks,
> Ming
>
