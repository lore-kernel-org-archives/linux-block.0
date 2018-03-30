Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27969 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeC3UBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Mar 2018 16:01:31 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tim.t.walker@seagate.com" <tim.t.walker@seagate.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: Multi-Actuator SAS HDD First Look
Date: Fri, 30 Mar 2018 20:01:23 +0000
Message-ID: <3351f24c47e16ce33f9fc9e70e703d7aaf5ff67f.camel@wdc.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
         <20180326170840.0130f366@pentland.suse.de>
         <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
         <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
         <CANo=J16HKWi+t2zK4LOAM+hhTJC=oNBr+-AJpJYvnipjmf3KPw@mail.gmail.com>
         <8be5e46f7b63290638383f05769211e6858e2267.camel@wdc.com>
         <CANo=J15fR6H0COYrBx=5a4uwwBS4AJKNWhks8-Ugc5DMDtg3TQ@mail.gmail.com>
         <fbdcf0a4133d60c6e8e6b6dbadc9fa27bb1af314.camel@wdc.com>
         <CANo=J1788-mA2bL3j-MOkZ2uuHoo7DdccdB_WhaP1WQRxzsfiA@mail.gmail.com>
In-Reply-To: <CANo=J1788-mA2bL3j-MOkZ2uuHoo7DdccdB_WhaP1WQRxzsfiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAzLTMwIGF0IDEyOjM2IC0wNjAwLCBUaW0gV2Fsa2VyIHdyb3RlOg0KPiBZ
ZXMgSSB3aWxsIGJlIHRoZXJlIHRvIGRpc2N1c3MgdGhlIG11bHRpLUxVTiBhcHByb2FjaC4gSSB3
YW50ZWQgdG8gZ2V0DQo+IHRoZXNlIGludGVyZmFjZSBkZXRhaWxzIG91dCBzbyB3ZSBjb3VsZCBo
YXZlIHNvbWUgYmFja2dyb3VuZCBhbmQNCj4gcGVyaGFwcyBmb2xrcyB3b3VsZCBjb21lIHdpdGgg
aWRlYXMuIEkgZG9uJ3QgaGF2ZSBtdWNoIG1vcmUgdG8gcHV0DQo+IG91dCwgYnV0IEkgd2lsbCBj
ZXJ0YWlubHkgYW5zd2VyIHF1ZXN0aW9ucyAtIGVpdGhlciBvbiB0aGlzIGxpc3Qgb3INCj4gZGly
ZWN0bHkuDQoNCkhlbGxvIFRpbSwNCg0KQXMgZmFyIGFzIEkga25vdyB0aGUgTGludXggU0NTSSBz
dGFjayBkb2VzIG5vdCB5ZXQgc3VwcG9ydCBhbnkgU0NTSSBkZXZpY2VzDQpmb3Igd2hpY2ggYSBz
aW5nbGUgU0NTSSBjb21tYW5kIGFmZmVjdHMgbXVsdGlwbGUgKHR3byBpbiB0aGlzIGNhc2UpIExV
TnMuDQpBZGRpbmcgc3VjaCBzdXBwb3J0IG1heSB0YWtlIHNpZ25pZmljYW50IHdvcmsuIFRoZXJl
IHdpbGwgYWxzbyBiZSB0aGUNCmRpc2FkdmFudGFnZSB0aGF0IG1vc3QgU0NTSSBjb3JlIGNvbnRy
aWJ1dG9ycyBkbyBub3QgaGF2ZSBhY2Nlc3MgdG8gYSBtdWx0aS0NCmFjdHVhdG9yIGRldmljZSBh
bmQgaGVuY2UgdGhhdCB0aGVpciBjaGFuZ2VzIG1heSBicmVhayBzdXBwb3J0IGZvciBtdWx0aS0N
CmFjdHVhdG9yIGRldmljZXMuDQoNClBTOiB0aGUgcHJlZmVycmVkIHN0eWxlIGZvciBhbGwgTGlu
dXgga2VybmVsIG1haWxpbmcgbGlzdHMgSSBrbm93IG9mIGlzIHRvIHJlcGx5DQpiZWxvdyBhIHBy
ZXZpb3VzIG1lc3NhZ2UuIFNlZSBhbHNvIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL1Bv
c3Rpbmdfc3R5bGUuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
