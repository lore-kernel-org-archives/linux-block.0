Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921BEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 04:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGKEG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 00:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKEGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 00:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EC188
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689048337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=e+Z9cLEzq+yZ4M+eUzzHl1G9CV6nL7emo9Qy+kzQciQ9BDP/ymVgNPUOLVUaaisUVpYQED
        w1yU5zwUEOTdjmAp/6m5g32Y33Y7I3hqd8PZhvt+mTJAExxHB9b2kVvZTUgl94LqRTxsoG
        JtaYX65U+J+9kvga/ayGgt4vfGpasAI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-xmW-sF_HPUC0N8f3mbBlpw-1; Tue, 11 Jul 2023 00:05:36 -0400
X-MC-Unique: xmW-sF_HPUC0N8f3mbBlpw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635dce11cb0so55382156d6.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 21:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048336; x=1691640336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=YCNw4TqS4x7VbJRn2kpcbrS/cr3YnvON66sjwlw5TXKwV9vAf6UQ8kbmDAA5vZvR+r
         aT7yL+/QIoQwz12wfCFHDaPydNo3Zc37CMoXf0f+1wRwa0hVkBp5FZFS6xdMjSLIp+Po
         +w/m6JTRTTQJjHry1AFMsogCRB+hnWKn8+XMmHr0ra5JHBL96bWXu38jiu/9jFqIn8ew
         JUc4B8yIjCpvpzTVIShuheJliGrn0INaKrMRxZTbCCs3jyW7p4iJlf6ENt0xDSnPRorG
         1VcJXKWHumwfdpgwJH0FJKSU44HPtl+P9sqsxjKYZNnfCLJU80Rmn7na72VfY+mewa6/
         r2kw==
X-Gm-Message-State: ABy/qLbr8j7icRl8JBPney/RrVALcZ0XmB0L2ipdYfSC+o7d2ickHf/e
        tvCKtse9uK6XvM0SdcGCSdOs76qLgDyjQrupjkvujDwtPtGuUHSt27uTRnSe2a1mF6FgULRQkc3
        zRxn3u1yGcwX6KaRYXrDTP0GTIRixlMo4ySNROcc=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id d13-20020a0ce44d000000b0062def66ff1cmr12076658qvm.24.1689048335875;
        Mon, 10 Jul 2023 21:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGTtnbv4lplqsuwMA0lcF/2QRhbSnqCLDEDGVhD6GZ6v3vRL7xgj3ixm6UdOxJvERNjVYrT8Aw+QUQlev+2Ls=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id
 d13-20020a0ce44d000000b0062def66ff1cmr12076645qvm.24.1689048335643; Mon, 10
 Jul 2023 21:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Tue, 11 Jul 2023 12:05:24 +0800
Message-ID: <CAF+s44T5Hn5ikNq+YMp2Nucb6rBT=e4VHW8WN8YDhZHe9JmqGw@mail.gmail.com>
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

Hi Ming,

Having no [PATCH 1/2] blk-mq: add blk_mq_max_nr_hw_queues() in inbox.
So I reply here.

At first glance, I think that  the cpu hot plug callback hook should
be the remedy for the newly introduced blk_mq_max_nr_hw_queues(),
although it is more complicated.

Consider the scene where nr_cpus=3D4, which can speed up the dumping
process, the blk_mq_max_nr_hw_queues() can not utilize the other three
cpus.


Thanks,

Pingfan

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
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
>
> On arm and ppc64, 'maxcpus=3D1' is passed for kdump kernel, and "maxcpu=
=3D1"
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

