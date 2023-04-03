Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF353C76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjDCMnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjDCMnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 08:43:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E2658F
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 05:43:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r29so29165935wra.13
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2023 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680525802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRRTCbiGACPoljjVpBjW3QwozpnkiX8EBP1CGqAYlv8=;
        b=C6y5I5N6i+3y5ePLo/VvtJb9Ti6nNN2dPQO6o9nEN7tPhjire+DjEjZmx5VBJP033s
         7hV9+QEne9Zp0843ldbfAVB4xCR1pEmhSyIcjoLviKSHYEbPV8qmogBjdAxzMl8bjsbc
         leantIoNP/Wlt/m2nGc2+U/b56l0oYyejHsLU+W4skX6Kf/XKutxXHGf8/whU8f0m2rQ
         c8wh8xJazc88AH08bUeVGWRrvMyf2Ie8KKxhBuWimx+O/Kgt62AwgQz47lQSJBJQj6YU
         pFIPv1Zyk4ZIlL/7MG+vsv2NwiSZ8cq+Hs/aKPqNu6QmmGQXuunBTOQoyFanoSK1C2pT
         ZR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRRTCbiGACPoljjVpBjW3QwozpnkiX8EBP1CGqAYlv8=;
        b=dq5xBVzmjD/XLHKcqHOyGFuKHCdkS4zjR7VtijeXRcy7+1XZRNhtu0oMFnVzib2fR2
         t1lMGb6+Lu8Nj7AX2hyGae6u8sVepwOQzDwa8Q6FmyDtpX0aH1uWQ3rV3xDf9YqDAAKY
         8PeZwk9tDAD+JghE4TZtSHU7gKimSw0kwhSleY4VK+j8IBhXxjJDNEqiF4RERts0yVbc
         e1AYbqHUJGHwvpYzfod1UYuy24XzDkbtdLCjQ4uEqTgw+6csROmwriMT1I1SFN2zBsAG
         D4h8oP6u8vM0Zv+mgvofSgwT5n0WBbhcxCzWVQWJC/e74PtCV3yIafnd35kJNKGRWIy1
         bETQ==
X-Gm-Message-State: AAQBX9cZa3SjVJVFg4RC9NmzQmafNYtvvCpcWM0V/4jp8YISHWDd27vm
        dyx7MITNJ+ynW+QwDXQVWWGZAjxKpyy0EMrsjsc=
X-Google-Smtp-Source: AKy350aXpOscQ6kEFa5UuxUnn0eGOFmp4kvli+CJWNXB3ROSV1Vd8T4p86lWHGAY5V8llnRsukBDGhsLSS1jXhzfp0k=
X-Received: by 2002:a5d:5691:0:b0:2cf:efad:9c23 with SMTP id
 f17-20020a5d5691000000b002cfefad9c23mr5891388wrv.14.1680525802212; Mon, 03
 Apr 2023 05:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212803.1837554-1-kbusch@meta.com> <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com> <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
 <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com> <20230328074939.GA2800@green5>
 <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com> <20230329084618.GB2800@green5>
 <ZCRjGmPCeLvi2m39@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZCRjGmPCeLvi2m39@kbusch-mbp.dhcp.thefacebook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 3 Apr 2023 18:12:55 +0530
Message-ID: <CA+1E3r+OrN-sFQ5TGC238Km=KurOZBvx+1ZeLXA=tsrgZZo8Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 9:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Mar 29, 2023 at 02:16:18PM +0530, Kanchan Joshi wrote:
> > On Tue, Mar 28, 2023 at 08:52:53AM -0600, Keith Busch wrote:
> > > > > +       else if (issue_flags & IO_URING_F_IOPOLL)
> > > > > +               ioucmd->flags |=3D IORING_URING_CMD_NOPOLL;
> > > >
> > > > If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags=
", we
> > > > could have just cleared that here. That would avoid the need of NOP=
OLL flag.
> > > > That said, I don't feel strongly about new flag too. You decide.
> > >
> > > IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly lik=
e it is
> > > part of ioucmd->flags, is actually ctx flags, so a little confusing. =
And we
> > > need to be a litle careful here: the existing ioucmd->flags is used w=
ith uapi
> > > flags.
> >
> > Indeed. If this is getting crufty, series can just enable polling on
> > no-payload requests. Reducing nvme handlers - for another day.
>
> Well something needs to be done about multipath since it's broken today: =
if the
> path changes between submission and poll, we'll consult the wrong queue f=
or
> polling enabled. This could cause a missed polling opprotunity, polling a
> pointer that isn't a bio, or poll an irq enabled cq. All are bad.

I see, that is because "nvme_find_path" was used.
How about using top 4 bits of "ioucmd->flags" for an internal flag.
That means we can support max 28 flags for "sqe->uring_cmd_flags".
That perhaps is not too bad, given that we use one bit at the moment?
