Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44582 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbeI1BcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:23 -0400
From: Jens Axboe <axboe@fb.com>
To: Ilya Dryomov <idryomov@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: I/O and timer unplugs are inverted in blktrace
Date: Thu, 27 Sep 2018 19:12:16 +0000
Message-ID: <4fdf7bb4-b24c-482e-063a-9e94e1c4f001@fb.com>
References: <20180926123550.16311-1-idryomov@gmail.com>
In-Reply-To: <20180926123550.16311-1-idryomov@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gOS8yNi8xOCA2OjM1IEFNLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+IHRyYWNlX2Jsb2NrX3Vu
cGx1ZygpIHRha2VzIHRydWUgZm9yIGV4cGxpY2l0IHVucGx1Z3MgYW5kIGZhbHNlIGZvcg0KPiBp
bXBsaWNpdCB1bnBsdWdzLiAgc2NoZWR1bGUoKSB1bnBsdWdzIGFyZSBpbXBsaWNpdCBhbmQgc2hv
dWxkIGJlDQo+IHJlcG9ydGVkIGFzIHRpbWVyIHVucGx1Z3MuICBXaGlsZSBjb3JyZWN0IGluIHRo
ZSBsZWdhY3kgY29kZSwgdGhpcyBoYXMNCj4gYmVlbiBpbnZlcnRlZCBpbiBibGstbXEgc2luY2Ug
NC4xMS4NCg0KVGhhdCdzIHByZXR0eSBzaWxseS4uLiBUaGFua3MsIHdpbGwgcXVldWUgdXAgZm9y
IDQuMTkuDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
