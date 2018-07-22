Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbeGVNVL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jul 2018 09:21:11 -0400
From: Josef Bacik <jbacik@fb.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
Date: Sun, 22 Jul 2018 12:24:14 +0000
Message-ID: <F822F61E-0B79-494E-B989-6012F6490056@fb.com>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>,<20180722072804.GA955@ming.t460p>
In-Reply-To: <20180722072804.GA955@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

VWdoIGNyYXAgaXTigJlzIGluIHdidC4gIEnigJlsbCB0YWtlIGEgbG9vayB3aGVuIEnigJltIGJh
Y2sgZnJvbSB2YWNhdGlvbi4gIFRoYW5rcywNCg0KSm9zZWYNCg0KU2VudCBmcm9tIG15IGlQaG9u
ZQ0KDQo+IE9uIEp1bCAyMiwgMjAxOCwgYXQgMzoyOCBBTSwgTWluZyBMZWkgPG1pbmcubGVpQHJl
ZGhhdC5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFN1biwgSnVsIDIyLCAyMDE4IGF0IDAyOjE1OjM4
QU0gKzAwMDAsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gWXVwIEkgc2VudCBhIHBhdGNoIGZvciB0
aGlzIG9uIFRodXJzZGF5LCBzb3JyeSBhYm91dCB0aGF0LA0KPj4gDQo+IA0KPiBJIGp1c3QgYXBw
bGllZCB0aGUgcGF0Y2ggb2YgJ2Jsay1ycS1xb3M6IG1ha2UgZGVwdGggY29tcGFyaXNvbnMgdW5z
aWduZWQnLA0KPiBsb29rcyB0aGUgc2FtZSBJTyBoYW5nIGNhbiBiZSB0cmlnZ2VyZWQgdG9vLg0K
PiANCj4gVGhhbmtzLA0KPiBNaW5nDQo=
