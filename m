Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hare@suse.com" <hare@suse.com>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 7/7] block: Make SCSI device suspend and resume work
 reliably
Date: Tue, 26 Sep 2017 14:44:53 +0000
Message-ID: <1506437092.3787.27.camel@wdc.com>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
	 <20170925202924.16603-8-bart.vanassche@wdc.com>
	 <20170925225911.GC18137@ming.t460p> <1506381226.2641.60.camel@wdc.com>
	 <20170926083252.GB518@ming.t460p>
In-Reply-To: <20170926083252.GB518@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTA5LTI2IGF0IDE2OjMyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
TW9uLCBTZXAgMjUsIDIwMTcgYXQgMTE6MTM6NDdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IFNvcnJ5IGJ1dCBJIGRpc2FncmVlLiBJJ20gdXNpbmcgUkNVIHRvIGFjaGlldmUg
dGhlIHNhbWUgZWZmZWN0IGFzIGEgYmFycmllcg0KPiA+IGFuZCB0byBtb3ZlIHRoZSBjb3N0IG9m
IHRoZSBiYXJyaWVyIGZyb20gdGhlIHJlYWRlciB0byB0aGUgdXBkYXRlci4gU2VlIGFsc28NCj4g
PiBQYXVsIEUuIE1jS2VubmV5LCBNYXRoaWV1IERlc25veWVycywgTGFpIEppYW5nc2hhbiwgYW5k
IEpvc2ggVHJpcGxldHQsDQo+ID4gVGhlIFJDVS1iYXJyaWVyIG1lbmFnZXJpZSwgTFdOLm5ldCwg
Tm92ZW1iZXIgMTIsIDIwMTMNCj4gPiAoaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzU3MzQ5Ny8p
Lg0KPiANCj4gTGV0IG1lIGV4cGxhaW4gaXQgaW4gYSBiaXQgZGV0YWlsczogWyAuLi4gXQ0KDQpU
aGUgYXBwcm9hY2ggSSB1c2VkIGluIHBhdGNoIDcvNyBpcyBpZGVudGljYWwgdG8gb25lIG9mIHRo
ZSBhcHByb2FjaGVzIGV4cGxhaW5lZA0KaW4gdGhlIGFydGljbGUgSSByZWZlcnJlZCB0by4gSWYg
eW91IGRvIG5vdCBhZ3JlZSB0aGF0IHRoYXQgYXBwcm9hY2ggaXMgc2FmZSB0aGF0DQptZWFucyB0
aGF0IHlvdSBkbyBub3QgbmVpdGhlciBhZ3JlZSB3aXRoIFBhdWwgTWNLZW5uZXkncyB2aWV3IG9u
IGhvdyBSQ1Ugd29ya3MuDQpEbyB5b3UgcmVhbGx5IHRoaW5rIHRoYXQgeW91IGtub3cgbW9yZSBh
Ym91dCBSQ1UgdGhhbiBQYXVsIE1jS2VubmV5Pw0KDQpCYXJ0Lg==
