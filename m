Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781DCC47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE6208DB
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgEASCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 14:02:34 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:54194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgEASCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 14:02:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8770B182CF66B;
        Fri,  1 May 2020 18:02:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dust01_1634cf6994e20
X-Filterd-Recvd-Size: 2968
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 18:02:32 +0000 (UTC)
Message-ID: <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
Subject: Re: [PATCH v3 0/4] floppy: suppress UBSAN warning in
 setup_rw_floppy()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 May 2020 11:02:31 -0700
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-05-01 at 16:44 +0300, Denis Efremov wrote:
> These patches are based on Willy's cleanup patches
> https://lkml.org/lkml/2020/3/31/609.

Maybe add pr_fmt and clean up a few messages so
all the logging output is prefixed too.

---
 drivers/block/floppy.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c3daa64..b26bb1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -145,6 +145,8 @@
  * Better audit of register_blkdev.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #undef  FLOPPY_SILENT_DCL_CLEAR
 
 #define REALLY_SLOW_IO
@@ -1724,7 +1726,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 	if (current_fdc >= N_FDC || fdc_state[current_fdc].address == -1) {
 		/* we don't even know which FDC is the culprit */
 		pr_info("DOR0=%x\n", fdc_state[0].dor);
-		pr_info("floppy interrupt on bizarre fdc %d\n", current_fdc);
+		pr_info("interrupt on bizarre fdc %d\n", current_fdc);
 		pr_info("handler=%ps\n", handler);
 		is_alive(__func__, "bizarre fdc");
 		return IRQ_NONE;
@@ -2276,7 +2278,7 @@ static void request_done(int uptodate)
 	reschedule_timeout(MAXTIMEOUT, msg);
 
 	if (!req) {
-		pr_info("floppy.c: no request in request_done\n");
+		pr_info("no request in request_done\n");
 		return;
 	}
 
@@ -4181,8 +4183,7 @@ static void floppy_rb0_cb(struct bio *bio)
 	int drive = cbdata->drive;
 
 	if (bio->bi_status) {
-		pr_info("floppy: error %d while reading block 0\n",
-			bio->bi_status);
+		pr_info("error %d while reading block 0\n", bio->bi_status);
 		set_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
 	}
 	complete(&cbdata->complete);
@@ -4954,7 +4955,7 @@ static void floppy_release_irq_and_dma(void)
 #endif
 
 	if (delayed_work_pending(&fd_timeout))
-		pr_info("floppy timer still active:%s\n", timeout_message);
+		pr_info("timer still active:%s\n", timeout_message);
 	if (delayed_work_pending(&fd_timer))
 		pr_info("auxiliary floppy timer still active\n");
 	if (work_pending(&floppy_work))


