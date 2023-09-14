Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412DFEDE99E
	for <linux-block@archiver.kernel.org>; Thu, 14 Sep 2023 09:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjINJGy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbjINJGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2023 05:06:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF3141FDF
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2023 02:06:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-oVJiQy4pMkOK69oh5CjVkA-1; Thu, 14 Sep 2023 10:06:29 +0100
X-MC-Unique: oVJiQy4pMkOK69oh5CjVkA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Sep
 2023 10:06:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 14 Sep 2023 10:06:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 05/13] iov: Move iterator functions to a header file
Thread-Topic: [PATCH v4 05/13] iov: Move iterator functions to a header file
Thread-Index: AQHZ5mNctrIi+SmkLEm1sOlIj5L+5rAaBNNA
Date:   Thu, 14 Sep 2023 09:06:25 +0000
Message-ID: <445a78b0ff3047fea20d3c8058a5ff6a@AcuMS.aculab.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
 <20230913165648.2570623-6-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-6-dhowells@redhat.com>
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

From: David Howells
> Sent: 13 September 2023 17:57
> 
> Move the iterator functions to a header file so that other operations that
> need to scan over an iterator can be added.  For instance, the rbd driver
> could use this to scan a buffer to see if it is all zeros and libceph could
> use this to generate a crc.

These all look a bit big for being more generally inlined.

I know you want to avoid the indirect call in the normal cases,
but maybe it would be ok for other uses?

		David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

