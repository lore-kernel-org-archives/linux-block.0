Return-Path: <prvs=6422fe000=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v6] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
Date: Sat, 21 Apr 2018 15:05:11 +0000
Message-ID: <e885c77ec18a9c7f71ca7339202c7db10e8cbc04.camel@wdc.com>
References: <20180419164353.13561-1-bart.vanassche@wdc.com>
	 <18cd85bb-ee41-ce6f-e8c8-dcf6e7fd0504@oracle.com>
	 <a47209f74d52d19464f993c11c4a4811271e6348.camel@wdc.com>
	 <389cc1a6-6c2a-db08-fec1-1e103a6a9c9e@oracle.com>
	 <7183cb81-5fb5-eea2-afaf-443f26921257@kernel.dk>
	 <f806a661-4702-1757-94fe-243704974fa4@oracle.com>
In-Reply-To: <f806a661-4702-1757-94fe-243704974fa4@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE4LTA0LTIxIGF0IDIyOjU1ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBTbyB3ZSBoYXZlIGEgX19kZWFkbGluZSBhcyBiZWxvdzoNCj4gICAgICAgICAgICAgICAgICAN
Cj4gICAgIGRlYWRsaW5lICAgICBnZW4gc3RhdGUgICANCj4gPiBfX19fX19fX19fX19fX3xfX19f
fF98DQo+IA0KPiAgICAgICAgICAgICAgICBcX19fIF9fLyANCj4gICAgICAgICAgICAgICAgICAg
IFYNCj4gICAgICAgICAgICAgICBncmFudWxhcml0eSANCj4gDQo+IGFuZCBldmVuIHdlIHVzdWFs
bHkgaGF2ZSBhIDMwfjYwcyB0aW1lb3V0LA0KPiBidXQgd2Ugc2hvdWxkIHN1cHBvcnQgYSAxcyBn
cmFudWxhcml0eSBhdCBsZWFzdC4NCj4gSG93IHRvIGRlY2lkZSB0aGUgZ3JhbnVsYXJpdHkgPw0K
DQpZb3VyIGRpYWdyYW0gc2hvd3MgdGhhdCB0aGUgdXBwZXJtb3N0IGJpdHMgYXJlIHVzZWQgZm9y
IHRoZSBkZWFkbGluZS4gV2hhdCBJDQpwcm9wb3NlZCBpcyB0byB1c2UgdGhlIGxvd2VyIDMyIGJp
dHMgZm9yIHRoZSBkZWFkbGluZSBzdWNoIHRoYXQgd2UgYWdhaW4gaGF2ZQ0KYSByZXNvbHV0aW9u
IG9mIDEvSFouDQoNCkJhcnQuDQoNCg0K
