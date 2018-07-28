Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailrelay.collogia.de ([194.8.207.98]:2019 "HELO
        mailrelay.collogia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729227AbeG1Uoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 16:44:44 -0400
Date: Sat, 28 Jul 2018 21:17:06 +0200
From: <stockhausen@collogia.de>
To: <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] direct IO: respect backing device max IO size
Message-ID: <5b5cc132.ZRg3eYC3DaoOBtul%stockhausen@collogia.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPartTM-000-a52f1283-2e8b-423a-8427-1e42079968b7"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-a52f1283-2e8b-423a-8427-1e42079968b7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Running older FusionIO cards with newer linux kernels turns out to be
a headache. First of all their driver is a mix of open sources and
proprietary object parts. Second we get only support for kernels up
to ~4.0. Trying to get this to work with 4.9 longterm was successful
but 4.14 renders the driver totally useless.

Searching the reason for lost data it turned out that the driver has 
a hard 1024K or 257 page IO limit and silently drops any request that 
is too large. Of course this might be a driver only problem but at 
least it discloses the real source of a bad chain reaction.

blkdev_direct_IO() sets the maximum allowed IO size to BIO_MAX_PAGES.
With 225311a4 ("mm: test code to write THP to swap device as a whole")
its value changed from 256 to 512. Indepedant of its value the choice
is arbitrary and can be driver agnostic as long as breakdown of bios
happens later on.

We already have sufficent info about backing device properties and 
can packetize the IO into sane values to avoid hassle later on. If
bdi->io_pages is set and lower than BIO_MAX_PAGES reduce the package
size appropriately.

Ths patch consists of two parts. The first is only a cosmetic change
to avoid double coding in the second one.

------=_NextPartTM-000-a52f1283-2e8b-423a-8427-1e42079968b7
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

------=_NextPartTM-000-a52f1283-2e8b-423a-8427-1e42079968b7--
