Return-Path: <linux-ide-owner@vger.kernel.org>
From: Klaus Kusche <klaus.kusche@computerix.info>
Subject: Subsystem responsible for /proc/diskstats timings?
To: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Message-ID: <fdbf1284-a111-f99b-30e4-4d35a35b119c@computerix.info>
Date: Sun, 9 Sep 2018 10:03:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


Hello,

Which subsystem could be responsible for

https://bugzilla.kernel.org/show_bug.cgi?id=200857

("4.18 regression: /proc/diskstats: I/O busy time not updated correctly")?

This is for AHCI SATA disks (/dev/sda, /dev/sdb, ...),
and the busy time reported by /proc/diskstats for SSD's is still (4.18.6)
to low by at least a factor of 20 (!).

Many thanks in advance for your help!

-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
