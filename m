Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D9C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA0760F56
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1Pqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:46:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49162 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhJ1Pqq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:46:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5BE564403A;
        Thu, 28 Oct 2021 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1635435855; x=
        1637250256; bh=p5CINr2Cl2CInJJHW943Rc6amxtNs1dnYkvYwOkCJPE=; b=s
        pFvdcvkI6CPw1qXp8jDbcZRCMqRc61q9CbWC1yx5BzSIRTQOk9Ekmdfxc2iv94mo
        1KrmY9iwsI8PfbasVJtJ5g77ZQD2rJEN/cm1DUASF0dbNiv074H8oQzr0IUj3OCZ
        PiCEabDYG1ta4Py9yv40aFufdRyIlBPjwOdAqELjJg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GOZRe_H_HnOo; Thu, 28 Oct 2021 18:44:15 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 43E2F460E5;
        Thu, 28 Oct 2021 18:44:15 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (172.17.100.104) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 28 Oct 2021 18:44:14 +0300
Received: from T-EXCH-04.corp.yadro.com ([fe80::d8c5:6f0a:3d48:18df]) by
 T-EXCH-04.corp.yadro.com ([fe80::d8c5:6f0a:3d48:18df%15]) with mapi id
 15.01.0669.032; Thu, 28 Oct 2021 18:44:14 +0300
From:   Mikhail Malygin <m.malygin@yadro.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     Alexander Buev <a.buev@yadro.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH 0/3] implement direct IO with integrity
Thread-Topic: [PATCH 0/3] implement direct IO with integrity
Thread-Index: AQHXy+5fTd3x555CfUaTUdCnXfPwjqvoUniAgAABmoCAAACJAIAABo2A
Date:   Thu, 28 Oct 2021 15:44:14 +0000
Message-ID: <AAD8717C-E050-47C0-B8C9-119C8F51B47D@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
 <20211028151851.GC9468@lst.de>
 <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
In-Reply-To: <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.128.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD6D64178F2FDA4AAE1D21ED4B3363FE@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIHdl4oCZbGwgc3VibWl0IGFuZCB1cGRhdGVkIHZlcnNp
b24gb2YgdGhlIHNlcmllcy4NCg0KVGhlIG9ubHkgcXVlc3Rpb24gaXMgcmVnYXJkaW5nIHVhcGk6
IHNob3VsZCB3ZSBhZGQgYSBzZXBhcmF0ZSBvcGNvZGVzIGZvciByZWFkL3dyaXRlIG9yIHVzZSBl
eGlzdGluZyBvcGNvZGVzIHdpdGggdGhlIGZsYWcgaW4gdGhlIGlvX3VyaW5nX3NxZS5yd19mbGFn
cyBmaWVsZD8NCg0KVGhlIGZsYWcgd2FzIGRpc2N1c3NlZCBpbiB0aGUgYW5vdGhlciBzdWJtaXNz
aW9uLCB3aGVyZSBpdCB3YXMgY29uc2lkZXJlZCB0byBiZSBhIGJldHRlciBhcHByb2FjaCBvdmVy
IG9wY29kZXM6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1ibG9j
ay9wYXRjaC8yMDIwMDIyNjA4MzcxOS40Mzg5LTItYm9iLmxpdUBvcmFjbGUuY29tLw0KDQpUaGFu
a3MsDQpNaWtoYWlsDQoNCj4gT24gMjggT2N0IDIwMjEsIGF0IDE4OjIwLCBKZW5zIEF4Ym9lIDxh
eGJvZUBrZXJuZWwuZGs+IHdyb3RlOg0KPiANCj4gT24gMTAvMjgvMjEgOToxOCBBTSwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBUaHUsIE9jdCAyOCwgMjAyMSBhdCAwOToxMzowN0FN
IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPj4+IEEgY291cGxlIG9mIHN1Z2dlc3Rpb25zIG9u
IHRoaXM6DQo+Pj4gDQo+Pj4gMSkgRG9uJ3QgdGhpbmsgd2UgbmVlZCBhbiBJT1NRRSBmbGFnLCB0
aG9zZSBhcmUgbW9zdGx5IHJlc2VydmVkIGZvcg0KPj4+ICAgbW9kaWZpZXJzIHRoYXQgYXBwbHkg
dG8gKG1vc3RseSkgYWxsIGtpbmRzIG9mIHJlcXVlc3RzDQo+Pj4gMikgSSB0aGluayB0aGlzIHdv
dWxkIGJlIGNsZWFuZXIgYXMgYSBzZXBhcmF0ZSBjb21tYW5kLCByYXRoZXIgdGhhbg0KPj4+ICAg
bmVlZCBvZGQgYWRqdXN0bWVudHMgYW5kIGlvdiBhc3N1bXB0aW9ucy4gVGhhdCBhbHNvIGdldHMg
aXQgb3V0DQo+Pj4gICBvZiB0aGUgZmFzdCBwYXRoLg0KPj4+IA0KPj4+IEknZCBhZGQgSU9SSU5H
X09QX1JFQURWX1BJIGFuZCBJT1JJTkdfT1BfV1JJVEVWX1BJIGZvciB0aGlzLCBJIHRoaW5rDQo+
Pj4geW91J2QgZW5kIHVwIHdpdGggYSBtdWNoIGNsZWFuZXIgaW1wbGVtZW50YXRpb24gdGhhdCB3
YXkuDQo+PiANCj4+IEFncmVlZC4gIEkgYWxzbyB3b25kZXIgaWYgd2UgY291bGQgZG8gc2FuZXIg
cGFyYW10ZXIgcGFzc2luZy4NCj4+IEUuZy4gcGFzcyBhIHNlcGFyYXRlIHBvaW50ZXIgdG8gdGhl
IFBJIGRhdGEgaWYgd2UgZmluZCBzcGFjZSBmb3INCj4+IHRoYXQgc29tZXdoZXJlIGluIHRoZSBT
UUUuDQo+IA0KPiBZZWFoLCB0aGUgd2hvbGUgInB1dCBQSSBpbiB0aGUgbGFzdCBpb3ZlYyIgbWFr
ZXMgdGhlIGNvZGUgcmVhbGx5IHVnbHkNCj4gZGVhbGluZyB3aXRoIGl0LiBXb3VsZCBiZSBhIGxv
dCBjbGVhbmVyIHRvIHNlcGFyYXRlIHRoZSB0d28uIElNSE8gdGhpcw0KPiBpcyBsYXJnZWx5IGEg
d29yay1hcm91bmQgdGhhdCB5b3UnZCBhcHBseSB0byBzeXNjYWxsIGludGVyZmFjZXMgdGhhdA0K
PiBvbmx5IHRha2UgdGhlIGlvdmVjLCBidXQgd2UgZG9uJ3QgbmVlZCB0byB3b3JrIGFyb3VuZCBp
dCBoZXJlIGlmIHdlIGNhbg0KPiBkZWZpbmUgYSBjbGVhbiBjb21tYW5kIHVwZnJvbnQuDQo+IA0K
PiBBbmQgaWYgd2UgZG9uJ3QgbmVlZCB2ZWN0b3JlZCByZXF1ZXN0cyBmb3IgdGhlIGRhdGEgcGFy
dCwgdGhlbiBldmVuDQo+IGJldHRlci4gVGhhdCBvbmUgbWlnaHQgbm90IGJlIGZlYXNpYmxlLCBi
dXQgZmlndXJlZCBJJ2QgdG9zcyBpdCBvdXQNCj4gdGhlcmUuDQo+IA0KPiAtLSANCj4gSmVucyBB
eGJvZQ0KPiANCg0K
