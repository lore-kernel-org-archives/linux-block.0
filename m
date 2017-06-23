Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21084 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbdFWJFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2017 05:05:25 -0400
Date: Fri, 23 Jun 2017 12:05:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] mtip32xx: convert internal command issue to block IO
 path
Message-ID: <20170623090506.GA7127@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens Axboe,

The patch 3f5e6a35774c: "mtip32xx: convert internal command issue to
block IO path" from Apr 28, 2017, leads to the following static
checker warning:

	drivers/block/mtip32xx/mtip32xx.c:1067 mtip_exec_internal_command()
	warn: 'int_cmd->status' is unsigned

drivers/block/mtip32xx/mtip32xx.c
  1065  
  1066          rv = int_cmd->status;
                     ^^^^^^^^^^^^^^^
This is a new block error code.

  1067          if (rv < 0) {
                    ^^^^^^
So this doesn't make sense.  This used to be rv <= 0.

  1068                  if (rv == -ERESTARTSYS) { /* interrupted */
  1069                          dev_err(&dd->pdev->dev,
  1070                                  "Internal command [%02X] was interrupted after %u ms\n",
  1071                                  fis->command,
  1072                                  jiffies_to_msecs(jiffies - start));
  1073                          rv = -EINTR;
  1074                          goto exec_ic_exit;
  1075                  } else if (rv == 0) /* timeout */
                                   ^^^^^^^
This doesn't make sense either.

  1076                          dev_err(&dd->pdev->dev,
  1077                                  "Internal command did not complete [%02X] within timeout of  %lu ms\n",
  1078                                  fis->command, timeout);
  1079                  else
  1080                          dev_err(&dd->pdev->dev,
  1081                                  "Internal command [%02X] wait returned code [%d] after %lu ms - unhandled\n",
  1082                                  fis->command, rv, timeout);
  1083  
  1084                  if (mtip_check_surprise_removal(dd->pdev) ||
  1085                          test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
  1086                                          &dd->dd_flag)) {
  1087                          dev_err(&dd->pdev->dev,
  1088                                  "Internal command [%02X] wait returned due to SR\n",
  1089                                  fis->command);
  1090                          rv = -ENXIO;

regards,
dan carpenter
