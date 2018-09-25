Return-Path: <ztong@vt.edu>
From: Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: duplicate check for CAP_SYS_RAWIO
Message-Id: <9CFCBC36-B08F-4920-B144-F7EED5B9BC33@vt.edu>
Date: Tue, 25 Sep 2018 13:27:05 -0400
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Wenbo Shen <shenwenbosmile@gmail.com>
To: axboe@kernel.dk, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
List-ID: <linux-block@vger.kernel.org>

Kernel Version: 4.18.5

Problem Description:

We found a path where duplicate capability checks are observed,
the path is :

scsi_ioctl<- require CAP_SYS_ADMIN and CAP_SYS_RAWIO
     `->sg_scsi_ioctl() 
                `->blk_verify_command() <- require CAP_SYS_RAWIO

CAP_SYS_RAWIO is checked twice.

related file: 
  block/scsi_ioctl.c:215 
  block/scsi_ioctl.c:471
  drivers/scsi/scsi_ioctl.c:240
  drivers/scsi/scsi_ioctl.c:242

- Tong
