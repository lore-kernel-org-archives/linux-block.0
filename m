Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41987 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdHXLEg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 07:04:36 -0400
Date: Thu, 24 Aug 2017 14:04:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] skd: Avoid that module unloading triggers a
 use-after-free
Message-ID: <20170824110412.uh27qkhutnrid7ji@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Bart Van Assche,

This is a semi-automatic email about new static checker warnings.

The patch 7277cc67b391: "skd: Avoid that module unloading triggers a 
use-after-free" from Aug 17, 2017, leads to the following Smatch 
complaint:

drivers/block/skd_main.c:3080 skd_free_disk()
	 error: we previously assumed 'disk' could be null (see line 3074)

drivers/block/skd_main.c
  3073	
  3074		if (disk && (disk->flags & GENHD_FL_UP))
                    ^^^^
Existing code checked for NULL.  The new code shuffles things around.

  3075			del_gendisk(disk);
  3076	
  3077		if (skdev->queue) {
  3078			blk_cleanup_queue(skdev->queue);
  3079			skdev->queue = NULL;
  3080			disk->queue = NULL;
                        ^^^^^^^^^^^
Now we don't check here.

  3081		}
  3082	

regards,
dan carpenter
