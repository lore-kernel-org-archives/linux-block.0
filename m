Return-Path: <linux-block-owner@vger.kernel.org>
Received: from sender-op-o12.zoho.com ([135.84.80.197]:17307 "EHLO
        sender-op-o12.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeJ1DhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Oct 2018 23:37:06 -0400
From: Thomas Fjellstrom <thomas@fjellstrom.ca>
To: linux-block@vger.kernel.org
Subject: recent issues with heavy delete's causing soft lockups
Date: Sat, 27 Oct 2018 12:40:03 -0600
Message-ID: <2800911.LnhMzhikfW@natasha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

As of the past few months or so I've been dealing with my workstation locking 
up for upwards of minutes at a time when deleting a large directory tree. I 
don't recall this being a problem before.

Current setup is 3 SATA SSDs in an lvm vg. most space is allocated to an ext4 
/home where my work projects live.

The main use case causing problems is deleting the "out" directory of an 
android AOSP build tree. It can be upwards of 95GB in size with 240k or more 
files. If I run a `rm -fr out` or `make clean` it will lock up anything 
attempting to use the disk (eg: plasma, intellij, android studio, chrome, etc) 
for sometimes minutes.

I have tried different block scheduler settings including none, mq-deadline, 
kyber and bfq none of which seem to improve things much at all.

It may be worth noting that disk space is starting to run low, perhaps there's 
some interaction going on with free space handling or ssd wear leveling...

That said, it seems to have started happening (or at least made worse) some 
time around when mq was made the default and only implementation for sata.

if it helps, my system specs are:

Kernel: Debian Sid's 4.18.0-2-amd64 (4.18.10-2)
CPU: AMD FX-8320 OCed to 4.4Ghz
RAM: 32GB DDR3 1866
MB: Asus 970 Aura Pro Gaming
Storage: Kingston HyperX 3K 240G + Samsung 850 Evo 250G + SanDisk X300 500G

I'm thinking of testing with a different or older kernel, what would be the 
best to test with?

Thanks for any assistance.

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
