Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26390 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdIOVno (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 17:43:44 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 5/5] dm-mpath: improve I/O schedule
Date: Fri, 15 Sep 2017 21:42:55 +0000
Message-ID: <1505511774.2705.3.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
         <20170915164456.9803-6-ming.lei@redhat.com>
In-Reply-To: <20170915164456.9803-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTE2IGF0IDAwOjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3N0
YXRpYyB2b2lkIHNhdmVfcGF0aF9xdWV1ZV9kZXB0aChzdHJ1Y3QgcGdwYXRoICpwKQ0KPiArew0K
PiArCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0gYmRldl9nZXRfcXVldWUocC0+cGF0aC5kZXYt
PmJkZXYpOw0KPiArDQo+ICsJcC0+b2xkX25yX3JlcXVlc3RzID0gcS0+bnJfcmVxdWVzdHM7DQo+
ICsJcC0+cXVldWVfZGVwdGggPSBxLT5xdWV1ZV9kZXB0aDsNCj4gKw0KPiArCS8qIG9uZSBleHRy
YSByZXF1ZXN0IGZvciBtYWtpbmcgdGhlIHBpcGVsaW5lIGZ1bGwgKi8NCj4gKwlpZiAocC0+cXVl
dWVfZGVwdGgpDQo+ICsJCWJsa191cGRhdGVfbnJfcmVxdWVzdHMocSwgcC0+cXVldWVfZGVwdGgg
KyAxKTsNCj4gK30NCg0KYmxrX21xX2luaXRfYWxsb2NhdGVkX3F1ZXVlKCkgaW5pdGlhbGl6ZXMg
bnJfcmVxdWVzdHMgdG8gdGhlIHRhZyBzZXQgcXVldWUgZGVwdGguDQpEb2VzIHRoYXQgbWVhbiB0
aGF0IHRoZSBhYm92ZSBjb2RlIGluY3JlYXNlcyBucl9yZXF1ZXN0cyBieSBvbmU/IElmIHNvLCBk
b2VzDQp0aGF0IGNoYW5nZSBvbmx5IHJlc3VsdCBpbiBhIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50
IGZvciB0aGUgcXVldWUgZGVwdGgNCm1lbnRpb25lZCBpbiB0aGUgcGF0aCBkZXNjcmlwdGlvbiAo
Myk/IFNvcnJ5IGJ1dCBJIGRvdWJ0IHRoYXQgdGhpcyBjaGFuZ2Ugd2lsbA0KeWllbGQgYSBzaWdu
aWZpY2FudCBpbXByb3ZlbWVudCBmb3IgaGlnaGVyIHF1ZXVlIGRlcHRocy4gRG9lcyB0aGF0IG1l
YW4gdGhhdA0KdGhpcyBwYXRjaCBjYW4gYmUgbGVmdCBvdXQ/DQoNClRoYW5rcywNCg0KQmFydC4=
