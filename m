Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19551 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbdJTUFc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2017 16:05:32 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx
 restart
Date: Fri, 20 Oct 2017 20:05:30 +0000
Message-ID: <1508529929.3029.20.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
         <1508435243.2429.42.camel@wdc.com>
         <CAJrWOzCyLSNYAmEY6afoVjPYK8KaoH1HSs63iGpDuCwesjwBLQ@mail.gmail.com>
In-Reply-To: <CAJrWOzCyLSNYAmEY6afoVjPYK8KaoH1HSs63iGpDuCwesjwBLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEwLTIwIGF0IDExOjM5ICswMjAwLCBSb21hbiBQZW55YWV2IHdyb3RlOg0K
PiBCdXQgd2hhdCBib3RoZXJzIG1lIGlzIHRoZXNlIGxvb29uZyBsb29wcyBpbnNpZGUgYmxrX21x
X3NjaGVkX3Jlc3RhcnQoKSwNCj4gYW5kIHNpbmNlIHlvdSBhcmUgdGhlIGF1dGhvciBvZiB0aGUg
b3JpZ2luYWwgNmQ4YzZjMGY5N2FkICgiYmxrLW1xOiBSZXN0YXJ0DQo+IGEgc2luZ2xlIHF1ZXVl
IGlmIHRhZyBzZXRzIGFyZSBzaGFyZWQiKSBJIHdhbnQgdG8gYXNrIHdoYXQgd2FzIHRoZSBvcmln
aW5hbA0KPiBwcm9ibGVtIHdoaWNoIHlvdSBhdHRlbXB0ZWQgdG8gZml4PyAgTGlrZWx5IEkgYW0g
bWlzc2luZyBzb21lIHRlc3Qgc2NlbmFyaW8NCj4gd2hpY2ggd291bGQgYmUgZ3JlYXQgdG8ga25v
dyBhYm91dC4NCg0KTG9uZyBsb29wcz8gSG93IG1hbnkgcXVldWVzIHNoYXJlIHRoZSBzYW1lIHRh
ZyBzZXQgb24geW91ciBzZXR1cD8gSG93IG1hbnkNCmhhcmR3YXJlIHF1ZXVlcyBkb2VzIHlvdXIg
YmxvY2sgZHJpdmVyIGNyZWF0ZSBwZXIgcmVxdWVzdCBxdWV1ZT8NCg0KQ29tbWl0IDZkOGM2YzBm
OTdhZCBpcyBzb21ldGhpbmcgSSBjYW1lIHVwIHdpdGggdG8gZml4IHF1ZXVlIGxvY2t1cHMgaW4g
dGhlDQpTQ1NJIGFuZCBkbS1tcSBkcml2ZXJzLg0KDQpCYXJ0Lg==
