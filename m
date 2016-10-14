Return-Path: <Adam.Manzanares@wdc.com>
Date: Fri, 14 Oct 2016 11:08:32 -0700
From: Adam Manzanares <adam.manzanares@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Shaun Tancheff <shaun.tancheff@seagate.com>, Adam Manzanares
	<adam.manzanares@hgst.com>, Jens Axboe <axboe@kernel.dk>, Tejun Heo
	<tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke
	<hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mike
 Christie <mchristi@redhat.com>, Toshi Kani <toshi.kani@hpe.com>, Ming Lei
	<ming.lei@canonical.com>, Sathya Prakash <sathya.prakash@broadcom.com>,
	<chaitra.basappa@broadcom.com>, <suganath-prabu.subramani@broadcom.com>,
	<linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <MPT-FusionLinux.pdl@broadcom.com>,
	<linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] fusion: remove iopriority handling
Message-ID: <20161014180832.GA6788@hgst.com>
References: <1476399631-5799-1-git-send-email-adam.manzanares@hgst.com>
 <1476399631-5799-3-git-send-email-adam.manzanares@hgst.com>
 <CAJVOszDaOiDN1nMW7X6pgEkjSkE9+hNE0doUc-hweJc-qtAu3w@mail.gmail.com>
 <20161014053449.GA16510@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20161014053449.GA16510@infradead.org>
Return-Path: adam.manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

VGggMTAvMTMvMjAxNiAyMjozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBTdHlsZSB3
aXNlIHlvdSBjYW4gZnVydGhlciByZW1vdmUgdGhlIGV4dHJhIHBhcmVucyBhcm91bmQKPiA+ICAg
U0NwbnQtPmRldmljZS0+dGFnZ2VkX3N1cHBvcnRlZAo+ID4gQXMgd2VsbCBhcyB0aGUgbm93IHJl
ZHVuZGFudCBicmFjZXMuCj4gCj4gSSBkaWQgc2VuZCBhIHBhdGNoIGxvb2tpbmcganVzdCBsaWtl
IHRoYXQgZWFybGllciA6KQoKSSdsbCByZW1vdmUgdGhlIHBhdGNoIGZyb20gdGhlIHBhdGNoc2V0
LiBJIG11c3QgaGF2ZSBtaXNzZWQgdGhlIHBhdGNoIAp5b3UgYXJlIHJlZmVyZW5jaW5nLgoKVGFr
ZSBjYXJlLApBZGFtCldlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbiAoYW5kIGl0cyBzdWJzaWRp
YXJpZXMpIEUtbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICYgRGlzY2xhaW1lcjoKClRoaXMg
ZS1tYWlsIGFuZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBtYXkgY29udGFpbiBjb25m
aWRlbnRpYWwgb3IgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIG9mIFdEQyBhbmQvb3Ig
aXRzIGFmZmlsaWF0ZXMsIGFuZCBhcmUgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRo
ZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aGljaCB0aGV5IGFyZSBhZGRyZXNzZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGFueSBkaXNjbG9zdXJlLCBjb3B5aW5n
LCBkaXN0cmlidXRpb24gb3IgYW55IGFjdGlvbiB0YWtlbiBvciBvbWl0dGVkIHRvIGJlIHRha2Vu
IGluIHJlbGlhbmNlIG9uIGl0LCBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGFuZCBkZWxldGUgdGhlIGUtbWFpbCBpbiBpdHMgZW50aXJldHkgZnJvbSB5b3VyIHN5c3RlbS4K
