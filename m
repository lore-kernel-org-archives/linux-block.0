Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40857 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758513AbeD0Pra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Apr 2018 11:47:30 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "james.bottomley@hansenpartnership.com"
        <james.bottomley@hansenpartnership.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 1/3] scsi: introduce scsi_host_busy()
Date: Fri, 27 Apr 2018 15:47:25 +0000
Message-ID: <0da9676e432e393562f24b09f233012c7fdd7943.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
         <20180420065742.8043-2-ming.lei@redhat.com>
In-Reply-To: <20180420065742.8043-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTA0LTIwIGF0IDE0OjU3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBpbnRyb2R1Y2VzIFNDU0kgbWlkZGxlIGxheWVyIEFQSSBvZiBzY3NpX2hvc3RfYnVz
eSgpIGZvcg0KPiBkcml2ZXJzIHRvIHJlYWQgdGhlIGhvc3Qtd2lkZSBjb3VudGVyIG9mIHNjc2lf
aG9zdC0+aG9zdF9idXN5Lg0KDQpUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBmdW5jdGlvbiB0aGF0
IGhhcyBubyBjYWxsZXJzIHNvIEkgdGhpbmsgdGhpcyBwYXRjaA0Kc2hvdWxkIGJlIGNvbWJpbmVk
IHdpdGggcGF0Y2ggMi8zIGZyb20gdGhpcyBzZXJpZXMgaW50byBhIHNpbmdsZSBwYXRjaC4NCg0K
QmFydC4NCg0KDQo=
