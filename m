Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC90C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDPPko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 11:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295C2D4A
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681659597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvt+olLf5Ke4NxMJElJ2Y/2pEXoH3+QAPeuiL1K7VLs=;
        b=JCCbcgMh1jL0JTTVIg2TNDnkwv6PjCE3dLHuPh2frW+aOj6SnpPmGxpDGiWpS0m/Rjbu0M
        iBIx7pAZYm+WsjruOUpvGCd+BiT3/iYlxqwA95oCooPXNJWCYKtn//036VG6a/zrWjnV1Q
        M8SYeHEPC32DmGHMImtLqIt29dHH41g=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-cMSYmc7oO5WcNtaEGUYTGA-1; Sun, 16 Apr 2023 11:39:56 -0400
X-MC-Unique: cMSYmc7oO5WcNtaEGUYTGA-1
Received: by mail-ua1-f70.google.com with SMTP id y22-20020ab05616000000b00771f717cc16so5431027uaa.9
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 08:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681659595; x=1684251595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvt+olLf5Ke4NxMJElJ2Y/2pEXoH3+QAPeuiL1K7VLs=;
        b=Hd5LrTZJBq0drcGOei0dF+JWUXHhSrLydPWncuyoBTcG0sH6RNQjZgF8VxJtC2h/PK
         liijiXFtfCUNJWCM0QPwtCDOMaUYpd/MfNg1KCEYyAhk5EjIJYqq7oJPTs1bDZBZMY9z
         kjhCSykOISZ2qbuCYQhvhOMkdv8jcItRPQEFoMh57SOa2ObDQ7l4hc/ioidtUO+crceT
         UK1NeVuDLaciL9FqZ/vnFUIQQB0g1RMHjlaUfjqGQ6yrUZS5upSyGFGge7O5SH7ZfMOI
         joCej1Tf4VA0z3EwkWm+3KkkBswna+/cHuJ6WUihvdXig8tpJhJTMT4xn1PumLG3c1pb
         Xr5g==
X-Gm-Message-State: AAQBX9f5GGltB1TJ9fPqgU5Cvw6SsFigu1psvM82HLJ2Av2D5NMCM1xq
        jgCftOzAW5B205ElYhiEXaNiZTgkD7A16UQaGnmfVOG/TQCz+q7BGZ7uOu5YCqSSv3pGKYC1T9c
        OcqNiEmGCsigM5TtejJo7HAjKi8UdboDGhGzONdo=
X-Received: by 2002:ab0:1053:0:b0:772:1ae2:306 with SMTP id g19-20020ab01053000000b007721ae20306mr6949849uab.0.1681659595595;
        Sun, 16 Apr 2023 08:39:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZS7AHzbBsFlcneMPkEbqFCRqIiziYLLbI1lQr8zTYziMhn0Y68D82t/jHt+yrc+cemovA4fSMmm5ep+q1OgvE=
X-Received: by 2002:ab0:1053:0:b0:772:1ae2:306 with SMTP id
 g19-20020ab01053000000b007721ae20306mr6949839uab.0.1681659595324; Sun, 16 Apr
 2023 08:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230407083722.2090706-1-ming.lei@redhat.com>
In-Reply-To: <20230407083722.2090706-1-ming.lei@redhat.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sun, 16 Apr 2023 23:39:44 +0800
Message-ID: <CAFj5m9KcRgvY+4Doe8BP8wL1-P+v93ZSJuPrOac_CC8f+ar12w@mail.gmail.com>
Subject: Re: [PATCH] block: ublk: switch to ioctl command encoding
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens and Guys,

On Fri, Apr 7, 2023 at 4:37=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> All ublk commands(control, IO) should have taken ioctl command encoding
> from the beginning, unfortunately we didn't do that way, and it could be
> one lesson learnt from ublk driver.
>
> So switch to ioctl command encoding now, we still support commends
> encoded in old way, but they become legacy definition. And new command
> should take ioctl encoding.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Ping...

Thanks,

