Return-Path: <Adam.Manzanares@wdc.com>
Date: Thu, 13 Oct 2016 16:37:43 -0700
From: Adam Manzanares <adam.manzanares@wdc.com>
To: Tejun Heo <tj@kernel.org>
CC: Adam Manzanares <adam.manzanares@hgst.com>, <axboe@kernel.dk>,
	<dan.j.williams@intel.com>, <hare@suse.de>, <martin.petersen@oracle.com>,
	<mchristi@redhat.com>, <toshi.kani@hpe.com>, <ming.lei@canonical.com>,
	<sathya.prakash@broadcom.com>, <chaitra.basappa@broadcom.com>,
	<suganath-prabu.subramani@broadcom.com>, <linux-block@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] ata: ATA Command Priority Disabled By Default
Message-ID: <20161013233742.GA5854@hgst.com>
References: <1476399631-5799-1-git-send-email-adam.manzanares@hgst.com>
 <1476399631-5799-5-git-send-email-adam.manzanares@hgst.com>
 <20161013232230.GB32534@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20161013232230.GB32534@mtj.duckdns.org>
Return-Path: adam.manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

SGVsbG8gVGVqdW4sCgpUaGUgMTAvMTMvMjAxNiAxOToyMiwgVGVqdW4gSGVvIHdyb3RlOgo+IEhl
bGxvLCBBZGFtLgo+IAo+IFNvcnJ5IGFib3V0IGxhdGUgcmVwbHkuICBXYXMgb24gdmFjYXRpb24u
CgpOUCBJIHdhcyBvbiB2YWNhdGlvbiBhdCB0aGUgZW5kIG9mIHRoZSB3ZWVrIGxhc3Qgd2Vlay4K
Cj4gCj4gT24gVGh1LCBPY3QgMTMsIDIwMTYgYXQgMDQ6MDA6MzFQTSAtMDcwMCwgQWRhbSBNYW56
YW5hcmVzIHdyb3RlOgo+ID4gQWRkIGEgc3lzZnMgZW50cnkgdG8gdHVybiBvbiBwcmlvcml0eSBp
bmZvcm1hdGlvbiBiZWluZyBwYXNzZWQKPiA+IHRvIGEgQVRBIGRldmljZS4gQnkgZGVmYXVsdCB0
aGlzIGZlYXR1cmUgaXMgdHVybmVkIG9mZi4KPiA+IAo+ID4gVGhpcyBwYXRjaCBkZXBlbmRzIG9u
IGF0YTogRW5hYmxpbmcgQVRBIENvbW1hbmQgUHJpb3JpdGllcwo+IAo+IExvb2tzIGdlbmVyYWxs
eSBnb29kIGJ1dCBjYW4gd2UgcGxlYXNlIHVzZSBhIGRldmljZSBhdHRyaWJ1dGUgbmFtZQo+IHdo
aWNoIGlzIG1vcmUgc3BlY2lmaWMgLSBpZS4gZW5hYmxlX25jcV9wcmlvPwoKV2lsbCBkbywgSSds
bCBhbHNvIGRvdWJsZSBjaGVjayB0aGUgbmFtaW5nIHNjaGVtZSBvZiBmdW5jdGlvbnMgYW5kIHZh
cmlhYmxlcyAKYWxzby4gVGhlIGZ1bmN0aW9ucyB0aGF0IGNoZWNrIGlmIHRoZSBkZXZpY2UgaGFz
IHRoZSBuY3EgcHJpbyBjYXBhYmlsaXR5IG1pZ2h0CmJlIHRvbyBzaW1pbGFyIHRvIHRoZSBmdW5j
dGlvbiB0aGF0IGNoZWNrcyBpZiB0aGUgZGV2aWNlIGF0dHJpYnV0ZSBpcyAKZW5hYmxlZC4KCj4g
Cj4gVGhhbmtzLgo+IAo+IC0tIAo+IHRlanVuCgpUYWtlIGNhcmUsCkFkYW0KV2VzdGVybiBEaWdp
dGFsIENvcnBvcmF0aW9uIChhbmQgaXRzIHN1YnNpZGlhcmllcykgRS1tYWlsIENvbmZpZGVudGlh
bGl0eSBOb3RpY2UgJiBEaXNjbGFpbWVyOgoKVGhpcyBlLW1haWwgYW5kIGFueSBmaWxlcyB0cmFu
c21pdHRlZCB3aXRoIGl0IG1heSBjb250YWluIGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gb2YgV0RDIGFuZC9vciBpdHMgYWZmaWxpYXRlcywgYW5kIGFyZSBp
bnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRv
IHdoaWNoIHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudCwgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiBvciBhbnkgYWN0
aW9uIHRha2VuIG9yIG9taXR0ZWQgdG8gYmUgdGFrZW4gaW4gcmVsaWFuY2Ugb24gaXQsIGlzIHBy
b2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0aGUgZS1tYWlsIGlu
IGl0cyBlbnRpcmV0eSBmcm9tIHlvdXIgc3lzdGVtLgo=
