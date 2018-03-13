Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36542 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeCMRYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 13:24:11 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jaco@uls.co.za" <jaco@uls.co.za>
CC: "pieterk@uls.co.za" <pieterk@uls.co.za>
Subject: Re: disk-io lockup in 4.14.13 kernel
Date: Tue, 13 Mar 2018 17:24:07 +0000
Message-ID: <1520961846.2638.25.camel@wdc.com>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
         <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
         <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
         <1520737695.8740.4.camel@wdc.com>
         <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
         <1520744455.8740.9.camel@wdc.com>
         <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
         <1520950225.2921.0.camel@wdc.com>
         <cca75546-a02e-bed3-fda0-0003ccc5d158@uls.co.za>
         <1520953606.2638.5.camel@wdc.com>
         <b9f2421d-6350-1136-86ea-bdb70a59b6d9@uls.co.za>
In-Reply-To: <b9f2421d-6350-1136-86ea-bdb70a59b6d9@uls.co.za>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAzLTEzIGF0IDE5OjE2ICswMjAwLCBKYWNvIEtyb29uIHdyb3RlOg0KPiBU
aGUgc2VydmVyIGluIHF1ZXN0aW9uIGlzIHRoZSBkZXN0aW5hdGlvbiBvZiAgbnVtZXJvdXMgcnN5
bmMvc3NoIGNhc2VzDQo+ICh1c2VkIHByaW1hcmlseSBmb3IgYmFja3VwcykgYW5kIGlzIG5vdCBp
bnRlbmRlZCBhcyBhIHJlYWwtdGltZSBzeXN0ZW0uDQo+IEknbSBoYXBweSB0byBlbmFibGUgdGhl
IG9wdGlvbnMgYmVsb3cgdGhhdCB5b3Ugd291bGQgaW5kaWNhdGUgd291bGQgYmUNCj4gaGVscGZ1
bCBpbiBwaW5wb2ludGluZyB0aGUgcHJvYmxlbSAoYXNzdW1pbmcgd2UncmUgbm90IGxvb2tpbmcg
YXQgYSA4eA0KPiBtb3JlIENQVSByZXF1aXJlZCB0eXBlIG9mIGRlZ3JhZGluZyBhcyBJJ3ZlIHJl
Y2VudGx5IHNlZW4gd2l0aCBhc3Rlcmlzaw0KPiBsb2NrIGRlYnVnZ2luZyBlbmFibGVkKS4gSSd2
ZSBtYXJrZWQgaW4gYm9sZCBiZWxvdyB3aGF0IEkgYXNzdW1lIHdvdWxkDQo+IGJlIGhlbHBmdWwu
ICBJZiB5b3UgZG9uJ3QgbWluZCBjb25maXJtaW5nIGZvciBtZSBJJ2xsIGVuYWJsZSBhbmQNCj4g
c2NoZWR1bGUgYSByZWJvb3QuDQoNCkhlbGxvIEphY28sDQoNCk15IHJlY29tbWVuZGF0aW9uIGlz
IHRvIHdhaXQgdW50aWwgdGhlIG1wdDNzYXMgbWFpbnRhaW5lcnMgcG9zdCBhIGZpeA0KZm9yIHdo
YXQgSSByZXBvcnRlZCB5ZXN0ZXJkYXkgb24gdGhlIGxpbnV4LXNjc2kgbWFpbGluZyBsaXN0LiBF
bmFibGluZw0KQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUCBoYXMgbmFtZWx5IGEgdmVyeSBhbm5v
eWluZyBjb25zZXF1ZW5jZSBmb3IgdGhlDQptcHQzc2FzIGRyaXZlcjogdGhlIGZpcnN0IHByb2Nl
c3MgdGhhdCBoaXRzIHRoZSAic2xlZXAgaW4gYXRvbWljIGNvbnRleHQiDQpidWcgZ2V0cyBraWxs
ZWQuIEkgZG9uJ3QgdGhpbmsgdGhhdCB5b3Ugd2FudCB0aGlzIGtpbmQgb2YgYmVoYXZpb3Igb24g
YQ0KcHJvZHVjdGlvbiBzZXR1cC4NCg0KQmFydC4NCg0KDQoNCg0K
