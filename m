Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A687C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A614208E4
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iy7/oaDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeL0Vbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:31:39 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:34053 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeL0Vbj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 16:31:39 -0500
Received: by mail-wm1-f53.google.com with SMTP id y185so24828333wmd.1
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 13:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kGrqOub0tTP4H0YSlAG61QiLz8n8Wr+BbzDwfcsaZFM=;
        b=iy7/oaDEiwKiq/nAS6s09TFXcLZY/iivWCfbeiwe7myC5lSd0tXaBhed4FQN/sOXWt
         DpJTEFTdM90NyaJ9dzUQGiJ9qYlfEr/nAcifAXNqBLz7HSaOD4P29tMP5wSlD+G9GWwl
         yolMVmdJjlDBvJzgiwrhBCUklzDBqsitIlL5YnrKaAV7qVfOzweFcK5gSpCN72OCw6Xc
         7Kl/2oFZiINwOWtLmoxAJU/F3srSpawk8Jk2EAEgPJ8NpDapgtk/pYSXDJ1mViHud8q2
         DMlOzhJuGSZPdpWrs7cathAOddaIGIRNZ3t9eTPKIFeIDdcdSM7wUSrgPfB+5yEtmInz
         sBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kGrqOub0tTP4H0YSlAG61QiLz8n8Wr+BbzDwfcsaZFM=;
        b=KKhTrywaMXdNNP57uXtX2TkWMmmxvHqPTW66Y8Mo7fHry2A5/b47Mprhz9RtX8BCRd
         kqQiCnhj42YQPzYVXq/8WVaPBdPTWZlKTkMXqHK0NfW+3V4PjeUu1N3dB4/JzVavAK9o
         AfLo+8mJxFQvVynxwsxH3Cp/DwjJ2pUwdjCbN9OGGI5GsSLrr81lDtJHErfkIpUtJT4E
         ytC0m14EXj6ISoL7sxjpMadd2im/gyHkGA4a3vH4O6npAQistYbzIWXLPWt9hLAvrn5l
         0CPsKK5pIM7ASR0ZsBNtUxyxqBeb0fPqJcTrWDxpYP93mHN0EhbSSTJGOc20+9O2pe30
         3RZA==
X-Gm-Message-State: AJcUukdFKoF4lvzXbSmT3ZUxq9LXUxrmV71deSzyuZogcfcHxXCutT1c
        kdeABOCUMUq75eXHf6j9mlIkaAzef7xzYfUMzOWbw99pkFA=
X-Google-Smtp-Source: AFSGD/VFeK/UggnDgvSXnOhqjIE7PdemTQLKdBJOLWkfG799Yb1QIJQNnheJbSyOpkZiUXyu962+7DibTvj/hLHro0Q=
X-Received: by 2002:a1c:7306:: with SMTP id d6mr21647227wmb.98.1545946296722;
 Thu, 27 Dec 2018 13:31:36 -0800 (PST)
MIME-Version: 1.0
From:   Kieran Kunhya <kieran618@googlemail.com>
Date:   Thu, 27 Dec 2018 21:31:24 +0000
Message-ID: <CABGuwEk4NhAKeCDMsH4cZbeTySO67+q=Z6GJ2Jrq0MvKUc8fqA@mail.gmail.com>
Subject: DMA memory from block layer vs pci_alloc_consistent
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I=E2=80=99ve been reverse engineering Sony SxS memory cards, which are simp=
le
PCIe based block devices. I am able to read successfully from the
device with DMA memory allocated using pci_alloc_consistent and
memcpying to the buffer the block device layer provides.

But if I use the dma_addr_t provided by the block device DMA layer, I
get a soft lockup. Is there something special about the dma_addr_t
that comes from the block layer? Is there anything I need to do to it
before passing it to the hardware.

The device=E2=80=99s block size is 2048, the block layer reads two blocks a=
t a time.

Memcpy code is here:
https://github.com/kierank/sxs-linux/blob/master/sxs.c#L98

DMA code is here:
https://github.com/kierank/sxs-linux/blob/dma/sxs.c#L101

Apologies for the untidiness of the code, it=E2=80=99s entirely reverse eng=
ineered.
Any help would be appreciated.

Kieran
