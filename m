Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48529 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbdHWPNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 11:13:31 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [v4.13-rc BUG] system lockup when running big buffered write(4M)
 to IB SRP via mpath
Date: Wed, 23 Aug 2017 15:12:42 +0000
Message-ID: <1503501161.2484.3.camel@wdc.com>
References: <20170808141715.GB22763@ming.t460p>
         <1502237504.4017.1.camel@redhat.com> <1502245693.6511.3.camel@redhat.com>
         <c072e942-0265-f0ad-561d-0e50d50e3cb1@redhat.com>
         <1502298599.2356.7.camel@wdc.com> <20170823113526.GA8130@ming.t460p>
In-Reply-To: <20170823113526.GA8130@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTA4LTIzIGF0IDE5OjM1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gc29m
dCBsb2NrdXAgc3RpbGwgY2FuIGJlIG9ic2VydmVkIGVhc2lseSB3aXRoIHBhdGNoIGQ0YWNmMzY1
MGM3YygNCj4gYmxvY2s6IE1ha2UgYmxrX21xX2RlbGF5X2tpY2tfcmVxdWV1ZV9saXN0KCkgcmVy
dW4gdGhlIHF1ZXVlIGF0IGEgcXVpZXQgdGltZSksDQo+IGJ1dCBubyBoYXJkIGxvY2t1cC4NCg0K
SGVsbG8gTWluZywNCg0KSSBuZXZlciBjbGFpbWVkIHRoYXQgY29tbWl0IGQ0YWNmMzY1MGM3YyB3
YXMgYSBmdWxsIHNvbHV0aW9uIHRvIGF2b2lkIHRoZXNlDQpzb2Z0IGxvY2t1cHMuIEkgYXNzdW1l
IHRoZXNlIHJlc3VsdHMgbWVhbiB0aGF0IHBhdGNoIHNlcmllcyAiW1BBVENIIDAvN10NCkRldmlj
ZSBtYXBwZXIgYW5kIGRtLW1wYXRoIGZpeGVzIiB3YXMgbm90IGFwcGxpZWQgdG8gdGhlIGtlcm5l
bCB1c2VkIGluIHlvdXINCnRlc3RzPyBBIGNvbGxlYWd1ZSBvZiB5b3UgaGFzIHJlcG9ydGVkIHRo
YXQgdGhhdCBwYXRjaCBzZXJpZXMgaXMgc3VmZmljaWVudA0KdG8gYXZvaWQgdGhlc2Ugc29mdCBs
b2NrdXBzLiBTZWUgYWxzbw0KaHR0cHM6Ly93d3cucmVkaGF0LmNvbS9hcmNoaXZlcy9kbS1kZXZl
bC8yMDE3LUF1Z3VzdC9tc2cwMDEyMi5odG1sLg0KDQpCYXJ0Lg==
