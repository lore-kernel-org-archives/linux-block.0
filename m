Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38014 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbdLDWuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 17:50:05 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hare@suse.com" <hare@suse.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] SCSI: delay run queue if device is blocked in
 scsi_dev_queue_ready()
Date: Mon, 4 Dec 2017 22:49:55 +0000
Message-ID: <1512427794.2795.15.camel@wdc.com>
References: <20171202163150.1273-1-ming.lei@redhat.com>
         <1512400159.23838.1.camel@wdc.com> <20171204224507.GB6888@ming.t460p>
In-Reply-To: <20171204224507.GB6888@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE3LTEyLTA1IGF0IDA2OjQ1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
TW9uLCBEZWMgMDQsIDIwMTcgYXQgMDM6MDk6MjBQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFN1biwgMjAxNy0xMi0wMyBhdCAwMDozMSArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBGaXhlczogMGRmMjFjODZiZGJmICgic2NzaTogaW1wbGVtZW50IC5nZXRfYnVk
Z2V0IGFuZCAucHV0X2J1ZGdldCBmb3IgYmxrLW1xIikNCj4gPiANCj4gPiBJdCBtaWdodCBiZSBz
YWZlciB0byByZXZlcnQgY29tbWl0IDBkZjIxYzg2YmRiZiBpbnN0ZWFkIG9mIHRyeWluZyB0byBm
aXggYWxsDQo+ID4gaXNzdWVzIGludHJvZHVjZWQgYnkgdGhhdCBjb21taXQgZm9yIGtlcm5lbCB2
ZXJzaW9uIHY0LjE1IC4uLg0KPiANCj4gV2hhdCBhcmUgYWxsIGlzc3VlcyBpbiB2NC4xNS1yYz8g
VXAgdG8gbm93LCBpdCBpcyB0aGUgb25seSBpc3N1ZSByZXBvcnRlZCwNCj4gYW5kIGNhbiBiZSBm
aXhlZCBieSB0aGlzIHNpbXBsZSBwYXRjaCwgd2hpY2ggb25lIGNhbiBiZSB0aG91Z2h0IGFzIGNs
ZWFudXANCj4gdG9vLg0KDQpUaGUgdGhyZWUgaXNzdWVzIEkgZGVzY3JpYmVkIGluIHRoZSBjb21t
aXQgbWVzc2FnZSBvZiB0aGUgcGF0Y2ggdGhhdCBpcyBhdmFpbGFibGUgYXQ6DQpodHRwczovL21h
cmMuaW5mby8/bD1saW51eC1ibG9jayZtPTE1MTI0MDg2NjAxMDU3Mi4NCg0KQmFydC4=
