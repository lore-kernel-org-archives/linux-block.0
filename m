Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C822C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 12:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5C8613EB
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFRMvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 08:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhFRMvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 08:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624020576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2lhGelTx8fldEun8KVVAS492ZUTRo8BC5S9GXfxSI4=;
        b=XzG/uuF6T7QhUYRHJDTreQTyuEXXGv79i6v1WQMsL8YM2bAh55xLCyrg3OmHosAziNzxYs
        Ajg3yBc1lA/PoG4/XvAu46fM2WN6jBx4gxIpNV9PPp7tq3ozfpLPL3uyW2S1LhGhsdex85
        22n2W2/yJz82iXlYJek49x+7L7oE9OA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-lTs_FelUNtSIaKZgDDS5xg-1; Fri, 18 Jun 2021 08:49:35 -0400
X-MC-Unique: lTs_FelUNtSIaKZgDDS5xg-1
Received: by mail-ed1-f72.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so3507336edt.23
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 05:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h2lhGelTx8fldEun8KVVAS492ZUTRo8BC5S9GXfxSI4=;
        b=NbAjqjS7D2LLKaJQcel8+gO5o+gRSi5YvTerll5N8HitEvuXUzudkdvm9AXcS0k5pt
         V+Ww9fmYQnvbfmBxbNP+vrKx6nK7raA7XFpDQcNSoD4mUtcImkpVES/FMmheKgphvVFB
         vzBW2vguHSVif3ZaOK1S0ebtAszGRutTJIU6ODceN0S6Gka/Ip8Yz/nExUmNYutnLRJ9
         OPIGRMluRbk/+Kx28qiOkA/RaQvIWc8PEmdp9YONisd170G2opDB3FkCLkiZBtbg4lrT
         /CmZc4GDsOB2SCWwffV9WiIJZ3kWFKyN6sOQ5FmxmipdXu8dNXW+ZZJO3xThagS89upt
         L/hA==
X-Gm-Message-State: AOAM533GyPncw/TNlNrx6POSfSsUWTHBH/5GdbllDM84RtZb23KviFap
        2zI9ElfQVUywQfOtuHhA61iCIod2h3j1lpTVEkokXgsWD43FIRd5/CPceLU5MJGFj9lTnfU8+1E
        Nm/z5227Otl/+eWuQX4InJOo4xBuOjQVJ1rLWvTQ=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr11041364ejb.310.1624020573712;
        Fri, 18 Jun 2021 05:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF+fY2A/R4fMbZsSc/YT7Y0FTBmRZ+DuUDFSDQzLe0/Y9+PHPEU9wK2Zrgt48OFlg+PySi9f019lvxVmZzJ/A=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr11041346ejb.310.1624020573544;
 Fri, 18 Jun 2021 05:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <85F98DA6-FB28-4C1F-A47D-C410A7C22A3D@gmail.com>
 <YL4Z/QJCKc0NCV5L@T590> <C866C380-7A71-4722-957F-2CE65BDACF26@gmail.com>
 <YMAOO3XjOUl2IG+4@T590> <1C6DB607-B7BE-4257-8384-427BB490C9C0@gmail.com>
 <CALTww28L7afRdVdBf-KsyF6Hvf-8-CORSCpZJAvnVbDRo6chDQ@mail.gmail.com>
 <ED5B1993-9D44-4B9C-A7DF-72BD2375A216@gmail.com> <13C1B2E3-B177-4B05-9FF3-AEE57E964605@gmail.com>
In-Reply-To: <13C1B2E3-B177-4B05-9FF3-AEE57E964605@gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Fri, 18 Jun 2021 20:49:21 +0800
Message-ID: <CALTww29rcAwSfbpsBzM_pnVSuVTYyt-YJryeUaNkHetCjXktCg@mail.gmail.com>
Subject: Re: [Bug Report] Discard bios cannot be correctly merged in blk-mq
To:     Wang Shanker <shankerwangmiao@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Miao

So you plan to fix this problem now? The plan is to submit the discard
bio directly to disk similar with raid0/raid10.
As we talked, it needs to consider the discard region. It should be
larger than chunk_sectors * nr_data_disks. It needs
to split the bio when its size not aligned with chunk_sectors *
nr_data_disks. And it needs to consider the start address
of the bio too. If it's not aligned with a start address of
chunk_sectors, it's better to split this part too.

I'm working on another job. So I don't have time to do this now. If
you submit the patches, I can help to review :)

Regards
Xiao

On Fri, Jun 18, 2021 at 2:28 PM Wang Shanker <shankerwangmiao@gmail.com> wr=
ote:
>
> Hi, Xiao
>
> Any ideas on this issue?
>
> Cheers,
>
> Miao Wang
>
> > 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 17:03=EF=BC=8CWang Shanker <shanker=
wangmiao@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> >>
> >> 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 16:44=EF=BC=8CXiao Ni <xni@redhat.=
com> =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi all
> >>
> >> Thanks for reporting about this. I did a test in my environment.
> >> time blkdiscard /dev/nvme5n1  (477GB)
> >> real    0m0.398s
> >> time blkdiscard /dev/md0
> >> real    9m16.569s
> >>
> >> I'm not familiar with the block layer codes. I'll try to understand
> >> the codes related with discard request and
> >> try to fix this problem.
> >>
> >> I have a question for raid5 discard, it needs to consider more than
> >> raid0 and raid10. For example, there is a raid5 with 3 disks.
> >> D11 D21 P1 (stripe size is 4KB)
> >> D12 D22 P2
> >> D13 D23 P3
> >> D14 D24 P4
> >> ...  (chunk size is 512KB)
> >> If there is a discard request on D13 and D14, and there is no discard
> >> request on D23 D24. It can't send
> >> discard request to D13 and D14, right? P3 =3D D23 xor D13. If we disca=
rd
> >> D13 and disk2 is broken, it can't
> >> get the right data from D13 and P3. The discard request on D13 can
> >> write 0 to the discard region, right?
> >
> > Yes. It can be seen at the beginning of make_discard_request(), where
> > the requested range being discarded is aligned to ``stripe_sectors",
> > which should be chunk_sectors * nr_data_disks.
> >
> > Cheers,
> >
> > Miao Wang
>

