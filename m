Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89EC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 15:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiG0PSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiG0PSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 11:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D82523C17F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658935097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zNiorTCLm4VG9xV7UIsqxW6pYr2Ej5URNUrjbcD5N+w=;
        b=iqWj9Zsj2N3HDVelQhED/e2wQF2S+Qm9iuXk5HmIE6oEBI6XvopCBtX8kFMH6Bd7myds51
        BnZmYBH+Ot1X8EACfslWbqkLHvB9nEWa73B8fFm1GIBUAwyAn1T/9ExCzeb+J9GIdBkarm
        JrE/72VvbPJlKd3hPXdq3OFgkapnMCM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-QkXdULTDNhm4JH32LRnpVQ-1; Wed, 27 Jul 2022 11:18:16 -0400
X-MC-Unique: QkXdULTDNhm4JH32LRnpVQ-1
Received: by mail-ej1-f72.google.com with SMTP id hr24-20020a1709073f9800b0072b57c28438so5202390ejc.5
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zNiorTCLm4VG9xV7UIsqxW6pYr2Ej5URNUrjbcD5N+w=;
        b=TYNWuJ9iHTv88Akcz4vRZ0gvHV9uw+yG5X4hFayBHduh7DwFCKg+SXayvUDFM9Ktm8
         F4bgmkrVv0FkNXGKUvLixy4fFoZgrCiKNCAGbsIsvTyEVLPfA8jkMCSQpo2hHq4CiQ6P
         jNVjVKcmjy7R9orwErzqqLnRCRrWIv87w1n85SzYQWAHa5ebIGa8y8vOrPnUkmsXcvnm
         zj1N0bpqFWVKGrGVkyj5rlTWccLBKbQFwStEH3hU6ao9RUWNlP333flhTLClTDOg/533
         3GugXZJh1ftx59kT1M4hH8BRxJh8wRyJBv/HSspMXpa4XLmL1SdFvhhhSqMGr2Xd3QDq
         cyWQ==
X-Gm-Message-State: AJIora+8UXZayD7rczmBivHO/lx+w5G0SDckD0QL2A4q7m7xtEX3zq8g
        UG1qIKgGV89Tu/Gd3cWMv2CKcSnpbmD456VaJlXuhn+DAIBuk+JtSSO/mMWVG44vdJYEPF2Fy18
        nG1azbeGfo6HUUsd4ooeqwpBdEi3dlk2y9elET3U=
X-Received: by 2002:a17:907:7294:b0:72b:1ae:9c47 with SMTP id dt20-20020a170907729400b0072b01ae9c47mr18031589ejc.253.1658935095111;
        Wed, 27 Jul 2022 08:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sb5N9U4hxiykhkcUJnITJLHSgpFhJSO0k4SNo7JUJ6blbtOasOTDkgXZ4zUHmEgFyb+GrB8vD0uw/VK5hoez8=
X-Received: by 2002:a17:907:7294:b0:72b:1ae:9c47 with SMTP id
 dt20-20020a170907729400b0072b01ae9c47mr18031575ejc.253.1658935094793; Wed, 27
 Jul 2022 08:18:14 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 27 Jul 2022 23:18:03 +0800
Message-ID: <CAHj4cs8HjT6T8VCZtWzB1DzqHqcqex+bV6vdh2MdVwqNP9GH=A@mail.gmail.com>
Subject: [bug report] compiling error with latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found below compiling error[2] on latest linux-block/for-next[1],
pls check it.

[1]
b8b914c06a6f (HEAD, origin/for-next) Merge branch
'for-5.20/drivers-post' into for-next

[2]
In file included from ./include/linux/export.h:33,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:17,
                 from io_uring/notif.c:1:
io_uring/notif.c: In function =E2=80=98io_alloc_notif=E2=80=99:
io_uring/notif.c:52:23: error: implicit declaration of function
=E2=80=98io_alloc_req_refill=E2=80=99; did you mean =E2=80=98io_rsrc_refs_r=
efill=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
   52 |         if (unlikely(!io_alloc_req_refill(ctx)))
      |                       ^~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:45: note: in definition of macro =E2=80=98unl=
ikely=E2=80=99
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
  CC      kernel/trace/trace_seq.o
  CC      drivers/mfd/stmpe.o
io_uring/notif.c:54:17: error: implicit declaration of function
=E2=80=98io_alloc_req=E2=80=99; did you mean =E2=80=98xa_alloc_irq=E2=80=99=
?
[-Werror=3Dimplicit-function-declaration]
   54 |         notif =3D io_alloc_req(ctx);
      |                 ^~~~~~~~~~~~
      |                 xa_alloc_irq
io_uring/notif.c:54:15: warning: assignment to =E2=80=98struct io_kiocb *=
=E2=80=99
from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
[-Wint-conversion]
   54 |         notif =3D io_alloc_req(ctx);
      |               ^



--=20
Best Regards,
  Yi Zhang

