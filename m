Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE3C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1014207BB
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 23:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lYvoR6bH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UZ1VFv0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgFAXhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:37:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14448 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAXhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 19:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591054637; x=1622590637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k17/yg2hIVDc146Ebpu0PUkQ8vi9Lap+mFKrSS+Ebmc=;
  b=lYvoR6bHW5tRP694+8cM8ff5ijvF4/B9DocPxCbgco6vqJHZZSUWnXcn
   zgIyTyJKe9/MF83HTdcZ4fS3TexPE5JSIBlww36JM/+n07nel0nj+N8ie
   ZkRRexYoccs2dbin9kOldY8xnx5vW5ZJQrZawJgU0eJry3lkDu60qZ3Ns
   KQmQ/S9uJU4JbuR4XfB5bWqD/yc0Bh8ts/G6ayzw4kC1u6gySCVPZud5V
   9IvI/JMJZSOlXbWG+lKzYnnYQbKRE0dvYHQ2GPpcIySAwD0U6Y55u5DGh
   eu3TChkn/EugsM1KFsu0t54fcxVEFzbeNUSQbFzogYLPcrouYQfO/8lTq
   Q==;
IronPort-SDR: /CnUb2ez5gmbYo4HylkOPY+MClQIuf4Bb7GEXr009NXNKFAzCbC+pKxC5TqdQhJ8Aw7/bBzHIq
 4vru1/mnoC6XZ9pLKGyYqTsMzMSH/8qVflVmdjnEj0zepxbszFXh2oUbpFRapCKojXrawO9VNj
 0Bmgtu1ha2p4d8iS0GDaPDyFtIVD+iHyNsqMv9dxu6BOepiSehEebVOcFAtAlBkFX+dsWtKH+k
 MyNCQWpqGUOQE7yDf2hw/oLZR31vzsVIB+/qF7gFpV41HtlT2gWlGpQHce9Phkzqm8aMNMRun+
 tgg=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="139303581"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 07:37:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNEExdpufi8OyoxcpEqdpn/zxd1kBulL2fLW2XuFKUNi45sIkMehi9gg8hKxlmM4LiMEvTK4wAVEVS45LpMUHvVUNTeOiHwZTg6qM5dRGrC+/YEBzNv6PQh1jhOCVOx8O6hHL5sYxqcpteOFszv5BE8dptc5kOA/1ocD4LuxVapM5mQvGVZRmYDI4jhkLRcEgx0OxBIPZAaXmHAg6K3WYefsVBLbmcRfSuHaohmapzhW/LYQLhSONbXtu7fsAroAUgGMcxFRh8L7SlYF0aXwHnS3IZPSiEEt/0Ol84S6+pw6JlK/wp9LewKAwIXDAdpZBAbwFup98pflmFYggHcSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k17/yg2hIVDc146Ebpu0PUkQ8vi9Lap+mFKrSS+Ebmc=;
 b=FoPqotP0Noc6J/7GsvzkbfrG9s+kJZHK3bKs8c63dnn1TgR/GsTmW/KztcuS5SzOqQrMxB3dgABW11tHkSOiv1Nb7/zi+rECJAvzNrt86gSMMUYX/vNNoiOGi6pSx11S4+gPl1WIDsKXfl78/wjEDrTTkL0tK0A54A+tRxx+HB78KcmDAs/NSn/0t7N91n6SkfBv+mvVXf0oLHFIhbmZZV5qJQbHi+5HgBqmx1L1grkbZjkSr2+Q6R3VKnexxZIdzczEJ7zsuvOfPq9gEiI0neVX90npiTLERPZeU7QNnddtRZX4LliDK2ahHIIZiAt6YyarV5eki1oPNBueVhsntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k17/yg2hIVDc146Ebpu0PUkQ8vi9Lap+mFKrSS+Ebmc=;
 b=UZ1VFv0qMvGpTJqvqm/RcExePvye0Sxy0dThGLv6xJNj5OnAwmmm74Av6582AeC9S8zvNMbUONV3gQfBt+QP3UEd9qRKKdcRrfjG93CnN8Xlmw/tfeHEieAke/6GIMzS2tgVUsc1ERId1BcLluJs3Ymo0b+MECoksbtf2NbdTMc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0215.namprd04.prod.outlook.com (2603:10b6:903:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 23:37:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 23:37:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
Thread-Topic: [PATCH] block: Flag elevators suitable for single queue
Thread-Index: AQHWNMe05j/yUN3OvkCO6kMWTOQvo6jDaO2AgAA/aQCAAAX7AIAAD3aAgACz0IA=
Date:   Mon, 1 Jun 2020 23:37:14 +0000
Message-ID: <7f9aaf69b24b794ca4c9c126eb2394862e276c73.camel@wdc.com>
References: <20200528081003.238804-1-linus.walleij@linaro.org>
         <20200601074957.GE1181806@T590>
         <CACRpkdYL4-Z=kaS+RfniVr=Sn-yOf+=CKMJDsn=eTK3atmGohg@mail.gmail.com>
         <20200601115818.GB1190838@T590>
         <CAPDyKFq2paDu9ogEFh6VXWq8___FLeEaNyBWhkMSdpZYpEytQQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq2paDu9ogEFh6VXWq8___FLeEaNyBWhkMSdpZYpEytQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.2 (3.36.2-1.fc32) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:62d1:16e6:ecb1:d604]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abb94424-c1c2-4051-3f00-08d80684b6f1
x-ms-traffictypediagnostic: CY4PR04MB0215:
x-microsoft-antispam-prvs: <CY4PR04MB0215BFB59FC293CBE6B1AA66E78A0@CY4PR04MB0215.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoM4xAU3/0oDUlezvWmqqk21Ct+wy+hJyxgyp629gAGByVl/azPTk89ksbIQEGPN3TcL/zJ1rmnNg5EyAJP/mkB7H1+w393Bz1BGre0hke35PQw0wEwQhxLdGmPMkc67aEu4h4q+nWHLO7G4h4I/SK6Lc7j0Ty3nThxoTcdG6qRVI6/npuzUQdlLl3MYPlsTrqrEql+xwdsZoteDzObjHUKp8XgW+y0gVrNWFzTr3j7k3vtfDKOkpGIyQcMo+Racz0YbiEFHiIl3XPFW/ZKw4HF38LsvxdmEFAgrta6XllR0vE6X+CJsElFbtOdKv5hX18XIeky9QdB4Y4DZITzyDuVOk/EVriE2ZZdlV1FOAQ2LuY+9PQA9SmnIkVc1VZWBYm49e7iekmFoPMrBDYGjqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(396003)(366004)(346002)(376002)(66446008)(76116006)(64756008)(66476007)(86362001)(66556008)(36756003)(66946007)(186003)(5660300002)(8936002)(8676002)(91956017)(2906002)(6506007)(2616005)(53546011)(7416002)(71200400001)(966005)(110136005)(316002)(6486002)(83380400001)(478600001)(4326008)(6512007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jrw7ZwW0cRbNWNv+XN4gx8w8LDtDd2DY+iAtEEJlB45L3kP6sJrphuRiYO+8BaDSHhKC/7F6ubalVfYlHdyegqC2g39it4HnkO2drJUxXv/ZpYxg41o9wUsvPTwXV4aVAp9jCbkT8ywEJ5p/UFe0AeH3hLFqdo+Ag4BQNtHZ4S9crTvx1TEmTd3nAYUYW6x5h4emErj+PDhY0bZIunnM15amKcAnt7a5d5NczVGW6rIRFaQ6voo8iWtqy5ZQUzdHxy1PlA6pBdIyx3P4LWRxi2l+XJeB+Xa05gN5uqP/mvX9FOJZ8B/oEB8zq8twY9u1Z1zsEa+0UFXLu/XWdIZdo8OM4PtE8YKN7FGZixlI3RTSGozFi40+oEhYFnUZBUEtcav/sFmzDNg7X8/x+h6GbuTZys09lH4DJy8J6EO47/jFOafIuavopAfXv1MVbTABN7uwHk/EwqSh7ojjhZT/UzDOCLMe3m+305B1uSMIEuWbAoEivOD5hgqXFrK78zMQ+UAwJCv7C/c5QZx7ulEdu2L+CAPTJ0LjEe16vWfGJCEcK8HnUROd3yqfnkctKCEJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2CFAEAD7024954C872AB397F2A4CB10@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb94424-c1c2-4051-3f00-08d80684b6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 23:37:14.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEf2CvB9AO13efvtN6cLmLksZKnCLzm4F/+i87CPadFxdbKwzRqHYD4ODgXOStLwWGMLEoTph18Al/Tc698bIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0215
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTAxIGF0IDE0OjUzICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gTW9uLCAxIEp1biAyMDIwIGF0IDEzOjU4LCBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+ID4gT24gTW9uLCBKdW4gMDEsIDIwMjAgYXQgMDE6MzY6NTRQTSArMDIwMCwg
TGludXMgV2FsbGVpaiB3cm90ZToNCj4gPiA+IE9uIE1vbiwgSnVuIDEsIDIwMjAgYXQgOTo1MCBB
TSBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwg
TWF5IDI4LCAyMDIwIGF0IDEwOjEwOjAzQU0gKzAyMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+
ID4gPiA+ID4gVGhlIEt5YmVyIGJsb2NrIHNjaGVkdWxlciBpcyBub3Qgc3VpdGFibGUgZm9yIHNp
bmdsZSBoYXJkd2FyZQ0KPiA+ID4gPiA+IHF1ZXVlIGRldmljZXMsIHNvIGFkZCBhIG5ldyBmbGFn
IGZvciBzaW5nbGUgaGFyZHdhcmUgcXVldWUNCj4gPiA+ID4gPiBkZXZpY2VzIGFuZCBhZGQgdGhh
dCB0byB0aGUgZGVhZGxpbmUgYW5kIEJGUSBzY2hlZHVsZXJzDQo+ID4gPiA+ID4gc28gdGhlIEt5
YmVyIHNjaGVkdWxlciB3aWxsIG5vdCBiZSBzZWxlY3RlZCBmb3Igc2luZ2xlIHF1ZXVlDQo+ID4g
PiA+ID4gZGV2aWNlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBhYm92ZSBtYXkgbm90IGJlIHRy
dWUgZm9yIHNvbWUgc2luZ2xlIGh3IHF1ZXVlIGhpZ2ggcGVyZm9ybWFuY2UgSEJBKA0KPiA+ID4g
PiBzdWNoIGFzIG1lZ2FzYXMpLCB3aGljaCBjYW4gZ2V0IGJldHRlciBwZXJmb3JtYW5jZSBmcm9t
IG5vbmUsIHNvIGl0IGlzDQo+ID4gPiA+IHJlYXNvbmFibGUgdG8gZ2V0IGJldHRlciBwZXJmb3Jt
YW5jZSBmcm9tIGt5YmVyLCBzZWUgNmNlM2RkNmVlYzExICgiYmxrLW1xOg0KPiA+ID4gPiBpc3N1
ZSBkaXJlY3RseSBpZiBodyBxdWV1ZSBpc24ndCBidXN5IGluIGNhc2Ugb2YgJ25vbmUnIiksIGFu
ZCB0aGUNCj4gPiA+ID4gZm9sbG93aW5nIGxpbms6DQo+ID4gPiA+IA0KPiA+ID4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDE4MDcxMDAxMDMzMS4yNzQ3OS0xLW1pbmcu
bGVpQHJlZGhhdC5jb20vDQo+ID4gPiANCj4gPiA+IEkgc2VlLCBidXQgaXNuJ3QgdGhlIGNhc2Ug
cmF0aGVyIHRoYXQgbm9uZSBpcyBwcmVmZXJyZWQgYW5kIGt5YmVyIGdpdmVzDQo+ID4gPiB0aGUg
c2FtZSBjaGFyYWN0ZXJpc3RpY3MgYmVjYXVzZSBpdCdzIG5vdCBzdGFuZGluZyBpbiB0aGUgd2F5
DQo+ID4gPiBhcyBtdWNoPw0KPiA+IA0KPiA+IEt5YmVyIGhhcyBpdHMgb3duIGNoYXJhY3Rlcmlz
dGljLCBzdWNoIGFzIGZhaXIgcmVhZCAmIHdyaXRlLCBiZXR0ZXINCj4gPiBJTyBtZXJnZS4gQW5k
IHRoZSBkZWNpc2lvbiBvbiBzY2hlZHVsZXIgaXNuJ3Qgb25seSByZWxhdGVkIHdpdGggZGV2aWNl
LA0KPiA+IGJ1dCBhbHNvIHdpdGggd29ya2xvYWRzLg0KPiA+IA0KPiA+ID4gSXQgbG9va3MgbGlr
ZSBpZiB3ZSBzaG91bGQgYWRkIGEgc3BlY2lhbCBmbGFnIGZvciB0aGVzZSBkZXZpY2VzIHdpdGgN
Cj4gPiA+IHZlcnkgZmFzdCBzaW5nbGUgcXVldWVzIHNvIHRoZXkgY2FuIHNheSAiSSBwcmVmZXIg
bm9uZSIsIGRvIHlvdQ0KPiA+ID4gYWdyZWU/DQo+ID4gDQo+ID4gSSBhbSBub3Qgc3VyZSBpZiBp
dCBpcyBlYXN5IHRvIGFkZCBzdWNoIGZsYWcsIGJlY2F1c2UgaXQgaXNuJ3Qgb25seQ0KPiA+IHJl
bGF0ZWQgd2l0aCBIQkEsIGJ1dCBhbHNvIHdpdGggdGhlIGF0dGFjaGVkIGRpc2tzLg0KPiA+IA0K
PiANCj4gSW4gZ2VuZXJhbCBJIGRvbid0IG1pbmQgdGhlIGlkZWEgb2YgZ2l2aW5nIGhpbnRzIGZy
b20gbG93ZXIgbGF5ZXINCj4gYmxvY2sgZGV2aWNlcywgYWJvdXQgd2hhdCBraW5kIG9mIHNjaGVk
dWxpbmcgYWxnb3JpdGhtIHRoYXQgY291bGQgbWFrZQ0KPiBzZW5zZSAoYXMgbG9uZyBpdCdzIG9u
IGEgcmVhc29uYWJsZSBncmFudWxhcml0eSkuDQo+IA0KPiBJZiBJIHVuZGVyc3RhbmQgeW91ciBw
b2ludCBjb3JyZWN0bHksIHdoYXQgeW91IGFyZSBzYXlpbmcgaXMgdGhhdCBpdA0KPiBpc24ndCBl
YXN5IG9yIGV2ZW4gcG9zc2libGUgZm9yIHNvbWUgYmxvY2sgZGV2aWNlcyBIV3MuIEhvd2V2ZXIs
IHRoYXQNCj4gc2hvdWxkIGJlIGZpbmUsIGFzIGl0IHdvdWxkbid0IGJlIG1hbmRhdG9yeSB0byBz
ZXQgdGhpcyBraW5kIG9mIGZsYWdzLA0KPiBidXQNCj4gaW5zdGVhZCBjb3VsZCBoZWxwIHdoZXJl
IHdlIHNlZSBpdCBmaXQsIHJpZ2h0Pw0KDQpUaGUgZWxldmF0b3IgZmVhdHVyZXMgZmxhZyB3YXMg
aW1wbGVtZW50ZWQgbm90IGFzIGEgaGludCwgYnV0IGFzIGhhcmQNCnJlcXVpcmVtZW50cyBmb3Ig
ZWxldmF0b3JzIHRoYXQgYXJlIG5lZWRlZCAobWFuZGF0b3J5KSBmb3IgYSBwYXJ0aWN1bGFyDQpk
ZXZpY2UgdHlwZSBmb3IgY29ycmVjdCBvcGVyYXRpb24uIEJ5IGNvcnJlY3Qgb3BlcmF0aW9uLCBJ
IG1lYW4gIm5vIElPDQplcnJvcnMgb3Igd2VpcmQgYmVoYXZpb3IgcmVzdWx0aW5nIGluIGVycm9y
cyBzdWNoIGFzIHRpbWVvdXRzIi4gVW50aWwNCm5vdywgdGhlIG9ubHkgaGFyZCByZXF1aXJlbWVu
dCB3ZSBoYXZlIGlzIGZvciB6b25lZCBibG9jayBkZXZpY2VzIHdoaWNoDQpuZWVkIG1xLWRlYWRs
aW5lIHRvIGd1YXJhbnRlZSBpbi1vcmRlciBkaXNwYXRjaCBvZiB3cml0ZSBjb21tYW5kcyAoZm9y
DQpzZXF1ZW50aWFsIHpvbmVzIHdyaXRpbmcpLg0KDQpXZSBkZWZpbml0ZWx5IGNvdWxkIGFkZCBo
aW50IGZsYWdzIHRvIGJldHRlciBoZWxwIHRoZSBibG9jayBsYXllcg0KZGVjaWRlIG9uIHRoZSBk
ZWZhdWx0IG9wdGltYWwgZWxldmF0b3IgZm9yIGEgcGFydGljdWxhciBkZXZpY2UgdHlwZSwNCmJ1
dCBhcyBpcywgdGhlIGVsZXZhdG9yIGZlYXR1cmVzIHdpbGwgY29tcGxldGVseSBwcmV2ZW50IHRo
ZSB1c2Ugb2YgYW55DQpvdGhlciBlbGV2YXRvciB0aGF0IGRvZXMgbm90IGhhdmUgdGhlIGZlYXR1
cmUgc2V0LiBUaG9zZSBlbGV2YXRvcnMgd2lsbA0Kbm90IGJlIHNlZW4gaW4gL3N5cy9ibG9jay88
ZGV2Pi9xdWV1ZS9zY2hlZHVsZXIuIFRoaXMgbWF5IGJlIGEgbGl0dGxlDQp0b28gbXVjaCBmb3Ig
aGludCBsZXZlbCByYXRoZXIgdGhhbiBoYXJkIHJlcXVpcmVtZW50Lg0KDQpGdXJ0aGVybW9yZSwg
YXMgTWluZyBzYWlkLCB0aGlzIGRlcGVuZHMgb24gdGhlIEhCQSB0b28gcmF0aGVyIHRoYW4ganVz
dA0KdGhlIGRldmljZSBpdHNlbGYuIEUuZy4gdGhlIHNtYXJ0cHFpIGRyaXZlciAoTWljcm9zZW1p
IFNBUyBIQkFzKQ0KZXhwb3NlcyBzaW5nbGUgaGFyZC1kaXNrcyBhcyB3ZWxsIGFzIGZhc3QgUkFJ
RCBhcnJheXMgYXMgbXVsdGktcXVldWUNCmRldmljZXMuIFdoaWxlIGt5YmVyIG1heSBtYWtlIHNl
bnNlIGZvciB0aGUgbGF0dGVyLCBpdCBwcm9iYWJseSBkb2VzDQpub3QgbWFrZSBtdWNoIHNlbnNl
IGZvciB0aGUgZm9ybWVyLg0KDQpJbiBrZXJuZWwgdnMgdWRldiBydWxlcyBmb3Igc2V0dGluZyB0
aGUgb3B0aW1hbCBlbGV2YXRvciBmb3IgYQ0KcGFydGljdWxhciBkZXZpY2UgdHlwZSBzaG91bGQg
YWxzbyBiZSBjb25zaWRlcmVkLg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQotLSAN
CkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0YWwgUmVzZWFyY2gNCg==
