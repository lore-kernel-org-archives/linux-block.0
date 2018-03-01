Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52610 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163211AbeCAXk1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Mar 2018 18:40:27 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [bug report] Don't enter SCSI error handler on kernel 4.16-rc1
Date: Thu, 1 Mar 2018 23:40:25 +0000
Message-ID: <1519947624.2675.11.camel@wdc.com>
References: <e8bba22c-a02b-f449-c67a-d4a7ae8482df@hisilicon.com>
         <1519658706.3975.2.camel@wdc.com>
         <75f77913-41a7-98fd-f4a1-0301ff4d6e2b@hisilicon.com>
         <1519743443.21815.2.camel@wdc.com>
         <0e03cf3a-9b96-d41e-5896-1e4c6bdf81d9@hisilicon.com>
In-Reply-To: <0e03cf3a-9b96-d41e-5896-1e4c6bdf81d9@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE4LTAyLTI4IGF0IDE0OjE3ICswODAwLCBjaGVueGlhbmcgKE0pIHdyb3RlOg0K
PiBJdCBzZWVtcyB0aGUgcGF0Y2ggaXMgZm9yIGJsb2NrIG1xLCBidXQgdGhlIGlzc3VlIGkgZW5j
b3VudCBpcyB1bmRlciANCj4gYmxvY2sgbGVnYWN5IGFzIENPTkZJR19TQ1NJX01RX0RFRkFVTFQg
aXMgbm90IGVuYWJsZWQuDQoNClNpbmNlIHRoZSBjYWxsIHRyYWNlcyByZWZlciB0byB0aGUgQVRB
IGNvZGUgSSBob3BlIHRoYXQgYW4gQVRBIGV4cGVydCB3aWxsDQpoYXZlIHRoZSB0aW1lIHRvIGhl
bHAgeW91IGZ1cnRoZXIuDQoNCkJhcnQu
