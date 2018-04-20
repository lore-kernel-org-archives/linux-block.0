Return-Path: <prvs=6414f13c5=staskins@amazon.de>
Subject: Re: [PATCH 1/3] xen: add generic fault injection facility
To: Juergen Gross <jgross@suse.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
        <tglx@linutronix.de>, <ggarcia@abra.uab.cat>, <daniel@iogearbox.net>,
        <x86@kernel.org>, <mingo@redhat.com>, <xen-devel@lists.xenproject.org>,
        <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
        <paul.durrant@citrix.com>, <stefanha@redhat.com>,
        <dsa@cumulusnetworks.com>, <boris.ostrovsky@oracle.com>,
        <linux-block@vger.kernel.org>, <wei.liu2@citrix.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104726.17823.40147.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <03a333dc-e505-e254-f39d-e68b1453a6f3@suse.com>
From: <staskins@amazon.com>
Message-ID: <74989e7c-4cde-81cf-c1ad-a3c19d477f52@amazon.com>
Date: Fri, 20 Apr 2018 14:45:15 +0200
MIME-Version: 1.0
In-Reply-To: <03a333dc-e505-e254-f39d-e68b1453a6f3@suse.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
List-ID: <linux-block@vger.kernel.org>

T24gMDQvMjAvMTggMTI6NTksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6Cj4gT24gMjAvMDQvMTggMTI6
NDcsIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToKPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L3hlbi9LY29uZmlnIGIvYXJjaC94ODYveGVuL0tjb25maWcKPj4gaW5kZXggYzFmOThmMy4uNDgz
ZmMxNiAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYveGVuL0tjb25maWcKPj4gKysrIGIvYXJjaC94
ODYveGVuL0tjb25maWcKPj4gQEAgLTc3LDMgKzc3LDEwIEBAIGNvbmZpZyBYRU5fUFZICj4+ICAg
CWJvb2wgIlN1cHBvcnQgZm9yIHJ1bm5pbmcgYXMgYSBQVkggZ3Vlc3QiCj4+ICAgCWRlcGVuZHMg
b24gWEVOICYmIFhFTl9QVkhWTSAmJiBBQ1BJCj4+ICAgCWRlZl9ib29sIG4KPj4gKwo+PiArY29u
ZmlnIFhFTl9GQVVMVF9JTkpFQ1RJT04KPj4gKwlib29sICJFbmFibGUgWGVuIGZhdWx0IGluamVj
dGlvbiIKPj4gKwlkZXBlbmRzIG9uIEZBVUxUX0lOSkVDVElPTl9ERUJVR19GUwo+PiArCWRlZmF1
bHQgbgo+PiArCWhlbHAKPj4gKwkgIEVuYWJsZSBYZW4gZmF1bHQgaW5qZWN0aW9uIGZhY2lsaXR5
Cj4gV2h5IGZvciB4ODYgb25seT8gSSdkIHJhdGhlciBhZGQgdGhpcyB1bmRlciBkcml2ZXJzL3hl
bgoKU3VyZS4KCj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9NYWtlZmlsZSBiL2FyY2gv
eDg2L3hlbi9NYWtlZmlsZQo+PiBpbmRleCBkODNjYjU0Li4zMTU4ZmUxIDEwMDY0NAo+PiAtLS0g
YS9hcmNoL3g4Ni94ZW4vTWFrZWZpbGUKPj4gKysrIGIvYXJjaC94ODYveGVuL01ha2VmaWxlCj4+
IEBAIC0zNCwzICszNCw0IEBAIG9iai0kKENPTkZJR19YRU5fRE9NMCkJCSs9IHZnYS5vCj4+ICAg
b2JqLSQoQ09ORklHX1NXSU9UTEJfWEVOKQkrPSBwY2ktc3dpb3RsYi14ZW4ubwo+PiAgIG9iai0k
KENPTkZJR19YRU5fRUZJKQkJKz0gZWZpLm8KPj4gICBvYmotJChDT05GSUdfWEVOX1BWSCkJIAkr
PSB4ZW4tcHZoLm8KPj4gK29iai0kKENPTkZJR19YRU5fRkFVTFRfSU5KRUNUSU9OKQkrPSBmYXVs
dF9pbmplY3Qubwo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2ZhdWx0X2luamVjdC5jIGIv
YXJjaC94ODYveGVuL2ZhdWx0X2luamVjdC5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGlu
ZGV4IDAwMDAwMDAuLmVjZjBmN2MKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9hcmNoL3g4Ni94
ZW4vZmF1bHRfaW5qZWN0LmMKPj4gQEAgLTAsMCArMSwxMDkgQEAKPj4gKy8qCj4+ICsgKiBGYXVp
dCBpbmplY3Rpb24gaW50ZXJmYWNlIGZvciBYZW4gdmlydHVhbCBibG9jayBkZXZpY2VzCj4+ICsg
Kgo+PiArICogQ29weXJpZ2h0IDIwMTggQW1hem9uLmNvbSwgSW5jLiBvciBpdHMgYWZmaWxpYXRl
cy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPj4gKyAqCj4+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCj4+ICsgKiBtb2RpZnkg
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJz
aW9uIDIKPj4gKyAqIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
OyBvciwgd2hlbiBkaXN0cmlidXRlZAo+PiArICogc2VwYXJhdGVseSBmcm9tIHRoZSBMaW51eCBr
ZXJuZWwgb3IgaW5jb3Jwb3JhdGVkIGludG8gb3RoZXIKPj4gKyAqIHNvZnR3YXJlIHBhY2thZ2Vz
LCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgbGljZW5zZToKPiBQbGVhc2UgdXNlIHRoZSBhcHBy
b3ByaWF0ZSBTUERYIGhlYWRlciBpbnN0ZWFkIG9mIHRoZSBmdWxsIEdQTDIKPiBib2lsZXJwbGF0
ZS4KCkRpdHRvLgoKPgo+Cj4gSnVlcmdlbgo+CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vu
c3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmlj
aCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFt
IEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=
