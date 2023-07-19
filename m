Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89115EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 08:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGSI5i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGSI5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 04:57:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B2136
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 01:57:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-199-JcrrCbdbNSik7gdKJemqkQ-1; Wed, 19 Jul 2023 09:57:33 +0100
X-MC-Unique: JcrrCbdbNSik7gdKJemqkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 09:57:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 09:57:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tejun Heo' <tj@kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd <amd@localhost.localdomain>
Subject: RE: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Thread-Topic: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Thread-Index: AQHZuN9gMxBfo8Y4UkeL32HKckyYqK/Ay+LQ
Date:   Wed, 19 Jul 2023 08:57:32 +0000
Message-ID: <2b4540aadc3c4449a192aeed6211f232@AcuMS.aculab.com>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
In-Reply-To: <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tejun Heo
> Sent: 17 July 2023 19:49
> 
> On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
> > From: amd <amd@localhost.localdomain>
> >
> > Fix two type mismatch errors encountered while compiling blk-iocost.c with
> > GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> > result of the division operation to (unsigned int) to match the expected
> > format specifier %u in two seq_printf invocations.
> 
> Can you detail the warnings? Was that on 32bit compiles?

The problem is caused by gcc 13 changing the types of the
constants inside an enum to be all the same.

The best fix is (probably) to replace all the enum used to
define unrelated constants with #defines.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

