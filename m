Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A1C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BDC21B1A
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yvi3goS6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZQGnupH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbfBKPWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:22:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56190 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390688AbfBKPWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:22:23 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BFDgsv032141;
        Mon, 11 Feb 2019 07:22:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+twvrhFP9sgs3BBMNqtts1xpV815yTaAPpdExXijzx8=;
 b=Yvi3goS6kdggwquQKMYLwFixq/+HCLcspKEDRoX4iVlhcRU3+EpohjwN/S8ANCh/Dv7Y
 rPsgd1Jq4UBw6n9HgV0E8zdM+Y2naFC9cZQFOlP2dmxRf2m/HvernENV9ajChP7R/5aY
 DSbaCtH7kvG+S7WVXITpCPx1kPrAJYKxb/I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qk8908mx7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 07:22:20 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 07:22:17 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 07:22:14 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 11 Feb 2019 07:22:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+twvrhFP9sgs3BBMNqtts1xpV815yTaAPpdExXijzx8=;
 b=ZQGnupH08IjHH9N2fzQKiSJFCPIc8ak1l/hGprbqH2QWT42vgKoI7NeduoHXycoWlFsHUzTeL26EG1FfdMtA2SVv6nrdFfcRB/ghlCEJKevhKZ/xzmXua4DKuUAi8Mqjh5YIo/IhDgWTOUPhGhMlKhKRunwmssjrr9WZBEy1uS0=
Received: from MWHPR15MB1470.namprd15.prod.outlook.com (10.173.234.148) by
 MWHPR15MB1246.namprd15.prod.outlook.com (10.175.3.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.23; Mon, 11 Feb 2019 15:22:12 +0000
Received: from MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::986d:2d1e:2fef:32a9]) by MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::986d:2d1e:2fef:32a9%6]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 15:22:12 +0000
From:   Jens Axboe <axboe@fb.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 0/8] lightnvm updates for 5.1
Thread-Topic: [GIT PULL 0/8] lightnvm updates for 5.1
Thread-Index: AQHUwgTcepQLlylOakmZmyGRYyMZ16XatxAA
Date:   Mon, 11 Feb 2019 15:22:12 +0000
Message-ID: <00485a53-4fe9-dfa0-b333-eca65b5190e9@fb.com>
References: <20190211122509.19910-1-mb@lightnvm.io>
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To MWHPR15MB1470.namprd15.prod.outlook.com
 (2603:10b6:300:bd::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1246;20:g/pQPpeJSMoQDhLJHMetIig1Z8E9miySG9N4MXcd5fa76T4TxGW2Zv5MOjChUKK7gxjZPn0IzjYryjD1dhQGeWFTnlSvyHCcx1TLHpQGxhMsO6nLUY4VpC4NbYo1aH3AJlfOLsleOq390FhbkESxgBtF3sujhYalHgK44mIEOx0=
x-ms-office365-filtering-correlation-id: 0a39da77-1d55-46be-b315-08d69034b1e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1246;
x-ms-traffictypediagnostic: MWHPR15MB1246:
x-microsoft-antispam-prvs: <MWHPR15MB1246ADBACC052AE7742B9810C0640@MWHPR15MB1246.namprd15.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(68736007)(102836004)(186003)(31686004)(86362001)(71190400001)(71200400001)(53546011)(6486002)(14444005)(256004)(229853002)(26005)(6436002)(25786009)(217873002)(106356001)(6916009)(4326008)(36756003)(31696002)(6512007)(316002)(54906003)(66066001)(14454004)(446003)(6246003)(8936002)(81156014)(81166006)(99286004)(66574012)(2616005)(478600001)(105586002)(8676002)(97736004)(476003)(305945005)(7736002)(6116002)(386003)(6506007)(53936002)(3846002)(76176011)(52116002)(486006)(2906002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1246;H:MWHPR15MB1470.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8/v6CdQVzmwpGTlFpf+/95HbOb+dSEo7xKVPvhsLUckmTlcL5zo2+kuSXrTTstBErsohgSZ5oM/LAH9uN/g0HuHQgcy2S/MIodBnDsCJF/SpsxIA7+4BQwmWGby4vP77JDLQdIUwXQp9AZ9cBPOAkKgqnZ2kH5c/+EFzw2XF/Z2eprAo+reUA/MDsksuEQxveOkoDsUCVHIdivxGVxNLwywMjvGfSEx8UCE8vjYNPLH5HdUaEnuxEZtRU+G93NnXJd+nxqWEgh8ogNNPZRLn34O8QDESTy/mhrjk2q1/iXmm4i3Ns3K2HSG1IQ7CfJ8e5m04kWdvFmkKOFIbfeSDXA0aXTFMMn+lMRjNHUHS/2o2+z6T6ik/rF+KGQPuqTvbI2mJr3KGgQu1t9DtIw7wvV1QoG4SD9DDRoOYJLot8CA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <323CEE9118ADFF4E9439634F9B043B1C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a39da77-1d55-46be-b315-08d69034b1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 15:22:11.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xMS8xOSA1OjI1IEFNLCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOg0KPiBIaSBKZW5zLA0K
PiANCj4gV291bGQgeW91IHBsZWFzZSBwaWNrIHVwIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBmb3Ig
NS4xPw0KPiANCj4gSXQgaXMgYSBidW5jaCBvZiBtaXNjIHBhdGNoZXMgdGhpcyB0aW1lLiBBIGNv
dXBsZSBvZiBmaXhlcyBhbmQgY2xlYW51cHMuDQo+IA0KPiBBbmR5IFNoZXZjaGVua28gKDIpOg0K
PiAgIGxpZ2h0bnZtOiBVc2UgdTY0IGluc3RlYWQgb2YgX19sZTY0IGZvciBDUFUgdmlzaWJsZSBz
aWRlDQo+ICAgbGlnaHRudm06IHBibGs6IFN3aXRjaCB0byB1c2UgbmV3IGdlbmVyaWMgVVVJRCBB
UEkNCj4gDQo+IEhhbnMgSG9sbWJlcmcgKDMpOg0KPiAgIGxpZ2h0bnZtOiBwYmxrOiBzdG9wIHRh
a2luZyB0aGUgZnJlZSBsb2NrIGluIGluIHBibGtfbGluZXNfZnJlZQ0KPiAgIGxpZ2h0bnZtOiBw
YmxrOiB1c2UgdmZyZWUgdG8gZnJlZSBtZXRhZGF0YSBvbiBlcnJvciBwYXRoDQo+ICAgbGlnaHRu
dm06IHBibGs6IGV4dGVuZCBsaW5lIHdwIGJhbGFuY2UgY2hlY2sNCj4gDQo+IEhlaW5lciBMaXR6
ICgxKToNCj4gICBsaWdodG52bTogcGJsazogZml4IHJhY2UgY29uZGl0aW9uIG9uIEdDDQo+IA0K
PiBKYXZpZXIgR29uesOhbGV6ICgxKToNCj4gICBsaWdodG52bTogcGJsazogcHJldmVudCBzdGFs
bCBkdWUgdG8gd2IgdGhyZXNob2xkDQo+IA0KPiBNYXNhaGlybyBZYW1hZGEgKDEpOg0KPiAgIGxp
Z2h0bnZtOiBwYmxrOiBmaXggVFJBQ0VfSU5DTFVERV9QQVRIDQo+IA0KPiAgZHJpdmVycy9saWdo
dG52bS9wYmxrLWNvcmUuYyAgICAgfCAgOCArKy0tDQo+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGst
Z2MuYyAgICAgICB8IDIyICsrKysrKystLS0tDQo+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5p
dC5jICAgICB8ICA0ICstDQo+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGstbWFwLmMgICAgICB8ICAx
ICsNCj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay1yYi5jICAgICAgIHwgMjYgKysrKysrKysrKy0t
LQ0KPiAgZHJpdmVycy9saWdodG52bS9wYmxrLXJlY292ZXJ5LmMgfCA2NCArKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9saWdodG52bS9wYmxrLXJsLmMgICAgICAg
fCAgNSArLS0NCj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay10cmFjZS5oICAgIHwgIDIgKy0NCj4g
IGRyaXZlcnMvbGlnaHRudm0vcGJsay13cml0ZS5jICAgIHwgIDEgKw0KPiAgZHJpdmVycy9saWdo
dG52bS9wYmxrLmggICAgICAgICAgfCAxNyArKystLS0tLS0NCj4gIDEwIGZpbGVzIGNoYW5nZWQs
IDkzIGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KDQpBcHBsaWVkLCB0aGFua3MuDQoN
Ci0tIA0KSmVucyBBeGJvZQ0KDQo=
