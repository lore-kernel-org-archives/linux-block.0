Return-Path: <prvs=5980fa318=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>, "snitzer@redhat.com"
	<snitzer@redhat.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"mroos@linux.ee" <mroos@linux.ee>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "don.brace@microsemi.com"
	<don.brace@microsemi.com>, "james.bottomley@hansenpartnership.com"
	<james.bottomley@hansenpartnership.com>, "arun.easi@cavium.com"
	<arun.easi@cavium.com>, "osandov@fb.com" <osandov@fb.com>,
	"loberman@redhat.com" <loberman@redhat.com>, "kashyap.desai@broadcom.com"
	<kashyap.desai@broadcom.com>, "peter.rivera@broadcom.com"
	<peter.rivera@broadcom.com>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Date: Thu, 8 Mar 2018 15:31:48 +0000
Message-ID: <1520523107.3383.1.camel@wdc.com>
References: <20180227100750.32299-1-ming.lei@redhat.com>
	 <20180227100750.32299-2-ming.lei@redhat.com>
	 <20180308075035.GE15748@lst.de> <20180308081527.GA24816@ming.t460p>
	 <ad59f1bc-5db6-1f27-9924-b043b76d5257@suse.de>
In-Reply-To: <ad59f1bc-5db6-1f27-9924-b043b76d5257@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTA4IGF0IDA5OjQxICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IElFIHRoZSBfZW50aXJlXyByZXF1ZXN0IHNldCBpcyBhbGxvY2F0ZWQgYXMgX29uZV8gYXJy
YXksIG1ha2luZyBpdCBxdWl0ZQ0KPiBoYXJkIHRvIGhhbmRsZSBmcm9tIHRoZSBsb3dlci1sZXZl
bCBDUFUgY2FjaGVzLg0KPiBBbHNvIHRoZSAnbm9kZScgaW5kaWNhdG9yIGRvZXNuJ3QgcmVhbGx5
IGhlbHAgdXMgaGVyZSwgYXMgdGhlIHJlcXVlc3RzDQo+IGhhdmUgdG8gYmUgYWNjZXNzIGJ5IGFs
bCBDUFVzIGluIHRoZSBzaGFyZWQgdGFnIGNhc2UuDQo+IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJs
ZSBtb3ZlIHRhZ3MtPnJxcyB0byBiZWNvbWUgYSBfZG91YmxlXyBwb2ludGVyPw0KPiBUaGVuIHdl
IHdvdWxkIGhhdmUgb25seSBhIHNoYXJlZCBsb29rdXAgdGFibGUsIGJ1dCB0aGUgcmVxdWVzdHMN
Cj4gdGhlbXNlbHZlcyBjYW4gYmUgYWxsb2NhdGVkIHBlciBub2RlLCBkZXBlbmRpbmcgb24gdGhl
IENQVSBtYXAuDQo+IF9BbmRfIGl0IHNob3VsZCBiZSBlYXNpZXIgb24gdGhlIENQVSBjYWNoZSAu
Li4NCg0KVGhhdCBpcyBvbmUgcG9zc2libGUgc29sdXRpb24uIEFub3RoZXIgc29sdXRpb24gaXMg
dG8gZm9sbG93IHRoZSBhcHByb2FjaA0KZnJvbSBzYml0bWFwOiBhbGxvY2F0ZSBhIHNpbmdsZSBh
cnJheSB0aGF0IGlzIHNsaWdodGx5IGxhcmdlciB0aGFuIG5lZWRlZA0KYW5kIHVzZSB0aGUgZWxl
bWVudHMgaW4gc3VjaCBhIHdheSB0aGF0IG5vIHR3byBDUFVzIHVzZSB0aGUgc2FtZSBjYWNoZQ0K
bGluZS4NCg0KQmFydC4NCg0KDQoNCg0K
