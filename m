Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D90BC433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 14:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiEOOSl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEOOSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 10:18:38 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D028708
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 07:18:37 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id n6so8880449ili.7
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwphx9wPck/NWDydkQSNjs3FWUdXMzvmbDaM8Jlp77U=;
        b=ZmAnnDA9H2j4V9dYUAsU30Uy67C/xmE4iP+514u8omU4efKrK1HXw5YORsilvGJDhy
         BABuSXc/GHC4pvlSmeY/goB9ne+T3c34nCVYwQo4eJvG7p4V+oIkIGghmEUE3eRiTxOK
         jU93BZPc9ktzWdbxB0tY+Qw46lfFrMgkL4XcwstSb+jEUWloSz2Z8nhiWfFAEdo1HYFJ
         wekYx3P94h0tED7CLJh3TDbFzncLjOpQ/otsDwKCjIdCxlskN45nz0S6wdjPMf9Hvcqi
         qXNKsUSObPZPS8rGD3wWK99bIZ1/mkJ8B/nsV0TbQDTTThkguKxpsGVcQ1dzUXq6elRV
         LhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwphx9wPck/NWDydkQSNjs3FWUdXMzvmbDaM8Jlp77U=;
        b=oTh4RhtHeIK4ypSVVZoU5y0t9BZ0CI0xRrRiD9kg+iwV0Nd4sITrDEM47H1oxIZLgI
         AsOnSBAECK7uw3GmJ7od+AJjXBCOEsSmvrBD2Ix9qM0St3Q90cx/JvGx119RMnpSOL1E
         hwYqnNTV94NpfPLcSVB8DaiqnhvUY3o4BtsfG3r4uGicREErEK8GWnNr7Nut6Pz8vmsM
         AJNYeXJqFsVdb5BWu1FBiKa1GvlHPeKHmL2D0hduz/x8RmQPmlw54IbcPdbOBRc2XgUX
         VAatMXSe6b95eiEEzK9KuZ7Z5dSxC/BLdrKruYNhr2hE/zMDq8Msu4DMUaknXptecLBV
         3yqw==
X-Gm-Message-State: AOAM533q+X8eK2FOvCmw8cxto0JDeE2IUgdPMnBpbMTSSWSqF98hUzmN
        ps9glzFiuU4xt+XaT4S3n0/RoqyQj2YCxUFjpYZqQK3nuX0=
X-Google-Smtp-Source: ABdhPJxN3hka7ZtE/3qhzeZq7hHbIfuFb+85A4AFy1z7NNMomt8YTAPVNcb7EojVa82ptQIu8hhpKdaWJOux2YZroLY=
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id
 j13-20020a92ca0d000000b002cf3bb8f1a5mr7098836ils.152.1652624316810; Sun, 15
 May 2022 07:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <87o80awgq4.fsf@vostro.rath.org> <4295e767-2f3a-476e-b4c5-99814f879b9c@www.fastmail.com>
In-Reply-To: <4295e767-2f3a-476e-b4c5-99814f879b9c@www.fastmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 10:18:26 -0400
Message-ID: <CAEzrpqfEp9Kt7HhH3_PGES8-v663uEaVWGAdT+m4JVMYN0CBsA@mail.gmail.com>
Subject: Re: How to safely disconnect NBD device
To:     Nikolaus Rath <Nikolaus@rath.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 15, 2022 at 7:36 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hi Josef,
>
> Would you be able to help with the question below?
>
> If I understand linux/MAINTAINERS correctly, then you're currently taking core of the NBD kernel-code?
>
> Best,
> -Nikolaus
>
> On Fri, 6 May 2022, at 21:25, Nikolaus Rath wrote:
> > $ nbd-client localhost /dev/nbd1 && mkfs.ext4 /dev/nbd1 && nbd-client -d
> > /dev/nbd1
> >
> > Frequently gives me errors like this:
> >
> > May 02 15:20:50 vostro.rath.org kernel: nbd1: detected capacity change
> > from 0 to 52428800
> > May 02 15:20:50 vostro.rath.org kernel: block nbd1: NBD_DISCONNECT
> > May 02 15:20:50 vostro.rath.org kernel: block nbd1: Disconnected due to
> > user request.
> > May 02 15:20:50 vostro.rath.org kernel: block nbd1: shutting down
> > sockets
> > May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 776
> > op 0x0:(READ) flags 0x80700 phys_seg 29 prio class 0
> > May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 776
> > op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > May 02 15:20:50 vostro.rath.org kernel: Buffer I/O error on dev nbd1,
> > logical block 97, async page read
> > May 02 15:20:50 vostro.rath.org kernel: block nbd1: Attempted send on
> > invalid socket
> > May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 0
> > op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> > May 02 15:20:50 vostro.rath.org kernel: block nbd1: Attempted send on
> > invalid socket
> > May 02 15:20:50 vostro.rath.org kernel: I/O error, dev nbd1, sector 0
> > op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> >
> > To me, this looks as if the kernel is shutting down the NBD connection
> > while there are still active requests and/or while there is still dirty
> > data that needs to be flushed.
> >
> > Is this expected behavior?
> >
> > If so, what is the recommended way to *safely* disconnect an NBD device?
>

Normally this happens because systemd/udev have rules to go and
trigger a scan of devices when they are closed after being opened with
O_EXCL.  mkfs.ext4 should be doing the correct thing and fsync()'ing,
so all of it's stuff should be flushed. the WRITE's are disconcerting,
I'd expect the READ's for sure.  I'd recommend pulling out bpftrace or
something similar to figure out who is issuing WRITE's after the mkfs.

Unfortunately there's nothing for NBD to do here, there's no way for
it to predict what requests may come in.  It should be waiting for all
outstanding requests, but new requests coming in will just get EIO.
Thanks,

Josef
