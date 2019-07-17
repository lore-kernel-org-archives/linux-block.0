Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482AEC76186
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 07:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144352077C
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 07:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyVsvjXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfGQHVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:21:40 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:45076 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQHVk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 03:21:40 -0400
Received: by mail-yw1-f47.google.com with SMTP id m16so10163314ywh.12
        for <linux-block@vger.kernel.org>; Wed, 17 Jul 2019 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0qkVVcHr8Fd6hMPNJoWwIKStQuG8BeHit6JmAIQS+9Q=;
        b=UyVsvjXJvekLt/iTeu6HseRJJioU43xj4GD7KSSI2jfUsS4i7BGHqFtA4fKGJyd6qB
         GydrV0PoGSjZMnAJxD4KZR5LbzrVbY9O5jCH1DLloICzV1pFUsKO72Apey+3OiuOvQsL
         xc8HxVyWeMAAQa+mYhAKJJov5M2RZdt4IOnCEC6Bvm3HEgLbLyIGctN36YgTi56AL+PH
         Qn5vACiIJVS0ZqPL5SDXzkyhjPrY1spOWgOkdhzS4eteOygKAOeUxLgjUJxudoctOGcS
         4G2lPc+oN9AooBS1DepEy3e9M5w7Ynsn7fwT6G9NPE0eOEWo2sWcvmzVYVezvgZQUOsK
         UiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0qkVVcHr8Fd6hMPNJoWwIKStQuG8BeHit6JmAIQS+9Q=;
        b=Us1Km6tha4AvJcFhWFtkJlfyTBcRZQEm4ac0NcgwtD064l//Or3slk8joc33tMs254
         BIPy1mCBETQwq9SBFvhDcru1QQKbhtTDu7Ow+ABh23BctUpOsXMc0UzUxGIWOCaKyBR8
         am+2MOiW3tJrFQ5a6lsItLeQIJGudzsIlP/3qA0cidihxNc12NPXi7b+9FYZnHZkyjHu
         VJ/+8Nq3L+1XJuqt6M7sArtRjgxLGXS6p8FWzZWGnU1UKvYcsP25yc54RMp6MnKvdGEh
         e1tGVswyh6tvaedhkaxu9Yh6ofp/4XnmYrMI5xK966GmfaqiQ05ahJZsE11Spz2FNx58
         9TJQ==
X-Gm-Message-State: APjAAAVp1gvTbJVfJbMCKGs0o7d66afOTXxjcCMvqtXbTjNFNQEUBTix
        xsULRRXQ844EGrID7f5tAuoMsn8IYMuJSveuaxD2ealMMzM=
X-Google-Smtp-Source: APXvYqzX9Ht77OlRegjre8U9QF0/UmHbxrzFY6+o4SeczFmWQpVVj+fBlurDTz/dQjmSORRIpQ5eGHsKS497e5XxuAM=
X-Received: by 2002:a81:914b:: with SMTP id i72mr2663049ywg.133.1563348098889;
 Wed, 17 Jul 2019 00:21:38 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Majer <stefan.majer@gmail.com>
Date:   Wed, 17 Jul 2019 09:21:27 +0200
Message-ID: <CADdPHGseMJf+=16S4NpHxG_bQQdZ4EtY7=s=hsLfzXHiS+sdgg@mail.gmail.com>
Subject: 5.1.18/5.2.1 write to nvme failed with: removing after probe failure
 status -19
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

booting a bare metal machine with kernel 5.0.21, partitioning the nvme
disk with:

/boot/EFI with vfat
/ with ext4
/var/lib with ext4

and writing a ubuntu image onto that layout works.

Booting with 5.1.18 or 5.2.1 with the same static (no modules) kernel
configuration always fails with:

[  132.236757] nvme nvme0: I/O 323 QID 10 timeout, aborting
[  132.242091] nvme nvme0: I/O 324 QID 10 timeout, aborting
                                           [  132.247414] nvme nvme0:
Abort status: 0x0
                         [  132.251437] nvme nvme0: I/O 325 QID 10
timeout, aborting
 [  132.256752] nvme nvme0: I/O 326 QID 10 timeout, aborting
                                           [  132.262074] nvme nvme0:
I/O 327 QID 10 timeout, aborting
                [  132.267392] nvme nvme0: I/O 328 QID 10 timeout,
aborting                                                       [
132.272707] nvme nvme0: I/O 329 QID 10 timeout, aborting
                                        [  132.278027] nvme nvme0: I/O
330 QID 10 timeout, aborting
            [  132.283340] nvme nvme0: I/O 331 QID 10 timeout,
aborting                                                       [
132.288674] nvme nvme0: Abort status: 0x0
                                                 [  132.292690] nvme
nvme0: Abort status: 0x0
[  132.296701] nvme nvme0: Abort status: 0x0
[  132.300714] nvme nvme0: Abort status: 0x0
[  132.304727] nvme nvme0: Abort status: 0x0
[  132.308741] nvme nvme0: Abort status: 0x0
[  132.312753] nvme nvme0: Abort status: 0x0
[  132.316769] nvme nvme0: Abort status: 0x0
.....
[  310.716746] nvme nvme0: Device not ready; aborting reset
                                           [  310.722068] nvme nvme0:
Removing after probe failure status: -19
            [  310.734040] Buffer I/O error on dev nvme0n1, logical
block 4, async page read                         [  310.734044]
print_req_error: I/O error, dev nvme0n1, sector 2049 flags 0
                      [  310.734050] print_req_error: I/O error, dev
nvme0n1, sector 5139312 flags 801                       [  310.734119]
Aborting journal on device nvme0n1p2-8.
                               [  310.734132] Buffer I/O error on dev
nvme0n1p2, logical block 557056, lost sync page write     [
310.734135] JBD2: Error -5 detected when updating journal superblock
for nvme0n1p2-8.       [  310.775898] print_req_error: I/O error, dev
nvme0n1, sector 3567 flags 100001                       [  310.775909]
FAT-fs (nvme0n1p1): bread failed in fat_clusters_flush
                          [  310.783036] Buffer I/O error on dev
nvme0n1p1, logical block 1519, lost async page write       [
310.783038] print_req_error: I/O error, dev nvme0n1, sector 3566 flags
100001                       [  310.783039] Buffer I/O error on dev
nvme0n1p1, logical block 1518, lost async page write       [
310.783040] print_req_error: I/O error, dev nvme0n1, sector 3565 flags
100001                       [  310.783040] Buffer I/O error on dev
nvme0n1p1, logical block 1517, lost async page write       [
310.783041] print_req_error: I/O error, dev nvme0n1, sector 3564 flags
100001                       [  310.783042] Buffer I/O error on dev
nvme0n1p1, logical block 1516, lost async page write       [
310.783045] print_req_error: I/O error, dev nvme0n1, sector 3563 flags
100001                       [  310.789253] Buffer I/O error on dev
nvme0n1p2, logical block 1, lost async page write             [
310.797310] Buffer I/O error on dev nvme0n1p1, logical block 1515,
lost async page write       [  310.797311] print_req_error: I/O error,
dev nvme0n1, sector 3562 flags 100001                         [
310.797313] Buffer I/O error on dev nvme0n1p1, logical block 1514,
lost async page write       [  310.804451] Buffer I/O error on dev
nvme0n1p2, logical block 594, lost async page write         [
310.812535] print_req_error: I/O error, dev nvme0n1, sector 3561 flags
100001
[  310.812535] print_req_error: I/O error, dev nvme0n1, sector 3561
flags 100001                       [  310.896373] print_req_error: I/O
error, dev nvme0n1, sector 3303 flags 100001
[  310.903626] Aborting journal on device nvme0n1p3-8.
[  310.908527] JBD2: Error -5 detected when updating journal
superblock for nvme0n1p3-8.
[  311.094887] FAT-fs (nvme0n1p1): unable to read inode block for
updating (i_pos 19713)
[  311.102729] FAT-fs (nvme0n1p1): unable to read inode block for
updating (i_pos 19843)
[  311.110557] FAT-fs (nvme0n1p1): unable to read inode block for
updating (i_pos 19844)

No Idea where to start digging, any help welcome.

regards

-- 
Stefan Majer
