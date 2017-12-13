Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12952 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdLMVx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 16:53:28 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>,
        "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Date: Wed, 13 Dec 2017 21:53:04 +0000
Message-ID: <1513201983.2413.11.camel@sandisk.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
         <20171127124147.GA16095@ming.t460p>
         <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
In-Reply-To: <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTExLTI5IGF0IDEwOjU3ICswODAwLCBjaGVueGlhbmcgKE0pIHdyb3RlOg0K
PiBJIGFwcGxpZWQgdGhpcyB2MiBwYXRjaHNldCB0byBrZXJuZWwgNC4xNS1yYzEsIHJ1bm5pbmcg
ZmlvIG9uIGEgU0FUQSANCj4gZGlzaywgdGhlbiBkaXNhYmxlIHRoZSBkaXNrIHdpdGggc3lzZnMg
aW50ZXJmYWNlDQo+IChlY2hvIDAgPiAvc3lzL2NsYXNzL3Nhc19waHkvcGh5LTE6MDoxL2VuYWJs
ZSksIGFuZCBmaW5kIHN5c3RlbSBpcyBodW5nLiANCj4gQnV0IHdpdGggdjEgcGF0Y2gsIGl0IGRv
ZXNuJ3QgaGFzIHRoaXMgaXNzdWUuDQoNCkhlbGxvIGNoZW54aWFuZywNCg0KV291bGQgaXQgYmUg
cG9zc2libGUgdG8gcmVwZWF0IHlvdXIgdGVzdCB3aXRoIHYyIG9mIHRoaXMgc2VyaWVzIGFuZCBN
YXJ0aW4ncw0KZm9yLTQuMTYgU0NTSSB0cmVlIG1lcmdlZCBpbnRvIHlvdXIga2VybmVsIHRlc3Qg
dHJlZT8gTWFydGluJ3MgdHJlZSBpcyBhdmFpbGFibGUNCmF0IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21rcC9zY3NpLmdpdC9sb2cvP2g9NC4xNi9zY3Np
LXF1ZXVlLg0KVGhlIGZvbGxvd2luZyBwYXRjaCBpbiB0aGF0IHRyZWUgZml4ZXMgYSByYWNlIGNv
bmRpdGlvbiB0aGF0IHNvbWV0aW1lcyBjYXVzZWQNCnRoZSBTQ1NJIGVycm9yIGhhbmRsZXIgbm90
IHRvIGJlIHdva2VuIHVwOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbWtwL3Njc2kuZ2l0L2NvbW1pdC8/aD00LjE2L3Njc2ktcXVldWUmaWQ9M2JkNmY0
M2Y1Y2IzNzE0ZjcwYzU5MTUxNGYzNDQzODlkZjU5MzUwMQ0KDQpUaGFua3MsDQoNCkJhcnQu
