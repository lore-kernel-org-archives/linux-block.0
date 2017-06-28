Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43971 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdF1O05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:26:57 -0400
Date: Wed, 28 Jun 2017 17:26:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jg@lightnvm.io
Cc: linux-block@vger.kernel.org
Subject: [bug report] lightnvm: pblk: sched. metadata on write thread
Message-ID: <20170628142645.khaab3l43vzd5fpt@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Javier Gonz�lez,

The patch dd2a43437337: "lightnvm: pblk: sched. metadata on write
thread" from Jun 26, 2017, leads to the following static checker
warning:

	drivers/lightnvm/pblk-init.c:822 pblk_lines_init()
	warn: 'pblk->lines' double freed

drivers/lightnvm/pblk-init.c
   810  
   811          return 0;
   812  fail_free_lines:
   813          while (--i >= 0)
   814                  pblk_free_line_bitmaps(&pblk->lines[i]);
   815  
   816          kfree(pblk->lines);
                      ^^^^^^^^^^^
Freed.

   817  fail_free_bb_aux:
   818          kfree(l_mg->bb_aux);
   819  fail_free_bb_template:
   820          kfree(l_mg->bb_template);
   821  fail_free_meta:
   822          pblk_line_meta_free(pblk);
                                    ^^^^
Double freed.

   823  fail:
   824          for (i = 0; i < geo->nr_luns; i++)
   825                  kfree(pblk->luns[i].bb_list);
   826  
   827          return ret;
   828  }

regards,
dan carpenter
