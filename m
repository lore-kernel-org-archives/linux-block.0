Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77071C433E3
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56489207D3
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 10:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GcyRcfEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETKMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 06:12:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87817C061A0F
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 03:12:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so2513762wrt.9
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBcqQ8zxIDDNjlNpFLw9XT6VQWod6ur15qrla/UFJIM=;
        b=GcyRcfEjdfbUfF8SYp6YXFCUiSmHxZEnby3pNjehHWcDBnLM95xiIR946clqhMIo8v
         q+v5u3uDiDhe8BwtjxlihKWI+8U1pWzeM5cAq/iINiMV6zxZz02aD80JLlLBqtdpOr6i
         wADkaP6IfmQ9s+UGfWXE0NcUcb45UtiO5o1CH2/VfQs3ReRWTB16/pQ8rSpnVwBHlAHS
         u7oV2A5AJ6a62eVFO4EYeZjkfGG4F2rfUpPXPh7KKl/I8GnbAZyKp3mlRc5DePAyoJ6s
         uGDQT5aedJV3pbX0QlcaREnlFnSIG4Dm0ONnZ4ppugikoVr/9w451geilvvnMm3tREOk
         0PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBcqQ8zxIDDNjlNpFLw9XT6VQWod6ur15qrla/UFJIM=;
        b=HzrZ0D4NrW+RP0AYnarsbThG7pB2MugbhQOx9zXgxdlEjdznBOOCjUholXvdFeV3FX
         g4RJVjSsqqMYtf4N5RL//Y6MBQEYBkYWN53/SjPeJ+0hoRAld1fyPELZDTKPyvNK4J9d
         bMwOZZIm0VIL5UPz0wpfcNzXDQcoswkJ/yulClLVUnWQ5yCvyOXIKI/s15oDmWovkNZ1
         3tlinWGp5GbrkyXlxtVnvQb1sWK8bZueu6EQ1iJKT/dhRJumfuw7nsnnIY0/sX6yPSOt
         NQFUrHWeCHiWq/+nzKh9d4KPGg+MVlFNWxXvutf/uzP1GTknSomPo4GanNEVc9vkFDvi
         VSCQ==
X-Gm-Message-State: AOAM533BDGQBe6svWxwfDX46SrqOh1UKxonIsAQVKdUw6rHjm0q1DOFE
        3uM82ro3wkvKY+USwwaiXZt9Av5w2M0GcvpT0AY4
X-Google-Smtp-Source: ABdhPJypgX0CYZ1BPyRbnRWRWfBgtSJZTe/P5PsSECo15WsGXB6uu7WRt6MROF7Juxl784icOyfURtWML4iF6b7GMoM=
X-Received: by 2002:adf:cc81:: with SMTP id p1mr3338025wrj.192.1589969538224;
 Wed, 20 May 2020 03:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200520040354.3e619918@canb.auug.org.au> <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
In-Reply-To: <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 20 May 2020 12:12:07 +0200
Message-ID: <CAHg0Huww=oyj0DSuLSKOrJp5vtG_2xLLqM27MAHWNJdLWNeB3A@mail.gmail.com>
Subject: Re: linux-next: Tree for May 19 (block/rnbd/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Randy,

On Tue, May 19, 2020 at 8:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/19/20 11:03 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: there will be no linux-next release tomorrow.
> >
> > Changes since 20200518:
> >
>
> seen on i386:
>
> when CONFIG_MODULES is not set/enabled:
>
> ../drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_remove_dev_symlink':
> ../drivers/block/rnbd/rnbd-clt-sysfs.c:435:39: error: implicit declaration of function 'module_is_live'; did you mean 'module_driver'? [-Werror=implicit-function-declaration]
>   if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
>                                        ^~~~~~~~~~~~~~
>                                        module_driver
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Looking into this, thank you
