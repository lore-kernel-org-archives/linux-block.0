Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH V3 7/8] block: allow to allocate req with REQF_PREEMPT
 when queue is preempt frozen
Date: Tue, 5 Sep 2017 01:40:11 +0000
Message-ID: <1504575610.3360.7.camel@wdc.com>
References: <20170902130840.24609-1-ming.lei@redhat.com>
         <20170902130840.24609-8-ming.lei@redhat.com>
         <20170902131208.GA10940@ming.t460p> <1504498405.10804.10.camel@wdc.com>
         <20170904071653.GD7959@ming.t460p> <1504539634.3189.15.camel@wdc.com>
         <20170904160813.GA21757@ming.t460p>
In-Reply-To: <20170904160813.GA21757@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTA5LTA1IGF0IDAwOjA4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
TW9uLCBTZXAgMDQsIDIwMTcgYXQgMDM6NDA6MzVQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IEhhdmUgeW91IGNvbnNpZGVyZWQgdG8gdXNlIHRoZSBibGstbXEgInJlc2VydmVk
IHJlcXVlc3QiIG1lY2hhbmlzbSB0byBhdm9pZA0KPiA+IHN0YXJ2YXRpb24gb2YgcG93ZXIgbWFu
YWdlbWVudCByZXF1ZXN0cyBpbnN0ZWFkIG9mIG1ha2luZyB0aGUgYmxvY2sgbGF5ZXINCj4gPiBl
dmVuIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBpdCBhbHJlYWR5IGlzPw0KPiANCj4gcmVzZXJ2ZWQg
cmVxdWVzdCBpcyByZWFsbHkgYSBiYWQgaWRlYSwgdGhhdCBtZWFucyB0aGUgcmVzZXJ2ZWQgcmVx
dWVzdA0KPiBjYW4ndCBiZSB1c2VkIGZvciBub3JtYWwgSS9PLCB3ZSBhbGwga25vdyB0aGUgcmVx
dWVzdC90YWcgc3BhY2UgaXMNCj4gcHJlY2lvdXMsIGFuZCBzb21lIGRldmljZSBoYXMgYSBxdWl0
ZSBzbWFsbCB0YWcgc3BhY2UsIHN1Y2ggYXMgc2F0YS4NCj4gVGhpcyB3YXkgd2lsbCBhZmZlY3Qg
cGVyZm9ybWFuY2UgZGVmaW5pdGVseS4NCg0KU29ycnkgYnV0IEknbSBuZWl0aGVyIGNvbnZpbmNl
ZCB0aGF0IHJlc2VydmluZyBhIHJlcXVlc3QgZm9yIHBvd2VyIG1hbmFnZW1lbnQgDQp3b3VsZCBi
ZSBhIGJhZCBpZGVhIG5vciB0aGF0IGl0IHdvdWxkIGhhdmUgYSBzaWduaWZpY2FudCBwZXJmb3Jt
YW5jZSBpbXBhY3Qgbm9yDQp0aGF0IGl0IHdvdWxkIGJlIGNvbXBsaWNhdGVkIHRvIGltcGxlbWVu
dC4gSGF2ZSB5b3Ugbm90aWNlZCB0aGF0IHRoZSBMaW51eCBBVEENCmltcGxlbWVudGF0aW9uIGFs
cmVhZHkgcmVzZXJ2ZXMgYSByZXF1ZXN0IGZvciBpbnRlcm5hbCB1c2UgYW5kIHRoZXJlYnkgcmVk
dWNlcw0KdGhlIHF1ZXVlIGRlcHRoIGZyb20gMzIgdG8gMzEgKHNlZSBhbHNvIEFUQV9UQUdfSU5U
RVJOQUwpPyBXaGF0IEkgd291bGQgbGlrZSB0bw0Ka25vdyBpZiBpcyB3aGV0aGVyIHRoZSBwZXJm
b3JtYW5jZSBpbXBhY3Qgb2YgcmVzZXJ2aW5nIGEgcmVxdWVzdCBpcyBtb3JlIG9yIGxlc3MNCnRo
YW4gMSUuDQoNCkJhcnQu
