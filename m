Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6627 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeDPEbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 00:31:40 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tim.t.walker@seagate.com" <tim.t.walker@seagate.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Multi-Actuator SAS HDD First Look
Date: Mon, 16 Apr 2018 04:31:38 +0000
Message-ID: <2fc74a844eaff408c8e5aac563f31145682aeed2.camel@wdc.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
         <20180326170840.0130f366@pentland.suse.de>
         <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
         <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
         <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
         <20180403074637.GB13259@infradead.org>
         <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
         <20180406082418.127a0ec6@pentland.suse.de>
         <20180406064236.GA17456@infradead.org>
         <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
         <CANo=J176w+NiskEDU_-dZ0CmmHCp-ZquPqKgY7_3oyMED_r3Zg@mail.gmail.com>
         <c5bf0358-ba24-1196-7cfd-8bfec558c514@suse.de>
         <236addea-463c-3802-29c2-c8df9a31c285@interlog.com>
         <CANo=J14RnmVWuw+5jRukwbptVnHNRYbhPiwhYv+RZTQ6nGuHGw@mail.gmail.com>
In-Reply-To: <CANo=J14RnmVWuw+5jRukwbptVnHNRYbhPiwhYv+RZTQ6nGuHGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE4LTA0LTE1IGF0IDE5OjM1IC0wNjAwLCBUaW0gV2Fsa2VyIHdyb3RlOg0KPiBJ
IGFsc28gYmVsaWV2ZSB0aGUgZHVhbC1hY3R1YXRvciwgb3IgYW55IHNpZ25pZmljYW50IEhERCBw
YXJhbGxlbGlzbSwNCj4gd291bGQgbWFwIHdlbGwgb250byBhbiBOVk1lIHRhcmdldCwgb3IgTlZN
ZS1vRiBiZWhpbmQgbnZtZXQuIE1heWJlIGENCj4gbGlnaHR3ZWlnaHQgdmlydHVhbCBOVk1lIGNv
bnRyb2xsZXIgdGhhdCB3b3VsZCBlZmZpY2llbnRseSBwcmVzZW50IHRoZQ0KPiBIREQgbG9ncy9t
b2RlIHBhZ2VzL2V0YyB2aWEgdGhlIGFkbWluIHF1ZXVlIGFuZCB0aGUgTFVOcyBhcyBmaXhlZA0K
PiBuYW1lc3BhY2VzLi4uPw0KPiANCj4gRG91ZywgSSB3aWxsIGZsZXNoIHlvdXIgdGhyZWUgTFVO
IGlkZWEgb3V0IHNvbWUgbW9yZSBhbmQgc2VuZCBpdCB1cA0KPiB0aGUgZmxhZ3BvbGUgb3ZlciBo
ZXJlLiBUaGFua3MgZm9yIHRoZSBpbnB1dC4NCj4gDQo+IEknZCBsaWtlIHRvIGhhdmUgYSBjb252
ZXJzYXRpb24gYXQgTFNGTU0gYW5kIG1heWJlIHB1bGwgdG9nZXRoZXIgYQ0KPiBmYWlybHkgd2Vs
bCBkZWZpbmVkIGNvbnNlbnN1cyByZWNvbW1lbmRhdGlvbi4gSXMgdGhhdCBwb3NzaWJsZT8gQ2Fu
IHdlDQo+IHNjaGVkdWxlIGl0Pw0KDQpIZWxsbyBUaW0sDQoNCkkgdGhpbmsgdGhhdCB5b3UgaGF2
ZSB0byBzdWJtaXQgYSByZXF1ZXN0IHRvIHRoZSBMU0YvTU0gcHJvZ3JhbSBjb21taXR0ZWUNCihs
c2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcpIHRvIGFkZCBhbiBpdGVtIHRvIHRoZSBv
ZmZpY2lhbCBhZ2VuZGEuDQpJbiBjYXNlIHRoaXMgdG9waWMgd291bGRuJ3QgYmUgYWRkZWQgdG8g
dGhlIG9mZmljaWFsIGFnZW5kYSB3ZSBjYW4gc3RpbGwNCmRpc2N1c3MgdGhpcyB0b3BpYyBpbiBh
IG1lZXRpbmcgcm9vbSBhdCB0aGUgTFNGL01NIGxvY2F0aW9uLg0KDQpCYXJ0Lg0KDQoNCg0K
