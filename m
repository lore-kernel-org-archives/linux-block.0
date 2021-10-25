Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D383860F92
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 15:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJYP2q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbhJYP2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 11:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635175583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Ze5UCBhxMpT7T/pRDyBuqgguA4zqOiqNjYEOTfZR2s=;
        b=BjlUNq3IXyanpsUwnL327gcS8eGNbcK3v/Ql/O8MLFkL3tWOAn4eW/J+INkw38NoBXsd+S
        D8ocY/RB7f1t2rjBXZiNyLHrrme0wh6rpHvhN+KWKXkNabzQ/8O0iAhiBkW6vh5Y11N8+Y
        zGc9CdQGoPQiqAAdjlhohRLKjOEnOzY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-2OFLsgbBPaOmGe54vwRZjA-1; Mon, 25 Oct 2021 11:26:21 -0400
X-MC-Unique: 2OFLsgbBPaOmGe54vwRZjA-1
Received: by mail-yb1-f200.google.com with SMTP id a20-20020a25ae14000000b005c1961310aeso1755978ybj.3
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6Ze5UCBhxMpT7T/pRDyBuqgguA4zqOiqNjYEOTfZR2s=;
        b=PppSefkSjbUGYkoGiqGoVuyCPnm2+AHlU7AsrQa+VSZgrWlMAedX5+b/t1JA2rs5bF
         xug3Ar0lyGaO37T3Tff6pK3ztVxzHd3Q2UMt92T+judfK1yE5JqzWiDSxOYK5wCw7JKe
         nfBxMYN6pAQrcLfOtQsV5k4eP2SjGM7crBCf8Okv/b1zweHBTonPhM3t//2AZaaMATAG
         Ae5q3Y2VvFQHerj2ZJVZ95JXGxvxmzdQ4FIfZA53pGqKpKg705Az2QXX5Q7kNJf16syj
         L90YrYO63HQnoaVqvBfek1UoBhxzX49WW8KuNMzAEE8qeTZKnjhRQwolNO4j1LfsVPAd
         N3YQ==
X-Gm-Message-State: AOAM532AbQNoogvFswnGpZYVJGvFCpgbdYgFQUgo+43s505D3iB/tKiQ
        GqQJ8I+iguuNDqCSlkFX4Ye/mIsmOVtstBHHVraj5JrZ9ZctMm8dUZmlmanY3UNHx8ZlHldoSRH
        5/wGv4sQ40KBK7j8UFmnlNweMDZ0qT2Yp+wvuYEM=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr18683525ybl.308.1635175581241;
        Mon, 25 Oct 2021 08:26:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrjjycNOBcOI51nm4aeKSnQwR7pnuCBCDU08WPs0XCzI9HX3T+hPICwRL9iJsiDV7GYNUwmoibpl43Ov7bwDc=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr18683493ybl.308.1635175580954;
 Mon, 25 Oct 2021 08:26:20 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 25 Oct 2021 23:26:10 +0800
Message-ID: <CAHj4cs-Q7eLbrch63sQozd5p6jt2CaJLy2wywDNWA0=fUGHREQ@mail.gmail.com>
Subject: [bug report] Compiling failed on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens
Compiling the latest linux-block/for-next failed, pls check below log:

ca20d946ed42 (HEAD, origin/for-next, for-next) Merge branch
'for-5.16/block' into for-next
fa5fa8ec6077 block: refactor bio_iov_bvec_set()
54a88eb838d3 block: add single bio async direct IO helper

[root@fedora kernel]# make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CHK     include/generated/compile.h
  CHK     kernel/kheaders_data.tar.xz
  CC      block/fops.o
block/fops.c: In function =E2=80=98blkdev_bio_end_io_async=E2=80=99:
block/fops.c:321:9: error: too many arguments to function =E2=80=98iocb->ki=
_complete=E2=80=99
  321 |         iocb->ki_complete(iocb, ret, 0);
      |         ^~~~
make[1]: *** [scripts/Makefile.build:277: block/fops.o] Error 1
make: *** [Makefile:1869: block] Error 2


--=20
Best Regards,
  Yi Zhang

