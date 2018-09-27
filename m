Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40466 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbeI1F41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Sep 2018 01:56:27 -0400
From: Jens Axboe <axboe@fb.com>
To: Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 0/5] kyber: better heuristics
Date: Thu, 27 Sep 2018 23:35:33 +0000
Message-ID: <d97a3733-a50d-7aa0-22b5-4f6cecda28a5@fb.com>
References: <cover.1538088475.git.osandov@fb.com>
In-Reply-To: <cover.1538088475.git.osandov@fb.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gOS8yNy8xOCA0OjU1IFBNLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0KPiBGcm9tOiBPbWFyIFNh
bmRvdmFsIDxvc2FuZG92QGZiLmNvbT4NCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBpcyBteSBzZXJp
ZXMgdG8gaW1wcm92ZSB0aGUgaGV1cmlzdGljcyB1c2VkIGJ5IEt5YmVyLiBQYXRjaGVzIDEgYW5k
DQo+IDIgYXJlIHByZXBhcmF0aW9uLiBQYXRjaCAzIGlzIGEgbWlub3Igb3B0aW1pemF0aW9uLiBQ
YXRjaCA0IGlzIHRoZSBtYWluDQo+IGNoYW5nZSwgYW5kIGluY2x1ZGVzIGEgZGV0YWlsZWQgZGVz
Y3JpcHRpb24gb2YgdGhlIG5ldyBoZXVyaXN0aWNzLiBQYXRjaA0KPiA1IGFkZHMgdHJhY2Vwb2lu
dHMgZm9yIGRlYnVnZ2luZy4gVGhpcyBpcyBiYXNpY2FsbHkgdGhlIHNhbWUgYXMgdGhlIFJGQw0K
PiBJIHBvc3RlZCBiYWNrIGluIEF1Z3VzdCBbMV0gd2l0aCBvbmUgYWRkZWQgdHJhY2Vwb2ludCAo
a3liZXJfdGhyb3R0bGVkKQ0KPiBhbmQgcmViYXNlZCBvbiBsaW51eC1ibG9jay9mb3ItbmV4dC4N
Cg0KQXBwbGllZCBmb3IgNC4yMCwgdGhhbmtzIE9tYXIuDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
