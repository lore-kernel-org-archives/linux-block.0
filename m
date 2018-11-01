Return-Path: <SRS0=YJ2/=NM=gmail.com=tedheadster@kernel.org>
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 1 Nov 2018 16:22:26 -0400
Message-ID: <CAP8WD_ZXzwW7pNSac2TqXqxzKGRbnwG6pf8RqJ9ZG4PLCeVxoQ@mail.gmail.com>
Subject: loopback block device will not free
To: linux-block@vger.kernel.org, axboe@kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Jens,
  I am running the latest 4.19 kernel. When I mount a disk image using
option 'loop' in /etc/fstab, it mounts just fine. When I un-mount the
loopback device, lsof verifies that nothing else is using it.

However, losetup -d will not free the device. Also, the reference
counts in lsmod show 2 references for the one loopback device.

Where should I start debugging?

/usr/src/linux.stable # losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                   DIO LOG-SEC
/dev/loop0         0      0         1  0 /mnt/images0/i486.img         0     512

/usr/src/linux.stable # lsmod | grep loop
loop                   24576  2

- Matthew Whitehead
