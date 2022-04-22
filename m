Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54FC433FE
	for <linux-block@archiver.kernel.org>; Fri, 22 Apr 2022 05:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiDVFpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Apr 2022 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiDVFpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Apr 2022 01:45:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3604F46E
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 22:42:41 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 486503F19D
        for <linux-block@vger.kernel.org>; Fri, 22 Apr 2022 05:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650606156;
        bh=hWerQpQZlUf6tJ3oEQBKDh+uBBIZTIztZC7wzThBamE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Q7+1a/8gM/eL4iLPaWUCxpzsnrFL5jSxImAp8SvHSOWxlkIyXrnWi3sjXGm8Umnz/
         rNOLYJN0UTzW+a2jWF847yDPi95fX1wE3bJQ11TBzt6Of40WH3HhLMVRnMcrXMqfXT
         mP3zkan3kBSZXFWyKaOrqSVDrUowmeJXHuEs1PlpdUa8mAHD7EI+7E/i4pWzLq/uKe
         NWTc2xDKlO9+OLTDIKuAi79JB1V3l4Kk3otNnVWdDNV63E8fm+NmbGxC7TVjdwir0u
         016gBmCfOj5rEX+5svRH7fuCZNJz1zKyvjNtOqstWrn+d3KwUJTj6lEvW//KhMjwcT
         1waKHsMtnRXjA==
Received: by mail-pl1-f200.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso3859452pll.5
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWerQpQZlUf6tJ3oEQBKDh+uBBIZTIztZC7wzThBamE=;
        b=IY6tKU7U6ZowlgltQLaOiR6H3Lv7Zpl2Z0xeFg7777pWRgAaTKEXrVzQS+0U6+rtVU
         7RwBv0ja0D2Jmnn1S+QgLRea6DKObh+J4t/QeP6YXZ0lyWjCJc2ymI3PYA5GAwkS3sh7
         m10W+iQ0nDo2QyLv5A8EwnlnIn6o7nb6/eOUVTuq8tczWX4M+dfuBHYJYnocqhph9TEX
         omE4VZKnk2O35ROUAVXcflF+5Aj6Bg+FbCEUnYcEw0f7lUgOa9e2yljmk8WuFCfkK+kF
         BmDnfzJCha1t/Kkp5w/PJaADGspvq3v3hP5xk641dS4hLnpdJz0gUablEp9mNSqcUhnZ
         6mGA==
X-Gm-Message-State: AOAM532LHC9v+Y5Qv6zSRoFyxgQ1utm/NUx1WHAmzVD4zvv3lSykP4Ui
        pw+sN/gi+Olqak/Ez12fyhZ34Ipao2BPDkWRKeNjEW5j/hj1g9M6F4bq+VhnLxa2AAwitSIs1RM
        i8N8cRWZnw9ATh3f4E9N7hyxMw2xJsKuYmq2j4moR
X-Received: by 2002:a63:2ad0:0:b0:3aa:c8d5:c7b9 with SMTP id q199-20020a632ad0000000b003aac8d5c7b9mr521904pgq.306.1650606154926;
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRsYMLjMdP/oCRdsW7JcxBBna5VFVNb2T+2REufL2x1MY+dEqZKv+dVqN/g4A2C83rrU4MUA==
X-Received: by 2002:a63:2ad0:0:b0:3aa:c8d5:c7b9 with SMTP id q199-20020a632ad0000000b003aac8d5c7b9mr521895pgq.306.1650606154661;
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
Received: from desktop.. (125-239-17-100-fibre.sparkbb.co.nz. [125.239.17.100])
        by smtp.gmail.com with ESMTPSA id m13-20020a62a20d000000b004fe0ce6d7a1sm1018633pff.193.2022.04.21.22.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
To:     josef@toxicpanda.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PROBLEM] nbd requests become stuck when devices watched by inotify emit udev uevent changes
Date:   Fri, 22 Apr 2022 17:42:24 +1200
Message-Id: <20220422054224.19527-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear maintainers of the nbd subsystem,

A user has come across an issue which causes the nbd module to hang after a
disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
being the server.

The issue is easily reproducible with the following:

Ubuntu 20.04, 22.04 or Fedora 36
Linux 5.18-rc2 or earlier (have tested 5.18-rc2, 5.15, 5.4, 4.15)
QEMU 6.2 or earlier

Instructions to reproduce:
==========================

$ sudo apt install qemu-nbd

$ cat << EOF >> reproducer.sh
#!/bin/bash

sudo modprobe nbd

while :
do
        qemu-img create -f qcow2 foo.img 500M
        sudo qemu-nbd --disconnect /dev/nbd15 || true
        sudo qemu-nbd --connect=/dev/nbd15 --cache=writeback --format=qcow2 foo.img
        sudo mkfs.ext4 -L root -O "^64bit" -E nodiscard /dev/nbd15
        sudo qemu-nbd --disconnect /dev/nbd15
done
EOF

$ chmod +x reproducer.sh
$ ./reproducer.sh

On Ubuntu, the terminal will pause within a minute or two, and dmesg will report
a lot of I/O errors, followed by hung task timeouts. On Fedora, it takes a 
little longer, but it will break in the same way within 10 minutes.

An example kernel log is below:

https://paste.ubuntu.com/p/5ZjC5b8MR7/

Debugging done:
===============

Looking at syslog, it seems systemd-udevd gets stuck, and enters D state.

systemd-udevd[419]: nbd15: Worker [2004] processing SEQNUM=5661 is taking a long time

$ ps aux
...
419    1194 root     D     0.1 systemd-udevd   -

I rebooted, and disabled systemd-udevd and its sockets, with:

$ sudo systemctl stop systemd-udevd.service
$ sudo systemctl stop systemd-udevd-control.socket
$ sudo systemctl stop systemd-udevd-kernel.socket

When running the reproducer again, everything works fine, and nbd subsystem does
not hang.

Looking at udev rules, I looked at the differences between those in Ubuntu 18.04
where the issue does not occur, and 20.04, where it does, and came across:

/usr/lib/udev/rules.d/60-block.rules

In 18.04:
# watch metadata changes, caused by tools closing the device node which was opened for writing
ACTION!="remove", SUBSYSTEM=="block", KERNEL=="loop*|nvme*|sd*|vd*|xvd*|pmem*|mmcblk*", OPTIONS+="watch"

In 20.04:
# watch metadata changes, caused by tools closing the device node which was opened for writing
ACTION!="remove", SUBSYSTEM=="block", \
  KERNEL=="loop*|mmcblk*[0-9]|msblk*[0-9]|mspblk*[0-9]|nvme*|sd*|vd*|xvd*|bcache*|cciss*|dasd*|ubd*|ubi*|scm*|pmem*|nbd*|zd*", \
  OPTIONS+="watch"
  
The difference is the OPTIONS+="watch" being added to nbd* any event not remove.

When I deleted nbd* and retried the reproducer again, everything works smoothly.

Looking at the manpage for udev:

> watch
>   Watch the device node with inotify; when the node is closed after being 
>   opened for writing, a change uevent is synthesized.
>
> nowatch
>   Disable the watching of a device node with inotify.

It appears that there is some sort of problem where systemd-udevd uses inotify
to watch for updates to the device metadata, and it blocks a subsequent
disconnect request, causing it to fail with:

block nbd15: Send disconnect failed -32

After which we start seeing stuck requests:

block nbd15: Possible stuck request 000000007fcf62ba: control (read@523915264,24576B). Runtime 30 seconds

All userspace calls to the nbd module hang, and the system has to be rebooted.

Workaround:
===========

We can workaround the issue by adding a higher priority udev rule to not watch
nbd* devices.

$ cat << EOF >> /etc/udev/rules.d/97-nbd-device.rules
# Disable inotify watching of change events for NBD devices
ACTION=="add|change", KERNEL=="nbd*", OPTIONS:="nowatch"
EOF

$ sudo udevadm control --reload-rules
$ sudo udevadm trigger

Help on debugging the problem:
==============================

I need some help debugging the problem, as I am not quite sure how to trace
the interactions between inotify and nbd.

I am happy to help debug the issue, or try any patches that gather debugging
data or any potential fixes.

Thanks,
Matthew
