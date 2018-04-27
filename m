Return-Path: <linux-scsi-owner@vger.kernel.org>
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
Subject: Re: [PATCH 2/3] scsi: read host_busy via scsi_host_busy()
Date: Fri, 27 Apr 2018 15:51:46 +0000
Message-ID: <6112db0045837d0583d4b30aa4a1fd2bc4bdc239.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
         <20180420065742.8043-3-ming.lei@redhat.com>
In-Reply-To: <20180420065742.8043-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTIwIGF0IDE0OjU3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIHNo
b3dfaG9zdF9idXN5KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsIGNoYXIgKmJ1ZikNCj4gIHsNCj4gIAlzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9zdCA9IGNs
YXNzX3RvX3Nob3N0KGRldik7DQo+IC0JcmV0dXJuIHNucHJpbnRmKGJ1ZiwgMjAsICIlZFxuIiwg
YXRvbWljX3JlYWQoJnNob3N0LT5ob3N0X2J1c3kpKTsNCj4gKwlyZXR1cm4gc25wcmludGYoYnVm
LCAyMCwgIiVkXG4iLCBzY3NpX2hvc3RfYnVzeShzaG9zdCkpOw0KPiAgfQ0KPiAgc3RhdGljIERF
VklDRV9BVFRSKGhvc3RfYnVzeSwgU19JUlVHTywgc2hvd19ob3N0X2J1c3ksIE5VTEwpOw0KDQpU
aGUgIiwgMjAiIHBhcnQgaXMgY2FyZ28tY3VsdCBwcm9ncmFtbWluZy4gU2luY2UgeW91IGhhdmUg
dG8gdG91Y2ggdGhpcyBjb2RlLA0KcGxlYXNlIGVpdGhlciB1c2UgInNwcmludGYoYnVmLCAuLi4p
IiBvciB1c2UgInNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgLi4uKSIuDQoNClRoYW5rcywNCg0K
QmFydC4NCg0KDQoNCg==
