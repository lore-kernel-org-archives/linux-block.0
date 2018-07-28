Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailrelay.collogia.de ([194.8.207.98]:2024 "HELO
        mailrelay.collogia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730154AbeG1Uot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 16:44:49 -0400
Date: Sat, 28 Jul 2018 21:17:16 +0200
From: <stockhausen@collogia.de>
To: <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] direct IO: respect backing device max IO size
Message-ID: <5b5cc13c.CXLhFwUStcCT0Ox+%stockhausen@collogia.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPartTM-000-5688bddd-77a1-426d-9197-e23d52eb10fe"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-5688bddd-77a1-426d-9197-e23d52eb10fe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

blkdev_direct_IO() currently uses BIO_MAX_PAGES for maximum IO transfer size.
For more than a decade its value has been fixed to 256. With 4.14+ and commit
225311a4 ("mm: test code to write THP to swap device as a whole") this has
increased to 512. Tests with older FusionIO cards show that the new setting
totally breaks direct IO. The driver advertises max_hw_blocks_kb=1024 and
max_segments=257 and expects the upper layers to cut data correspondingly.
Other propretary drivers might face similar problems. Fix that by respecting
sane values in bdi->io_pages. Patch could qualify for stable.

Signed-off-by: Markus Stockhausen stockhausen@collogia.de


diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2f777f9..6263f75 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -420,15 +420,21 @@ static void blkdev_bio_end_io(struct bio *bio)
 static ssize_t
 blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(inode);
+	struct backing_dev_info *bdi = bdev->bd_bdi;
+	int max_io_pages;
 	int nr_pages;
 
-	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
+	max_io_pages = min_not_zero(bdi->io_pages, (unsigned long)BIO_MAX_PAGES);
+	nr_pages = iov_iter_npages(iter, max_io_pages + 1);
 	if (!nr_pages)
 		return 0;
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
+	if (is_sync_kiocb(iocb) && nr_pages <= max_io_pages)
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 
-	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES), BIO_MAX_PAGES);
+	return __blkdev_direct_IO(iocb, iter, min(nr_pages, max_io_pages), max_io_pages);
 }
 
 static __init int blkdev_init(void)
------=_NextPartTM-000-5688bddd-77a1-426d-9197-e23d52eb10fe
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

****************************************************************************
Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte
Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail
irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und
vernichten Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte
Weitergabe dieser Mail ist nicht gestattet.

Über das Internet versandte E-Mails können unter fremden Namen erstellt oder
manipuliert werden. Deshalb ist diese als E-Mail verschickte Nachricht keine
rechtsverbindliche Willenserklärung.

Collogia AG
Ubierring 11
D-50678 Köln

Vorstand:
Kadir Akin
Dr. Michael Höhnerbach

Vorsitzender des Aufsichtsrates:
Hans Kristian Langva

Registergericht: Amtsgericht Köln
Registernummer: HRB 52 497

This e-mail may contain confidential and/or privileged information. If you
are not the intended recipient (or have received this e-mail in error)
please notify the sender immediately and destroy this e-mail. Any
unauthorized copying, disclosure or distribution of the material in this
e-mail is strictly forbidden.

e-mails sent over the internet may have been written under a wrong name or
been manipulated. That is why this message sent as an e-mail is not a
legally binding declaration of intention.

Collogia AG
Ubierring 11
D-50678 Köln

executive board:
Kadir Akin
Dr. Michael Höhnerbach

President of the supervisory board:
Hans Kristian Langva

Registry office: district court Cologne
Register number: HRB 52 497

****************************************************************************

------=_NextPartTM-000-5688bddd-77a1-426d-9197-e23d52eb10fe--
