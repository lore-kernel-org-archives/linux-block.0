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
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
Date: Fri, 27 Apr 2018 15:31:53 +0000
Message-ID: <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
In-Reply-To: <20180420065742.8043-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTIwIGF0IDE0OjU3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhp
cyBwYXRjaGVzIHJlbW92ZXMgdGhlIGV4cGVuc2l2ZSBhdG9taWMgb3BlYXRpb24gb24gaG9zdC13
aWRlIGNvdW50ZXINCj4gb2YgLmhvc3RfYnVzeSBmb3Igc2NzaS1tcSwgYW5kIGl0IGlzIG9ic2Vy
dmVkIHRoYXQgSU9QUyBjYW4gYmUgaW5jcmVhc2VkIGJ5DQo+IDE1JSB3aXRoIHRoaXMgY2hhbmdl
IGluIElPIHRlc3Qgb3ZlciBzY3NpX2RlYnVnLg0KPiANCj4gDQo+IE1pbmcgTGVpICgzKToNCj4g
ICBzY3NpOiBpbnRyb2R1Y2Ugc2NzaV9ob3N0X2J1c3koKQ0KPiAgIHNjc2k6IHJlYWQgaG9zdF9i
dXN5IHZpYSBzY3NpX2hvc3RfYnVzeSgpDQo+ICAgc2NzaTogYXZvaWQgdG8gaG9sZCBob3N0LXdp
ZGUgY291bnRlciBvZiBob3N0X2J1c3kgZm9yIHNjc2lfbXENCj4gDQo+ICBkcml2ZXJzL3Njc2kv
YWR2YW5zeXMuYyAgICAgICAgICAgICAgICAgICB8ICA4ICsrKystLS0tDQo+ICBkcml2ZXJzL3Nj
c2kvaG9zdHMuYyAgICAgICAgICAgICAgICAgICAgICB8IDMyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIGRyaXZlcnMvc2NzaS9saWJzYXMvc2FzX3Njc2lfaG9zdC5jICAgICAg
IHwgIDQgKystLQ0KPiAgZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX3Nhc19iYXNlLmMg
fCAgMiArLQ0KPiAgZHJpdmVycy9zY3NpL21wdDNzYXMvbXB0M3Nhc19iYXNlLmMgICAgICAgfCAg
NCArKy0tDQo+ICBkcml2ZXJzL3Njc2kvcWxvZ2ljcHRpLmMgICAgICAgICAgICAgICAgICB8ICAy
ICstDQo+ICBkcml2ZXJzL3Njc2kvc2NzaS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICBkcml2ZXJzL3Njc2kvc2NzaV9lcnJvci5jICAgICAgICAgICAgICAgICB8ICA2ICsrKy0t
LQ0KPiAgZHJpdmVycy9zY3NpL3Njc2lfbGliLmMgICAgICAgICAgICAgICAgICAgfCAyMyArKysr
KysrKysrKysrKysrLS0tLS0tDQo+ICBkcml2ZXJzL3Njc2kvc2NzaV9zeXNmcy5jICAgICAgICAg
ICAgICAgICB8ICAyICstDQo+ICBpbmNsdWRlL3Njc2kvc2NzaV9ob3N0LmggICAgICAgICAgICAg
ICAgICB8ICAxICsNCj4gIDExIGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDIxIGRl
bGV0aW9ucygtKVwNCg0KSGVsbG8gTWluZywNCg0KRnJvbSB0aGUgTUFJTlRBSU5FUlMgZmlsZToN
Cg0KU0NTSSBTVUJTWVNURU0NCk06ICAgICAgIkphbWVzIEUuSi4gQm90dG9tbGV5IiA8amVqYkBs
aW51eC52bmV0LmlibS5jb20+DQpUOiAgICAgIGdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvamVqYi9zY3NpLmdpdA0KTTogICAgICAiTWFydGluIEsuIFBl
dGVyc2VuIiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+DQpUOiAgICAgIGdpdCBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWtwL3Njc2kuZ2l0DQpMOiAg
ICAgIGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnDQpTOiAgICAgIE1haW50YWluZWQNCkY6ICAg
ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Njc2kvDQpGOiAgICAgIGRyaXZl
cnMvc2NzaS8NCkY6ICAgICAgaW5jbHVkZS9zY3NpLw0KDQpIZW5jZSBteSBzdXJwcmlzZSB3aGVu
IEkgc2F3IHRoYXQgeW91IHNlbnQgdGhpcyBwYXRjaCBzZXJpZXMgdG8gSmVucyBpbnN0ZWFkDQpv
ZiBKYW1lcyBhbmQgTWFydGluPw0KDQpCYXJ0Lg==
