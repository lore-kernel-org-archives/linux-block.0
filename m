Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84BC678D4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 08:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCCIeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCCIeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 03:34:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B31352D
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 00:34:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so7181156edb.9
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 00:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1677832446;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX/s24fyXps09GmRUXN6+YF0kQsZjEttAdLoVe9JJU8=;
        b=KE8kJDfmZXlNopgtYY4tozghvbSzrDPir+aOJyvz4M9lULysiFooq0W9opwHCbAgXM
         sUokj7MEEiZj0N0IlDYeNWxFcRvLwDeZp+KeuEQfjunuJ/CuLAdXO4JuCss+Ed1ook8C
         LEPdrpsr4+ThxrdGwOtVsjvc1a/3K3g/X+3CNDsUW9HjKj8CRnLfNgwzTX5pIKoz+ixT
         2JQ2VPzFZyTvtD3NYd8WQKJmU51lkNbPS1GVRLFoUA7o4GLnIp2OwY02RlSH9kyrltR7
         oMy1TccoGb2eZ6n1NLq6ehvPWnGMaGiwyyifIcSwIoCBrof6ABWlJwUvBDIJ46zfuxIN
         iORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832446;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QX/s24fyXps09GmRUXN6+YF0kQsZjEttAdLoVe9JJU8=;
        b=53LR6KVmaxKBUhyfJJjbzthQaJFbaMryyELJEyINdcgvduH0tX0l2H2fRb/1i7k9FX
         IYrEAEbrzKInSPyyriaSRI72jwQ5M6R36oFMiJW9olXvA1zC9hpjlsW1efifHohf7uEg
         WpnhnlS7+H5rPpEQPYFm+Z8fRIW6FH4ygFfQht+AP2mmNuUWLkNBG5acuTppVLRWM4eh
         7tY5j09wvEnawiVOeFtUjjfrF1JTE4saZvtneg4xvJnG0oJ7Cxz4D/neTuM8Mjgj1MtG
         gY/qJn+MOV6t+bWqGmRfLg87BvkK4lpT8nZcqet9LJ/HQxSw+ypRXNp+uoZEpMh9LEKO
         LBYQ==
X-Gm-Message-State: AO0yUKU4Tft+WiLj3/GcrSVNqPVfldAgkPRVK/VMY84A5C+6kT/pFbY7
        4fTaw2qZKyKpU1mRwDVUDipd6V6x3GVP7eOb
X-Google-Smtp-Source: AK7set+gReERjem/pLhjTAwaodgJwetDff7PtxIZhYQEiDj2UkwqZN3tOQ/Ey6fVvCjcGCGStfPDZA==
X-Received: by 2002:aa7:cfcb:0:b0:4af:6c25:ed9a with SMTP id r11-20020aa7cfcb000000b004af6c25ed9amr1235797edy.29.1677832446739;
        Fri, 03 Mar 2023 00:34:06 -0800 (PST)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id t30-20020a50ab5e000000b004ad601533a3sm872101edc.55.2023.03.03.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:34:06 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590> <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk> <ZAChttVoCHsnXmvF@T590>
 <875ybjl1r0.fsf@metaspace.dk> <ZAFieW9PZ2LNQYHa@T590>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Fri, 03 Mar 2023 09:27:58 +0100
In-reply-to: <ZAFieW9PZ2LNQYHa@T590>
Message-ID: <87wn3yfd36.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Mar 02, 2023 at 02:28:33PM +0100, Andreas Hindborg wrote:
>>=20
>> Ming Lei <ming.lei@redhat.com> writes:
>>=20
>> > On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
>> >>=20
>> >> Ming Lei <ming.lei@redhat.com> writes:
>> >>=20
>> >> > On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.co=
m> wrote:
>> >> >>
>> >> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
>> >> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
>> >> >> > >
>> >> >>
>> >> >> ...
>> >> >>
>> >> >> > >
>> >> >> > > I agree about fetching more zones. However, it is no good to f=
etch up to
>> >> >> > > a max, since the requested zone report may less than max. I was
>> >> >> >
>> >> >> > Short read should always be supported, so the interface may need=
 to
>> >> >> > return how many zones in single command, please refer to nvme_ns=
_report_zones().
>> >> >>
>> >> >> blk_zone is part of uapi, maybe the short read can be figured out =
by
>> >> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
>> >> >> reporting zones.
>> >> >
>> >> > oops, we have blk_zone_report data for reporting zones to userspace=
 already,
>> >> > see blkdev_report_zones_ioctl(), then this way can be re-used for g=
etting zone
>> >> > report from ublk server too, right?
>> >>=20
>> >> Yes that would be nice. But I did the report_zone command like a read
>> >> operation, so we are not currently copying any buffers to user space
>> >> when issuing the command, we just rely on the iod.
>> >
>> > What I meant is to reuse the format of blk_zone_report for returning
>> > multiple 'blk_zone' info in single command.
>> >
>> > The only change is that you need to allocate one bigger kernel buffer
>> > to hold more 'blk_zone' in single report zone request.
>> >
>> >> I think it would be
>> >> better to use the start_sectors and nr_sectors of the iod instead. Th=
en
>> >> we don't have to copy the blk_zone_report. What do you think?
>> >
>> > For IN parameter of report zone command, you still can reuse
>> > blk_zone_report:
>> >
>> > struct blk_zone_report {
>> >         __u64           sector;
>> >         __u32           nr_zones;
>> >         __u32           flags;
>> > };
>> >
>> > Just by using the 1st two 64b words of iod for holding 'blk_zone_repor=
t', and
>> > keep the iod->addr field not touched.
>>=20
>> I see. Would you make the first part of `struct ublksrv_io_desc` a union
>> for this, or would you just cast it at the use site?
>
> oops, you still need iod->op_flags for recognizing the io op, so just
> start_sector and nr_sectors can be used.

We do not actually need to pass the flags to user space, or back from
user space to kernel for ublk zone report. They are currently used to
tell user space if the zone report contains capacity field. We could
exclude them from the ublk kabi since the zone report will always
contain capacity? But it might be good to have a flags field or future
things.

> However, this way isn't good too, cause UBLK_IO_OP_DRV_IN is just mapped
> to 'report zone' command in your implementation, what if new pt request
> is required in future?

We are currently mapping REQ_OP_* 1:1 to  UBLK_OP_OP_*. If we relax
this, we can have a UBLK_IO_OP_REPORT_ZONES.

>
> We need to think about how to support ublk pt request in generic way.

Another option is to allow REQ_OP_DRV_IN to pass a buffer to user space.
Instead of being similar to a read operation, it could be a combination of
a read and a write operation.

BR Andreas

