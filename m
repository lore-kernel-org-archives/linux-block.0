Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E2C10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9220693
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwteLQdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfDRShn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:37:43 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:35472 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389757AbfDRShn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 14:37:43 -0400
Received: by mail-qt1-f175.google.com with SMTP id h39so3265135qte.2
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=STJkyaIjzZOnylWmChU6MjAWkvyJjy9lWlWcjt6Tlds=;
        b=kwteLQdy9K5FZFEEDYf1/9Saka0d4DqD0meIXIuK6dYu3HlUbguNnjCuHOR7jBM4HW
         oT4XhmtdTjRex5mysnVrjFhczIXe29t/+6tAZRT67cOIN42dt3USBYhi5EbNjox8eoUy
         +ykFnRi+5aOZCZl9VdIoDXB1m6iXox5BfkB5+9d0Hwuqw/NRRnk8TGJitk2/uCGH38HC
         +tCKBFRR0rLqKw2xeOkfkAlQ4Jpkdc94fR/p4wJH5tBQZLbReEFUpLY3BF/78YlqRbcT
         rvG8LRQlyTZIReYyrs4X9FBjuLecJSY67QDsRX7HGL1UcT6vVOHtJxGiG8NM1lXCR4YR
         d28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=STJkyaIjzZOnylWmChU6MjAWkvyJjy9lWlWcjt6Tlds=;
        b=mOBW3fRFUT61VZ8f5OSFUaHiMynLtmknTamQsjQZxi63EfKmzYPvc/y7iLJCSupn+u
         2ui8B5KAOlP0LdWi4nJZPQDWuSyVEsioSaZ9ZtFu6n1C9nWjy/OuJJBK+HAjN85ICZX4
         UQV89y9sFClHV1HOMQ04Mn+qM5DJQ2+vMJcPGtwHV5bYDcaVnIdMRgsLsa9erg02C0pU
         1BU9bpd/q+D8P6U3KiEQyeGzJ1kPo2d1IMdUwiOHwLl95mzfCssDNoP0RQiUvYZnxVkI
         DT24H1UPW8OmfK4KsjDPmY6tPwMI0WpdOphgVERR879obWlz19kko1UBxiZRM575SqcP
         FMVg==
X-Gm-Message-State: APjAAAU2EvwPLXrSQegoQNMGz1GjW3XlfKbn2c8M3ovXSB+u1uMsfHvR
        xguX3OWAVbYN52rgB+KXUJ+WpnziGq69pCf/4aupQajcyXU=
X-Google-Smtp-Source: APXvYqxCTA9HbvKRCCwdHYTsSAndiZ3YvaFmEzuhnKU4is2Gf8eq2TVNWfwEyRlEjqKkmoMmuQD5tmPZwhFg3v1n0zE=
X-Received: by 2002:a0c:96eb:: with SMTP id b40mr76223036qvd.131.1555612662107;
 Thu, 18 Apr 2019 11:37:42 -0700 (PDT)
MIME-Version: 1.0
From:   David Ford <firefighterblu3@gmail.com>
Date:   Thu, 18 Apr 2019 14:37:31 -0400
Message-ID: <CAFZ8Xq7WbZFWzXvSiQ0vTFd4b4LySO7w1DJ-+T4HKzdq8q2_bA@mail.gmail.com>
Subject: Mounting partitions with same label as filesystem mountpoint name
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kernel: 5.0.7-arch1-1-ARCH

Is this a known oddity? I tried to mount a partition today that has
the gpt label and partlabel of "backups" to /mnt/backups. The syscall
succeeds but in reality, it silently failed. dmesg reports the
filesystem was mounted.

mount("/dev/sdc3", "/mnt/backups", "ext4", 0, NULL) =3D 0
[...]
[259524.127545] EXT4-fs (sdc3): mounted filesystem with ordered data
mode. Opts: (null)

It isn't actually mounted nor is there any mount data reflected
anywhere in /proc or /sys for it. If the mount point is named
differently, it succeeds.

=E2=94=94=E2=94=80> ls -ald /mnt/backups
drwxr-xr-x 2 root root 4096 Apr 18 10:41 /mnt/backups
=E2=94=94=E2=94=80> mv /mnt/backups /mnt/backitup
=E2=94=94=E2=94=80> mount /dev/sdc3 /mnt/backtitup
=E2=94=94=E2=94=80> df|grep backit
/dev/sdc3            3.8T   68M  3.6T   1% /mnt/backitup
