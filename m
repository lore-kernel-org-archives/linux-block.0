Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC4C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 06:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjDZGIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbjDZGIc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 02:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AC35A0
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682489236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnUvJChPglJT6Eco3hbvGH9Lo6nmr4nS6X6JvDkrsew=;
        b=bRu6gv6R0LG5FPsmTxijKad2ne6/jrHjSCTHMYRWZJUdbhe6MPQyXShYp8mQ1KLH+ceI0o
        de1gag4wvtxiuuvAIP3u99oAUOLeZj0xr/+jK77w1fqTVSdI3asTU6y73rqXnns2jnmgAH
        hWqMSqQHDYIxUdA8FCceKnUBiO8/kv4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-JvOdmDUgOPKq9xCkaJn_ZQ-1; Wed, 26 Apr 2023 02:07:11 -0400
X-MC-Unique: JvOdmDUgOPKq9xCkaJn_ZQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355c9028so719474466b.3
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682489229; x=1685081229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnUvJChPglJT6Eco3hbvGH9Lo6nmr4nS6X6JvDkrsew=;
        b=hPrYxYby/7Szti1HFgMGuLIBCtcUYoROeR5iCjjyfzPEgA1fojRW27bD3gfYz9AV9J
         5DgociueGSWdhVDfGopt7gk54UZqfHfJ55zcDnFgPGeWcOGTU6pg+pjosLYUXkhojUWP
         fV8ZdE1lQojgxciNUHDlHWI/XBpniHD1+PJs2vP7LtgIZlYje1FpozEp97U4Q/DLSe3S
         UpjrxREIAv5bDmdzUk82BxOJABqRngCTNd+ykzQqg8sngDSfB9sYe/nO684wfzTHaCSz
         iSxWjU4eJoDV9udIBh7LiqGK25eJEvmw8KLdJf6YOoLAVRLJWjgVSrHSkWiGG8ou68vn
         HrmQ==
X-Gm-Message-State: AAQBX9e8DL3RgeoqTNiibo5D9QWTy/jFshatwI5UpDfnqH5hy40mmmeP
        hAa3B67zbrP7x0FZnsTAmPWnvkLyW/z89h2qnufQtmuBUbkZm/VnH+VHoUMqq+oR0iych5haELN
        PCRnYaG0SMyD0BtMzrIxufaq+4aawIc1hNKIHpo4xpthymFylloVkLJo=
X-Received: by 2002:a17:907:3a07:b0:94f:9acc:65c9 with SMTP id fb7-20020a1709073a0700b0094f9acc65c9mr12665200ejc.66.1682489229774;
        Tue, 25 Apr 2023 23:07:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTLNeGE4UYjcdNb22cc5DfV2xVPHRJzhIgpoeyjNH6vGx2qxtSVsX+Hz3lgVeogGUxndp20UidHbHpqrls+xo=
X-Received: by 2002:a17:907:3a07:b0:94f:9acc:65c9 with SMTP id
 fb7-20020a1709073a0700b0094f9acc65c9mr12665184ejc.66.1682489229403; Tue, 25
 Apr 2023 23:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Xk025Sv-GJDRKcnhaQe0e2TonDK9zwGhWxX2KWd017+g@mail.gmail.com>
 <ZEdJYotr4ynP8we6@ovpn-8-24.pek2.redhat.com>
In-Reply-To: <ZEdJYotr4ynP8we6@ovpn-8-24.pek2.redhat.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 26 Apr 2023 14:06:57 +0800
Message-ID: <CAGVVp+V=kvbzs2pPqjdzOJ8JHT-P8f3EEEwJ4YzeOipLNMZFNQ@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718 remove_proc_entry+0x192/0x1a0
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 25, 2023 at 11:31=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Changhui,
>
> On Tue, Apr 25, 2023 at 11:15:49AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > Below issue was triggered in blktests/001 test,please help check it.
> > branch: for-6.4/block
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >
> > [  304.049316] ------------[ cut here ]------------
> > [  304.050033] remove_proc_entry: removing non-empty directory
> > 'scsi/scsi_debug', leaking at least '12'
> > [  304.050569] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718
> > remove_proc_entry+0x192/0x1a0
>
> This one should have been fixed by Bart's patch:
>
> https://lore.kernel.org/linux-scsi/20230307214428.3703498-1-bvanassche@ac=
m.org/
>
>
> Thanks,
> Ming
>

Hi=EF=BC=8CMing

after applying Bart's patch, the blktests/001 test pass,it avoid the
WARNING info.

Thanks=EF=BC=8C

