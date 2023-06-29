Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7867DEB64D7
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 00:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjF2AFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF2AFg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 20:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13117183
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687997085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZs6dH4xlvJ918fhSCUdP0XfoUPZWo4ujkAmSZIqEjo=;
        b=PxRozCC8BRYdught8S5v2Q/HsWq6ShrkLoPlnPy5IPezUkIO3W1xP8Ls7X0gI/fbIuRJxn
        4PDm70SjHeOh7ZFSZ7nc4b6aOgumkKuU6vXoQG1hejSC7zm7QHUgaTRxIIukz8bg+OVyFz
        DUlQdTFe6pvxPuTkosgSyuAAIIuuUSs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-8mSCL5-DNXqVkE6q_FnhWA-1; Wed, 28 Jun 2023 20:04:43 -0400
X-MC-Unique: 8mSCL5-DNXqVkE6q_FnhWA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-262e7132c74so69039a91.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997082; x=1690589082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZs6dH4xlvJ918fhSCUdP0XfoUPZWo4ujkAmSZIqEjo=;
        b=hAxjDpk2j2Icva54XIBgOQNT+mzW/m2LHRp3uJ0PdIku7aHC+oQJVzB4ns6hgvG64r
         nQDbQPL4Zugu5qlc/FInqGmksrQXRnv9vTAqH9o+yeo2BqM1XTyZ97FhfLLjuHOcICeb
         IKOjBxZ9Xt+o9TE8utTG5W0HDcAyolpyCvlExNcITgWfPrsAgT8WTzbvdIOXhOatbFXC
         8GESlK7s0AKqN302ngFqkoT04eQAVgxtOI62U2WJtvQkuBMD4Fr31ORzNbKV6xceYr4O
         Q7VpQAgKutr3baKk+rqAYbIYHJkbDa0KXbtZCiV2tkkRO8Jmij7SuuXbb7Mvk3iQ/7x3
         LNzQ==
X-Gm-Message-State: AC+VfDxiPoACihj3E8xpzoay4ERCI7RVMr7WA6fIk+2B+pkFuQ8X7dFI
        W6gF8IW5+wXAFriWnL7v2AuXTWrtwNaThU3k8VjmjwvAA7ujgs+LylgH+KHaCxgn/EKIGkbYFHR
        x/qfY8sepqa+pF6xuUzxhw8j8CVm9fBajVrN6ETU=
X-Received: by 2002:a17:90a:2f47:b0:253:8260:f9aa with SMTP id s65-20020a17090a2f4700b002538260f9aamr23080555pjd.6.1687997082417;
        Wed, 28 Jun 2023 17:04:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KXhLUvdRsUvi62VC3VaMrwpwDO1+/Ophi+reiuJaWrVy5ZdnkYveON8wAp0ooDS1ngZtslasdOUdv2bmFDAY=
X-Received: by 2002:a17:90a:2f47:b0:253:8260:f9aa with SMTP id
 s65-20020a17090a2f4700b002538260f9aamr23080545pjd.6.1687997082135; Wed, 28
 Jun 2023 17:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com> <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com> <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me> <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me> <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <0ab5d195-549f-342f-8c92-b7f1a4ca2d26@nvidia.com>
In-Reply-To: <0ab5d195-549f-342f-8c92-b7f1a4ca2d26@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 29 Jun 2023 08:04:28 +0800
Message-ID: <CAHj4cs-_9NtBujvOY=F7EZfTu5SfFX+PUx3YGbGaZaj2Lg5h6g@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you all for the quick fix, I've verified the patch. :)

On Thu, Jun 29, 2023 at 6:06=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/28/2023 1:09 AM, Max Gurtovoy wrote:
> >
> >
> > On 28/06/2023 10:24, Sagi Grimberg wrote:
> >>
> >>>> Yi,
> >>>>
> >>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
> >>>>
> >>>
> >>> No, only one discovery.conf there.
> >>>
> >>> # ls /etc/nvme/
> >>> discovery.conf
> >>
> >> So the hostid is generated every time if it is not passed.
> >> We should probably revert the patch and add it back when
> >> blktests are passing.
> >
> > Seems like the patch is doing exactly what it should do - fix wrong
> > behavior of users that override hostid.
> > Can we fix the tests instead ?
>
> I didn't find anything wrong with the Max's patch and more importantly
> blktests are still passing on my setup where it has required files, but
> Yi doesn't have those file as stated above :-
>
> nvme (nvme-6.5) # ls -l /etc/nvme/
> total 12
> -rw-r--r--. 1 root root 183 Jan 23 23:58 discovery.conf
> -rw-r--r--. 1 root root  37 Mar 16  2022 hostid
> -rw-r--r--. 1 root root  12 Mar 17  2022 hostnqn
> nvme (nvme-6.5) #
>
> Let's not revert Max's patch and fix the blktests.
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang

