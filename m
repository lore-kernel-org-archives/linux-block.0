Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56759 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbdJROaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 10:30:00 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "byungchul.park@lge.com" <byungchul.park@lge.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: Fix false positive by LOCKDEP_CROSSRELEASE
Date: Wed, 18 Oct 2017 14:29:56 +0000
Message-ID: <1508336995.2923.2.camel@wdc.com>
References: <1508319532-24655-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1508319532-24655-1-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDE4OjM4ICswOTAwLCBCeXVuZ2NodWwgUGFyayB3cm90ZToN
Cj4gU2V2ZXJhbCBmYWxzZSBwb3NpdGl2ZXMgd2VyZSByZXBvcnRlZCwgc28gSSB0cmllZCB0byBm
aXggdGhlbS4NCj4gDQo+IEl0IHdvdWxkIGJlIGFwcHJlY2lhdGVkIGlmIHlvdSB0ZWxsIG1lIGlm
IGl0IHdvcmtzIGFzIGV4cGVjdGVkLCBvciBsZXQNCj4gbWUga25vdyB5b3VyIG9waW5pb24uDQoN
CldoYXQgSSBoYXZlIGJlZW4gd29uZGVyaW5nIGFib3V0IGlzIHdoZXRoZXIgdGhlIGNyb3NzbG9j
ayBjaGVja2luZyBtYWtlcw0Kc2Vuc2UgZnJvbSBhIGNvbmNlcHR1YWwgcG9pbnQgb2Ygdmlldy4g
SSB0cmllZCB0byBmaW5kIGRvY3VtZW50YXRpb24gZm9yIHRoZQ0KY3Jvc3Nsb2NrIGNoZWNraW5n
IGluIERvY3VtZW50YXRpb24vbG9ja2luZy9sb2NrZGVwLWRlc2lnbi50eHQgYnV0DQpjb3VsZG4n
dCBmaW5kIGEgZGVzY3JpcHRpb24gb2YgdGhlIGNyb3NzbG9jayBjaGVja2luZy4gU2hvdWxkbid0
IGl0IGJlDQpkb2N1bWVudGVkIHNvbWV3aGVyZSB3aGF0IHRoZSBjcm9zc2xvY2sgY2hlY2tzIGRv
IGFuZCB3aGF0IHRoZSB0aGVvcnkgaXMNCmJlaGluZCB0aGVzZSBjaGVja3M/DQoNCkJhcnQuDQo=
