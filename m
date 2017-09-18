Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:56853 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbdIRNrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2017 09:47:16 -0400
Received: by mail-it0-f46.google.com with SMTP id g18so953060itg.5
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 06:47:16 -0700 (PDT)
MIME-Version: 1.0
From: Tony Yang <yyt168@gmail.com>
Date: Mon, 18 Sep 2017 21:47:15 +0800
Message-ID: <CADL4p-rjo2DisDwRP5YFDDMZS-GrP3fKijGSmp26Uqa+BACB6A@mail.gmail.com>
Subject: compile nvme not find bi_disk
To: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dear All

  I'm compiling nvme, but encountered the following error, how can I
solve it? Thanks

 CHK     include/generated/compile.h
  CC [M]  drivers/nvme/host/core.o
drivers/nvme/host/core.c: In function =E2=80=98__nvme_submit_user_cmd=E2=80=
=99:
drivers/nvme/host/core.c:631: error: =E2=80=98struct bio=E2=80=99 has no me=
mber named =E2=80=98bi_disk=E2=80=99
make[3]: *** [drivers/nvme/host/core.o] Error 1
make[2]: *** [drivers/nvme/host] Error 2
make[1]: *** [drivers/nvme] Error 2
make: *** [drivers] Error 2
[root@cescel03 nvme-nvme-4.13]# bi_disk
