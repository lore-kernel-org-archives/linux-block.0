Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EDFC282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 12:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AE221738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 12:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hKTi6SgD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gZtO5cEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1M42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:56:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44443 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfA1M41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 07:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548680188; x=1580216188;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=24NVha5wKjPjvQTFIlEmYDddl5/bFNfmBwuUu2OiHng=;
  b=hKTi6SgD+KG34vKU8W8O+IG2roMuMWvPjdU07DfLZxfX0lOUEi+W77Et
   p7cnQ2elgQmShpVayc1jWsTKEvCxxsU7k3OUKhchwcx8uHQx4ehmjRrod
   tjZWa/vKsysalN2imKb5oqQpQ6h4T8TQehC9fwlpLwXjU88PMWZS2sKAw
   CSFVh2EzNIVzSSWpOfMCjdKP8fvUt4r5/LzqG4EA5MRPQhSpDEOe6J6gl
   G063TK/07pDDIsx3x45yXMqj9uKjWqqNJZCIk4JkJk2bKkJMDKv1pTY38
   cvp+nnyNTtujWBJU9svCPpWTQTEKK47fS8Fc8tUAUPyFLceKY7S3ivJIx
   w==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="198046448"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 20:56:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24NVha5wKjPjvQTFIlEmYDddl5/bFNfmBwuUu2OiHng=;
 b=gZtO5cEKe0TjWH5omZlfPssQ6tnGjPRdenG96tlkxOQTqiCluEibjG2oFLVgUoA5fMlQLM4TIYgvZOI5cR6QxpE7fNAirZxwxKs01xvxBZJXCWdflZRCOwY0mnW7lsQYzwonwma3SEFAP1MUWk9PE8LHm8zR5ySGi0SmU3Fk0Tc=
Received: from CO2PR04MB2168.namprd04.prod.outlook.com (10.166.93.150) by
 CO2PR04MB2181.namprd04.prod.outlook.com (10.166.93.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 12:56:25 +0000
Received: from CO2PR04MB2168.namprd04.prod.outlook.com
 ([fe80::21ea:a5ae:4c3a:6ee7]) by CO2PR04MB2168.namprd04.prod.outlook.com
 ([fe80::21ea:a5ae:4c3a:6ee7%10]) with mapi id 15.20.1558.021; Mon, 28 Jan
 2019 12:56:25 +0000
From:   Matias Bjorling <Matias.Bjorling@wdc.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [LSF/MM TOPIC] Zoned Block Devices
Thread-Topic: [LSF/MM TOPIC] Zoned Block Devices
Thread-Index: AQHUtwjghszGVKdFVEqErvaL+C8iLA==
Date:   Mon, 28 Jan 2019 12:56:25 +0000
Message-ID: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To CO2PR04MB2168.namprd04.prod.outlook.com
 (2603:10b6:102:c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matias.Bjorling@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.128.118.3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR04MB2181;6:g3S+fHSovBA8RxB1x6YDAYUjR8pbuYg44GnFJXW8VwauzykA/SpMWPKddKWpbXEodVyn9hzZRdBRwfS8GFU5jM/jGhpCVuS4Ff3ecVreDWUX8MbyHgLV6y4q2Mk5MGwBsUbuTuhMlJvHxRInGE5V83WC3Uk6Nb40EYdyXRvEayUhDVQTncSXqt4p7bq0aNZffz5qIXB2WBWadRA/UfcHhzETVF0cwucdk4JJylQuATAYhVa3WX9GxoIVm+iiIcBFFcR32hoVFM3EGEpiblUZFpL7r36erx4m7sIrK51SDv4cLP2q4T3JK+9r2WuSTd2a13aDStidVNyTOZoDawK0Y4p2nF4aJrq0/VHT5ZN/9hftGfh6QevFMe5Ci0nxlenAU8Q3eqFlUWABzN7Gaixrv1jNTBmBjZ4FkCULA57O6qQ5lL7tdCRawL8YpzbI8vYmriK2mQwHlN3i8KTVbckUdw==;5:I8H40AygNj9V7Op7JJLTn+HoIjnLfJH5PvdtO6MRlaTRGAs6GHjQZZFaIMHl61Y6uTfSSym2Pt2fGPaJ6RXhZz0lUVuNVfzgwlsSv8rd3+nbh1+di1JKO0j3aVB4bxyemTcB532sC3Qn8QzB4vudF+MuLX8nxX2ihYCIIM286UOvuTzGNp9FlWRDwzx1pBIbeG61Ppm0XEg5hnqrOqwBMg==;7:liWXk0KGkZeuQhHP/H97Kkv+/EEF1rfPhCYgldkldHQOAtt4WbUkWfKKC2ehpbY4IoCP2uGC1zG1q2JNf+lDobi44SOIKkYbZBTrbA3OWmr80L9GFsZG/NAuCt09GHMOazvudUlCdP6mvH5ZYFJ4JA==
x-ms-office365-filtering-correlation-id: 4ea4f5ec-8061-4de4-d0f5-08d6852002b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CO2PR04MB2181;
x-ms-traffictypediagnostic: CO2PR04MB2181:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CO2PR04MB2181F20427524425C7072866F1960@CO2PR04MB2181.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(14444005)(2616005)(476003)(486006)(478600001)(6512007)(99286004)(97736004)(72206003)(26005)(6506007)(2501003)(256004)(52116002)(31686004)(386003)(186003)(44832011)(106356001)(102836004)(25786009)(105586002)(14454004)(110136005)(53936002)(316002)(68736007)(8936002)(2201001)(6486002)(36756003)(2906002)(8676002)(81156014)(6116002)(6636002)(31696002)(81166006)(66066001)(6436002)(3846002)(7736002)(305945005)(86362001)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2181;H:CO2PR04MB2168.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 087PN6D17WzBHOUkzOomq+eY7LvxQCFgiH7CExWjDKyv5pcUyTmX2pFTRlk60uZLsxIBc10rOKUpK8qYjTWAd3+2k0h88h5PBngj6zebGh+bx3+twPajS69yA+01bu7MbLgVQTNeTixFgBwAz27Ztvt60nbLd+k/+3+FD3zAaWjvInitGGmnbgPDC5jZZ0gWnWfEltBe5c9tMJCF0yORjIdSp84mkTrD90M4Hz2VsLUbQQIJ3HO8ZfmasFZ8LPNbSPDTol2YhGZLOBHSeS/vC2OBDfNC/h8Dsb+Og8/gg63hI7jfNKIuKMiNssQWsTzdV1JMFRASJ60eLs+Pj3he0ybtoqFfuWvCS90oiAan0UHuoEcvVVCZqOvPhYv7Jr8+ijX4F54ql+er1O9brkI2rG+FDD80X4f4J2XmaN+qHFE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BC0AE6159F0814E94F61723AE1A008F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea4f5ec-8061-4de4-d0f5-08d6852002b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 12:56:24.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2181
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGksDQoNCkRhbWllbiBhbmQgSSB3b3VsZCBsaWtlIHRvIHByb3Bvc2UgYSBjb3VwbGUgb2YgdG9w
aWNzIGNlbnRlcmluZyBhcm91bmQgDQp6b25lZCBibG9jayBkZXZpY2VzOg0KDQoxKSBab25lZCBi
bG9jayBkZXZpY2VzIHJlcXVpcmUgdGhhdCB3cml0ZXMgdG8gYSB6b25lIGFyZSBzZXF1ZW50aWFs
LiBJZiANCnRoZSB3cml0ZXMgYXJlIGRpc3BhdGNoZWQgdG8gdGhlIGRldmljZSBvdXQgb2Ygb3Jk
ZXIsIHRoZSBkcml2ZSByZWplY3RzIA0KdGhlIHdyaXRlIHdpdGggYSB3cml0ZSBmYWlsdXJlLg0K
DQpTbyBmYXIgaXQgaGFzIGJlZW4gdGhlIHJlc3BvbnNpYmlsaXR5IHRoZSBkZWFkbGluZSBJL08g
c2NoZWR1bGVyIHRvIA0Kc2VyaWFsaXplIHdyaXRlcyB0byB6b25lcyB0byBhdm9pZCBpbnRyYS16
b25lIHdyaXRlIGNvbW1hbmQgcmVvcmRlcmluZy4gDQpUaGlzIEkvTyBzY2hlZHVsZXIgYmFzZWQg
YXBwcm9hY2ggaGFzIHdvcmtlZCBzbyBmYXIgZm9yIEhERHMsIGJ1dCB3ZSBjYW4gDQpkbyBiZXR0
ZXIgZm9yIG11bHRpLXF1ZXVlIGRldmljZXMuIE5WTWUgaGFzIHN1cHBvcnQgZm9yIG11bHRpcGxl
IHF1ZXVlcywgDQphbmQgb25lIGNvdWxkIGRlZGljYXRlIGEgc2luZ2xlIHF1ZXVlIHRvIHdyaXRl
cyBhbG9uZS4gRnVydGhlcm1vcmUsIHRoZSANCnF1ZXVlIGlzIHByb2Nlc3NlZCBpbi1vcmRlciwg
ZW5hYmxpbmcgdGhlIGhvc3QgdG8gc2VyaWFsaXplIHdyaXRlcyBvbiANCnRoZSBxdWV1ZSwgaW5z
dGVhZCBvZiBpc3N1aW5nIHRoZW0gb25lIGJ5IG9uZS4gV2UgbGlrZSB0byBnYXRoZXIgDQpmZWVk
YmFjayBvbiB0aGlzIGFwcHJvYWNoIChuZXcgSENUWF9UWVBFX1dSSVRFKS4NCg0KMikgQWRvcHRp
b24gb2YgWm9uZSBBcHBlbmQgaW4gZmlsZS1zeXN0ZW1zIGFuZCB1c2VyLXNwYWNlIGFwcGxpY2F0
aW9ucy4NCg0KQSBab25lIEFwcGVuZCBjb21tYW5kLCB0b2dldGhlciB3aXRoIFpvbmVkIE5hbWVz
cGFjZXMsIGlzIGJlaW5nIGRlZmluZWQgDQppbiB0aGUgTlZNZSB3b3JrZ3JvdXAuIFRoZSBuZXcg
Y29tbWFuZCBhbGxvd3Mgb25lIHRvIGF1dG9tYXRpY2FsbHkgDQpkaXJlY3Qgd3JpdGVzIHRvIGEg
em9uZSB3cml0ZSBwb2ludGVyIHBvc2l0aW9uLCBzaW1pbGFybHkgdG8gd3JpdGluZyB0byANCmEg
ZmlsZSBvcGVuIHdpdGggT19BUFBFTkQuIFdpdGggdGhpcyB3cml0ZSBhcHBlbmQgY29tbWFuZCwg
dGhlIGRyaXZlIA0KcmV0dXJucyB3aGVyZSBkYXRhIHdhcyB3cml0dGVuIGluIHRoZSB6b25lLiBQ
cm92aWRpbmcgdHdvIGJlbmVmaXRzOg0KDQooQSkgSXQgbW92ZXMgdGhlIGZpbmUtZ3JhaW5lZCBs
b2dpY2FsIGJsb2NrIGFsbG9jYXRpb24gaW4gZmlsZS1zeXN0ZW1zIA0KdG8gdGhlIGRldmljZSBz
aWRlLiBBIGZpbGUtc3lzdGVtIGNvbnRpbnVlcyB0byBkbyBjb2Fyc2UtZ3JhaW5lZCBsb2dpY2Fs
IA0KYmxvY2sgYWxsb2NhdGlvbiwgYnV0IHRoZSBzcGVjaWZpYyBMQkFzIHdoZXJlIGRhdGEgaXMg
d3JpdHRlbiBhbmQgDQpyZXBvcnRlZCBmcm9tIHRoZSBkZXZpY2UuIFRodXMgaW1wcm92aW5nIGZp
bGUtc3lzdGVtIHBlcmZvcm1hbmNlLiBUaGUgDQpjdXJyZW50IHRhcmdldCBpcyBYRlMgYnV0IHdl
IHdvdWxkIGxpa2UgdG8gaGVhciB0aGUgZmVhc2liaWxpdHkgb2YgaXQgDQpiZWluZyB1c2VkIGlu
IG90aGVyIGZpbGUtc3lzdGVtcy4NCg0KKEIpIEl0IGxldHMgaG9zdCBpc3N1ZSBtdWx0aXBsZSBv
dXRzdGFuZGluZyB3cml0ZSBJL09zIHRvIGEgem9uZSwgDQp3aXRob3V0IGhhdmluZyB0byBtYWlu
dGFpbiBJL08gb3JkZXIuIFRodXMsIGltcHJvdmluZyB0aGUgcGVyZm9ybWFuY2Ugb2YgDQp0aGUg
ZHJpdmUsIGJ1dCBhbHNvIHJlZHVjaW5nIHRoZSBuZWVkIGZvciB6b25lIGxvY2tpbmcgb24gdGhl
IGhvc3Qgc2lkZS4NCg0KSXMgdGhlcmUgb3RoZXIgdXNlLWNhc2VzIGZvciB0aGlzLCBhbmQgd2ls
bCBhbiBpbnRlcmZhY2UgbGlrZSB0aGlzIGJlIA0KdmFsdWFibGUNCmluIHRoZSBrZXJuZWw/IElm
IHRoZSBpbnRlcmZhY2UgaXMgc3VjY2Vzc2Z1bCwgd2Ugd291bGQgZXhwZWN0IHRoZSANCmludGVy
ZmFjZSB0byBtb3ZlIHRvIEFUQS9TQ1NJIGZvciBzdGFuZGFyZGl6YXRpb24gYXMgd2VsbC4NCg0K
VGhhbmtzLCBNYXRpYXMNCg0K
