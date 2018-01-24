Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43530 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934227AbeAXQYk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jan 2018 11:24:40 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@fb.com" <axboe@fb.com>
CC: "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
Date: Wed, 24 Jan 2018 16:24:36 +0000
Message-ID: <1516811073.3873.0.camel@wdc.com>
References: <20180123105538.24860-1-jthumshirn@suse.de>
In-Reply-To: <20180123105538.24860-1-jthumshirn@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAxLTIzIGF0IDExOjU1ICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IFVzZSBwcl9kZWJ1ZyBpbnN0ZWFkIG9mIGhhbmQgY3JhZnRldCBtYWNyb3MuIFRoaXMg
d2F5IGl0IGlzIG5vdCBuZWVkZWQgdG8NCj4gcmUtY29tcGlsZSB0aGUga2VybmVsIHRvIGVuYWJs
ZSBic2cgZGVidWcgb3V0cHV0cyBhbmQgaXQncyBwb3NzaWJsZSB0bw0KPiBzZWxlY3RpdmVseSBl
bmFibGUgc3BlY2lmaWMgcHJpbnRzLg0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxi
YXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KDQoNCg0K
