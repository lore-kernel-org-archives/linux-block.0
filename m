Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21306 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752832AbdD0XMk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 19:12:40 -0400
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: hide badblocks attribute by default
Date: Thu, 27 Apr 2017 23:12:38 +0000
Message-ID: <1493334676.30844.5.camel@intel.com>
References: <149332958627.40858.3562179022452904734.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149332958627.40858.3562179022452904734.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA0LTI3IGF0IDE0OjQ2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IENvbW1pdCA5OWU2NjA4YzllNzQgImJsb2NrOiBBZGQgYmFkYmxvY2sgbWFuYWdlbWVudCBmb3Ig
Z2VuZGlza3MiDQo+IGFsbG93ZWQgZm9yIGRyaXZlcnMgbGlrZSBwbWVtIGFuZCBzb2Z0d2FyZS1y
YWlkIHRvIGFkdmVydGlzZSBhIGxpc3Qgb2YNCj4gYmFkIG1lZGlhIGFyZWFzLiBIb3dldmVyLCBp
dCBpbmFkdmVydGVudGx5IGFkZGVkIGEgJ2JhZGJsb2NrcycgdG8gYWxsDQo+IGJsb2NrIGRldmlj
ZXMuIExldHMgY2xlYW4gdGhpcyB1cCBieSBoYXZpbmcgdGhlICdiYWRibG9ja3MnIGF0dHJpYnV0
ZQ0KPiBub3QgYmUgdmlzaWJsZSB3aGVuIHRoZSBkcml2ZXIgaGFzIG5vdCBwb3B1bGF0ZWQgYSAn
c3RydWN0IGJhZGJsb2NrcycNCj4gaW5zdGFuY2UgaW4gdGhlIGdlbmRpc2suDQo+IA0KPiBDYzog
SmVucyBBeGJvZSA8YXhib2VAZmIuY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+DQo+IENjOiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUu
Y29tPg0KPiBSZXBvcnRlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gwqBibG9jay9nZW5oZC5jIHzCoMKgwqAxMSArKysrKysrKysrKw0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KVGVzdGVkIHRoYXQgdGhpcyBy
ZW1vdmVzIHRoZSBiYWRibG9ja3MgYXR0cmlidXRlIGZvciBibG9jayBkZXZpY2VzIHRoYXQNCmRv
bid0IHVzZSB0aGVtOg0KDQokIGNhdCAvc3lzL2Jsb2NrL3BtZW02L2JhZGJsb2Nrc8KgDQo2MTU3
NiA4DQoNCiQgY2F0IC9zeXMvYmxvY2svdmRhL2JhZGJsb2Nrc8KgDQpjYXQ6IC9zeXMvYmxvY2sv
dmRhL2JhZGJsb2NrczogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KDQpUZXN0ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg==
