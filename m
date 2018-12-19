Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA083C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7B21873
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKchAHwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeLSKcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:32:46 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36819 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLSKcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 05:32:46 -0500
Received: by mail-wm1-f51.google.com with SMTP id p6so5543968wmc.1
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOVr8F17cwKDn5P2cN2PetFc/LaJMmUgsrmuYwGhjn0=;
        b=MKchAHwlgHZL67xNv3fkvcRZG2ylcUp3qY+B/tSwwDqYkauMFv0BpWla/tbic3GBGQ
         MTAfie52jOcsxWiXwqLuyu3eOKLJcebJhHHv2TUgpfLrHcK2kRXSJNd27VyvxxMyUAu3
         DmyuGCoHK+o1xWmIY2R657j++BZHjbenCe5xXyULRlDwc7FN+sbYe38x0UnJ8oQVxRHC
         HXQCqxlKGamLT6RlXpeVgP9gK3/pwBnlUezKFbef38hN/tnVjsctEQetXqK/QxYyUxbU
         CQFUFufnEsyBVCJ8d9jGrqJsg+4t/1sN4/zc1L/aFAiveEci6+I4mLx3KMwIRpFS1teh
         grIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOVr8F17cwKDn5P2cN2PetFc/LaJMmUgsrmuYwGhjn0=;
        b=ZzvxvShdHFim3n++majMsp6pF5rRklNubfKTKymsTckc/bZ8ydcmWADz9WMaOu1zz3
         zSCnGDFUasFDJCBCRMn5Bo+xLz1Qy8koa61VLuIkbppPg4/OdLkVnCPyDnV6LBw1cpKW
         Yy4FG0aq1R3xefYU7yyNQAssjXyfprYe9vk4VOdalhVMjJ9+tZ4HIgKTa3vWFI5R3i34
         8Tf7iH61lPd+T8lDUvsIj8UsJ7Xn0qc1su6+YTxZGB8lrULppoYoHhnog/v91SMbubMw
         DNZ7Ustog9PquxFUcYqjjrfMFsan28mLTT7v3e61FpPWHZIznGnsZifcdax2bEAXUc6a
         GELw==
X-Gm-Message-State: AA+aEWZucjj+BTZXNm/8dUZRYyq/AVsAbL5jiTbxXaFknb5seGAJjwO9
        DIdPw16MevH9DoBicOIQsaF+SiIs4nP56FWGvT8=
X-Google-Smtp-Source: AFSGD/XIOD1V8vYbT5yA8on88cod1tQd5u9NEf4Kyaj9twnazklvTeILCl4i3Qbi6mgY1y+wrdsEMWfZyyqUSFqY9Oc=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr6322249wml.61.1545215564064;
 Wed, 19 Dec 2018 02:32:44 -0800 (PST)
MIME-Version: 1.0
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
 <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk> <CACVXFVML3ZJ0ezsRBC6T_6zbJHqXRFXVQJxVhsK9spKEfgKipQ@mail.gmail.com>
 <80B060E9-48E9-45D3-9456-64E94947F048@linaro.org>
In-Reply-To: <80B060E9-48E9-45D3-9456-64E94947F048@linaro.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 19 Dec 2018 18:32:31 +0800
Message-ID: <CACVXFVO1ZE_8e=DDBanm8id+=672BOs5nt6AJtnztt48GZ1vnw@mail.gmail.com>
Subject: Re: confusion about nr of pending I/O requests
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 2:18 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
>
>
> > Il giorno 19 dic 2018, alle ore 04:45, Ming Lei <tom.leiming@gmail.com> ha scritto:
> >
> > On Wed, Dec 19, 2018 at 2:52 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 12/18/18 5:45 AM, Paolo Valente wrote:
> >>> Hi Jens,
> >>> sorry for the following silly question, but maybe you can solve very
> >>> quickly a doubt for which I'd spend much more time investigating.
> >>>
> >>> While doing some tests with scsi_debug, I've just seen that (at least)
> >>> with direct I/O, the maximum number of pending I/O requests (at least
> >>> in the I/O schedulers) is equal, unexpectedly, to the queue depth of
> >>> the drive and not to
> >>> /sys/block/<dev>/queue/nr_requests
> >>>
> >>> For example, after:
> >>>
> >>> sudo modprobe scsi_debug max_queue=4
> >>>
> >>> and with fio executed as follows:
> >>>
> >>> job: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=20
> >>>
> >>> I get this periodic trace, where four insertions are followed by four
> >>> completions, and so on, till the end of the I/O.  This trace is taken
> >>> with none, but the result is the same with bfq.
> >>>
> >>>             fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 + 8 [fio]
> >>>          <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 + 8 [0]
> >>>             fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 + 8 [fio]
> >>>             fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 + 8 [fio]
> >>>          <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 + 8 [0]
> >>>          <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 + 8 [0]
> >>>
> >>> Shouldn't the total number of pending requests reach
> >>> /sys/block/<dev>/queue/nr_requests ?
> >>>
> >>> The latter is of course equal to 8.
> >>
> >> With a scheduler, the depth is what the scheduler provides. You cannot
> >> exceed the hardware queue depth in any situation. You just have 8
> >> requests available for scheduling, with a max of 4 being inflight on
> >> the device side.
> >>
> >> If both were 4, for instance, then you would have nothing to schedule
> >> with, as all of them could reside on the hardware side. That's why
> >> the scheduler defaults to twice the hardware queue depth.
> >
> > The default twice to hw queue depth might not be reasonable for multi LUN.
> >
> > Maybe it should be set twice of sdev->queue_depth for SCSI or
> > hw queue depth/hctx->nr_active.  But either way may become complicated
> > because both can be adjusted runtime.
> >
>
> Could you please explain why it is not working (if it is not working)
> in my example, where there should be only one LUN?

I didn't say it isn't working, and I mean it isn't perfect.

The hardware queue depth is host-wide, that means it is shared by all LUNs.
Of course, lots of LUNs may be attached to one single HBA. You can setup
this setting via 'modprobe scsi_debug max_luns=16 max_queue=4' easily,
then all 4 LUNs share the 4 tags.

Thanks,
Ming Lei
