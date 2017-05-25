Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54592 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941903AbdEYFZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 01:25:04 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
Date: Thu, 25 May 2017 05:24:54 +0000
Message-ID: <1495689892.3045.2.camel@sandisk.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
In-Reply-To: <20170525042131.13172-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA1LTI1IGF0IDEyOjIxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT25l
IGJpZyBwcm9ibGVtIG9mIGJsa19tcV9xdWllc2NlX3F1ZXVlKCkgaXMgdGhhdCBpdA0KPiBjYW4n
dCBwcmV2ZW50IC5xdWV1ZV9ycSgpIGluIGRpcmVjdCBpc3N1ZSBwYXRoIGZyb20NCj4gYmVpbmcg
cnVuIGV2ZW4gdGhvdWdoIGh3IHF1ZXVlcyBhcmUgc3RvcHBlZCBieQ0KPiBibGtfbXFfcXVpZXNj
ZV9xdWV1ZSgpLg0KDQpUaGF0J3Mgd3JvbmcuIEFsbCB3aGF0J3MgbmVlZGVkIHRvIHByZXZlbnQg
dGhhdA0KX19ibGtfbXFfdHJ5X2lzc3VlX2RpcmVjdGx5KCkgY2FsbHMgLnF1ZXVlX3JxKCkgZm9y
IGEgc3RvcHBlZA0KcXVldWUgaXMgdG8gY2hlY2sgaW4gX19ibGtfbXFfdHJ5X2lzc3VlX2RpcmVj
dGx5KCkgd2hldGhlciB0aGUNCnJlbGV2YW50IGhhcmR3YXJlIHF1ZXVlIGhhcyBiZWVuIHN0b3Bw
ZWQuIFRoYXQgYXBwcm9hY2ggaGFzIHRoZQ0KZm9sbG93aW5nIHR3byBhZHZhbnRhZ2VzIG92ZXIg
dGhlIGFwcHJvYWNoIG9mIHlvdXIgcGF0Y2ggc2VyaWVzOg0KLSBMb3dlciBjb2RlIGNvbXBsZXhp
dHkgYW5kIGhlbmNlIGVhc2llciB0byByZXZpZXcgYW5kIHRvIG1haW50YWluLg0KLSBGYXN0ZXIg
Zm9yIHF1ZXVlcyBmb3Igd2hpY2ggQkxLX01RX0ZfQkxPQ0tJTkcgaGFzIG5vdCBiZWVuIHNldC4N
CiAgRm9yIG5vbi1wcmVlbXB0aWJsZSBrZXJuZWxzIHJjdV9yZWFkX2xvY2soKSBhbmQgcmN1X3Jl
YWRfbG9jaygpDQogIGFyZSBvcHRpbWl6ZWQgb3V0LiBUaGF0IGlzIG5vdCBwb3NzaWJsZSBmb3IN
CiAgcGVyY3B1X3JlZl90cnlnZXRfbGl2ZSgpIC8gcGVyY3B1X3JlZl9wdXQoKS4NCg0KQmFydC4=
