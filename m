Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E3C001B2
	for <linux-block@archiver.kernel.org>; Sun, 11 Dec 2022 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLKJuX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Dec 2022 04:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLKJuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Dec 2022 04:50:22 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49411114F
        for <linux-block@vger.kernel.org>; Sun, 11 Dec 2022 01:50:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 82so6361281pgc.0
        for <linux-block@vger.kernel.org>; Sun, 11 Dec 2022 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
        b=PwZx72Aog3dMWak7X5RfDIKA0Stm9ImI03XPRB3S+OK2Lm094+5ABxaYH5mTN8ITc5
         0rkuCCeyg+P343biweU0dezATwKnk2bf1Z+2szM1asbufJO42JA5QLrD/7aW9moqEqh1
         J8psuIuFAqWpMvxZIs79Q5sQiBBP/MLRsufX+9mzb/85TVQSqLZs1m4jJbBw41PYdH63
         2sAISKQPJzZZyY6Vv26dVFhpDeoTf+OEEynL63DSXBk5gW0MhoguPc2C5t+d4r807v6d
         IZ8NDA6N6jz3XX613ndUDLeixIu12Z39o4LwE/lGUddlhukJ+k/leJpkPDBVdVgyvLVN
         LTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
        b=cSK/LZOM4CGkSyAX0eD3SiTgqaS95Yf16LvundhJATAOfksB3O6a/5A87zU8g9ue1s
         lIVRgct8XH3KVwwqezIKEzOmzG26sWBDrTj2imRarpefJBUgzC6j8N+CylIENLuHaln1
         LEZtZ01993bP0viR/9e2PA7/ztxqE49TCV3nkbkWpwSQU5zBMIoK6ex3XC5UcMZJoJ8r
         JypmUlAFmA688Oo7uL873N3fm+O6ldE29hHt1Lrv8gR3ppZJ49bjjVw68uVzz3iwpWRF
         cnyBRsHIEYIrMx0yeJF6lXg4Pb55xno/DTOCcTCNM22uSNnWxAeo6e6OZw3Q0sXv5Gr1
         G9+Q==
X-Gm-Message-State: ANoB5pnu5NhZkdhwACuM6R38NA0QKpL+Wu22DQDTGa/iWgEyBuV3T8MO
        XKO6Sh1KhKn/9GQdRcPoqy2d/CfYVKDATuukj2SuUA==
X-Google-Smtp-Source: AA0mqf6sTgZzExROP+3AcD990q4QofPnx+7w4Ve/p3V7twkuqcE/V+srS9ihCucVMYKxVIFQ4amS8gQqv9Gu8amMX4A=
X-Received: by 2002:a63:2226:0:b0:478:54e2:ecb1 with SMTP id
 i38-20020a632226000000b0047854e2ecb1mr37001807pgi.550.1670752221276; Sun, 11
 Dec 2022 01:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org> <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org> <20221207152116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221207152116-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Sun, 11 Dec 2022 11:49:44 +0200
Message-ID: <CAJs=3_Bu+tZqQk3JDzP0JfNbPZ8FG7mRNnPE9RrWUs8VOF=FzQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Alvaro could you pls explain the use-case? Christoph has doubts that
> it's useful. Do you have a device implementing this?

Our HW exposes virtio devices, virtio block included.
The block device backend can be a eMMC/uSD card.

The HW can report health values (power, temp, current, voltage) and I
thought that it would be nice to be able to report lifetime values as
well.
