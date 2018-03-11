Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59476 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeCKFBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Mar 2018 00:01:14 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jaco@uls.co.za" <jaco@uls.co.za>
CC: "pieterk@uls.co.za" <pieterk@uls.co.za>
Subject: Re: disk-io lockup in 4.14.13 kernel
Date: Sun, 11 Mar 2018 05:00:56 +0000
Message-ID: <1520744455.8740.9.camel@wdc.com>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
         <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
         <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
         <1520737695.8740.4.camel@wdc.com>
         <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
In-Reply-To: <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE4LTAzLTExIGF0IDA2OjMzICswMjAwLCBKYWNvIEtyb29uIHdyb3RlOg0KPiBj
cm93c25lc3QgfiAjIGZpbmQgL3N5cyAtbmFtZSBzZG0NCj4gL3N5cy9rZXJuZWwvZGVidWcvYmxv
Y2svc2RtDQo+IC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAw
LjAvaG9zdDAvcG9ydC0wOjAvZXhwYW5kZXItMDowL3BvcnQtMDowOjAvZXhwYW5kZXItMDoxL3Bv
cnQtMDoxOjAvZW5kX2RldmljZS0wOjE6MC90YXJnZXQwOjA6MTMvMDowOjEzOjAvYmxvY2svc2Rt
DQo+IC9zeXMvY2xhc3MvYmxvY2svc2RtDQo+IC9zeXMvYmxvY2svc2RtDQo+IA0KPiA+IGxzcGNp
DQo+IA0KPiBjcm93c25lc3QgfiAjIGxzcGNpDQo+IFsgLi4uIF0NCj4gMDE6MDAuMCBTZXJpYWwg
QXR0YWNoZWQgU0NTSSBjb250cm9sbGVyOiBMU0kgTG9naWMgLyBTeW1iaW9zIExvZ2ljDQo+IFNB
UzMwMDggUENJLUV4cHJlc3MgRnVzaW9uLU1QVCBTQVMtMyAocmV2IDAyKQ0KPiBbIC4uLiBdDQoN
CkhpIEphY28sDQoNClJlY2VudGx5IGEgYnVnIGZpeCBmb3IgdGhlIG1xLWRlYWRsaW5lIHNjaGVk
dWxlciB3YXMgcG9zdGVkIGJ1dCBJIGRvbid0DQp0aGluayB0aGF0IHRoYXQgcGF0Y2ggd2lsbCBj
aGFuZ2UgdGhlIGJlaGF2aW9yIG9uIHlvdXIgc2V0dXAgc2luY2UgeW91IGFyZQ0Kbm90IHVzaW5n
IFpCQyBkaXNrcy4gU2VlIGFsc28gIm1xLWRlYWRsaW5lOiBNYWtlIHN1cmUgdG8gYWx3YXlzIHVu
bG9jaw0Kem9uZXMiIChodHRwczovL21hcmMuaW5mby8/bD1saW51eC1ibG9jayZtPTE1MTk4Mzkz
MzcxNDQ5MikuDQoNCkRpZCBJIHNlZSBjb3JyZWN0bHkgdGhhdCAvZGV2L3NkbSBpcyBiZWhpbmQg
YSBNUFQgU0FTIGNvbnRyb2xsZXI/IFlvdSBtYXkNCndhbnQgdG8gY29udGFjdCB0aGUgYXV0aG9y
cyBvZiB0aGlzIGRyaXZlciBhbmQgQ2MgdGhlIGxpbnV4LXNjc2kgbWFpbGluZw0KbGlzdC4gU29y
cnkgYnV0IEknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgbXB0M3NhcyBkcml2ZXIgbXlzZWxmLg0K
DQpCYXJ0Lg==
