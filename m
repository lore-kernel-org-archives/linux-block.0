Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755327AbeCSLsl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Mar 2018 07:48:41 -0400
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH V5 1/5] scsi: hpsa: fix selection of reply queue
Date: Mon, 19 Mar 2018 11:48:35 +0000
Message-ID: <1521460114.4592.29.camel@intel.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
         <20180313094243.8710-2-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-2-ming.lei@redhat.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAzLTEzIGF0IDE3OjQyICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gRnJv
bSA4NDY3NmMxZjIxIChnZW5pcnEvYWZmaW5pdHk6IGFzc2lnbiB2ZWN0b3JzIHRvIGFsbCBwb3Nz
aWJsZSBDUFVzKSwNCj4gb25lIG1zaXggdmVjdG9yIGNhbiBiZSBjcmVhdGVkIHdpdGhvdXQgYW55
IG9ubGluZSBDUFUgbWFwcGVkLCB0aGVuIG9uZQ0KPiBjb21tYW5kJ3MgY29tcGxldGlvbiBtYXkg
bm90IGJlIG5vdGlmaWVkLg0KDQpIZWxsbyBNYXJ0aW4sIEphbWVzLA0KDQp3ZSBoYXZlIHRoaXMg
cGF0Y2gtc2V0IGFuZCBpdCBmaXhlcyBtZWdhcmFpZCByZWdyZXNzaW9uIGluIHY0LjE2LiBEbw0K
eW91IHBsYW4gdG8gbWVnZSBpdCB0byB2NC4xNi1yY1g/IEkgYW0gd29ycmllZCAtIHRoZXJlIHNl
ZW0gdG8gYmUgbm8NCnNpZ2h0IHRoYXQgdGhpcyBpcyBnb2luZyB0byBtZSBtZXJnZWQuIFRoZXkg
YXJlIG5vdCBpbiB0aGUgbGludXgtbmV4dC4NCg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpBcnRlbSBC
aXR5dXRza2l5Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5sYW5kIE95ClJlZ2lzdGVyZWQgQWRkcmVz
czogUEwgMjgxLCAwMDE4MSBIZWxzaW5raSAKQnVzaW5lc3MgSWRlbnRpdHkgQ29kZTogMDM1NzYw
NiAtIDQgCkRvbWljaWxlZCBpbiBIZWxzaW5raSAKClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ug
b2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBvciBkaXN0cmlidXRpb24K
Ynkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRl
bmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwg
Y29waWVzLgo=
