Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55FFC3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750F3221F4
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DmTEDWoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTGwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTGwH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 02:52:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB20C061A0F
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:52:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f19so9752897iog.5
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTN0Etd0QTtHC3Kctw5TWjwXgkC2NCT+z5h45jcHEk8=;
        b=DmTEDWoy6i0eg5b5thUjJAPi+1glCHhNgT+5DBnICfH09z8YyOh+OBIPc7lzOp87/V
         9lK4E9FThQ6nCIJETkFhWM9Z96kL/nJPM9ylaXJHgjIYPDD/2hgF3QvqPLwFdVCQ1BN1
         IBBwAViqBqxrfU/OgxKOL9D3H+3FGKrIONBV34Y0CJ5XrkKzE/SXRORnEr/XUmc3ggKl
         2eV9Jt3gDHOMiMzNlEWQ2cQyA7UcDgsdsCGpG3i4wxCvO3nh5XYGFLLZJDGsTO82ewzL
         Sfo1zksetBajEpfxgRIljvzs6/e/aP68IzVjC/O3iEVWiy4YcvT4LMgxpfQ4W/aihoq0
         4vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTN0Etd0QTtHC3Kctw5TWjwXgkC2NCT+z5h45jcHEk8=;
        b=LqSxThmW9DcC5o+XuOOeqvRuFOGadkZdQjtoeSfnxZ9kd9OySflnAnCjskEAodi6w7
         B97zqT8PJMrLtjiEfkQhCL4+tk+MDB3h/6yM43AMvHkEr02eybeeJS36zaKLrvIwJOZP
         LuTdILInUF5z7kXp2Grbp+MiTzQfKq7ucAq7Dg3lMK/v/Vd+JnSmDP8WWQjWZA42oUiV
         WYHBCzOA5o/8lOIv4CgfqzzOtOtNTz6fIpOWS5w6n7fteOGl/LelPU/4v4VYRj8Hxei/
         fRJSVsWceMhtraSZQz75aZytmcl3bZTrgv8z2VcTKe9AgYVtPVHrkGOEUPSBOLmj9aqJ
         AzkA==
X-Gm-Message-State: AGi0PuaIQriy3RO0+QSoGrp87sDEyeQK8J9uwO8aLdXhJFh6PhR6NnON
        +hCYM0uc5LdkBBYwA/r8g7L37tdrPV70IM0r5TBDnw==
X-Google-Smtp-Source: APiQypJGCkxSnfUi8KAmaAvFO0CCmdGyo88P4nt/FXTGFk5sNs2abAl+GIV0wh3fIg+Rb44MSCcCeU9ZjcbFwW8Sy2U=
X-Received: by 2002:a02:710c:: with SMTP id n12mr14528166jac.85.1587365526810;
 Sun, 19 Apr 2020 23:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-17-danil.kipnis@cloud.ionos.com> <5fdaf1c6-1445-79af-9b1f-3c1bd9b9536a@acm.org>
In-Reply-To: <5fdaf1c6-1445-79af-9b1f-3c1bd9b9536a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:51:58 +0200
Message-ID: <CAMGffEkRJRFFO21nntkeJHE5BOon9GMdR7XnnxxRMacHh6FfMQ@mail.gmail.com>
Subject: Re: [PATCH v12 16/25] block/rnbd: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This header describes main structs and functions used by rnbd-client
> > module, mainly for managing RNBD sessions and mapped block devices,
> > creating and destroying sysfs entries.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
