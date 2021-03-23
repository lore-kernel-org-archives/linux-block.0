Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F04C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36982601FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhCWVRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233461AbhCWVRr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 17:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 387FAAF1F;
        Tue, 23 Mar 2021 21:17:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Davidlohr Bueso <dave@stgolabs.net>, axboe@kernel.dk
Date:   Wed, 24 Mar 2021 08:17:40 +1100
Cc:     dbueso@suse.de, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/block: Goodbye BLK_DEV_UMEM
In-Reply-To: <20210323191604.aqibane2w55q4oma@offworld>
References: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
 <20210323190710.101888-1-dave@stgolabs.net>
 <20210323191604.aqibane2w55q4oma@offworld>
Message-ID: <87r1k5d0y3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Mar 23 2021, Davidlohr Bueso wrote:

> I'm also Ccing Neil, who is one of the authors.

Thanks!
I have no objection to the removal.  The driver served its purpose at
the time, but technology has moved on.
Add
  Acked-by: NeilBrown <neilb@suse.de>
if you like (not necessary).

Thanks,
NeilBrown

>
> On Tue, 23 Mar 2021, Bueso wrote:
>
>>This removes the driver on the premise that it has been unused for a long
>>time. This is a better approach compared to changing untestable code nobody
>>cares about in the first place. Similarly, the umem.com website now shows a
>>mere Godaddy parking add.
>>
>>Suggested-by: Christoph Hellwig <hch@infradead.org>
>>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>>---
>> arch/mips/configs/malta_defconfig       |    1 -
>> arch/mips/configs/malta_kvm_defconfig   |    1 -
>> arch/mips/configs/maltaup_xpa_defconfig |    1 -
>> drivers/block/Kconfig                   |   17 -
>> drivers/block/Makefile                  |    1 -
>> drivers/block/umem.c                    | 1130 -----------------------
>> drivers/block/umem.h                    |  132 ---
>> 7 files changed, 1283 deletions(-)
>> delete mode 100644 drivers/block/umem.c
>> delete mode 100644 drivers/block/umem.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBaWvQOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnMAg/8DUvxiFuYbMPHhdwKp7MkiNU11OjJFGSrvt7J
YgDXrF/6VbiMiG2eF7e+/+At4Mg1TBOgHoJCQGDBxXL3m8UCjyNvYOxi1ZYiHrEB
mDDVYiIXecBq1UGqXft9QXE6TlhoKnX512hoqnvA5fmC92xdeClJof4xtzRuLkRO
4ntTiJQC0xvlmRtTJIEQJJVgeDxAIgVFVy7XJ38a+OoAc5SYbuiyDPnHmCX0GzeY
xGBSPCUX1HoT2WmLE6s6nASsasOnzC319SPkFR8rRRjgyuzzJEv+lJIVKdS3VClU
yQ8stmsUy5uMgwm7NvVhqJGavKBUaP7NAl+8dKgikAZqeOR4bIuQu8O2pLuz2gH+
z+DeacWf0nvKRPaEFSRV9LpkAzrRvmqP7zV8XTO4OZlLgadBvQtPYTrFESmzjv5C
Aw69jJN4n8Y8H/dUfFMx8XO8ncpG/DRQy+6LW/XDE3PjGKtaR/LkdSL8Qn/9TStI
q9nUQSeWZM/HI/5NBJSpcfJpI9mWIQp4Ur0ADKb41GbE9Z9mU7byovHGaG64PnMN
PE4RYj0nA4MHvDQsLQ0Go0vV+gYHT+j/pPjrzaUtxn8de4US9OlLmc8ji4DeqpBC
KdGheMVUozeOPJOsDz0FvpgYz1RDIuv2lzLVHeulF/6YP+0iMfX0m6JF7yS1x2Qh
MAWU78M=
=gYta
-----END PGP SIGNATURE-----
--=-=-=--
