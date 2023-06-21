Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79EEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 08:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFUI5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFUI45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 04:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10251BD2
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687337656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUeqDc8Opf0qvxHmjDxn90zahKMQD9aZkovKepPjZUA=;
        b=Q7/CSyeT4WR3bdYqNom6ky5d8RcqAzy6ZcemN1tV55YP4DlVQJssHwzmRxDmG97JXzgbsq
        GYQoTD+QHFfH1w7TVUgBS0WaRAr1nkXaD0x1ioBriFZ0whJs0ndbdB7+yA+iJkTIOeqiO8
        SOPz0JvnrfSuGR1m08Y/5fz5AaQsoE8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-gf-aTU8TOyabm0jY6WYf-g-1; Wed, 21 Jun 2023 04:54:14 -0400
X-MC-Unique: gf-aTU8TOyabm0jY6WYf-g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25e81d23fe8so2480096a91.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 01:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337653; x=1689929653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUeqDc8Opf0qvxHmjDxn90zahKMQD9aZkovKepPjZUA=;
        b=U46VT4XBATCEKpOS5nsSra1gAYHvXoIRHRgp4L2mu2PiDa5O/OzDFCA2suKAhk9+l5
         a/LaElqrCF+xOQ8azB80zp7cceokvuWjv8CuUs3U4alKpvz5048pUAlafvWhuYzoT6Wr
         hrH84n56HSPZCNIih8akQp6K3cqNF9VRwsIjO3kEPb5fFZDXIlTwOZt/MfobE0fnb1J5
         UnMDZDzdaWJy56EC/oO0PqV3tYQoys6hmH3ebMWuvp0LAne2wjGDoC0xmQllZv6lGs8D
         gxfUHu3YQ8ryfBfMGatC3YIQM3aEIajcktmq1sidJv/3jqGlLacpRgS/O+Ai+Y7/Iamd
         FsPQ==
X-Gm-Message-State: AC+VfDzbJd2U1PIW+ozAJksURrER0lZAvYVA7Uhl5z91xbEtN6ImGjnX
        qwntelH9IRv8bz044+Iqkz3zWOgE8l8XzZSO5X053oufzeKUvONJdduxsvTY5DEA/+hLUPK72xD
        ldOm+dnDdDF/rhpf6WHIligvbIVd9XbiOz88V19BmJ8USw2yRrg==
X-Received: by 2002:a17:90a:7892:b0:259:d0f2:3576 with SMTP id x18-20020a17090a789200b00259d0f23576mr11216612pjk.19.1687337653361;
        Wed, 21 Jun 2023 01:54:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7s0sLYCC/Kgqb7IWgIG55HJgxMIIJsmoaEG2Fbph6Xt57Pt6Zp55wzkhsMm/ccLZ7/a7Zo7dBbpJj7EFn7JHs=
X-Received: by 2002:a17:90a:7892:b0:259:d0f2:3576 with SMTP id
 x18-20020a17090a789200b00259d0f23576mr11216605pjk.19.1687337653084; Wed, 21
 Jun 2023 01:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052405.305871-1-song@kernel.org> <CALTww2-f7vSXugM0kMMMG==YgmDOEqSLk+vLf2U_ZyprDKk2+w@mail.gmail.com>
 <2909cd3b-7716-a0ae-1ced-b5c78b0573da@huaweicloud.com>
In-Reply-To: <2909cd3b-7716-a0ae-1ced-b5c78b0573da@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 21 Jun 2023 16:54:01 +0800
Message-ID: <CALTww2_3E2eTCEb86GrK1cdmUsesuNPNFJgf4nPf=RFKmecgBw@mail.gmail.com>
Subject: Re: [PATCH] md: use mddev->external to select holder in export_rdev()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 4:21=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/21 16:10, Xiao Ni =E5=86=99=E9=81=93:
> > Hi Song
> >
> > After applying your patch, there are still warning messages in the
> > calltrace. It looks like a deadlock. The test case is
> > 10ddf-fail-stop-readd.
> >
> > [  381.825307] INFO: task md126_raid1:1896 blocked for more than 122 se=
conds.
> > [  381.825722]       Tainted: G           OE      6.4.0-rc2+ #1
> > [  381.826626] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  381.827080] task:md126_raid1     state:D stack:0     pid:1896
> > ppid:2      flags:0x00004000
> > [  381.827864] Call Trace:
> > [  381.828013]  <TASK>
> > [  381.828514]  __schedule+0x2ad/0x7c0
> > [  381.829126]  schedule+0x5a/0xd0
> > [  381.829733]  schedule_preempt_disabled+0x11/0x20
> > [  381.830396]  __mutex_lock+0x5c8/0xcc0
>
> Looks like this is the same deadlock that should be fixed by following
> patch:
>
> https://lore.kernel.org/linux-raid/20230621142933.1395629-1-yukuai1@huawe=
icloud.com/
>
> Thanks,
> Kuai

After applying these two patches, the warning messages disappear.

Regards
Xiao

