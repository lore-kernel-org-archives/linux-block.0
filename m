Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65370 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIOR6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 13:58:20 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
Date: Fri, 15 Sep 2017 17:57:31 +0000
Message-ID: <1505498249.3420.15.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
         <20170915164456.9803-2-ming.lei@redhat.com>
In-Reply-To: <20170915164456.9803-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA5LTE2IGF0IDAwOjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gSWYg
LnF1ZXVlX3JxKCkgcmV0dXJucyBCTEtfU1RTX1JFU09VUkNFLCBibGstbXEgd2lsbCByZXJ1bg0K
PiB0aGUgcXVldWUgaW4gdGhlIHRocmVlIHNpdHVhdGlvbnM6DQo+IA0KPiAxKSBpZiBCTEtfTVFf
U19TQ0hFRF9SRVNUQVJUIGlzIHNldA0KPiAtIHF1ZXVlIGlzIHJlcnVuIGFmdGVyIG9uZSBycSBp
cyBjb21wbGV0ZWQsIHNlZSBibGtfbXFfc2NoZWRfcmVzdGFydCgpDQo+IHdoaWNoIGlzIHJ1biBm
cm9tIGJsa19tcV9mcmVlX3JlcXVlc3QoKQ0KPiANCj4gMikgQkxLX01RX1NfVEFHX1dBSVRJTkcg
aXMgc2V0DQo+IC0gcXVldWUgaXMgcmVydW4gYWZ0ZXIgb25lIHRhZyBpcyBmcmVlZA0KPiANCj4g
Mykgb3RoZXJ3aXNlDQo+IC0gcXVldWUgaXMgcnVuIGltbWVkaWF0ZWx5IGluIGJsa19tcV9kaXNw
YXRjaF9ycV9saXN0KCkNCj4gDQo+IFNvIGNhbGxpbmcgYmxrX21xX2RlbGF5X3J1bl9od19xdWV1
ZSgpIGluc2lkZSAucXVldWVfcnEoKSBkb2Vzbid0IG1ha2UNCj4gc2Vuc2UgYmVjYXVzZSBubyBt
YXR0ZXIgaXQgaXMgY2FsbGVkIG9yIG5vdCwgdGhlIHF1ZXVlIHN0aWxsIHdpbGwgYmUNCj4gcmVy
dW4gc29vbiBpbiBhYm92ZSB0aHJlZSBzaXR1YXRpb25zLCBhbmQgdGhlIGJ1c3kgcmVxIGNhbiBi
ZSBkaXNwYXRjaGVkDQo+IGFnYWluLg0KDQpOQUsNCg0KQmxvY2sgZHJpdmVycyBjYWxsIGJsa19t
cV9kZWxheV9ydW5faHdfcXVldWUoKSBpZiBpdCBpcyBrbm93biB0aGF0IHRoZSBxdWV1ZQ0KaGFz
IHRvIGJlIHJlcnVuIGxhdGVyIGV2ZW4gaWYgbm8gcmVxdWVzdCBoYXMgY29tcGxldGVkIGJlZm9y
ZSB0aGUgZGVsYXkgaGFzDQpleHBpcmVkLiBUaGlzIHBhdGNoIGJyZWFrcyBhdCBsZWFzdCB0aGUg
U0NTSSBjb3JlIGFuZCB0aGUgZG0tbXBhdGggZHJpdmVycy4NCg0KQmFydC4=
