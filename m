Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53074 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbdI0M66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 08:58:58 -0400
From: Avri Altman <Avri.Altman@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@wdc.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH V9 09/15] mmc: core: Add parameter use_blk_mq
Date: Wed, 27 Sep 2017 12:58:53 +0000
Message-ID: <DM5PR04MB1085F5C71B915665133D2E3FFC780@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZWtSHxQfkgZZDvzX562Jy_KenP__ruszLoeKKn+AkKig@mail.gmail.com>
In-Reply-To: <CACRpkdZWtSHxQfkgZZDvzX562Jy_KenP__ruszLoeKKn+AkKig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtbW1jLW93bmVy
QHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LW1tYy0NCj4gb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgTGludXMgV2FsbGVpag0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAyNywgMjAxNyAyOjQyIEFNDQo+IFRvOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVy
QGludGVsLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsg
bGludXgtbW1jIDxsaW51eC0NCj4gbW1jQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWJsb2NrIDxs
aW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC0NCj4ga2VybmVsIDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsNCj4g
QWxleCBMZW1iZXJnIDxBbGV4LkxlbWJlcmdAd2RjLmNvbT47IE1hdGV1c3ogTm93YWsNCj4gPG1h
dGV1c3oubm93YWtAaW50ZWwuY29tPjsgWXVsaXkgSXpyYWlsb3YgPFl1bGl5Lkl6cmFpbG92QHdk
Yy5jb20+Ow0KPiBKYWVob29uIENodW5nIDxqaDgwLmNodW5nQHNhbXN1bmcuY29tPjsgRG9uZyBB
aXNoZW5nDQo+IDxkb25nYXM4NkBnbWFpbC5jb20+OyBEYXMgQXN1dG9zaCA8YXN1dG9zaGRAY29k
ZWF1cm9yYS5vcmc+OyBaaGFuZ2ZlaQ0KPiBHYW8gPHpoYW5nZmVpLmdhb0BnbWFpbC5jb20+OyBT
YWhpdHlhIFR1bW1hbGENCj4gPHN0dW1tYWxhQGNvZGVhdXJvcmEub3JnPjsgSGFyamFuaSBSaXRl
c2ggPHJpdGVzaGhAY29kZWF1cm9yYS5vcmc+Ow0KPiBWZW51IEJ5cmF2YXJhc3UgPHZieXJhdmFy
YXN1QG52aWRpYS5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLQ0KPiBjaGlwcy5jb20+
OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
OSAwOS8xNV0gbW1jOiBjb3JlOiBBZGQgcGFyYW1ldGVyIHVzZV9ibGtfbXENCj4gDQo+IE9uIEZy
aSwgU2VwIDIyLCAyMDE3IGF0IDI6MzYgUE0sIEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJA
aW50ZWwuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gVW50aWwgbW1jIGhhcyBibGstbXEgc3VwcG9y
dCBmdWxseSBpbXBsZW1lbnRlZCBhbmQgdGVzdGVkLCBhZGQgYQ0KPiA+IHBhcmFtZXRlciB1c2Vf
YmxrX21xLCBkZWZhdWx0IHRvIGZhbHNlIHVubGVzcyBjb25maWcgb3B0aW9uDQo+ID4gTU1DX01R
X0RFRkFVTFQgaXMgc2VsZWN0ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW4gSHVu
dGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gDQo+ID4gK2NvbmZpZyBNTUNfTVFfREVG
QVVMVA0KPiA+ICsgICAgICAgYm9vbCAiTU1DOiB1c2UgYmxrLW1xIEkvTyBwYXRoIGJ5IGRlZmF1
bHQiDQo+ID4gKyAgICAgICBkZXBlbmRzIG9uIE1NQyAmJiBCTE9DSw0KPiANCj4gSSB3b3VsZCBz
YXk6DQo+IGRlZmF1bHQgeQ0KPiANCj4gV2h5IG5vdC4gU0NTSSBpcyBzdGFydGluZyB0byBlbmFi
bGUgdGhpcyBieSBkZWZhdWx0IHNvIElNTyB3ZSBzaG91bGQgbm90IHRha2UNCj4gdGhlIGludGVy
bWVkaWF0ZSBzdGVwIG9mIGhhdmluZyB0aGlzIGFzIG9wdGlvbmFsLiBPdGhlcndpc2UgaXQgbmV2
ZXIgZ2V0cw0KPiB0ZXN0ZWQuDQo+IA0KPiBTZXQgaXQgdG8gZGVmYXVsdCB5IGFuZCBhZnRlciB0
d28ga2VybmVsIHJlbGVhc2VzLCBpZiBub3RoaW5nIGhhcHBlbnMsIHdlIHNpbXBseQ0KPiBkZWxl
dGUgdGhlIG9sZCBibG9jayBsYXllciBwYXRoLg0KPiANCj4gPiArI2lmZGVmIENPTkZJR19NTUNf
TVFfREVGQVVMVA0KPiA+ICtib29sIG1tY191c2VfYmxrX21xID0gdHJ1ZTsNCj4gPiArI2Vsc2UN
Cj4gPiArYm9vbCBtbWNfdXNlX2Jsa19tcSA9IGZhbHNlOw0KPiA+ICsjZW5kaWYNCj4gPiArbW9k
dWxlX3BhcmFtX25hbWVkKHVzZV9ibGtfbXEsIG1tY191c2VfYmxrX21xLCBib29sLCBTX0lXVVNS
IHwNCj4gPiArU19JUlVHTyk7DQo+IA0KPiBBcmUgcGVvcGxlIHJlYWxseSBtb2Rwcm9iaW5nIHRo
aXMgc28gaXQgbmVlZHMgdG8gYmUgYSBtb2R1bGUgcGFyYW1ldGVyPw0KDQoNCk1vZHVsZSBwYXJh
bSBjYW4gYmUgY2hhbmdlZCBpbiBydW50aW1lDQoNCj4gDQo+IE1heWJlIEknbSB0aGUgb25seSBk
ZXZlbG9wZXIgc3R1cGlkIGVub3VnaCB0byBqdXN0IHJlY29tcGlsZSBhbmQgcmVib290IHRoZQ0K
PiB3aG9sZSBrZXJuZWwsIEkgZ3Vlc3MgdGhpcyBtYWtlcyBzZW5zZSBpZiB5b3UncmUgdGVzdGlu
ZyBvbiB0aGUgc2FtZSBtYWNoaW5lDQo+IHlvdSdyZSBkZXZlbG9waW5nIG9uIChubyBjcm9zcy1j
b21waWxhdGlvbiBhbmQgcmVtb3RlIHRhcmdldCkgd2hpY2ggSSBndWVzcw0KPiBpcyB3aGF0IHNv
bWUgSW50ZWwgcGVvcGxlIGFyZSBkb2luZyB3aXRoIHRoZWlyIGxhcHRvcHMuDQo+IA0KPiBZb3Vy
cywNCj4gTGludXMgV2FsbGVpag0KPiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlz
dDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtbW1jIiBpbiB0aGUNCj4gYm9keSBv
ZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBp
bmZvIGF0DQo+IGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K
