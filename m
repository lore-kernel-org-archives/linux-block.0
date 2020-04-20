Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5A3C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4359820735
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN4PGe9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTLQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDTLQE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 07:16:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D14C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 04:16:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so8062683qth.2
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FDanc0qyY40aLCWZhz2kFtt9PDQMlJqIeZHPy7WlsG0=;
        b=JN4PGe9WHYU76wJHQsMsR15Z/0ZJpru8q+3ka6H4xb4Fk/10Miv/GWGpfoiFg03bxL
         RY8GAOeoRN9eqmtUIvXcpBNaEER9oK1GLw5W8r0gcZ9vwG556lXMzbVurKUW/Pg1j/z9
         ljkb4bRrWgVEd3a0leSCrheFciMQgKJWEXHIWB+O2VC3OE84RuGB2T3GobOkrTTUvX7R
         xDWrYk7dIeb6+vb9vJRBBcPUa5u8YW2qXd0Vdfgehwi7a5JpJi9oSJ89Je2FNTetRCSW
         syqkbWChVm8sCswRI/MXI72Ol+VmlJfRDzokbH4fbfHp/x1i9TIchtoCG6fJUZVl8E0u
         H+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FDanc0qyY40aLCWZhz2kFtt9PDQMlJqIeZHPy7WlsG0=;
        b=hX5fbAJcQXDMOC1vZQulDtFm5c2ztxMn9LrQ+X1eQ1VjfMCbfPUSbR3NpPDLGYWZj4
         4w/3W9AqXVcntHUYQ8RgxXOnqWlPPZJZdcHAMXV6om0sg5gMcsTBVi3YV1VPxUFINOGj
         ELxVCRxr+BZTcpKCjqiBByvXqYHPLeGyzaWU8T+3xAKnEnd0hV/abGlV6Irn0S8OMRZa
         6d6IE8K3hnTF7MGa7yuyxyTlL/auWQC2KsWRKuXf1LYopv4WnFpm5aYqoS+DKRnSNstM
         9QeAqHmh/xa87v1qCULbV4jSVPo9v+51arsusSjuyQEwenDE43aTuGhD2GiDcGCPWHoz
         ZlJA==
X-Gm-Message-State: AGi0PuaxbG+buydaVB1YIDpbj6AZwXpSG/Vw/9TirE0RGT+Nm8rbWG0Q
        mHzT6V/hxQ7vI+vUtdahYM8F3CUbM632PysaoK4=
X-Google-Smtp-Source: APiQypL3De0G0mnNvNvd6lKsyLmFbNMNUCDt9V7bD79r/P1dG33D4xj5qnQ6PAZpbYnKbVOcEGKTsqS7BMiRwQQ11NQ=
X-Received: by 2002:ac8:3928:: with SMTP id s37mr15717810qtb.115.1587381363392;
 Mon, 20 Apr 2020 04:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586199103.git.zhangweiping@didiglobal.com> <CAA70yB7mNEt+H5xd+hpeRDLXDi+V+Qmuvuy27wJ63dtmcKDpzQ@mail.gmail.com>
In-Reply-To: <CAA70yB7mNEt+H5xd+hpeRDLXDi+V+Qmuvuy27wJ63dtmcKDpzQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Mon, 20 Apr 2020 19:15:52 +0800
Message-ID: <CAA70yB7k5siarFfK0Bfko73HwzpTrC=c-8u=4X9fGuxkbrdbMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fix potential kernel panic when increase hardware queue
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Ping

On Wed, Apr 8, 2020 at 8:25 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> Weiping Zhang <zhangweiping@didiglobal.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:36=E5=86=99=E9=81=93=EF=
=BC=9A
> >
> > Hi,
> >
> > This series do some improvement base on V2, and also fix two memleaks.
> > And V2 import a regression for blktest/block/test/029, this test case
> > will increase and decrease hardware queue count quickly.
> >
> >
> > Memleak 1:
> >
> > __blk_mq_alloc_rq_maps
> >         __blk_mq_alloc_rq_map
> >
> > if fail
> >         blk_mq_free_rq_map
> >
> > Actually, __blk_mq_alloc_rq_map alloc both map and request, here
> > also need free request.
> >
> > Memleak 2:
> > When driver decrease hardware queue, set->nr_hw_queues will be changed
> > firstly in blk_mq_realloc_tag_set_tags or __blk_mq_update_nr_hw_queues,
> > then blk_mq_realloc_hw_ctxs and blk_mq_map_swqueue, even
> > blk_mq_free_tag_set have no chance to free these hardware queue resourc=
e,
> > because they iterate hardware queue by
> > for (i =3D 0; i < set->nr_hw_queues; i++).
> >
> > Patch1~3: rename some function name, no function change.
> > Patch4: fix first memleak.
> > Patch5: fix prev_nr_hw_queues issue, need be saved before change.
> > Patch6: alloc map and request to fix potential kernel panic.
> >
> Update patch description:
> Patch1~3: rename some function name, no function change.
> Patch4: fix first memleak.
> Patch5: fix prev_nr_hw_queues issue, need be saved before change.
> Patch6: add nr_allocated_map_rqs to struct blk_mq_tag_set to record how
> may rq and maps were allocated for this tag set, and also fix memleak2.
>
> Patch7: fix kernel panic when update hardware queue count > cpu count,
> when use multiple maps. Patch7's commit message has more detail informati=
on
> about this issue.
>
> >
> > Changes since V2:
> >  * rename some functions name and fix memleak when free map and request=
s
> >  * Not free new allocated map and request, they will be relased when ta=
gset gone
> >
> > Changes since V1:
> >  * Add fix for potential kernel panic when increase hardware queue
> >
> > Weiping Zhang (7):
> >   block: rename __blk_mq_alloc_rq_map
> >   block: rename __blk_mq_alloc_rq_maps
> >   block: rename blk_mq_alloc_rq_maps
> >   block: free both map and request
> >   block: save previous hardware queue count before udpate
> >   block: refactor __blk_mq_alloc_rq_map_and_requests
> >   block: alloc map and request for new hardware queue
> >
> >  block/blk-mq.c         | 49 ++++++++++++++++++++++++++++++------------
> >  include/linux/blk-mq.h |  1 +
> >  2 files changed, 36 insertions(+), 14 deletions(-)
> >
> > --
> > 2.18.1
> >
