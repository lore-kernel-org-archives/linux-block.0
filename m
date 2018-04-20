Return-Path: <prvs=6414f13c5=staskins@amazon.de>
Subject: Re: [PATCH 3/3] xen blkback: add fault injection facility
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
 <20180420104736.17823.42983.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <ef016b7b-6c0e-1684-5714-0a6d5a46504e@suse.com>
From: <staskins@amazon.com>
Message-ID: <403573a8-daeb-2e0e-fa31-e9bd160557fc@amazon.com>
Date: Fri, 20 Apr 2018 14:53:13 +0200
MIME-Version: 1.0
In-Reply-To: <ef016b7b-6c0e-1684-5714-0a6d5a46504e@suse.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
List-ID: <linux-block@vger.kernel.org>

T24gMDQvMjAvMTggMTM6MjgsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6Cj4gT24gMjAvMDQvMTggMTI6
NDcsIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToKPj4gVGhpcyBwYXRjaCBhZGRzIHdyYXBw
ZXIgaGVscGVycyBhcm91bmQgZ2VuZXJpYyBYZW4gZmF1bHQgaW5qZWN0Cj4+IGZhY2lsaXR5Lgo+
PiBUaGUgbWFqb3IgcmVhc29uIGlzIHRvIGtlZXAgYWxsIHRoZSBtb2R1bGUgZmF1bHQgaW5qZWN0
aW9uIGRpcmVjdG9yaWVzCj4+IGluIGEgZGVkaWNhdGVkIHN1YmRpcmVjdG9yeSBpbnN0ZWFkIG9m
IFhlbiBmYXVsdCBpbmplY3Qgcm9vdC4KPj4KPj4gSU9XLCB3aGVuIHVzaW5nIHRoZXNlIGhlbHBl
cnMsIHBlci1kZXZpY2UgYW5kIG5hbWVkIGJ5IGRldmljZSBuYW1lCj4+IGZhdWx0IGluamVjdGlv
biBjb250cm9sIGRpcmVjdG9yaWVzIHdpbGwgYXBwZWFyIHVuZGVyIHRoZSBmb2xsb3dpbmcKPj4g
ZGlyZWN0b3J5Ogo+PiAtIC9zeXMva2VybmVsL2RlYnVnL3hlbi9mYXVsdF9pbmplY3QveGVuLWJs
a2JhY2svCj4+IGluc3RlYWQgb2Y6Cj4+IC0gL3N5cy9rZXJuZWwvZGVidWcveGVuL2ZhdWx0X2lu
amVjdC8KPj4KPj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxzdGFza2lu
c0BhbWF6b24uY29tPgo+PiBDQzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgo+PiBDQzog
S29ucmFkIFJ6ZXN6dXRlayBXaWxrIDxrb25yYWQud2lsa0BvcmFjbGUuY29tPgo+PiBDQzogIlJv
Z2VyIFBhdSBNb25uw6kiIDxyb2dlci5wYXVAY2l0cml4LmNvbT4KPj4gQ0M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPj4gQ0M6IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZwo+PiBD
QzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCj4+IENDOiBTdGFuaXNsYXYgS2luc2J1
cnNraWkgPHN0YXNraW5zQGFtYXpvbi5jb20+Cj4+IENDOiBEYXZpZCBXb29kaG91c2UgPGR3bXdA
YW1hem9uLmNvLnVrPgo+IFRoaXMgaXMgYW4gZXhhY3QgY29weSBvZiB0aGUgbmV0YmFjayBwYXRj
aCBhcGFydCBmcm9tIHRoZSBuYW1lcy4KPgo+IEkgZG9uJ3QgbGlrZSBhZGRpbmcgbXVsdGlwbGUg
Y29waWVzIG9mIHRoZSBzYW1lIGNvZGluZyB0byB0aGUgdHJlZS4KClN1cmUsIHdpbGwgZGVkdXBw
bGljYXRlIHRoaXMuCgo+Cj4gSnVlcmdlbgo+CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vu
c3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmlj
aCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFt
IEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=
