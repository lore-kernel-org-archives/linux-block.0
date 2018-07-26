Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailrelay.collogia.de ([194.8.207.98]:58576 "HELO
        mailrelay.collogia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731673AbeGZUyJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 16:54:09 -0400
Date: Thu, 26 Jul 2018 21:35:42 +0200
From: <stockhausen@collogia.de>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] readahead: stricter check for bdi io_pages
Message-ID: <5b5a228e.MdvsdULQVpBGv+1Q%stockhausen@collogia.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPartTM-000-6de23e7e-ea0d-4172-89ad-c013ab2dc46e"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-6de23e7e-ea0d-4172-89ad-c013ab2dc46e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ondemand_readahead() checks bdi->io_pages to cap the maximum pages
that need to be processed. This works until the readit section. If
we would do an async only readahead (async size = sync size) and
target is at beginning of window we expand the pages by another
get_next_ra_size() pages. Btrace for large reads shows that kernel
always issues a doubled size read at the beginning of processing.
Add an additional check for io_pages in the lower part of the func.
The fix helps devices that hard limit bio pages and rely on proper
handling of max_hw_read_sectors (e.g. older FusionIO cards). For
that reason it could qualify for stable.
    
Fixes: 9491ae4a ("mm: don't cap request size based on read-ahead setting")
Signed-off-by: Markus Stockhausen stockhausen@collogia.de

diff --git a/mm/readahead.c b/mm/readahead.c
index 539bbb6..d4ad4bb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -380,6 +380,7 @@ static int try_context_readahead(struct address_space *mapping,
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
+	unsigned long add_pages;
 	pgoff_t prev_offset;
 
 	/*
@@ -469,10 +470,17 @@ static int try_context_readahead(struct address_space *mapping,
 	 * Will this read hit the readahead marker made by itself?
 	 * If so, trigger the readahead marker hit now, and merge
 	 * the resulted next readahead window into the current one.
+	 * Take care of maximum IO pages as above.
 	 */
 	if (offset == ra->start && ra->size == ra->async_size) {
-		ra->async_size = get_next_ra_size(ra, max_pages);
-		ra->size += ra->async_size;
+		add_pages = get_next_ra_size(ra, max_pages);
+		if (ra->size + add_pages <= max_pages) {
+			ra->async_size = add_pages;
+			ra->size += add_pages;
+		} else {
+			ra->size = max_pages;
+			ra->async_size = max_pages >> 1;
+		}
 	}
 
 	return ra_submit(ra, mapping, filp);
------=_NextPartTM-000-6de23e7e-ea0d-4172-89ad-c013ab2dc46e
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

------=_NextPartTM-000-6de23e7e-ea0d-4172-89ad-c013ab2dc46e--
