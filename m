Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA99C433C1
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 10:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7170161987
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 10:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhCaKis convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:38:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31676 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234862AbhCaKiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 06:38:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-99-VTUrauydP9eC8qUNDw8g6Q-1; Wed, 31 Mar 2021 11:38:16 +0100
X-MC-Unique: VTUrauydP9eC8qUNDw8g6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 31 Mar 2021 11:38:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 31 Mar 2021 11:38:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <nathan@kernel.org>,
        Jian Cai <jiancai@google.com>
CC:     "cjdb@google.com" <cjdb@google.com>,
        "manojgupta@google.com" <manojgupta@google.com>,
        "llozano@google.com" <llozano@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: fix alignment mismatch.
Thread-Topic: [PATCH] blk-mq: fix alignment mismatch.
Thread-Index: AQHXJbyzId+/bYuSL06dtp6dmHSiz6qd53HQ
Date:   Wed, 31 Mar 2021 10:38:15 +0000
Message-ID: <553e40c54eea408a96f42eec53616993@AcuMS.aculab.com>
References: <20210330230249.709221-1-jiancai@google.com>
 <20210330232946.m5p7426macyjduzm@archlinux-ax161>
In-Reply-To: <20210330232946.m5p7426macyjduzm@archlinux-ax161>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Nathan Chancellor
> Sent: 31 March 2021 00:30
> 
> Hi Jian,
> 
> On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> > This fixes the mismatch of alignments between csd and its use as an
> > argument to smp_call_function_single_async, which causes build failure
> > when -Walign-mismatch in Clang is used.
> >
> > Link:
> > http://crrev.com/c/1193732
> >
> > Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Jian Cai <jiancai@google.com>
> 
> Thanks for the patch. This is effectively a revert of commit
> 4ccafe032005 ("block: unalign call_single_data in struct request"),
> which I had brought up in this thread:
> 
> https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
> 
> This is obviously a correct fix, I am not just sure what the impact to
> 'struct request' will be.

If the structure is allocated on-stack then aligning it
requires the compiler generate the rather horrid
'double stack frame' for the function.

Possibly the unaligned 'struct' should be used by all
the code except for a few places where it makes sense
to allocate an aligned item?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

