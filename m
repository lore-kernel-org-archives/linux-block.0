Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674AC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE8C2083B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Lexmark.com header.i=@Lexmark.com header.b="Q1Yd1rIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBFVJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:09:02 -0500
Received: from mail-eopbgr770112.outbound.protection.outlook.com ([40.107.77.112]:22943
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfBFVJC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 16:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0OfevzX13q0+QtgOOQvGetn7ZhKvJz6Wb3VaEg43GI=;
 b=Q1Yd1rIL2I3xiSoHIJI7T7Fwn9RSW9lSu90xxNCTPm5by8lu7lJd4TUeReLI6ixswuqHPMu5eOJkll/XCsPzbOsdQV/4MpsBjkoYq+pe0EA8Yehedxz2kjTZpNrakDEzyR+PdtTZuQqqlk80wisOtoKeUo/ixP8NG9xB/4N8V+4=
Received: from DM5PR1001MB2412.namprd10.prod.outlook.com (10.174.184.33) by
 DM5PR1001MB2076.namprd10.prod.outlook.com (10.174.181.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 6 Feb 2019 21:08:57 +0000
Received: from DM5PR1001MB2412.namprd10.prod.outlook.com
 ([fe80::3134:b76:2401:e3d0]) by DM5PR1001MB2412.namprd10.prod.outlook.com
 ([fe80::3134:b76:2401:e3d0%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 21:08:57 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH] mmc: block: handle complete_work on separate workqueue
Thread-Topic: [PATCH] mmc: block: handle complete_work on separate workqueue
Thread-Index: AQHUvXNINO0IDeOGjEqNEniFzvEJKqXSrFiAgAALfwCAABgAAIAAcyIg
Date:   Wed, 6 Feb 2019 21:08:56 +0000
Message-ID: <DM5PR1001MB2412B645697E832E4420D7C08C6F0@DM5PR1001MB2412.namprd10.prod.outlook.com>
References: <1549385523-20521-1-git-send-email-zhays@lexmark.com>
 <CAPDyKFofTMGXfp1sKgv1Z6OSEyM9e78B-+3qZ=a6s3s2aNWybg@mail.gmail.com>
 <6956f0d7-0dea-b100-06ec-54148f043710@intel.com>
 <CAPDyKFrC4QjfrarvjRYCKYqoi7A1QOz_fQLnrOFocXARTP1kWA@mail.gmail.com>
In-Reply-To: <CAPDyKFrC4QjfrarvjRYCKYqoi7A1QOz_fQLnrOFocXARTP1kWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [74.129.179.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1001MB2076;6:C/K2Vp2+e/wfPNTBI/8cZBfTlX+oYrygaBla+mEigSIvAb/fUm8LQEMeCevEPuZqd1AQ5/qusRPQNSCmhK+SFdFMa41fvraaqd5yHXnH9J8Hg6dPxXK9BosSc2g71VZAiNKyt2Qz/UTZhzcbmo/ghqnOaWhQB58++PutfcrEWlUEiErUpSZAP20LJhFxptBtFUqX/Hu2xTMxmU8BscKmgiMWRkrvsai/o7o7kp0fQIMfIGYspQHPcC41fIlh/SJ56BMIdQcha8W8GdJtCFNP353rPnwh4gxomGXs+UM3QgrXXdFe0nPSdDW/tEiFN1Xw1NndKqzqXyRSqMuNPajtkPLML8w9VeuNFa9gNmw8KjQbm2G1wmZHjnzaqXoFb+x0WbOa7Q14E8gz+hkkOk3IK6qcsrM5VAswzJ33U4QTk+i0W1E5jV/Fbq5W6KInz+IoFfgexcyL6X4S0KN8/L2zqw==;5:N8GUt7N/+peoGMv7dGup2Y2CV5719Km58S90doepJxIoYDMA9QUZHYBa4npFGSWauVhhueqK8K3/yUKvqs8cDX/G7lRbOe4wRp6BvLicVOvb7sr5HvwV9wglEM8lCuRrTAmRbzCiV8+/QpFcsUuCESmJwdV1PomOctBqQMg52+nHvWnQQTmlHfYl9dajjDFTcuixZaD3L+n9sRPOwIgx8Q==;7:iM9EgI7+ZDstm4syo0aKUaheCz0kHZfsuRyXGCWx5qKFor8dSUZF/pnPhjoVPryImEMJHNkva94QpIP87Ut7QsebFpFZW6sdyS/YLKnBkTet4TuwP7Q7q4CTE6daNrjSsRWG+Wqru+aWSaBLiEv1kw==
x-ms-office365-filtering-correlation-id: a30570e2-9361-4eff-3bb7-08d68c774ed3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM5PR1001MB2076;
x-ms-traffictypediagnostic: DM5PR1001MB2076:
x-microsoft-antispam-prvs: <DM5PR1001MB20768D177B740C92981CE8058C6F0@DM5PR1001MB2076.namprd10.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(54534003)(13464003)(186003)(26005)(4326008)(3846002)(6116002)(68736007)(33656002)(9686003)(229853002)(6436002)(55016002)(8676002)(81156014)(66066001)(7696005)(110136005)(81166006)(6246003)(2906002)(93886005)(8936002)(99286004)(86362001)(316002)(53936002)(76176011)(74316002)(54906003)(305945005)(7736002)(14454004)(25786009)(486006)(71190400001)(44832011)(256004)(478600001)(53546011)(476003)(106356001)(97736004)(102836004)(105586002)(11346002)(6506007)(14444005)(446003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1001MB2076;H:DM5PR1001MB2412.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y5dBIT5tIvhnkFvPnW4YJdPq48Z0iTKOt92PomGFFRfN1bwyogIg9vL0DOvnBr24D/Qkpewj6TrRricTftqMgGY1Zvk30yPyEQ/IF45XNOhi2FQUhFVYkrGr1QPJEmYZ+ziVBBXXfbYxLlOR3FI5whoWxMBsFd2elj57E92m5raD/DfYTxZJ6+Uhfna4O5DhJwVnh/5QjTa01luvTwDLu9y0mBu2It8RbCae0gUlfyLGCME/fmUks1+5drq+Q2fPxMdRcBq113UqrFfe72RyY/Ppb9T9pkUrHs/2F+sJ7RQBHWNZoxnYOVmqOqSnJw4UnZYv+vLlVGYIuOSKgi/nyodAHiaiXFSE2KEiqV8Sv0MSR5ttUf4PKaJsX9/7gbL3u6Fq0XPo9QvQ2GQV+FutHfrWq7ccin8LD8CWhZ9vzXs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30570e2-9361-4eff-3bb7-08d68c774ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 21:08:56.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2076
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDYsIDIwMTkg
OTowOCBBTQ0KPiBUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+
IENjOiBaYWsgSGF5cyA8emFrLmhheXNAbGV4bWFyay5jb20+OyBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT47DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWJsb2NrIDxs
aW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxs
ZWlqQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogYmxvY2s6IGhhbmRs
ZSBjb21wbGV0ZV93b3JrIG9uIHNlcGFyYXRlDQo+IHdvcmtxdWV1ZQ0KPiANCj4gT24gV2VkLCA2
IEZlYiAyMDE5IGF0IDEzOjQzLCBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiA2LzAyLzE5IDI6MDAgUE0sIFVsZiBIYW5zc29uIHdy
b3RlOg0KPiA+ID4gKyBBZHJpYW4sIExpbnVzDQo+ID4gPg0KPiA+ID4gT24gVHVlLCA1IEZlYiAy
MDE5IGF0IDE3OjUzLCBaYWNoYXJ5IEhheXMgPHpoYXlzQGxleG1hcmsuY29tPiB3cm90ZToNCj4g
PiA+Pg0KPiA+ID4+IFRoZSBrYmxvY2tkIHdvcmtxdWV1ZSBpcyBjcmVhdGVkIHdpdGggdGhlIFdR
X01FTV9SRUNMQUlNIGZsYWcNCj4gc2V0Lg0KPiA+ID4+IFRoaXMgZ2VuZXJhdGVzIGEgcmVzY3Vl
ciB0aHJlYWQgZm9yIHRoYXQgcXVldWUgdGhhdCB3aWxsIHRyaWdnZXIgd2hlbg0KPiA+ID4+IHRo
ZSBDUFUgaXMgdW5kZXIgaGVhdnkgbG9hZCBhbmQgY29sbGVjdCB0aGUgdW5jb21wbGV0ZWQgd29y
ay4NCj4gPiA+Pg0KPiA+ID4+IEluIHRoZSBjYXNlIG9mIG1tYywgdGhpcyBjcmVhdGVzIHRoZSBw
b3NzaWJpbGl0eSBvZiBhIGRlYWRsb2NrIGFzDQo+ID4gPj4gb3RoZXIgYmxrLW1xIHdvcmsgaXMg
YWxzbyBydW4gb24gdGhlIHNhbWUgcXVldWUuIEZvciBleGFtcGxlOg0KPiA+ID4+DQo+ID4gPj4g
LSB3b3JrZXIgMCBjbGFpbXMgdGhlIG1tYyBob3N0DQo+ID4gPj4gLSB3b3JrZXIgMSBhdHRlbXB0
cyB0byBjbGFpbSB0aGUgaG9zdA0KPiA+ID4+IC0gd29ya2VyIDAgc2NoZWR1bGVzIGNvbXBsZXRl
X3dvcmsgdG8gcmVsZWFzZSB0aGUgaG9zdA0KPiA+ID4+IC0gcmVzY3VlciB0aHJlYWQgaXMgdHJp
Z2dlcmVkIGFmdGVyIHRpbWUtb3V0IGFuZCBjb2xsZWN0cyB0aGUgZGFuZ2xpbmcNCj4gPiA+PiAg
IHdvcmsNCj4gPiA+PiAtIHJlc2N1ZXIgdGhyZWFkIGF0dGVtcHRzIHRvIGNvbXBsZXRlIHRoZSB3
b3JrIGluIG9yZGVyIHN0YXJ0aW5nIHdpdGgNCj4gPiA+PiAgIGNsYWltIGhvc3QNCj4gPiA+PiAt
IHRoZSB0YXNrIHRvIHJlbGVhc2UgaG9zdCBpcyBub3cgYmxvY2tlZCBieSBhIHRhc2sgdG8gY2xh
aW0gaXQgYW5kDQo+ID4gPj4gICB3aWxsIG5ldmVyIGJlIGNhbGxlZA0KPiA+ID4+DQo+ID4gPg0K
PiA+ID4gQWRyaWFuLCBJIG5lZWQgeW91ciBoZWxwIHRvIHVuZGVyc3RhbmQgbW9yZSBvZiB0aGlz
LiBUaGUgYWJvdmUNCj4gPiA+IGRlc2NyaXB0aW9uIGRvZXNuJ3QgYWRkIHVwIHRvIG1lLg0KPiA+
ID4NCj4gPiA+IEluIHByaW5jaXBsZSwgYWxyZWFkeSB3aGVuICJ3b3JrZXIgMSBhdHRlbXB0cyB0
byBjbGFpbSB0aGUgaG9zdCIgYXMNCj4gPiA+IGRlc2NyaWJlZCBhYm92ZSwgaXQgc2hvdWxkIHN1
Y2NlZWQgYW5kIHNob3VsZCAqbm90KiBuZWVkIHRvIHdhaXQgZm9yDQo+ID4gPiB0aGUgaG9zdCB0
byBiZSByZWxlYXNlZC4gUmlnaHQ/DQo+ID4NCj4gPiBJZiBpdCBpcyB0aGUgc2FtZSBxdWV1ZSwg
dGhlbiB5ZXMuICBBbHRob3VnaCBpbiB0aGF0IGNhc2UgdGhlcmUgaXMgb25seSAxDQo+ID4gd29y
ayBmb3IgdGhlIGh3IHF1ZXVlIHNvIHRoZXJlIGNhbm5vdCBiZSBhbm90aGVyIHdvcmtlci4gIFRo
ZXJlIGNvdWxkIGJlDQo+ID4gYW5vdGhlciBhdHRlbXB0IHRvIHNlbmQgYSByZXF1ZXN0IGRpcmVj
dGx5LCBidXQgdGhhdCB3aWxsIG5vdCBibG9jayAtIGlmIHRoZQ0KPiA+IGhvc3QgY29udHJvbGxl
ciBpcyBidXN5LCBCTEtfU1RTX1JFU09VUkNFIHdpbGwgYmUgcmV0dXJuZWQgZnJvbSAtDQo+ID5x
dWV1ZV9ycSgpLg0KPiA+DQo+IA0KPiBSaWdodC4NCj4gDQo+ID4gPg0KPiA+ID4gVGhlIGhvbGUg
cG9pbnQgd2l0aCB0aGUgY29tbWl0IDZjMGNlZGQxZWY5NSAoIm1tYzogY29yZTogSW50cm9kdWNl
DQo+ID4gPiBob3N0IGNsYWltaW5nIGJ5IGNvbnRleHQiKSwgd2FzIHRvIGFsbG93IHRoZSBtbWMg
aG9zdCB0byBiZQ0KPiA+ID4gcmUtY2xhaW1hYmxlIGZvciBibGsgSS9PIHJlcXVlc3RzLCBubyBt
YXR0ZXIgZnJvbSB3aGF0IHdvcmtlci90aHJlYWQNCj4gPiA+IHRoZSBjbGFpbS9yZWxlYXNlIGlz
IGRvbmUgZnJvbS4NCj4gPiA+DQo+ID4gPiBJcyBpdCBub3Qgd29ya2luZyBhcyBleHBlY3RlZCB5
b3UgdGhpbms/IFdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/DQo+ID4NCj4gPiBJIGFzc3VtZWQgd2Ug
d2VyZSB0YWxraW5nIGFib3V0IGEgc2l0dWF0aW9uIHdoZXJlIHRoZXJlIGFyZSBtdWx0aXBsZQ0K
PiA+IGludGVybmFsIGVNTUMgcGFydGl0aW9ucyBlYWNoIHdpdGggdGhlaXIgb3duIGRpc2sgYW5k
IHF1ZXVlLiAgSW4gdGhhdCBjYXNlLA0KPiA+IGEgcXVldWUgd2FpdHMgaWYgdGhlcmUgaXMgYW5v
dGhlciBxdWV1ZSB0aGF0IGlzIHVzaW5nIHRoZSBlTU1DLg0KPiANCj4gT2YgY291cnNlISBJIHRv
dGFsbHkgZm9yZ290IGFib3V0IHRoaXMgY2FzZSwgdGhhdCBpcyBtb3N0IGNlcnRhaW5seQ0KPiB3
aGF0IG11c3QgYmUgaGFwcGVuaW5nIQ0KPiANCj4gPg0KPiA+IFdlIHNob3VsZCBjbGFyaWZ5IHdo
ZXRoZXIgdGhhdCBpcyB0aGUgc2NlbmFyaW8gd2UgYXJlIGxvb2tpbmcgYXQuICBaYWNoYXJ5Pw0K
PiANCj4gWWVzLCBwbGVhc2UuDQoNClllcywgdGhpcyBpcyB0aGUgY2FzZS4gVGhlcmUgYXJlIG11
bHRpcGxlIHBhcnRpdGlvbnMgb24gdGhlIGVNTUMuDQoNCj4gDQo+IEFzc3VtaW5nIHRoaXMgaXMg
dGhlIGNhc2UsIEkgd291bGQgYWxzbyBwcmVmZXIgYW4gdXBkYXRlZCBjaGFuZ2Vsb2cNCj4gdGhh
dCBkZXNjcmliZSB0aGlzIHNjZW5hcmlvLg0KDQpJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVz
c2FnZSB0byBjbGFyaWZ5IHRoaXMgYW5kIHJlc3VibWl0Lg0KDQo+IEFkcmlhbiwgdGhhbmtzIGEg
bG90IGZvciB5b3UgaGVscCENCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZm
ZQ0K
