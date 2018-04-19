Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43721 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDSTlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 15:41:42 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "maier@linux.ibm.com" <maier@linux.ibm.com>,
        "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] scsi/004: add regression test for false
 BLK_STS_OK with non good SAM status
Date: Thu, 19 Apr 2018 19:41:37 +0000
Message-ID: <18799c58a6ce27142b46ba6ec471e09f1eefedcf.camel@wdc.com>
References: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
         <20180419185330.GA20941@vader> <20180419191320.GB20941@vader>
In-Reply-To: <20180419191320.GB20941@vader>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE4LTA0LTE5IGF0IDEyOjEzIC0wNzAwLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0K
PiBPbiBUaHUsIEFwciAxOSwgMjAxOCBhdCAxMTo1MzozMEFNIC0wNzAwLCBPbWFyIFNhbmRvdmFs
IHdyb3RlOg0KPiA+IFRoYW5rcyBmb3IgdGhlIHRlc3QhIEFwcGxpZWQuDQo+IA0KPiBTaWRlIG5v
dGUsIGl0J3MgdW5mb3J0dW5hdGUgdGhhdCB0aGlzIHRlc3QgdGFrZXMgMTgwIHNlY29uZHMgdG8g
cnVuIG9ubHkNCj4gYmVjYXVzZSB3ZSBoYXZlIHRvIHdhaXQgZm9yIHRoZSBjb21tYW5kIHRpbWVv
dXQuIFdlIHNob3VsZCBiZSBhYmxlIHRvDQo+IGV4cG9ydCByZXF1ZXN0X3F1ZXVlLT5ycV90aW1l
b3V0IHdyaXRlYWJsZSBpbiBzeXNmcy4gV291bGQgeW91IGJlDQo+IGludGVyZXN0ZWQgaW4gZG9p
bmcgdGhhdD8NCg0KSGVsbG8gT21hciwNCg0KSXMgdGhpcyBwZXJoYXBzIHdoYXQgeW91IGFyZSBs
b29raW5nIGZvcj8NCiMgbHMgLWwgL3N5cy9jbGFzcy9zY3NpX2RldmljZS8qLyovdGltZW91dCAg
ICAgICAgICAgICANCi1ydy1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBBcHIgMTkgMDg6NTIgL3N5
cy9jbGFzcy9zY3NpX2RldmljZS8yOjA6MDowL2RldmljZS90aW1lb3V0DQotcnctci0tci0tIDEg
cm9vdCByb290IDQwOTYgQXByIDE5IDEyOjM5IC9zeXMvY2xhc3Mvc2NzaV9kZXZpY2UvODowOjA6
MS9kZXZpY2UvdGltZW91dA0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
