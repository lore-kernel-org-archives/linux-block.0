Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22285 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGFXHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 19:07:08 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Date: Fri, 6 Jul 2018 23:07:06 +0000
Message-ID: <e62c7749ff73f1cb7ab91fccffb5f353dd8d7c58.camel@wdc.com>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
         <20180627214908.26379-4-bart.vanassche@wdc.com>
         <20180628234305.GB14953@vader>
         <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
         <20180703194913.GA25954@vader> <20180703195010.GB25954@vader>
         <20180703213918.GC25954@vader>
         <69e800ccba7644a5a0b26e6d83483310926a907b.camel@wdc.com>
         <20180706212144.GF25954@vader> <20180706230328.GG25954@vader>
In-Reply-To: <20180706230328.GG25954@vader>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDE2OjAzIC0wNzAwLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0K
PiBBbHJpZ2h0LCBJJ20gbm90IGdldHRpbmcgdGhlIHVkZXYgZXZlbnRzIGF0IGFsbCAoZXZlbiBh
ZnRlciBlbmFibGluZw0KPiBDT05GSUdfRE1fVUVWRU5UIGluIGFkZGl0aW9uIHRvIGV2ZXJ5dGhp
bmcgbWVudGlvbmVkIGluIHRoZSBSRUFETUUpLiBJDQo+IGhhdmUgbm8gaWRlYSB3aGVyZSB0byBn
byBmcm9tIGhlcmUuDQo+IA0KPiBBZnRlciwgZS5nLiwgc3JwLzAwMiBmYWlscywgdGhpcyBpcyB0
aGUgc3RhdGUgb2YgbXkgc3lzdGVtOg0KPiANCj4gJCBzdWRvIG11bHRpcGF0aCAtbA0KPiAkIGxz
IC9zeXMvY2xhc3MvYmxvY2sNCj4gbnZtZTBuMSAgcmFtMCAgcmFtMSAgcmFtMiAgc2RhICBzZGIg
IHNkYyAgc2RkICB2ZGEgIHZkYTEgIHZkYiAgdmRjICB2ZGQNCj4gJCBsc2Jsaw0KPiBOQU1FICAg
IE1BSjpNSU4gUk0gU0laRSBSTyBUWVBFIE1PVU5UUE9JTlQNCj4gc2RhICAgICAgIDg6MCAgICAw
ICAzMk0gIDAgZGlzaw0KPiBzZGIgICAgICAgODoxNiAgIDAgIDMyTSAgMCBkaXNrDQo+IHNkYyAg
ICAgICA4OjMyICAgMCAgMzJNICAwIGRpc2sNCj4gc2RkICAgICAgIDg6NDggICAwICAzMk0gIDAg
ZGlzaw0KPiB2ZGEgICAgIDI1NDowICAgIDAgIDE2RyAgMCBkaXNrDQo+IOKUlOKUgHZkYTEgIDI1
NDoxICAgIDAgIDE2RyAgMCBwYXJ0IC8NCj4gdmRiICAgICAyNTQ6MTYgICAwICAgOEcgIDAgZGlz
aw0KPiB2ZGMgICAgIDI1NDozMiAgIDAgICA4RyAgMCBkaXNrDQo+IHZkZCAgICAgMjU0OjQ4ICAg
MCAgIDhHICAwIGRpc2sNCj4gbnZtZTBuMSAyNTk6MCAgICAwICAgOEcgIDAgZGlzaw0KPiAkIGxz
c2NzaQ0KPiBbMDowOjA6MF0gICAgZGlzayAgICBMaW51eCAgICBzY3NpX2RlYnVnICAgICAgIDAx
ODggIC9kZXYvc2RhDQo+IFsxOjA6MDowXSAgICBkaXNrICAgIExJTy1PUkcgIElCTE9DSyAgICAg
ICAgICAgNC4wICAgL2Rldi9zZGINCj4gWzE6MDowOjFdICAgIGRpc2sgICAgTElPLU9SRyAgSUJM
T0NLICAgICAgICAgICA0LjAgICAvZGV2L3NkZA0KPiBbMTowOjA6Ml0gICAgZGlzayAgICBMSU8t
T1JHICBJQkxPQ0sgICAgICAgICAgIDQuMCAgIC9kZXYvc2RjDQoNClRoYXQncyB3ZWlyZC4gSWYg
eW91IHdhbnQgSSBjYW4gaW5zdGFsbCBBcmNoIExpbnV4IG15c2VsZiBhbmQgZGVidWcgdGhpcw0K
ZnVydGhlci4gU29tZXRoaW5nIHRoYXQgd291bGQgYWxzbyBoZWxwIGlzIGlmIHlvdSBjb3VsZCBy
dW4gdGhlIGZvbGxvd2luZw0KY29tbWFuZHMgYXMgcm9vdCBhbmQgcHJvdmlkZSB0aGVpciBvdXRw
dXQ6DQoNCmVjaG8gcmVjb25maWd1cmUgfCBtdWx0aXBhdGhkIC1rDQptdWx0aXBhdGggLWxsDQoN
ClRoYW5rcywNCg0KQmFydC4=
