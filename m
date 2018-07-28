Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailrelay.collogia.de ([194.8.207.98]:2020 "HELO
        mailrelay.collogia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730154AbeG1Uoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 16:44:44 -0400
Date: Sat, 28 Jul 2018 21:17:11 +0200
From: <stockhausen@collogia.de>
To: <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] direct IO: respect backing device max IO size
Message-ID: <5b5cc137.aQS0RwRzNKJxHCMY%stockhausen@collogia.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPartTM-000-b3d7098d-925c-4e66-b16e-9cd83786a039"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-b3d7098d-925c-4e66-b16e-9cd83786a039
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

blkdev_direct_IO() and __blkdev_direct_IO() currently calculate the maximum
number of IO pages independently. This is no problem as they both rely on
BIO_MAX_PAGES. The forthcoming patch will provide a modified calculation
scheme. Make the internal function dependent from the caller to have only
one single source of truth.

Signed-off-by: Markus Stockhausen stockhausen@collogia.de

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e..2f777f9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -317,7 +317,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
 
 static ssize_t
-__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
+__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages,
+		int max_io_pages)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
@@ -375,7 +376,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
+		nr_pages = iov_iter_npages(iter, max_io_pages);
 		if (!nr_pages) {
 			qc = submit_bio(bio);
 			break;
@@ -427,7 +428,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 
-	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
+	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES), BIO_MAX_PAGES);
 }
 
 static __init int blkdev_init(void)
------=_NextPartTM-000-b3d7098d-925c-4e66-b16e-9cd83786a039
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

------=_NextPartTM-000-b3d7098d-925c-4e66-b16e-9cd83786a039--
