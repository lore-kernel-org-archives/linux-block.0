Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453AC6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 20:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjHXUVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjHXUUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 16:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F5E4B
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692908400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4Z0d4E9iPXvaKz/Jyh5mYwykExSOMrH0ov7WaYqyyM=;
        b=KPXMGivb+B/Pue99s7seqUqIt9Mqhk6iZSP7T8kZZvWvZZituwYZqOtiE5LzH2ii8mqANf
        YVV9Of1G6qnnWv6S7SX0wun2ph6OBFeDcN+1liJzKOc+V1i6MhqdGokCRphY7TPMOVfRd6
        LMndBNOdIAwf1UCNEm1ZGwO4P/DNsqE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-R3PyXUwaP5KssQRdiDnMag-1; Thu, 24 Aug 2023 16:19:58 -0400
X-MC-Unique: R3PyXUwaP5KssQRdiDnMag-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-57116decad8so275023eaf.2
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 13:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692908394; x=1693513194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4Z0d4E9iPXvaKz/Jyh5mYwykExSOMrH0ov7WaYqyyM=;
        b=DNrr6LHNCj/OH9qNW+0pBy1fjV+4xHMCiMX1DeFBtQtI6tnroKFDEHkBh+XRIw8G+M
         wFiqi5rU9uJYWd0bq73JjKfAoTc5Qj3OQ9ItaCiHC/f7KWC80wzDUS12bK6WC+fFpe8u
         lXFRvSQKuPTYsGZX+uWCP7AMv1y0858aF7EbIJIDlnHSkfKGKii+IxezHJMPwksixvQg
         9CgAgTXkn1COJjo+oTZzsCV9jGC2WaqsHWhVz4wPfNuCQQNvHlkjD+merVHTLZd1RrWy
         ZJegECVc0mPCklhy7hcVz/QZRwrK3O/zxbXO8SFy2k6RVR18oDWmevXAz3li844fk0we
         mm3w==
X-Gm-Message-State: AOJu0YwvpnLvR/DQv0VPC7ljlkXc9MNUgpBzlb/FVridnBFESm8qdmVQ
        j+ZjuOyfuP81TIC2hx+kQosuWOgEHjXTSRLVFxciJ5IZSiovLvgcsS5pJMUHPgaWuRCT9QfrPBf
        HBMDx0fJ0vwPcQvUuuaIaRL5EN/QxY+g=
X-Received: by 2002:a05:6358:893:b0:133:a55:7e26 with SMTP id m19-20020a056358089300b001330a557e26mr15393267rwj.7.1692908393973;
        Thu, 24 Aug 2023 13:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+atzCLnDevWDsek3DwGGBemrxM7CbQNyCu5IzMhL7JVssTeyYNt/q2q+VtND3pOro+cGTUQ==
X-Received: by 2002:a05:6358:893:b0:133:a55:7e26 with SMTP id m19-20020a056358089300b001330a557e26mr15393245rwj.7.1692908393610;
        Thu, 24 Aug 2023 13:19:53 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id l4-20020a81d544000000b00589b653b7adsm81762ywj.136.2023.08.24.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:19:53 -0700 (PDT)
Message-ID: <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
Subject: Re: LVM kernel lockup scenario during lvcreate
From:   Laurence Oberman <loberman@redhat.com>
To:     Jaco Kroon <jaco@uls.co.za>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 24 Aug 2023 16:19:51 -0400
In-Reply-To: <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
         <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
         <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
         <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2023-08-24 at 22:01 +0200, Jaco Kroon wrote:
> Hi,
>=20
> On 2023/08/24 19:29, Laurence Oberman wrote:
>=20
> > On Mon, 2023-06-12 at 11:40 -0700, Bart Van Assche wrote:
> > > On 6/9/23 00:29, Jaco Kroon wrote:
> > > > I'm attaching dmesg -T and ps axf.=C2=A0 dmesg in particular may
> > > > provide
> > > > clues as it provides a number of stack traces indicating
> > > > stalling
> > > > at
> > > > IO time.
> > > >=20
> > > > Once this has triggered, even commands such as "lvs" goes into
> > > > uninterruptable wait, I unfortunately didn't test "dmsetup ls"
> > > > now
> > > > and triggered a reboot already (system needs to be up).
> > > To me the call traces suggest that an I/O request got stuck.
> > > Unfortunately call traces are not sufficient to identify the root
> > > cause
> > > in case I/O gets stuck. Has debugfs been mounted? If so, how
> > > about
> > > dumping the contents of /sys/kernel/debug/block/ into a tar file
> > > after
> > > the lockup has been reproduced and sharing that information?
> > >=20
> > > tar -czf- -C /sys/kernel/debug/block . >block.tgz
> > >=20
> > > Thanks,
> > >=20
> > > Bart.
> > >=20
> > One I am aware of is this
> > commit 106397376c0369fcc01c58dd189ff925a2724a57
> > Author: David Jeffery <djeffery@redhat.com>
> >=20
> > Can we try get a vmcore (assuming its not a secure site)
>=20
> Certainly.=C2=A0 Obviously on any host handling any kind of sensitive dat=
a
> there is a likelihood that sensitive data may be present in the
> vmcore,=20
> as such I more than happy to create a vmcore, I'm assuming this will=20
> create a kernel version of a core dump ... with 256GB of RAM (most of
> which goes towards disk caches) I'm further assuming this file can be
> potentially large.=C2=A0 Where will this get stored should the capture be=
=20
> made?=C2=A0 (I need to ensure that the filesystem has sufficient storage=
=20
> available)
>=20
> >=20
> > Add these to /etc/sysctl.conf
> >=20
> > kernel.panic_on_io_nmi =3D 1
> > kernel.panic_on_unrecovered_nmi =3D 1
> > kernel.unknown_nmi_panic =3D 1
> >=20
> > Run sysctl -p
> > Ensure kdump is running and can capture a vmcore
> Done.=C2=A0 Had to enable a few extra kernel options to get all the other=
=20
> requirements, so scheduled a reboot to activate the new kernel. This=20
> will happen on Saturday morning very early.
> >=20
> > When it locks up again
> > send an NMI via the SuperMicro Web Managemnt interface
>=20
> Possible to send from sysrq at the keyboard?=C2=A0 Otherwise I'll just
> need=20
> to set up the RMI, will just be easier to do this from the keyboard
> if=20
> possible, it's not always if it's left too late.
>=20
> >=20
> > Share the vmcore, or we can have you capture some specifics from it
> > to
> > triage.
>=20
> I'd prefer you let me know what you need ... security concerns and
> all=20
> ... frankly, I highly doubt there is any data that is really so=20
> sensitive that it can be classified as "top secret" but we do have
> NDAs=20
> in place prohibiting me from sharing anything that may potentially=20
> contain customer related data ...
>=20
> Kind regards,
> Jaco
>=20

Hello, this would usually need an NMI sent from a management interface
as with it locked up no guarantee a sysrq c will get there from the
keyboard.=C2=A0
You could try though.

As long as you have in /etc/kdump.conf=20

path /var/crash
core_collector makedumpfile -l --message-level 7 -d 31

This will get kernel only pages and would not be very big.

I could work with you privately to get what we need out of the vmcore
and we would avoid transferring it.

Thanks
Laurence

