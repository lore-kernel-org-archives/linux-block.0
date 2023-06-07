Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974AC7EE2E
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbjFGJmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbjFGJmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 05:42:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8CE10EA
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 02:42:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so1169513a12.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130971; x=1688722971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTSJC08M16dk7ac+qC1NLiFtaB9M/5yyS+Z15P92ssA=;
        b=T8ER5TNAg8z1wij3zxfOUWFCDItlghCiuUXhsaqzc4ZwLofamB8RtpTyQLSVJ9h2UJ
         K5p37hopSMXQsov3IbM/+pXTCPYzGIBfMzkaAwZATA27zGzqc2RsatdEeeSYzb8OJe7S
         EtKjbCR7ypq1BPl33V5iDYjnSNzEbZ8SSmlT2bsu8chvDUII0Eyuhqg1weJGkPNF54UA
         at62NLYWJFIfELcet832L35oN/vTBLLRmhbv4E6euKkZT5GIkiCfz/SvQVjjr0TSQFn4
         eMDgRORV7ULS7YCAm2XXby1mXqhN+JgUeFWJ6iq0dvTYt+w3IowjHJDt6ezXaXQ0V0f7
         BdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130971; x=1688722971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTSJC08M16dk7ac+qC1NLiFtaB9M/5yyS+Z15P92ssA=;
        b=LEp5qdq1W4EzaHpE3HryIBH89W5uLzQguYb6j53M5Nf0sQBSLeeEHcJZYFTNkg08Ve
         ejDKyg2YJGOAPwA5QL1XGBYYzb1CD8go0QLq7W3e7zRnVvwgxA0UUdD97AhsToCwQ6o7
         kB6txsmlAOnesTBjpzBJAncE8jqcAQKQUqfiCHxfmPmlb415H7crtqgI4H1fqzkYS05U
         Zit4hr0SHLN/1+nsNPlp97ZVEMuNUZEobeg8IudhxHDhjKeWtj9sXJk+3hPifZQl089Z
         pdsclsis2laFpkL4jdztYgRY2ptQ/fQNfoMa40Ygfaz67qJ/YzGGy9cQR0iNKVSA3IGu
         LNpw==
X-Gm-Message-State: AC+VfDyj3gBPpF3TfYkiuWrBJvW6PNVnQIHRfvEjYK76g/o+g9rivDjU
        PHni4XoVs61iHpMGAsmpCOpkWLOORHqSPKRwK//ggw==
X-Google-Smtp-Source: ACHHUZ5i8f5AUVXLioiA4Msh4foVuVuox1MKnFKi4fucw3rKEDDzkk1m6bVkvWRpki6Lz1RgGXGnv70bM2LGvyL4BxY=
X-Received: by 2002:aa7:cd55:0:b0:514:8e6f:7113 with SMTP id
 v21-20020aa7cd55000000b005148e6f7113mr3506396edw.22.1686130971195; Wed, 07
 Jun 2023 02:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-10-hch@lst.de>
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Jun 2023 11:42:40 +0200
Message-ID: <CAMGffEkKpHzatfeJhKtJQMTNckJGc7sJQ_LWFg-KvazvOD4DWw@mail.gmail.com>
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 6, 2023 at 9:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> ->open is only called on the whole device.  Make that explicit by
> passing a gendisk instead of the block_device.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/drivers/ubd_kern.c          |  5 ++---
>  arch/xtensa/platforms/iss/simdisk.c |  4 ++--
>  block/bdev.c                        |  2 +-
>  drivers/block/amiflop.c             |  8 ++++----
>  drivers/block/aoe/aoeblk.c          |  4 ++--
>  drivers/block/ataflop.c             | 16 +++++++--------
>  drivers/block/drbd/drbd_main.c      |  6 +++---
>  drivers/block/floppy.c              | 30 +++++++++++++++--------------
>  drivers/block/nbd.c                 |  8 ++++----
>  drivers/block/pktcdvd.c             |  6 +++---
>  drivers/block/rbd.c                 |  4 ++--
>  drivers/block/rnbd/rnbd-clt.c       |  4 ++--
Acked-by: Jack Wang <jinpu.wang@ionos.com> # for rnbd
