Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailrelay.collogia.de ([194.8.207.98]:2862 "HELO
        mailrelay.collogia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731155AbeG1X7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 19:59:11 -0400
From: Markus Stockhausen <stockhausen@collogia.de>
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: AW: [PATCH 0/2] direct IO: respect backing device max IO size
Date: Sat, 28 Jul 2018 22:31:01 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD173010E0B4ED5@EXCHANGE.collogia.de>
References: <5b5cc132.ZRg3eYC3DaoOBtul%stockhausen@collogia.de>,<b5c01601-9a80-118a-0f40-e730b87ce390@kernel.dk>
In-Reply-To: <b5c01601-9a80-118a-0f40-e730b87ce390@kernel.dk>
Content-Type: multipart/mixed;
        boundary="----=_NextPartTM-000-440a8eed-1de3-4d90-9754-37e8447ff0db"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-440a8eed-1de3-4d90-9754-37e8447ff0db
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Jens Axboe [axboe@kernel.dk]=0A=
> Gesendet: Sonntag, 29. Juli 2018 00:22=0A=
> An: Markus Stockhausen; linux-block@vger.kernel.org=0A=
> Betreff: Re: [PATCH 0/2] direct IO: respect backing device max IO size=0A=
> =0A=
> On 7/28/18 1:17 PM, stockhausen@collogia.de wrote:=0A=
> > Running older FusionIO cards with newer linux kernels turns out to be=
=0A=
> > a headache. First of all their driver is a mix of open sources and=0A=
> > proprietary object parts. Second we get only support for kernels up=0A=
> > to ~4.0. Trying to get this to work with 4.9 longterm was successful=0A=
> > but 4.14 renders the driver totally useless.=0A=
> >=0A=
> > Searching the reason for lost data it turned out that the driver has=0A=
> > a hard 1024K or 257 page IO limit and silently drops any request that=
=0A=
> > is too large. Of course this might be a driver only problem but at=0A=
> > least it discloses the real source of a bad chain reaction.=0A=
> >=0A=
> > blkdev_direct_IO() sets the maximum allowed IO size to BIO_MAX_PAGES.=
=0A=
> > With 225311a4 ("mm: test code to write THP to swap device as a whole")=
=0A=
> > its value changed from 256 to 512. Indepedant of its value the choice=
=0A=
> > is arbitrary and can be driver agnostic as long as breakdown of bios=0A=
> > happens later on.=0A=
> >=0A=
> > We already have sufficent info about backing device properties and=0A=
> > can packetize the IO into sane values to avoid hassle later on. If=0A=
> > bdi->io_pages is set and lower than BIO_MAX_PAGES reduce the package=0A=
> > size appropriately.=0A=
> >=0A=
> > Ths patch consists of two parts. The first is only a cosmetic change=0A=
> > to avoid double coding in the second one.=0A=
> =0A=
> Sounds to me like the fusion driver isn't calling split like it is=0A=
> supposed to. That's what you get when it's unmaintained for years.=0A=
> Add a:=0A=
> =0A=
>         blk_queue_split(queue, &bio);=0A=
> =0A=
> to kblock.c:kfio_make_request() and see if that helps.=0A=
> --=0A=
> Jens Axboe=0A=
=0A=
I guess You know the driver and got my only by a few minutes.=0A=
Was just comparing iomemory 3.2.x with 4.3.x. And tadaaa: New=0A=
driver has a split.=0A=
=0A=
Thanks a lot.=0A=
=0A=
Markus=0A=
=0A=
=0A=
------=_NextPartTM-000-440a8eed-1de3-4d90-9754-37e8447ff0db
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

------=_NextPartTM-000-440a8eed-1de3-4d90-9754-37e8447ff0db--
