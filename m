Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46190 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdJ0Exd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 00:53:33 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Fri, 27 Oct 2017 04:53:18 +0000
Message-ID: <1509079996.3244.3.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
In-Reply-To: <20171027044330.11921-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEwLTI3IGF0IDEyOjQzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
IDFzdCBwYXRjaCByZW1vdmVzIHRoZSBSRVNUQVJUIGZvciBUQUctU0hBUkVEIGJlY2F1c2UgU0NT
SSBoYW5kbGVzIGl0DQo+IGJ5IGl0c2VsZiwgYW5kIG5vdCBuZWNlc3NhcnkgdG8gd2FzdGUgQ1BV
IHRvIGRvIHRoZSBleHBlbnNpdmUgUkVTVEFSVC4NCj4gQW5kIFJvbWFuIFBlbiByZXBvcnRlZCB0
aGF0IHRoaXMgUkVTVEFSVCBjdXRzIGhhbGYgb2YgSU9QUyBpbiBoaXMgY2FzZS4NCj4gDQo+IFRo
ZSAybmQgcGF0Y2ggcmVtb3ZlcyB0aGUgUkVTVEFSVCB3aGVuIC5nZXRfYnVkZ2V0IHJldHVybnMg
QkxLX1NUU19SRVNPVVJDRSwNCj4gYW5kIHRoaXMgUkVTVEFSVCBpcyBoYW5kbGVkIGJ5IFNDU0kn
cyBSRVNUQVJUKHNjc2lfZW5kX3JlcXVlc3QoKSkgdG9vLg0KDQpIZWxsbyBNaW5nLA0KDQpUaGVy
ZSBhcmUgbW9yZSBibG9jayBkcml2ZXJzIHRoYW4gdGhlIFNDU0kgY29yZSB0aGF0IHNoYXJlIHRh
Z3MuIElmIHRoZQ0KcmVzdGFydCBtZWNoYW5pc20gaXMgcmVtb3ZlZCBmcm9tIHRoZSBibGstbXEg
Y29yZSwgZG9lcyB0aGF0IG1lYW4gdGhhdCBhbGwNCmJsb2NrIGRyaXZlcnMgdGhhdCBzaGFyZSB0
YWdzIHdpbGwgaGF2ZSB0byBmb2xsb3cgdGhlIGV4YW1wbGUgb2YgdGhlIFNDU0kNCmNvcmUgYW5k
IGltcGxlbWVudCBhIHJlc3RhcnQgbWVjaGFuaXNtIHRoZW1zZWx2ZXM/IEFzIGZhciBhcyBJIGtu
b3cgdGhlcmUNCmlzIGEgc3Ryb25nIHByZWZlcmVuY2UgaW4gdGhlIExpbnV4IGNvbW11bml0eSB0
byBpbXBsZW1lbnQgY29tbW9uIG1lY2hhbmlzbXMNCmluIHRoZSAoYmxvY2sgbGF5ZXIpIGNvcmUg
aW5zdGVhZCBvZiBpbiBkcml2ZXJzLiBJdCBzZWVtcyB0byBtZSBsaWtlIHlvdSBhcmUNCnByb3Bv
c2luZyB0aGUgb3Bwb3NpdGUsIG5hbWVseSByZW1vdmluZyBhIGdlbmVyYWwgbWVjaGFuaXNtIGZy
b20gdGhlIChibG9jaw0KbGF5ZXIpIGNvcmUgYW5kIG1vdmluZyBpdCBpbnRvIGEgZHJpdmVyLCBu
YW1lbHkgdGhlIFNDU0kgY29yZT8NCg0KQmFydC4=
