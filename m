Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E0C2BA16
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 03:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7821A206A3
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 03:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abEzYmoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDEDJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:09:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34289 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDEDJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 23:09:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id i186so3676451qke.1
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 20:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5l5djp15fhqmaw1ZUF9zv9d+4qcfAeGGd97wUsov/go=;
        b=abEzYmoHlGY3SHCbH3EHAzU2Oe6zPIk03fqtl1OIgxcM+4gb+oAw/ljzPoa/WEaCgZ
         O16OXnY4GpBb4sQ7Q+9ETrrwjy1GcwA1fQvsg9ZfEr40wT60FQAYZ9p1lu0aB4XgQTKW
         1m7l5mq19D+VzpOZI5uO6nRHjQ0qZsRbF13EN/uL1iZvlKSLi27t3HeEOYIPTorGm6+N
         A3El/WkdbmYtst6c6CqhOcqiEtx0kiYWTf+0IZZaQ/5cX6eibk+2fnSw/2AUOw5s5nDm
         hKrcbgHdNp37MaBoCT8kBUjpnxnpUAWNLrjSMvXaTRJsckoQpvW99zpspdOGW3rL2zix
         Pfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5l5djp15fhqmaw1ZUF9zv9d+4qcfAeGGd97wUsov/go=;
        b=cgJEppFon21XrsgUNvmw6Vv24xWrkl6JZMdwVNI8sraUtds2WLWFubkL98S3SC59qp
         8/bIM1PnU0dJ3R9ItfXspfFdRh8A8X7gMx1k6LZNyAzAxhUtnolnAVC34Z8NDwoNFYJt
         bLFRPY/lbLA8KxR/SVE54xKNY1pLWIzrR/wUlGzGgMPXYCeZYkhB4C0yamfeG2CMkR8t
         TpewfZeqyyrwX0Yi3bM288xFGkUAWiozTGGUGQ4tA5Zn2EJGIbDJF6aisZMcFyWu8Hjf
         pV7gDfWd5eFNHL2CoWZMZGI+gPFpJEFJvfPex0QO355rs4QXlCmE6uRb9l65L/Vffw7V
         MINg==
X-Gm-Message-State: AGi0PuYTv5/y5B5qhQhD6XR51mQ7n/13j9R69tBBWtMgM68WQNTi0OdU
        7DGAgn33It+IJoS42zxoritZkQjHF6UUCLpcMVho+57o
X-Google-Smtp-Source: APiQypJ6L4IWhRIHcImrZhnKKeZQxh37gbLyFu78k9cfmuVTtqeX5+qKbpl864VLd/9KS3I+nPr0SpoQUdskg/OR0LE=
X-Received: by 2002:a37:e115:: with SMTP id c21mr15411756qkm.249.1586056140420;
 Sat, 04 Apr 2020 20:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586006904.git.zhangweiping@didiglobal.com>
 <9818e6d277f88df0e40948c580b38316750c626f.1586006904.git.zhangweiping@didiglobal.com>
 <d08d0ecd-c12e-8b39-bb9c-45df0b8bad13@acm.org>
In-Reply-To: <d08d0ecd-c12e-8b39-bb9c-45df0b8bad13@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 5 Apr 2020 11:08:49 +0800
Message-ID: <CAA70yB4Q8AHmL3=wnbSVgNpdowJc36R6aM+k_1jxH1FvDpO+Vg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] block: alloc map and request for new hardware queue
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2020=E5=B9=B44=E6=9C=885=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8810:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2020-04-04 06:36, Weiping Zhang wrote:
> > Alloc new map and request for new hardware queue when increse
>   ^^^^^                                                 ^^^^^^^
>   allocate?                                            increasing the?
> > hardware queue count. Before this patch, it will show a
> [ ... ]
> > Reproduce script:
> >
> > nr=3D$(expr `cat /sys/block/nvme0n1/device/queue_count` - 1)
> > echo $nr > /sys/module/nvme/parameters/write_queues
> > echo 1 > /sys/block/nvme0n1/device/reset_controller
> > dd if=3D/dev/nvme0n1 of=3D/dev/null bs=3D4K count=3D1
>
> Can this be converted in a blktests test?
>
It's ok, add it to blktest latter,
> Otherwise this patch looks good to me, hence:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks
