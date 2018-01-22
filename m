Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3940 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeAVUmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 15:42:07 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "joe@perches.com" <joe@perches.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@fb.com" <axboe@fb.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH TRIVIAL] bsg: use pr_debug instead of hand crafted macros
Date: Mon, 22 Jan 2018 20:42:04 +0000
Message-ID: <1516653723.2545.37.camel@wdc.com>
References: <20180122075348.6974-1-jthumshirn@suse.de>
         <1516652629.8378.14.camel@perches.com>
In-Reply-To: <1516652629.8378.14.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTAxLTIyIGF0IDEyOjIzIC0wODAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4g
T24gTW9uLCAyMDE4LTAxLTIyIGF0IDA4OjUzICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+ID4gVXNlIHByX2RlYnVnIGluc3RlYWQgb2YgaGFuZCBjcmFmdGVkIG1hY3Jvcy4gVGhp
cyB3YXkgaXQgaXMgbm90IG5lZWRlZCB0bw0KPiA+IHJlLWNvbXBpbGUgdGhlIGtlcm5lbCB0byBl
bmFibGUgYnNnIGRlYnVnIG91dHB1dHMgYW5kIGl0J3MgcG9zc2libGUgdG8NCj4gPiBzZWxlY3Rp
dmVseSBlbmFibGUgc3BlY2lmaWMgcHJpbnRzLg0KPiANCj4gUGVyaGFwcyBiZXR0ZXIgdG8gdXNl
DQo+IA0KPiAjZGVmaW5lIGJzZ19kYmcoYmQsIGZtdCwgLi4uKSBcDQo+IAlwcl9kZWJ1ZyhiZC0+
bmFtZSwgZm10LCAjI19fVkFfQVJHU19fKQ0KDQpIZWxsbyBKb2UsDQoNCldoeSBkbyB5b3UgdGhp
bmsgdGhhdCB3b3VsZCBiZSBiZXR0ZXI/DQoNClRoYW5rcywNCg0KQmFydC4=
