Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbdEPOHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2017 10:07:32 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "anand.jain@oracle.com" <anand.jain@oracle.com>
CC: "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [RFC PATCH 0/2] Introduce blkdev_issue_flush_no_wait()
Date: Tue, 16 May 2017 14:07:23 +0000
Message-ID: <1494943642.2935.1.camel@sandisk.com>
References: <20170516093914.16035-1-anand.jain@oracle.com>
In-Reply-To: <20170516093914.16035-1-anand.jain@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE3LTA1LTE2IGF0IDE3OjM5ICswODAwLCBBbmFuZCBKYWluIHdyb3RlOg0KPiBC
VFJGUyB3YW50ZWQgYSBibG9jayBkZXZpY2UgZmx1c2ggZnVuY3Rpb24gd2hpY2ggZG9lcyBub3Qg
d2FpdCBmb3INCj4gaXRzIGNvbXBsZXRpb24sIHNvIHRoYXQgdGhlIGZsdXNoIGZvciB0aGUgbmV4
dCBkZXZpY2UgY2FuIGJlIGNhbGxlZA0KPiBpbiB0aGUgc2FtZSB0aHJlYWQuDQo+IA0KPiBIZXJl
IGlzIGEgUkZDIHBhdGNoIHRvIHByb3ZpZGUgdGhlIGZ1bmN0aW9uDQo+ICdibGtkZXZfaXNzdWVf
Zmx1c2hfbm9fd2FpdCgpJywgd2hpY2ggaXMgYmFzZWQgb24gdGhlIGN1cnJlbnQgZGV2aWNlDQo+
IGZsdXNoIGZ1bmN0aW9uICdibGtkZXZfaXNzdWVfZmx1c2goKScsIGhvd2V2ZXIgaXQgdXNlcyBz
dWJtaXRfYmlvKCkNCj4gaW5zdGVhZCBvZiBzdWJtaXRfYmlvX3dhaXQoKS4NCj4gDQo+IFRoaXMg
cGF0Y2ggaXMgZm9yIHJldmlldyBjb21tZW50cywgd2lsbCBzZW5kIG91dCBhIGZpbmFsIHBhdGNo
IGJhc2VkDQo+IG9uIHRoZSBjb21tZW50cyByZWNlaXZlZC4NCg0KSGVsbG8gQW5hbmQsDQoNClNp
bmNlIHRoZSBibG9jayBsYXllciBjYW4gcmVvcmRlciByZXF1ZXN0cywgSSB0aGluayB1c2luZw0K
YmxrZGV2X2lzc3VlX2ZsdXNoX25vX3dhaXQoKSB3aWxsIG9ubHkgeWllbGQgdGhlIGludGVuZGVk
IHJlc3VsdCBpZg0KdGhlIGNhbGxlciB3YWl0cyB1bnRpbCB0aGUgcmVxdWVzdHMgdGhhdCBoYXZl
IHRvIGJlIGZsdXNoZWQgaGF2ZSBjb21wbGV0ZWQuDQpJcyB0aGF0IGhvdyB5b3UgaW50ZW5kIHRv
IHVzZSB0aGlzIGZ1bmN0aW9uPw0KDQpUaGFua3MsDQoNCkJhcnQu
