Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:56328 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbeAMHvw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jan 2018 02:51:52 -0500
From: tang.junhui@zte.com.cn
To: hare@suse.de, kartilak@cisco.com, sebaddel@cisco.com,
        linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
Subject: how to enlarge value of max_sectors_kb  
Date: Sat, 13 Jan 2018 15:53:24 +0800
Message-Id: <1515830004-5476-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

There is a machine with very little max_sectors_kb size:
[root@ceph151 queue]# pwd
/sys/block/sdd/queue
[root@ceph151 queue]# cat max_hw_sectors_kb 
256
[root@ceph151 queue]# cat max_sectors_kb 
256

The performance is very low when I run big I/Os.
I can not modify it directly, I need a little bigger,
so how can I enlarge it?

the system info:

[root@ceph151 queue]# uname -r
3.10.0-327.22.2.el7.x86_64

[root@ceph151 queue]# lsmod |grep scsi
scsi_transport_fc      64056  1 lpfc
scsi_tgt               20027  1 scsi_transport_fc

[root@ceph151 queue]# lsscsi
[0:0:0:0]    disk    ASR7805  system           V1.0  /dev/sda 
[0:1:8:0]    disk    ATA      Hitachi HUA72201 JP4O  /dev/sdb 
[0:1:9:0]    disk    ATA      Hitachi HUA72201 JP4O  /dev/sdc 
[0:1:10:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdd 
[0:1:11:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sde 
[0:1:12:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdf 
[0:1:13:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdg 
[0:1:14:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdh 
[0:1:15:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdi 
[0:1:16:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdj 
[0:1:17:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdk 
[0:1:18:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdl 
[0:1:19:0]   disk    ATA      Hitachi HUA72201 JP4O  /dev/sdm 
[0:1:20:0]   disk    TOSHIBA  AL13SEB600       0101  -        
[0:1:21:0]   disk    TOSHIBA  AL13SEB600       0101  -        
[0:3:0:0]    enclosu ZTE CORP 720381 EvBd 255  1     - 

Any comment would be wellcome.

Thanks,
Tang Junhui
