Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ADEB64DD
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGKD5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 23:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGKD4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 23:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA288172A
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689047728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
        b=e4PmIOL1gy8UHIdAbgiTUTJKgPJ52ZqbbsIsmcDPhHCCaKTBPBArSDpIvjnw9GpI7NUcDo
        FJg5Cd1v3uOT9OiLWfl/SWDVZK8XxpipmwPIx/CgzSw9/trApP2kZEI8wkRZAxi4udnuwG
        7XyF573aGl7U0ZbUaO791+EM3mp4gD4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-nyTTfR4nMTiRgCLYfiW41Q-1; Mon, 10 Jul 2023 23:55:27 -0400
X-MC-Unique: nyTTfR4nMTiRgCLYfiW41Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6355b301c9dso42211506d6.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 20:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047726; x=1691639726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I51Q3nKKNCTWEmMYUHL5yUr4E1b6ZzzA1zlm0zArZHo=;
        b=X5OS73VDk0Nu2qkxB4xmbPNzfi8vgYEtS+CL4H4CcoMWeyfi/f+ml8Oe6hPTQrfLJN
         lRhUIOQ1BDE+cukyjCeOHy3YsO2EKpu+7xMfhg+wuAmYHPdRusNs2VOeXF4LkdKFJ9EA
         RSoTbmKA9BqWwHkPGqUlN6UeUt0GcEGEIJiCz9Ne9pagZjKJY4CPDH5XsY154kGHGtcu
         tv1vkpDvX4CsJKYY/wdw8iWM2mM82vPn1Pz/B5UX90mVVJh8NXTkVPToRdbeLHPx8CcG
         mZYZzJZk7ECqYTDIY5gUw5un+ckxEouMbpVP2/VBnu21Ri3UC2DcRAX9SjVvrPqK7GV+
         jvZA==
X-Gm-Message-State: ABy/qLbprSG/Hs2RDbiOuy47Dp+GTdIz5cKhoCUXlF5aOHs/NSrpyycg
        Z1ubQ64WHEtEvU5FtFrDS3tllIB1m+LcMVJBScIZVvBAhdBqjWohX++0w+Z6tJS1m8DPXqB3Im9
        jOLzxWWRLunbT4ROFviJRup7hk4XG0lC3tv92lJw=
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id s5-20020a0c8d45000000b0062fec76f5b7mr11891455qvb.55.1689047726712;
        Mon, 10 Jul 2023 20:55:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTZhew2EUuIm724AKpM7YWVbIe48FZcuO2pasYKl7L1r04MF0dNfYfUrZnlan7BYQ6w00L0ejYouJH3uMuKwg=
X-Received: by 2002:a0c:8d45:0:b0:62f:ec76:f5b7 with SMTP id
 s5-20020a0c8d45000000b0062fec76f5b7mr11891446qvb.55.1689047726501; Mon, 10
 Jul 2023 20:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Tue, 11 Jul 2023 11:55:15 +0800
Message-ID: <CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 5:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > >
> > > Fix wrong queue mapping in case of kdump kernel.
> > >
> > > On arm and ppc64, 'maxcpus=3D1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> >
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
>

In fact, num_possible_cpus is not broken.

Quote from admin-guide/kernel-parameters.txt
       maxcpus=3D        [SMP] Maximum number of processors that an SMP ker=
nel
                       will bring up during bootup.  maxcpus=3Dn : n >=3D 0=
 limits
                       the kernel to bring up 'n' processors. Surely after
                       bootup you can bring up the other plugged cpu
by executing
                       "echo 1 > /sys/devices/system/cpu/cpuX/online".
So maxcpus
                       only takes effect during system bootup.
                       While n=3D0 is a special case, it is equivalent to "=
nosmp",
                       which also disables the IO APIC.

Here, as it explained, maxcpus only affects the bootup, later, extra
cpus can be online.

> That is documented in Documentation/admin-guide/kdump/kdump.rst.
>
> On arm and ppc64, 'maxcpus=3D1' is passed for kdump kernel, and "maxcpu=
=3D1"

On aarch64 and x86, nr_cpus=3D1 is used, while on ppc64, due to the
implementation, nr_cpus=3D1 can not be supported.


Thanks,

Pingfan

> simply keep one of CPU cores as online, and others as offline.
>
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=3D1' for
> kdump kernel.
>
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
>
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.
>
>
> Thanks,
> Ming
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

