Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:46732 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754887AbdLOEIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Dec 2017 23:08:31 -0500
Received: by mail-it0-f52.google.com with SMTP id t1so16424070ite.5
        for <linux-block@vger.kernel.org>; Thu, 14 Dec 2017 20:08:31 -0800 (PST)
MIME-Version: 1.0
From: Tony Yang <yyt168@gmail.com>
Date: Fri, 15 Dec 2017 12:08:30 +0800
Message-ID: <CADL4p-pigDQBM8oi+XU+qm+hkEJO68yee14n_u+ej2Mu3R4tNA@mail.gmail.com>
Subject: How to Persistent nvme Storage?
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-nvme-bounces@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dear All:

      I download the new nvme multipath version (git clone
git.infradead.org/nvme.git),I want to know how to use the
      multipath, because I want use udev to Persistent Storage,But
when use scsi_id command not found any messages.
      What method can nvme achieve multi-path? Can you provide an
example? Thank you

      [root@udev]# lsblk
NAME          MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdb             8:16   0   1.8T  0 disk
dfa           252:0    0   2.9T  0 disk
=E2=94=9C=E2=94=80dfa5        252:5    0 734.8G  0 part
=E2=94=9C=E2=94=80dfa3        252:3    0 745.1G  0 part
=E2=94=9C=E2=94=80dfa1        252:1    0   9.3G  0 part
=E2=94=9C=E2=94=80dfa4        252:4    0 745.1G  0 part
=E2=94=94=E2=94=80dfa2        252:2    0 745.1G  0 part
nvme1n1       259:10   0   2.9T  0 disk
=E2=94=9C=E2=94=80nvme1n1p5   259:15   0 734.8G  0 part
=E2=94=9C=E2=94=80nvme1n1p3   259:13   0 745.1G  0 part
=E2=94=9C=E2=94=80nvme1n1p1   259:11   0   9.3G  0 part
=E2=94=9C=E2=94=80nvme1n1p4   259:14   0 745.1G  0 part
=E2=94=94=E2=94=80nvme1n1p2   259:12   0 745.1G  0 part
loop0           7:0    0   3.8G  0 loop /mnt/cdrom
sdc             8:32   0 557.9G  0 disk
=E2=94=9C=E2=94=80sdc2          8:34   0   512M  0 part /boot
=E2=94=9C=E2=94=80sdc3          8:35   0 557.3G  0 part
=E2=94=82 =E2=94=9C=E2=94=80rhel-swap 253:1    0     4G  0 lvm  [SWAP]
=E2=94=82 =E2=94=94=E2=94=80rhel-root 253:0    0 553.3G  0 lvm  /
=E2=94=94=E2=94=80sdc1          8:33   0   100M  0 part /boot/efi
sda             8:0    0   1.8T  0 disk
nvme0n1       259:0    0   1.8T  0 disk
=E2=94=9C=E2=94=80nvme0n1p5   259:5    0   100G  0 part
=E2=94=9C=E2=94=80nvme0n1p3   259:3    0     8G  0 part
=E2=94=9C=E2=94=80nvme0n1p1   259:1    0     8G  0 part
=E2=94=9C=E2=94=80nvme0n1p8   259:8    0   100G  0 part
=E2=94=9C=E2=94=80nvme0n1p6   259:6    0   100G  0 part
=E2=94=9C=E2=94=80nvme0n1p4   259:4    0     1K  0 part
=E2=94=9C=E2=94=80nvme0n1p2   259:2    0     8G  0 part
=E2=94=9C=E2=94=80nvme0n1p9   259:9    0   100G  0 part
=E2=94=94=E2=94=80nvme0n1p7   259:7    0   100G  0 part
[root@udev]# /usr/lib/udev/scsi_id -g -u -d /dev/sdb
3518f2920201113ff
[root@udev]# /usr/lib/udev/scsi_id -g -u -d /dev/dfa
[root@udev]# /usr/lib/udev/scsi_id -g -u -d /dev/dfa5
[root@udev]# /usr/lib/udev/scsi_id -g -u -d /dev/nvme1n1p5
