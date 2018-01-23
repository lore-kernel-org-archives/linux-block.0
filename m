Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22265 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbeAWXMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jan 2018 18:12:23 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "joe@perches.com" <joe@perches.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@fb.com" <axboe@fb.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
Date: Tue, 23 Jan 2018 23:12:20 +0000
Message-ID: <1516749137.3339.62.camel@wdc.com>
References: <20180123105538.24860-1-jthumshirn@suse.de>
         <1516711552.8378.30.camel@perches.com>
In-Reply-To: <1516711552.8378.30.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAxLTIzIGF0IDA0OjQ1IC0wODAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4g
UGVyaGFwcyB0aGUgZW1haWwgc3ViamVjdCBjb3VsZCBiZSBpbXByb3ZlZCB0byBkZXNjcmliZQ0K
PiB0aGUgbmV3IG1hY3JvIGFuZCBhcyB3ZWxsLCB0aGlzIG1hY3JvLCB3aXRob3V0IGEgcHJfZm10
DQo+IGRlZmluZSBzb21ld2hhdCBhYm92ZSBpdCBsb3NlcyB0aGUgX19mdW5jX18gb3V0cHV0IHRv
by4NCg0KSG1tIC4uLiBJIHRob3VnaHQgdGhhdCB0aGUgcHJfZGVidWcoKSBvdXRwdXQgY2FuIGJl
IGNvbmZpZ3VyZWQgdG8gaW5jbHVkZQ0KdGhlIGZ1bmN0aW9uIG5hbWUgKF9fZnVuY19fKT8gRnJv
bQ0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvYWRtaW4tZ3VpZGUvZHlu
YW1pYy1kZWJ1Zy1ob3d0by5odG1sOg0KDQpUaGUgZmxhZ3MgYXJlOg0KDQpwICAgIGVuYWJsZXMg
dGhlIHByX2RlYnVnKCkgY2FsbHNpdGUuDQpmICAgIEluY2x1ZGUgdGhlIGZ1bmN0aW9uIG5hbWUg
aW4gdGhlIHByaW50ZWQgbWVzc2FnZQ0KbCAgICBJbmNsdWRlIGxpbmUgbnVtYmVyIGluIHRoZSBw
cmludGVkIG1lc3NhZ2UNCm0gICAgSW5jbHVkZSBtb2R1bGUgbmFtZSBpbiB0aGUgcHJpbnRlZCBt
ZXNzYWdlDQp0ICAgIEluY2x1ZGUgdGhyZWFkIElEIGluIG1lc3NhZ2VzIG5vdCBnZW5lcmF0ZWQg
ZnJvbSBpbnRlcnJ1cHQgY29udGV4dA0KXyAgICBObyBmbGFncyBhcmUgc2V0LiAoT3InZCB3aXRo
IG90aGVycyBvbiBpbnB1dCkNCg0KQmFydC4=
