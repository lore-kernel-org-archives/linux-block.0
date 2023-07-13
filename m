Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D8C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 20:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGMUge (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGMUge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 16:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF352117
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689280547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
        b=brAghUeEi5zm7m+NPYv9vZQ0dwGQRnDouoQDfN1E1wZMIVXlIukP9Yd0R21SknFIXiKQ8x
        qo+6Eq08ZpXY+06e6x8L1P1YZAmgUhlu4+6hNtsKNCQU4yBVy3HVlfhwWW5Q/2dacI/zp5
        ldab4W6esPZp9rYpMImkaKKmz7E41Bw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-6RWEtflcOuqUdoalR2E08g-1; Thu, 13 Jul 2023 16:35:45 -0400
X-MC-Unique: 6RWEtflcOuqUdoalR2E08g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314291caa91so722057f8f.2
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280544; x=1691872544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
        b=DMj/Puol+voZ2XWAUtAIhCJDkbW+P/MAJBXbKouVMqFMRDEm4nnFUhybEOAkNr44Xf
         wKx5kffi6KGM+uLj9hxtzYgKxSAA0L1UIZFBf4/BPKLGGCrweH+CqpvJ6XfJF2aJUlo9
         qAEY9m38gAfj2hmcaO8VZ7JsQZ7UNfi87sl4uBB5R/ZlUOaM2PW9aIwX3yCOclyrBsYd
         KmLO7URyFVqHKMVLkWuPE8uJw9UUPriEMmGWj1p5XStIUKq2r9vlX2zSpdTPm2Ij96Oi
         zqFAGF4CutViJbIJXswg8OIqTj9/jqujzaAQQ8I8OFOue0xuzvGe8Qk6g7pv5DPq7GlF
         aavw==
X-Gm-Message-State: ABy/qLbuiGa6CIFExK/eZCveclic5EBmbLUkrMy1FDXoFVBN2LcpvZOh
        +a7Z3Ycj04UEl7Dqo6EloEYcf+euCep74ePlh2GtmKwyTeMDBNg4MuZdjc/aXtJF1puY3WGeMjN
        +I7AhTWPDekh1mWLtjm3JvfoEbOjfWivIdQbmwUU=
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id p15-20020adfe60f000000b003141ad72ea8mr2264244wrm.54.1689280544728;
        Thu, 13 Jul 2023 13:35:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOrNFSNqO2ibgNG8U5/2UOpb0BAv2NtxVH0GEXiTL3/xlDsfILHX94fg3ANCKRsk4V/3fsHjacWFA3C9imx4A=
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id
 p15-20020adfe60f000000b003141ad72ea8mr2264232wrm.54.1689280544417; Thu, 13
 Jul 2023 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620133711.22840-1-dwagner@suse.de> <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com> <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
In-Reply-To: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
From:   Ewan Milne <emilne@redhat.com>
Date:   Thu, 13 Jul 2023 16:35:33 -0400
Message-ID: <CAGtn9rmDDqXKH2XfqKXww7aOKmNG6vwuPEsy6bXmABaWvHvd7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
To:     Daniel Wagner <dwagner@suse.de>
Cc:     James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Shin'ichiro Kawasaki" <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The basic issue I am trying to solve with NVMe/FC is that we cannot get sys=
tems
to boot reliably from NVMe/FC (boot from SAN) because we don't know how lon=
g
the connect is going to take, and we have seen spurious failures in our tes=
ting.

In general, I think the whole business of a userspace syscall() -> asynchro=
nous
work in the kernel is problematic because the syscall can return a good sta=
tus
even if the connect is never going to work due to a condition that is
not going to
clear.  It is difficult and cumbersome to script around this reliably.

So what I am saying is the current mechanism doesn't work completely
right anyway.

We also encounter the problem Daniel is addressing trying to get
blktests and other
internal tests to work, for similar reasons.

-Ewan

On Thu, Jul 6, 2023 at 8:07=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wrot=
e:
>
> Hi James,
>
> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
> > As much as you want to make this change to make transports "similar", I=
 am
> > dead set against it unless you are completing a long qualification of t=
he
> > change on real FC hardware and FC-NVME devices. There is probably 1.5 y=
rs of
> > testing of different race conditions that drove this change. You cannot
> > declare success from a simplistic toy tool such as fcloop for validatio=
n.
> >
> > The original issues exist, probably have even morphed given the time fr=
om
> > the original change, and this will seriously disrupt the transport and =
any
> > downstream releases.  So I have a very strong NACK on this change.
> >
> > Yes - things such as the connect failure results are difficult to retur=
n
> > back to nvme-cli. I have had many gripes about the nvme-cli's behavior =
over
> > the years, especially on negative cases due to race conditions which
> > required retries. It still fails this miserably.  The async reconnect p=
ath
> > solved many of these issues for fc.
> >
> > For the auth failure, how do we deal with things if auth fails over tim=
e as
> > reconnects fail due to a credential changes ?  I would think commonalit=
y of
> > this behavior drives part of the choice.
>
> Alright, what do you think about the idea to introduce a new '--sync' opt=
ion to
> nvme-cli which forwards this info to the kernel that we want to wait for =
the
> initial connect to succeed or fail? Obviously, this needs to handle signa=
ls too.
>
> From what I understood this is also what Ewan would like to have.
>
> Hannes thought it would make sense to use the same initial connect logic =
in
> tcp/rdma, because there could also be transient erros (e.g. spanning tree
> protocol). In short making the tcp/rdma do the same thing as fc?
>
> So let's drop the final patch from this series for the time. Could you gi=
ve some
> feedback on the rest of the patches?
>
> Thanks,
> Daniel
>

