Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD940C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725E22339F
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rn4uusKi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JinNXgaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfHVCX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:23:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8806 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHVCX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 22:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566440637; x=1597976637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ULNlUBgGXg9toaiWVgZ3LH8qNQF8N5iVqkjpwxYL3Pk=;
  b=rn4uusKifxKnLtyO+bX8JnL3qhchyYpicZG6aLXmlgwJe/a8euCZPpTA
   sOrrT+JQw71ZBCns/Zh3aOAxQu0AQW/D/qP6JZqeRmXstT8AN+g0IPUKQ
   qeUb792qbJBisOL61qXQOQ4wgwEZpWkgf1tEorZ+TiVxa8efKVIpcZk6/
   dgwInY1KuHeYrstCt20G4L11ZNoVf3wQhWfDC/E11KYarDYZtlE29Xxwr
   HLwLnpsmnlYH4zyR8NSpYY7lOv/LXc6eCUGiGmroOLoURlXLnbWLG4XWK
   G5dDrGVawJo5pepPg7BmczXu+wD1t7GbehPt6Fh1PR1tRRorSOHznSoCm
   A==;
IronPort-SDR: C2oKueLj4Rvq9TYTof0sKi4qqTyylzIfx+ZL7VrPioYlVsEFMlMAv/aXtn4KxwPlW9ag2oI58o
 +PvCDl1DAUkmWhdUDC4CsI49mBNAvpJDtZKIDya/vKQ2ILJXXLKnzmNhX+1wK3wColohRBjatL
 7Lp7md8S/oP1mOAFJMoLQlw4bU1gG6CmMOQNeImynjX9Xige7luPE7Ivezyn5FHNNAXYY5ihU+
 EVT3WJAmekVpKQdjHq4CWn7v+hlCL+olYZdYCxgIDpf+uU2B8dUpBOQrZil1AqZEsbCtPj2w5z
 VUQ=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="116378412"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 10:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCuGA9CdgPplruQuBC5gpHVAslYAepTsq6bzLrsootTBx0alEkXwJjXhWhWFhb5Jmwp7erNq4610+lvCCR9R/22vIcdYiMbYD+ceR59aM1Rtf0Gnd27vRvKHqvVijBe9P4In70yLdEBSa7JZFUCyZUUwTJVLfYh4zTbHnJ1uU6GQF6UFBp4gEcvGwNVLPtWX9nCVM4fD6cL8Sqv3JdON4DMmeIvh/f3WbtJynAMESTJT7BOY1S4oU7xUpPET8pw0NjsapZ9sCOpvDRQcc+Rx7s1M6pysSetISxY5ZLPo20z3R7Jk+PXkagY4o2P2JweL03a/hxaJDF4gipqn4LoxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULNlUBgGXg9toaiWVgZ3LH8qNQF8N5iVqkjpwxYL3Pk=;
 b=jEcoUR4vUN17WA9+3gorxxKm68gCALdtaw3prSNJ2q2rLCFaTAc8Xn2Sz8VzhF0iPnJC2CSN4hXUb36701tGAZqMVsEIgB6R1+GnJkAaWJaqPV8oyUmpgaFToN0vfwvFxachlqR+C7j5BqTtjsuU8hCOu8mo0lke961scpmf7IhjGSv3tdB0qkwb4v2O2PZrVL3IBG1w8nxnl7BFPk8PRFUnh9z//Wl8wkAIchN3hYtwK12Fi/TLD4svyA3/50q6ErBWYmzCeoiQ4IBtUy8IWq7OrxzuRXIgNbANMFajnxnrJontRT6y/qe9cOZJtnPPL2P81aHjGY0v3u3gaI49Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULNlUBgGXg9toaiWVgZ3LH8qNQF8N5iVqkjpwxYL3Pk=;
 b=JinNXgaFSCXmd5jAw+9dCnlFMNkd9XFPEoR1HcO6yzkPekh+QK8D7Vc4d9tszpB3J64MuXEJF/yy/pNAlJyXqFptRxSZuB7eoFcdEIJ9itoCg+bR8BjraWB997pPYIldYDVgY8aDljzFESuQMRZ2PQ+iGlGWxBwgnL3D3gAJD3g=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6039.namprd04.prod.outlook.com (20.178.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 02:23:53 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 02:23:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 6/6] null_blk: create a helper for req completion
Thread-Topic: [PATCH V3 6/6] null_blk: create a helper for req completion
Thread-Index: AQHVV+ehSFr0LyKLP06atCOeXLpHTKcGWdQAgAAV+QCAAAGsgA==
Date:   Thu, 22 Aug 2019 02:23:53 +0000
Message-ID: <8433496d-1fd4-6356-0e73-d595765fa760@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
 <20190821061314.3262-7-chaitanya.kulkarni@wdc.com>
 <20190822005916.GG10938@lst.de>
 <44b9bd7b-94b9-c89a-69be-07707cd0bd39@wdc.com>
In-Reply-To: <44b9bd7b-94b9-c89a-69be-07707cd0bd39@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c24240-7bf1-4732-5182-08d726a7c711
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6039;
x-ms-traffictypediagnostic: BYAPR04MB6039:
x-microsoft-antispam-prvs: <BYAPR04MB603960CE0564AB0606A72EE486A50@BYAPR04MB6039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(256004)(26005)(71190400001)(31696002)(478600001)(86362001)(53936002)(99286004)(25786009)(11346002)(446003)(486006)(6436002)(6486002)(76176011)(6246003)(6916009)(66946007)(6506007)(66446008)(66556008)(66476007)(31686004)(14454004)(229853002)(305945005)(64756008)(6512007)(76116006)(66066001)(65806001)(65956001)(2906002)(14444005)(36756003)(3846002)(6116002)(53546011)(186003)(5660300002)(54906003)(102836004)(8676002)(7736002)(4326008)(476003)(316002)(81166006)(2616005)(8936002)(71200400001)(58126008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6039;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +C1+Ccbq3Pu4LtZd7yLcY4YGOQ8uvhdnWHEHDfDQZ1BQauc1PSmyYldbycO8HXyCj/9q6o3z+HieSq4Q04BUeStAc2lc7wHRVjWBHZNlezdFgQ8lfj7hW9hrKVfqOAMbvSgkwp3jk9x4TjtI6pNXFT8deYjBJp8gi+OKxVdRdmpCyfOMCpZRZAmT1ktLJ9IbbwKhVABsfj55fd29v223IcTxLeoGm0r1Oxx3oddYNKVrnFlSQTppS7eVyL3E5BlRcdR1vFJ/XRDy2zr/q6avJ6ff6sbzQWrn01LZV/2NYfmtZO/NogGjG4k3Sz+644/TBLTBpW2yMcBxPNbXOYBPxayYldB0Nne5jh6vIWIuiAjhidzjbuTzVqyp5I6TEmhUgMCPIDRvLLrw47HJmryI0xE1RyPaSnRFGOhTTyhURDU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6DCCEAD651CFE4197031EFB45A85941@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c24240-7bf1-4732-5182-08d726a7c711
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 02:23:53.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh0tqwXoMmUU4k8Y3SWPicxPEOrXIOfaHhLS6G9O0X2VPlVlT7MCOQR+KkXndx+aRJNp5+UMJ6UVVk7HKQvNbbUa0l/uX62aOxeg0YlGe98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UGxlYXNlIGlnbm9yZSwgSSdsbCBzZW5kIGEgbmV3IHZlcnNpb24uDQoNCk9uIDgvMjEvMTkgNzox
NyBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiA4LzIxLzE5IDU6NTkgUE0sIENo
cmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gT24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMTE6MTM6
MTRQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2ggY3Jl
YXRlcyBhIGhlbHBlciBmdW5jdGlvbiBmb3IgaGFuZGxpbmcgdGhlIHJlcXVlc3QNCj4+PiBjb21w
bGV0aW9uIGluIHRoZSBudWxsX2hhbmRsZV9jbWQoKS4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPg0KPj4+IC0tLQ0KPj4+ICAg
IGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfbWFpbi5jIHwgNDkgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
MjIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxs
X2Jsa19tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYw0KPj4+IGluZGV4IDUw
MWFmNzliZmZiMi4uZmUxMmVjNTliM2E2IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvYmxvY2sv
bnVsbF9ibGtfbWFpbi5jDQo+Pj4gKysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa19tYWluLmMN
Cj4+PiBAQCAtMTIwMiw2ICsxMjAyLDMyIEBAIHN0YXRpYyBpbmxpbmUgYmxrX3N0YXR1c190IG51
bGxfaGFuZGxlX3pvbmVkKHN0cnVjdCBudWxsYl9jbWQgKmNtZCwNCj4+PiAgICAJcmV0dXJuIHN0
czsNCj4+PiAgICB9DQo+Pj4gICAgDQo+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBudWxsYl9oYW5k
bGVfY21kX2NvbXBsZXRpb24oc3RydWN0IG51bGxiX2NtZCAqY21kKQ0KPj4gTWF5YmUgY2FsIHRo
aXMgbnVsbGJfY29tcGxldGVfY21kIGluc3RlYWQ/DQo+IE9rYXkuDQo+DQo+IEplbnMgZG8geW91
IHdhbnQgbWUgdG8gc2VuZCBuZXcgc2VyaWVzIHdpdGggYWJvdmUgZml4IG9yIGl0IGNhbiBiZSBk
b25lDQo+DQo+IGF0IHRoZSB0aW1lIG9mIGFwcGx5aW5nIHRoZSBwYXRjaCB0byBtaW5pbWl6ZSB0
aGUgZW1haWxzID8gZWl0aGVyIHdheQ0KPiBJJ20gZmluZS4NCj4NCj4+IE90aGVyd2lzZSBsb29r
cyBmaW5lOg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4NCg0K
