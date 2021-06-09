Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52951C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6161375
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhFIIqT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhFIIqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 04:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623228263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6Euu4KPNqLtNLo891SVSfhz6UMhcEyVNeUStw8xpU0=;
        b=BJHPAbzo2SF4AKuvjaj5DEfTyGRbPMGuc1LNeE31wWtzCtyC7Nzv93I2oB7gvdH/K383b4
        1uTk3R39t24y8AcPi2OZsTlArCCUZekSsJc0hQSHbjG1TuplAOn/CIO8rH4cDy9xCyAZEr
        bkmc7reH5bBnv8k2z6EVUlsMH4pViyc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-7sRK_WTzMK2ptb7YT84tYg-1; Wed, 09 Jun 2021 04:44:20 -0400
X-MC-Unique: 7sRK_WTzMK2ptb7YT84tYg-1
Received: by mail-ej1-f71.google.com with SMTP id p18-20020a1709067852b02903dab2a3e1easo7740662ejm.17
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 01:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B6Euu4KPNqLtNLo891SVSfhz6UMhcEyVNeUStw8xpU0=;
        b=Il/8AqNmyQvU35/sPPdgQJrMmIIq5TxFIyO4V/MRWzBvrHWZFVbRl38irJyPBeW5tr
         rT1nt57wQl2B6G21WoPr5a4z0m41c3/voCh/Xx5nu08FH9LIGiSbkofoXjNUfLicdSoX
         4cGb8dBl8kRrSOl9iwWeUrLs8Ygk7wMLSkAftkQMRRUvqiRNA+fSelGEpIUnwuP64EXd
         1NFTZrZXGSTJsxvM1pTVNaOy/8UaozC2N+K70QWW27ta+d1B8uhqR+S0owNZJWNBO0FA
         YTkVDpWKKa0M+rZ3KDY5945Lo1t0VnmX139Jr+/6/3GsWwdCjr7AhC/8h7EPL2XYOUMn
         40cA==
X-Gm-Message-State: AOAM531Qp44dmK6OgEQpBsrbnhu7aaZVR00SsGti5NJQ3yPvmv+WbMVa
        fm2cisP1x+p5tfRnr0yecPFKiOK8fS8aWcOCXxWRtaATZrSZDk7nUJuudMmaDGBCp1eoY9r+MBq
        BVKuunISlnDQYBpjmep1EdRq9/yFC2uwYKek/jGs=
X-Received: by 2002:aa7:df04:: with SMTP id c4mr29804624edy.147.1623228259024;
        Wed, 09 Jun 2021 01:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDc/Qy1zIdzJhC7P+bcLMG8+o6JrmcVdRcJumUablaRYIJ9lnCeI5m56vYIWAOfmjAk+tLJdIJGwrlmGwGRMY=
X-Received: by 2002:aa7:df04:: with SMTP id c4mr29804615edy.147.1623228258856;
 Wed, 09 Jun 2021 01:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <85F98DA6-FB28-4C1F-A47D-C410A7C22A3D@gmail.com>
 <YL4Z/QJCKc0NCV5L@T590> <C866C380-7A71-4722-957F-2CE65BDACF26@gmail.com>
 <YMAOO3XjOUl2IG+4@T590> <1C6DB607-B7BE-4257-8384-427BB490C9C0@gmail.com>
In-Reply-To: <1C6DB607-B7BE-4257-8384-427BB490C9C0@gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 9 Jun 2021 16:44:07 +0800
Message-ID: <CALTww28L7afRdVdBf-KsyF6Hvf-8-CORSCpZJAvnVbDRo6chDQ@mail.gmail.com>
Subject: Re: [Bug Report] Discard bios cannot be correctly merged in blk-mq
To:     Wang Shanker <shankerwangmiao@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all

Thanks for reporting about this. I did a test in my environment.
time blkdiscard /dev/nvme5n1  (477GB)
real    0m0.398s
time blkdiscard /dev/md0
real    9m16.569s

I'm not familiar with the block layer codes. I'll try to understand
the codes related with discard request and
try to fix this problem.

I have a question for raid5 discard, it needs to consider more than
raid0 and raid10. For example, there is a raid5 with 3 disks.
D11 D21 P1 (stripe size is 4KB)
D12 D22 P2
D13 D23 P3
D14 D24 P4
...  (chunk size is 512KB)
If there is a discard request on D13 and D14, and there is no discard
request on D23 D24. It can't send
discard request to D13 and D14, right? P3 =3D D23 xor D13. If we discard
D13 and disk2 is broken, it can't
get the right data from D13 and P3. The discard request on D13 can
write 0 to the discard region, right?

If so, it can handle a discard bio at a time that is big enough at
least to contain the data. (data disks * chunk size). In this case the
size is 1024KB (512KB*2).

Regards
Xiao


On Wed, Jun 9, 2021 at 10:40 AM Wang Shanker <shankerwangmiao@gmail.com> wr=
ote:
>
>
> > 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 08:41=EF=BC=8CMing Lei <ming.lei@re=
dhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jun 08, 2021 at 11:49:04PM +0800, Wang Shanker wrote:
> >>
> >>
> >> Actually, what are received by the nvme controller are discard request=
s
> >> with 128 segments of 4k, instead of one segment of 512k.
> >
> > Right, I am just wondering if this way makes a difference wrt. single
> > range/segment discard request from device viewpoint, but anyway it is
> > better to send less segment.
> It would be meaningful if more than queue_max_discard_segments() bio's
> are sent and merged into big segments.
> >
> >>
> >>>
> >>>>
> >>>> Similarly, the problem with scsi devices can be emulated using the f=
ollowing
> >>>> options for qemu:
> >>>>
> >>>>       -device virtio-scsi,id=3Dscsi \
> >>>>       -device scsi-hd,drive=3Dnvme1,bus=3Dscsi.0,logical_block_size=
=3D4096,discard_granularity=3D2097152,physical_block_size=3D4096,serial=3DN=
VME1 \
> >>>>       -device scsi-hd,drive=3Dnvme2,bus=3Dscsi.0,logical_block_size=
=3D4096,discard_granularity=3D2097152,physical_block_size=3D4096,serial=3DN=
VME2 \
> >>>>       -device scsi-hd,drive=3Dnvme3,bus=3Dscsi.0,logical_block_size=
=3D4096,discard_granularity=3D2097152,physical_block_size=3D4096,serial=3DN=
VME3 \
> >>>>       -trace scsi_disk_emulate_command_UNMAP,file=3Dscsitrace.log
> >>>>
> >>>>
> >>>> Despite the discovery, I cannot come up with a proper fix of this is=
sue due
> >>>> to my lack of familiarity of the block subsystem. I expect your kind=
 feedback
> >>>> on this. Thanks in advance.
> >>>
> >>> In the above setting and raid456 test, I observe that rq->nr_phys_seg=
ments can
> >>> reach 128, but queue_max_discard_segments() reports 256. So discard
> >>> request size can be 512KB, which is the max size when you run 1MB dis=
card on
> >>> raid456. However, if the discard length on raid456 is increased, the
> >>> current way will become inefficient.
> >>
> >> Exactly.
> >>
> >> I suggest that bio's can be merged and be calculated as one segment if=
 they are
> >> contiguous and contain no data.
> >
> > Fine.
> >
> >>
> >> And I also discovered later that, even normal long write requests, e.g=
.
> >> a 10m write, will be split into 4k bio's. The maximum number of bio's =
which can
> >> be merged into one request is limited by queue_max_segments, regardles=
s
> >> of whether those bio's are contiguous. In my test environment, for scs=
i devices,
> >> queue_max_segments can be 254, which means about 1m size of requests. =
For nvme
> >> devices(e.g. Intel DC P4610), queue_max_segments is only 33 since thei=
r mdts is 5,
> >> which results in only 132k of requests.
> >
> > Here what matters is queue_max_discard_segments().
> Here I was considering normal write/read bio's, since I first took it for=
 granted
> that normal write/read IOs would be optimal in raid456, and finally disco=
vered
> that those 4k IOs can only be merged into not-so-big requests.
> >
> >>
> >> So, I would also suggest that raid456 should be improved to issue bigg=
er bio's to
> >> underlying drives.
> >
> > Right, that should be root solution.
> >
> > Cc Xiao, I remembered that he worked on this area.
>
> Many thanks for looking into this issue.
>
> Cheers,
>
> Miao Wang
>

