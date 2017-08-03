Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23657 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdHCBgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2017 21:36:16 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 04/14] blk-mq-sched: improve dispatching from sw queue
Date: Thu, 3 Aug 2017 01:35:29 +0000
Message-ID: <1501724126.30887.3.camel@wdc.com>
References: <20170731165111.11536-1-ming.lei@redhat.com>
         <20170731165111.11536-6-ming.lei@redhat.com>
         <1501544074.2466.29.camel@wdc.com> <20170801101718.GB31452@ming.t460p>
         <20170801105013.GD31452@ming.t460p> <1501600301.2475.1.camel@wdc.com>
         <20170802033135.GB7267@ming.t460p>
In-Reply-To: <20170802033135.GB7267@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTAyIGF0IDExOjMxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMDEsIDIwMTcgYXQgMDM6MTE6NDJQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAxNy0wOC0wMSBhdCAxODo1MCArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBPbiBUdWUsIEF1ZyAwMSwgMjAxNyBhdCAwNjoxNzoxOFBNICswODAwLCBNaW5n
IExlaSB3cm90ZToNCj4gPiA+ID4gSG93IGNhbiB3ZSBnZXQgdGhlIGFjY3VyYXRlICdudW1iZXIg
b2YgcmVxdWVzdHMgaW4gcHJvZ3Jlc3MnIGVmZmljaWVudGx5Pw0KPiA+IA0KPiA+IEhlbGxvIE1p
bmcsDQo+ID4gDQo+ID4gSG93IGFib3V0IGNvdW50aW5nIHRoZSBudW1iZXIgb2YgYml0cyB0aGF0
IGhhdmUgYmVlbiBzZXQgaW4gdGhlIHRhZyBzZXQ/DQo+ID4gSSBhbSBhd2FyZSB0aGF0IHRoZXNl
IGJpdHMgY2FuIGJlIHNldCBhbmQvb3IgY2xlYXJlZCBjb25jdXJyZW50bHkgd2l0aCB0aGUNCj4g
PiBkaXNwYXRjaCBjb2RlIGJ1dCB0aGF0IGNvdW50IGlzIHByb2JhYmx5IGEgZ29vZCBzdGFydGlu
ZyBwb2ludC4NCj4gDQo+IEl0IGhhcyB0byBiZSBhdG9taWNfdCwgd2hpY2ggaXMgdG9vIHRvbyBo
ZWF2eSBmb3IgdXMsIHBsZWFzZSBzZWUgdGhlIHJlcG9ydDoNCj4gDQo+IAlodHRwOi8vbWFyYy5p
bmZvLz90PTE0OTg2ODQ0ODQwMDAwMyZyPTEmdz0yDQo+IA0KPiBCb3RoIEplbnMgYW5kIEkgd2Fu
dCB0byBraWxsIGhkX3N0cnVjdC5pbl9mbGlnaHQsIGJ1dCBsb29rcyBzdGlsbCBubw0KPiBnb29k
IHdheS4gDQoNCkhlbGxvIE1pbmcsDQoNClNvcnJ5IGJ1dCBJIGRpc2FncmVlIHRoYXQgYSBuZXcg
YXRvbWljIHZhcmlhYmxlIHNob3VsZCBiZSBhZGRlZCB0byBrZWVwIHRyYWNrDQpvZiB0aGUgbnVt
YmVyIG9mIGJ1c3kgcmVxdWVzdHMuIENvdW50aW5nIHRoZSBudW1iZXIgb2YgYml0cyB0aGF0IGFy
ZSBzZXQgaW4NCnRoZSB0YWcgc2V0IHNob3VsZCBiZSBnb29kIGVub3VnaCBpbiB0aGlzIGNvbnRl
eHQuDQoNClRoYW5rcywNCg0KQmFydC4=
