Return-Path: <axboe@kernel.dk>
Subject: Re: [bug report] mtip32xx: convert internal command issue to block IO
 path
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-block@vger.kernel.org
References: <20170623090506.GA7127@elgon.mountain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a40332f0-5e5f-58a0-be47-de2a526ee7ca@kernel.dk>
Date: Fri, 23 Jun 2017 09:18:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170623090506.GA7127@elgon.mountain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/23/2017 03:05 AM, Dan Carpenter wrote:
> Hello Jens Axboe,
> 
> The patch 3f5e6a35774c: "mtip32xx: convert internal command issue to
> block IO path" from Apr 28, 2017, leads to the following static
> checker warning:
> 
> 	drivers/block/mtip32xx/mtip32xx.c:1067 mtip_exec_internal_command()
> 	warn: 'int_cmd->status' is unsigned
> 
> drivers/block/mtip32xx/mtip32xx.c
>   1065  
>   1066          rv = int_cmd->status;
>                      ^^^^^^^^^^^^^^^
> This is a new block error code.
> 
>   1067          if (rv < 0) {
>                     ^^^^^^
> So this doesn't make sense.  This used to be rv <= 0.

It's actually two layers of breakage. After the referenced commit, some
of the below were wonky. But the new breakage is:

commit 2a842acab109f40f0d7d10b38e9ca88390628996
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Jun 3 09:38:04 2017 +0200

    block: introduce new block status code type

since that means that int_cmd->status is a blk_status_t, it's not an
-Exx value at all. And that patch changed the cmd->status field from an
int to a u8, which is why you are now seeing complaints.
 
The below should do the trick. All we really care about is whether
->staut is zero or not. Just turn that into EIO, and dump the various
attempts at clever reporting.


diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index d8618a71da74..61b046f256ca 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1063,23 +1063,10 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	/* insert request and run queue */
 	blk_execute_rq(rq->q, NULL, rq, true);
 
-	rv = int_cmd->status;
-	if (rv < 0) {
-		if (rv == -ERESTARTSYS) { /* interrupted */
-			dev_err(&dd->pdev->dev,
-				"Internal command [%02X] was interrupted after %u ms\n",
-				fis->command,
-				jiffies_to_msecs(jiffies - start));
-			rv = -EINTR;
-			goto exec_ic_exit;
-		} else if (rv == 0) /* timeout */
-			dev_err(&dd->pdev->dev,
-				"Internal command did not complete [%02X] within timeout of  %lu ms\n",
-				fis->command, timeout);
-		else
-			dev_err(&dd->pdev->dev,
-				"Internal command [%02X] wait returned code [%d] after %lu ms - unhandled\n",
-				fis->command, rv, timeout);
+	if (int_cmd->status) {
+		dev_err(&dd->pdev->dev, "Internal command [%02X] failed %d\n",
+				fis->command, int_cmd->status);
+		rv = -EIO;
 
 		if (mtip_check_surprise_removal(dd->pdev) ||
 			test_bit(MTIP_DDF_REMOVE_PENDING_BIT,


-- 
Jens Axboe
