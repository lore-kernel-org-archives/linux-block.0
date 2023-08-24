Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33192C6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 17:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjHXRaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbjHXRaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 13:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902719B5
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692898162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XerZVYsBLsupyuldcAk3XlFkDauckeYXrIqkefabl0=;
        b=MjS/eGTJF2FW2YKovk2U2v7JiEOONxfRi24lrJyBoWkMxjOFHRnU+DLYeMW94iXEMLkWTW
        8OFAFq7MbgzqaUWiEhwklHDOhPEu10V24hnXr6ebZxqoT9+QXC6b8a6voLFW2prQruYHGz
        KikiKgO7eIwMs19K1+/qwt/6z1X6Zzo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-vnv-85RANx2Li9PR-ZKzZQ-1; Thu, 24 Aug 2023 13:29:20 -0400
X-MC-Unique: vnv-85RANx2Li9PR-ZKzZQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d74c58a3dd7so109342276.0
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 10:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898160; x=1693502960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XerZVYsBLsupyuldcAk3XlFkDauckeYXrIqkefabl0=;
        b=JYt/lBkY3JmoR+jnKooOzXwcgvfDxVXprLrM5w05QpradaytR4PTYZu6rUo8rzh+R4
         BQjwYoSkN7pINU9c900kRV3u5MOfDReAMdFF/XG98T8l2t5LonYcQmtOSw+qNxuLQa52
         Vp+RhQ6mDB/U6GPmulBY1jz3NFHkjTKGntgNnC6ReJJEaDNyhucYCqUcaXNnWaA3M2H9
         ROYTTV9n0K1han9/q023aghoGKRI4WaHZAJYNqUGdkDQ109ur4K3hbTXwKBnDCj3eDY8
         Y3Z/P2ArZC+yw6HLKKW+bsn0QHnUgmH92A39BF53AWtdhRXr/RFJvyoL03+lR84Uovuw
         /fYw==
X-Gm-Message-State: AOJu0YzgZHaG648mlzl4eUhk8BwA+6/9MlwqWqzRd99gw1mkrqDj+Bdl
        Ovl+NFrEpQ5UdfdF/0zBofr0PCEfK/Am4mxgkbpn5c25r+wXqlyJD2ptDnva1jNkVlcEI5w6dM0
        s0C6W5eTzX+zW2HccQY+l52r5YBB0s+s=
X-Received: by 2002:a0d:cc4f:0:b0:589:9717:22c7 with SMTP id o76-20020a0dcc4f000000b00589971722c7mr17360000ywd.22.1692898158390;
        Thu, 24 Aug 2023 10:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmeYlMkCNuo+7CDeTB21G5NrpqS/me37OKLf0uCIlrBJBWE2Vt23KkjQHGOtx0lr1+0c0weg==
X-Received: by 2002:a0d:cc4f:0:b0:589:9717:22c7 with SMTP id o76-20020a0dcc4f000000b00589971722c7mr17359897ywd.22.1692898156657;
        Thu, 24 Aug 2023 10:29:16 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id v20-20020a814814000000b00586ba973bddsm3828ywa.110.2023.08.24.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 10:29:16 -0700 (PDT)
Message-ID: <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
Subject: Re: LVM kernel lockup scenario during lvcreate
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 24 Aug 2023 13:29:14 -0400
In-Reply-To: <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
         <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2023-06-12 at 11:40 -0700, Bart Van Assche wrote:
> On 6/9/23 00:29, Jaco Kroon wrote:
> > I'm attaching dmesg -T and ps axf.=C2=A0 dmesg in particular may provid=
e
> > clues as it provides a number of stack traces indicating stalling
> > at
> > IO time.
> >=20
> > Once this has triggered, even commands such as "lvs" goes into
> > uninterruptable wait, I unfortunately didn't test "dmsetup ls" now
> > and triggered a reboot already (system needs to be up).
>=20
> To me the call traces suggest that an I/O request got stuck.=20
> Unfortunately call traces are not sufficient to identify the root
> cause=20
> in case I/O gets stuck. Has debugfs been mounted? If so, how about=20
> dumping the contents of /sys/kernel/debug/block/ into a tar file
> after=20
> the lockup has been reproduced and sharing that information?
>=20
> tar -czf- -C /sys/kernel/debug/block . >block.tgz
>=20
> Thanks,
>=20
> Bart.
>=20

One I am aware of is this
commit 106397376c0369fcc01c58dd189ff925a2724a57
Author: David Jeffery <djeffery@redhat.com>

Can we try get a vmcore (assuming its not a secure site)

Add these to /etc/sysctl.conf

kernel.panic_on_io_nmi =3D 1
kernel.panic_on_unrecovered_nmi =3D 1
kernel.unknown_nmi_panic =3D 1

Run sysctl -p
Ensure kdump is running and can capture a vmcore

When it locks up again
send an NMI via the SuperMicro Web Managemnt interface

Share the vmcore, or we can have you capture some specifics from it to
triage.

Thanks
Laurence


