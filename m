Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10ECC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB7F218FD
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlkjghAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfABPZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:25:57 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:39170 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfABPZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 10:25:57 -0500
Received: by mail-vs1-f50.google.com with SMTP id h78so19043684vsi.6
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2sc271/HPic9mR/9B+RX6kT7UZorH79geI2fFDy8rYY=;
        b=FlkjghAl8o845v6hY+cWucixph81sppZZZzf1nSvjf9gyZsc8LdAck0E/x1F/9JOUC
         zO9PmPE2e8/C7sjY7uX1xe7YWEB5GyuvQDZjNUhldijXOPlyAfIp4S4xVN9/9YZgQull
         GEPAAXnwqjJCHhA6i6htFXNBQSV9kSrkhzO1H4D3HR87zka2SuydqYD8JNr8ZrFZnrVf
         8qC4jujCU95I2dmJNKe5MDnLwifLthNMzKoneuXwbtLF+dees5ovyM8VzX527Vkx2Y4U
         RWRX7LPyG8FRTK23ZCGEowx9klE5fMdrP6qxqpzr8I0GYiya0EMXXI1nJskMji0lpWSJ
         HT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2sc271/HPic9mR/9B+RX6kT7UZorH79geI2fFDy8rYY=;
        b=nP7rBma98ppiB8afpFYiNZ4KIBfhBV1zOkvoU6hsxVEV9neEiOfAJMIYRJnz87/LNt
         GGmNrnKBiZWOLpl1Fh5uN2lvPD7NfYkMYklQF+ddIkFhgDzG2VdermQ2OUXUr6k9CBZP
         zbPwBRb52ky+Bzve7TZoplH7k8P8awUX5kJqooJFbFj4Spf6criv1fXL4rWHfBEB3Ih0
         CpGzu1fDRHGk7Eo84Ywl7vCqPbwaJ0fvRwwmN4uQRHw2P0O6Pcc+EtCFFX4zyFvXXBhD
         QNHooskKLXeZEXee/Q8Tvzxnbg6UEpM9/u/E4M98gl2YLY48NycZXLEPsxhLj0Rxl7zI
         t6gg==
X-Gm-Message-State: AA+aEWZZ62RKCWlQZqTDqrig6Z4vpuyj5ZCYUE2319+rZ/ljxLf1BnK9
        G1ru7E8pXIm9M30aHq1WEglhpm73R1uOErARzNnZ5T3f
X-Google-Smtp-Source: AFSGD/VKrWC1DHuvTM3X2wS0JeNnQjQaUnEhcVXCw5AfKy2PKOPXj+2Pc/UgJ0P+iVYSIaoT55Sbl9NjlqUHzHLcYDA=
X-Received: by 2002:a67:8513:: with SMTP id h19mr17153354vsd.91.1546442754505;
 Wed, 02 Jan 2019 07:25:54 -0800 (PST)
MIME-Version: 1.0
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Wed, 2 Jan 2019 15:25:35 +0000
Message-ID: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
Subject: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I recently purchased a SATA Samsung 860 EVO SSD and put it in an old
HP microserver (which has an AMD N36L). By default, when the disk load
becomes a little heavy e.g. by running a job like

fio --name=test --readonly --rw=randread --filename /dev/sdb --bs=32k \
    --ioengine=libaio --iodepth=32 --direct=1 --runtime=10m --time_based=1

the kernel starts repeatedly producing error messages like:

[ 1177.729912] ata2.00: exception Emask 0x10 SAct 0x3c000 SErr 0x0
action 0x6 frozen
[ 1177.729931] ata2.00: irq_stat 0x08000000, interface fatal error
[ 1177.729943] ata2.00: failed command: WRITE FPDMA QUEUED
[ 1177.729962] ata2.00: cmd 61/80:70:80:50:e6/06:00:00:00:00/40 tag 14
ncq dma 851968 out
[ 1177.729962]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[ 1177.729978] ata2.00: status: { DRDY }
[ 1177.729986] ata2.00: failed command: WRITE FPDMA QUEUED
[ 1177.730002] ata2.00: cmd 61/00:78:00:57:e6/03:00:00:00:00/40 tag 15
ncq dma 393216 out
[ 1177.730002]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[ 1177.730017] ata2.00: status: { DRDY }
[ 1177.730024] ata2.00: failed command: WRITE FPDMA QUEUED
[ 1177.730039] ata2.00: cmd 61/00:80:00:5a:e6/05:00:00:00:00/40 tag 16
ncq dma 655360 out
[ 1177.730039]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[ 1177.730053] ata2.00: status: { DRDY }
[ 1177.730060] ata2.00: failed command: WRITE FPDMA QUEUED
[ 1177.730078] ata2.00: cmd 61/00:88:00:5f:e6/01:00:00:00:00/40 tag 17
ncq dma 131072 out
[ 1177.730078]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[ 1177.730096] ata2.00: status: { DRDY }
[ 1177.730108] ata2: hard resetting link
[ 1178.205831] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1178.206165] ata2.00: supports DRM functions and may not be fully accessible
[ 1178.209743] ata2.00: supports DRM functions and may not be fully accessible
[ 1178.212786] ata2.00: configured for UDMA/133
[ 1178.212826] ata2: EH complete
[ 1178.212988] ata2.00: Enabling discard_zeroes_data

I tried moving the SSD to another caddy and bay but the issue
persists. None of the regular hard disks (a Western Digital and a
Seagate) nor the other SSD (a Crucial MX500) already in the system
trigger the issue the Samsung 860 EVO does. Adding

libata.force=2.00:noncq

seems to make the issue go away but seemingly at some speed cost (at
least compared to what the MX500 achieves). The OS in use is Ubuntu
18.04 with a 4.15.0-43-generic kernel but even a 4.18.0-13-generic had
the same issue.

Is there anything software-wise that might need investigating that
would allow NCQ to work and a better speed to be reached?

-- 
Sitsofe | http://sucs.org/~sits/
