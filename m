Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC12C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A3F2064A
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlbxGbJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfGNFeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:34:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42976 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfGNFeG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 01:34:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so12405339qtm.9;
        Sat, 13 Jul 2019 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcxZa3PK4xaiIgro1FXc0ErVGK5s8PduFW4m6QbB2jM=;
        b=SlbxGbJOjQfVtrx5ZyUuVmFB18tMvPtSLoImo3Ut9GDM1BShR8Mml77e/RyfWvvSO4
         z4Ns0H/nsjAAQjLaSU19OH4Twe/XVoooY6ejAMauOXbGQvzAcq2xyhbnEkBB7vcNpzq7
         10RTBWk8JxyZVLns8jRWT7w1Rvyar4XQtnZvQbOtgjV3tSytVeCzxxXsCW3eBSavEf5l
         W8XXzmlXXN9iwdoPr8r15Y6sf2uwBXi4k2r0SkLR9OgOupkSNDZ03xW8ChxnQqf+U8or
         6HdyhHFZlKGIVoPZharDx9155a+aNxnXzRBYWTgDtxNqkTw/HDCB739+Muz9N8hkFImi
         EDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcxZa3PK4xaiIgro1FXc0ErVGK5s8PduFW4m6QbB2jM=;
        b=HkXzWIoMblTb54onu5yKzU8WJ65hoczzBMfqaPnanm94w7EUWIggQTP8d84Sr9xBRb
         0ekb+/0mkf+eGqO71maYq7ep02D4Sic+HCOdw3URpoVjic3NPJNUOO7/+Z9mBJbLH5Z0
         T1220tMpvcdBvamk0t/bInnvmiRjopzht/qUOfy5UUZdEuk/LmvOg+B0ltA5SkRDMfQD
         NEI3obouLqii+ocTWfZFD5LE+RO1K0zzf504fc1/Jhujw3FuL/qR4NcZ6r0GlReLhwUu
         dpfiiK/XzlWH5ujMIayCMTgafkmIfYT1OcpeCGnX8urX62R7JtmNlZLNUkNqksgtiCQW
         0c7w==
X-Gm-Message-State: APjAAAUOc65AVRzFF6jVwh1EVV0DkuLtv+rV2YD18+rqdYE4YxVWvklv
        lGrZ9d8+UdU4K0EKaivyzc6qQTBzh7c=
X-Google-Smtp-Source: APXvYqxQMHuYzUllXWtp8bAfXQKxoCq4/t/Qi6Naf7Nno+oY5FVfNNhualk2ElwmMqOH9V7fB/K2rA==
X-Received: by 2002:a0c:a8d2:: with SMTP id h18mr13794451qvc.16.1563082445155;
        Sat, 13 Jul 2019 22:34:05 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id f133sm6308808qke.62.2019.07.13.22.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:34:04 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/4] Remove elevator kernel parameter
Date:   Sun, 14 Jul 2019 02:34:49 -0300
Message-Id: <20190714053453.1655-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the first patch sent[1], together with some background from Jens[2], this
patchset aims to remove completely elevator kernel parameter, since it is not
being used since blk-mq was set by default.

Along with elevator code, some documentation was also updated to remove elevator
references.

Please review, thanks.

[1]: https://lkml.org/lkml/2019/7/12/1008
[2]: https://lkml.org/lkml/2019/7/13/232

Marcos Paulo de Souza (4):
  block: elevator.c: Remove now unused elevator= argument
  kernel-parameters.txt: Remove elevator argument
  Documenation: switching-sched: Remove notes about elevator argument
  Documentation:kernel-per-CPU-kthreads.txt: Remove reference to
    elevator=

 Documentation/admin-guide/kernel-parameters.txt |  6 ------
 Documentation/block/switching-sched.txt         |  4 ----
 Documentation/kernel-per-CPU-kthreads.txt       |  8 +++-----
 block/elevator.c                                | 14 --------------
 4 files changed, 3 insertions(+), 29 deletions(-)

-- 
2.22.0

