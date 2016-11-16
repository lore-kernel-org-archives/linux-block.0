Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32939 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcKPGvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 01:51:00 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so13871290pgd.0
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2016 22:51:00 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCHSET] Add support for write zeroes operation in Block layer and NVMe Driver.
Date: Tue, 15 Nov 2016 22:50:34 -0800
Message-Id: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

1. Block layer implementation details :-
    a. Introducing __blkdev_issue_zeroout variant of exiting code.
    b. Introducing new request operation flag REQ_OP_WRITE_ZEROES to represent
       write zeroes operation.
    c. Mechanism to issue bios without payload with the help of
       __blkdev_issue_write_zeroes block library function. In block layer 
       blkdev_issue_zeroout/__blkdev_issue_zeroout APIs are exported to execute 
       write zeroes operation. Based on the device support these 
       functions will :-
       1. Try to execute optimized Write Zeroes (REQ_OP_WRITE_ZEROES).
       2. If REQ_OP_WRITE_ZEROES is not supported, it will try to write zeroes
          using write same (REQ_OP_WRITE_SAME) operation.
       3. In case write zeroes and write same are not supported zeroes are
          written using regular write (REQ_OP_WRITE) operation.

2. NVMe over Fabric Driver implementation details :-
       1. NVMe write zeroes command definitions for host and target.
       2. NVMe write zeroes command implementation for host and target.
