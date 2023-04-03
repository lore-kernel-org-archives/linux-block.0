Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC2C76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 18:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjDCSTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCSTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 14:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B92126
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680545904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ8XMJlmFNN1HI8OQhQFUe31S1D65GN8q4I0UmxuaGA=;
        b=AOjk377XKj01ker9ZTBkEKY0Lcdzhxi2ItQP4NEpDUVPbU9DYdqbCgeV2vzd9F/ajIs35D
        UdizHG+S5udIaMTw9YNwjNDrxWWbqi+vhTG+BrBkpXGc0Apdx8JrwfD2Mg5DvyfnsqZksS
        uhAN3ux6GgdYvNChVZ816eWSAF8Jjgg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-iKVvAyhvPT6cNYPVg6Weog-1; Mon, 03 Apr 2023 14:18:23 -0400
X-MC-Unique: iKVvAyhvPT6cNYPVg6Weog-1
Received: by mail-oo1-f69.google.com with SMTP id c83-20020a4a4f56000000b0053b4b212346so7849851oob.10
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2023 11:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJ8XMJlmFNN1HI8OQhQFUe31S1D65GN8q4I0UmxuaGA=;
        b=tt/5EglCTGMLTtKiBrtlFkXAA1AsbClfXmGrRyi0Rb0STZJGgdngyPzPY8Lbl2wrsB
         MzKvkHm15iQiaC2ZqX4sTlL0GdNCYj4YK3IQobJab4nBdl4ueMAUUJ2p5m9zwDEBzd7f
         s5cQHKdPb8xiMMcFoMoeD7jYq3gIk1xW/OYQUXuoJyFRy8FAPVvL4Eq+6lCdJosu2lrX
         W0v42qxTKaGLFikcR5AquFJo2w2LGWr9Py/ioFsa4vBq5+6tHfvPa+YqVdLv+umeLiG+
         wtg8vm597m2IvizzPiiVrz7elrjp1H2yHCPz+5mXsCvRkXZHl6kJbOaRzOq9rDJDJDZp
         F4oA==
X-Gm-Message-State: AAQBX9evlg/pJXjEdSFq4Yp6NBFve89ZECr3k0cmhRHUfQB2P8Tg5bN4
        tTnEwPtOMl0SYnY1VwkGty25qrHXAVa9efDOri/yiFAxqok5dOqooxE1JB5sXuR+ZXHJMZBk31N
        gQSNgA/9pGiPpFNBy9ZcN8TI=
X-Received: by 2002:aca:190d:0:b0:388:7983:2e06 with SMTP id l13-20020aca190d000000b0038879832e06mr40260oii.52.1680545903034;
        Mon, 03 Apr 2023 11:18:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJTMOs7xiTnNhy76LPqf+lB4UfRxzDL0CJcy/DmfoXMw0QCihh+8yf0/HqeQmAIrmUxXEWjA==
X-Received: by 2002:aca:190d:0:b0:388:7983:2e06 with SMTP id l13-20020aca190d000000b0038879832e06mr40255oii.52.1680545902772;
        Mon, 03 Apr 2023 11:18:22 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id o11-20020a9d6d0b000000b006a32ba92994sm2447603otp.23.2023.04.03.11.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:18:22 -0700 (PDT)
Message-ID: <89d2cd0379c848f145eed7daf1931d7b4c81b230.camel@redhat.com>
Subject: Re: Issue with discard with NVME and Infinibox Storage
From:   Laurence Oberman <loberman@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     minlei@redhat.com, jmeneghi@redhat.com,
        "Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 03 Apr 2023 14:18:21 -0400
In-Reply-To: <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
         <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2023-04-03 at 12:00 -0600, Keith Busch wrote:
> On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> > Hello Ming and Christoph
> >=20
> > Issue with Infinibox storage
> > ----------------------------
> > Really discovered 2 issues here=20
> >=20
> > Issue 1
> > Kernels 5.15 to 5.18 inclusive recognize the discard support on the
> > Infinibox device but they fail in the nvme_setup_discard function
> > call
>=20
> This first i ssue should be fixed with this commit:
>=20
> =C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
?id=3D37f0dc2ec78af0c3f35dd05578763de059f6fe77
>=20
> > Issue 2
> > Trying to narrow this down.
> > 5.19 and higher (6.3 included), no longer support discard on the
> > Infinibox device and log this message so I cannot run the test for
> > the
> > discard issue
> >=20
> > [=C2=A0=C2=A0 35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> > 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> > [=C2=A0=C2=A0 64.810437] XFS (nvme1n1): mounting with "discard" option,=
 but
> > the
> > device does not support discard
> > [=C2=A0=C2=A0 64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f=
-18cc-
> > 4a26-894b-8b0f8d79a98a
> >=20
> > I then bisected between 5.18 and 5.19 to this commit
> >=20
> > 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit
>=20
>=20
> > commit 1a86924e4f464757546d7f7bdc469be237918395
> > Author: Tom Yan <tom.ty89@gmail.com>
> > Date:=C2=A0=C2=A0 Fri Apr 29 12:52:43 2022 +0800
> >=20
> > =C2=A0=C2=A0=C2=A0 nvme: fix interpretation of DMRSL
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 DMRSLl is in the unit of logical blocks, while
> > max_discard_sectors
> > is
> > =C2=A0=C2=A0=C2=A0 in the unit of "linux sector".
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Christoph Hellwig <hch@lst.de>
> >=20
> > =C2=A0drivers/nvme/host/core.c | 6 ++++--
> > =C2=A0drivers/nvme/host/nvme.h | 1 +
> > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> >=20
> > Note that Infindat mentioned this in our case they logged with us
> > They say they fully adhere to TP4040 MDTS.
> > Towards NVMe-oF 2.0 specification, TP4040=C2=A0 - Max Data Transfer for
> > non-
> > IO Commands (MDTS) was released with additional fields to control
> > these
> > parameters.
> > These parameters are supported in kernel versions 5.15 and above.=C2=A0
> > ****
> >=20
> > Our storage target will reply with 0 for bit 2 of the ONCS,
> > indicating
> > UNMAP is supported based on the DMRL, DMRSL, and DMSL values.=20
> > (older kernels will interpret these values as UNMAP NOT SUPPORTED)
> >=20
> >=20
> > Let me know your thoughts please. for both issues
>=20
> The commit you found unconditionally sets the discard queue limit to
> the
> reported DMRSL, so it sounds like your target is reporting DMRSL as
> '0'. Prior
> to that commit, we'd use that value only if it was non-zero. I hope
> that helps.
>=20



Hello Keith,
Many Thanks as always
I will inform Infinidat and have them figure this out.

Regards
Laurence

