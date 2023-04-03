Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE3C76188
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDCSlz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDCSlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 14:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E8BC
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680547259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnUfxiNzIDCXaSEDlUou/KQ85PIVBXyvNqN5IYn9Rr0=;
        b=i4UyChUS93gfMcmzoiqhx4swBrEd6BB5raZHM/i8h2T1SH5jU4JfUdo3DtUb8w87xsouk5
        6XuZREK6/VT4sc2QOXM3In6jc7k9LUwgvyHG5qZ1O3YoOU2Q95OUwPVIv6ea5dODDMdT2a
        GcXowV6olRkl5eAtiHx29cBKAxBY+qE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-kGNpSXRBMK61uIHSej3Nbg-1; Mon, 03 Apr 2023 14:40:58 -0400
X-MC-Unique: kGNpSXRBMK61uIHSej3Nbg-1
Received: by mail-ot1-f72.google.com with SMTP id x20-20020a9d7054000000b006a149b4ad1cso7977365otj.23
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2023 11:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnUfxiNzIDCXaSEDlUou/KQ85PIVBXyvNqN5IYn9Rr0=;
        b=hwMQRwd2YVAGEfBrFKJ8LhGtxyov29SAI0sJEf8psZ+jWTMxdtmENFqI6taopqEobV
         mymdUHI7oS3g+CZwiWvzsYBxIDZ6kGe9txJXQPeb9hD67t1ksqsK0B9bCy+TVOLI7189
         9zrQrlMn95sT8LurhZONFBBLDidY+jV7NHWtnvpywA9GVDjf7+AK5g0Lm6I9kVuzqd+S
         oA0l73Ct3hEQf8k6Vo1Ayq6VdAldwJhCs+YMDh3wjK7r4KGEmTRjPxm8EjoUhrRTKqJ+
         cBep3IhpHpqgntWVuU73jrtzcpvhYhWhR7T35M7uUh1fFTYE1hZJrHEvZJh8OOm1SO+K
         X94g==
X-Gm-Message-State: AAQBX9ebScFAnXxe/BywPQeuZ6Ga90MI7Xo8U1ju9YHxm4nEDX8i64HL
        r9Onpb2kUvfisby8S00hW4DvcuskJlNHGDhGQ08lqcbQIL2y5Gnw6N7XUkHHTNZ5pr7MZifTZ0x
        eTzbALkYDMK/VJOYVrI7goVc=
X-Received: by 2002:a4a:1187:0:b0:541:521:b527 with SMTP id 129-20020a4a1187000000b005410521b527mr198579ooc.7.1680547258078;
        Mon, 03 Apr 2023 11:40:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yjw6SX+mZhSvcqaOrhUXUnvCZA88w50+qKtKQMN6F8MzrhjcbntFSEGSL5GlXqrbUxSoQBeA==
X-Received: by 2002:a4a:1187:0:b0:541:521:b527 with SMTP id 129-20020a4a1187000000b005410521b527mr198576ooc.7.1680547257803;
        Mon, 03 Apr 2023 11:40:57 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id q40-20020a4a962b000000b0053b543b027bsm4255367ooi.42.2023.04.03.11.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:40:57 -0700 (PDT)
Message-ID: <02ba658226be85a2b5ea678116fdc4c3059b82a7.camel@redhat.com>
Subject: Re: Issue with discard with NVME and Infinibox Storage
From:   Laurence Oberman <loberman@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     minlei@redhat.com, jmeneghi@redhat.com,
        "Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 03 Apr 2023 14:40:55 -0400
In-Reply-To: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
         <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
         <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2023-04-03 at 14:18 -0400, Laurence Oberman wrote:
> On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> > On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> > > Hello Ming and Christoph
> > >=20
> > > Issue with Infinibox storage
> > > ----------------------------
> > > Really discovered 2 issues here=20
> > >=20
> > > Issue 1
> > > Kernels 5.15 to 5.18 inclusive recognize the discard support on
> > > the
> > > Infinibox device but they fail in the nvme_setup_discard function
> > > call
> >=20
> > This first i ssue should be fixed with this commit:
> >=20
> > =C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it?id=3D37f0dc2ec78af0c3f35dd05578763de059f6fe77
> >=20
> > > Issue 2
> > > Trying to narrow this down.
> > > 5.19 and higher (6.3 included), no longer support discard on the
> > > Infinibox device and log this message so I cannot run the test
> > > for
> > > the
> > > discard issue
> > >=20
> > > [=C2=A0=C2=A0 35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> > > 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> > > [=C2=A0=C2=A0 64.810437] XFS (nvme1n1): mounting with "discard" optio=
n, but
> > > the
> > > device does not support discard
> > > [=C2=A0=C2=A0 64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a3=
3f-
> > > 18cc-
> > > 4a26-894b-8b0f8d79a98a
> > >=20
> > > I then bisected between 5.18 and 5.19 to this commit
> > >=20
> > > 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit
> >=20
> >=20
> > > commit 1a86924e4f464757546d7f7bdc469be237918395
> > > Author: Tom Yan <tom.ty89@gmail.com>
> > > Date:=C2=A0=C2=A0 Fri Apr 29 12:52:43 2022 +0800
> > >=20
> > > =C2=A0=C2=A0=C2=A0 nvme: fix interpretation of DMRSL
> > > =C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0 DMRSLl is in the unit of logical blocks, while
> > > max_discard_sectors
> > > is
> > > =C2=A0=C2=A0=C2=A0 in the unit of "linux sector".
> > > =C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >=20
> > > =C2=A0drivers/nvme/host/core.c | 6 ++++--
> > > =C2=A0drivers/nvme/host/nvme.h | 1 +
> > > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > >=20
> > > Note that Infindat mentioned this in our case they logged with us
> > > They say they fully adhere to TP4040 MDTS.
> > > Towards NVMe-oF 2.0 specification, TP4040=C2=A0 - Max Data Transfer
> > > for
> > > non-
> > > IO Commands (MDTS) was released with additional fields to control
> > > these
> > > parameters.
> > > These parameters are supported in kernel versions 5.15 and
> > > above.=C2=A0
> > > ****
> > >=20
> > > Our storage target will reply with 0 for bit 2 of the ONCS,
> > > indicating
> > > UNMAP is supported based on the DMRL, DMRSL, and DMSL values.=20
> > > (older kernels will interpret these values as UNMAP NOT
> > > SUPPORTED)
> > >=20
> > >=20
> > > Let me know your thoughts please. for both issues
> >=20
> > The commit you found unconditionally sets the discard queue limit
> > to
> > the
> > reported DMRSL, so it sounds like your target is reporting DMRSL as
> > '0'. Prior
> > to that commit, we'd use that value only if it was non-zero. I hope
> > that helps.
> >=20
>=20
>=20
>=20
> Hello Keith,
> Many Thanks as always
> I will inform Infinidat and have them figure this out.
>=20
> Regards
> Laurence


Hi Keith=C2=A0
Closing the loop

The challenge was the other issue was masking me testing the fix.

I reverted that commit (1a86924e4f464757546d7f7bdc469be237918395) and
now the original test passes so we are good here.

Linux localhost.localdomain 6.3.0-rc4+ #13 SMP PREEMPT_DYNAMIC Mon Apr
3 13:40:21 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux

[   57.090328] nvme nvme1: new ctrl: NQN "nqn.2020-
01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
[   61.441213] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
4a26-894b-8b0f8d79a98a
[   64.627670] XFS (nvme1n1): Ending clean mount
[   64.665657] xfs filesystem being mounted at /data supports
timestamps until 2038 (0x7fffffff)

Then running the fio test passes with no issues so confirming the fix
you called out (Ming had mentioned this too) resolves the original
issue.


Infinidat will have to fix their DMRSL issue

Thanks folks

Regards as always
Laurence Oberman


