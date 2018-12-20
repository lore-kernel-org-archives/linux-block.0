Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ECCC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B475E21904
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeLTVc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:32:59 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33862 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728808AbeLTVc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:32:58 -0500
X-Greylist: delayed 19432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2018 16:32:57 EST
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKG1U9J011267;
        Thu, 20 Dec 2018 16:08:55 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2pgb5rsskd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 16:08:55 +0000
Received: from G4W9122.americas.hpqcorp.net (g4w9122.houston.hp.com [16.210.21.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id C55C564;
        Thu, 20 Dec 2018 16:08:53 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G4W9122.americas.hpqcorp.net (2002:10d2:1511::10d2:1511) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 20 Dec 2018 16:08:41 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 20 Dec 2018 16:08:41 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0675.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Thu, 20 Dec 2018 16:08:39 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c083:f0a1:861f:a953]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c083:f0a1:861f:a953%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 16:08:39 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Christoph Hellwig <hch@lst.de>,
        Boaz Harrosh <ooo@electrozaur.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: remove exofs, the T10 OSD code and block/scsi bidi support V3
Thread-Topic: remove exofs, the T10 OSD code and block/scsi bidi support V3
Thread-Index: AQHUecMBakDdesG2sUCKcpWbMfVl4qViYocAgCP8cYCAAL12gIAA68pA
Date:   Thu, 20 Dec 2018 16:08:39 +0000
Message-ID: <AT5PR8401MB1169FF6CBFDD789452E9CB17ABBF0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20181111133211.13926-1-hch@lst.de>
 <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
 <20181219144347.GB23410@lst.de>
 <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
In-Reply-To: <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [67.8.158.32]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0675;6:f67Q+1tWHRupuflooEO3hxrJvmBtMPE6HNcnt9LswGUnK1r6bEYFjg2ra2XxzuL9xw/oenCj/mah5nL8cURicyZIQqR/Hqtep6QgvKvReo/aexghwx7pDb67zX5iztL21J00x80XBoMOA0J1YUUWG2b9j1T9Yb935t2Dyfc1j4kZpzTXzLV1wPxc4wxJH76Hdj7CKWk62w/mF/PAcWK/ok777GhMWa9g9p/HJvOR9ZmpHnC3wdbl6K4uV1rG1sHYT6WXsF1dE2rEJkc196Nfgv+qMalqWIESlqOdzX8zD9lOKBNbcLhaAyQ9J7zjB1hFuu9aFDF/fRZc4t2v2E5lUO0oX+tPjaGckQUMfEW0eEQovW2dA9ocBUrkMwyu3cJ6pazLGxl+hSuJJX845Z75knWLFEPH0ymOzxedw+fmALthFSrnwDaQkz/UGki/PNbg20u1AfzS9Q5wyFfl7jWJoA==;5:1kPImzY1RHT04x5vtGf1opL/houiZMC9l+ThpPELNQzaJClOazeGZn5+PO7mRzy9Yz+DjSlMNVCR4r/cCXFuUTZ55AB3s7J8DdKxAbYzl6OMrhZLQMKBsWQEQL0ypeEVFgXAad78zy66a7DsqyCeTiijtf0OUIPLLk0ETeq3XqE=;7:4FyxK1gKnJ+582bP+41zMKqILt9/IOpOWuELiR6LTMVbntKuKECTX6S7VRlXctBwdVpwJPSHXyew1dmlr2MO3auGZ0AS4kR8upYRzdYIZgsXE7BZuUqKZbV0LtUCEaUTpSudYxKYZ3BxNXTHadCLVw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f695c884-237e-470f-4c78-08d666956795
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0675;
x-ms-traffictypediagnostic: AT5PR8401MB0675:
x-microsoft-antispam-prvs: <AT5PR8401MB0675C0BDD8F7A2D842857D90ABBF0@AT5PR8401MB0675.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0675;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0675;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(13464003)(7416002)(71200400001)(86362001)(14454004)(229853002)(74316002)(71190400001)(478600001)(33656002)(66066001)(2906002)(97736004)(106356001)(105586002)(5660300001)(305945005)(7736002)(8676002)(81156014)(81166006)(8936002)(53936002)(99286004)(316002)(76176011)(9686003)(11346002)(446003)(7696005)(4326008)(25786009)(54906003)(6246003)(256004)(14444005)(3846002)(53546011)(6116002)(26005)(93886005)(6506007)(6436002)(102836004)(476003)(68736007)(186003)(486006)(55016002)(2501003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0675;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8oynKcM5I9mDQnrpQDa8+Y3iGZki5Bet8GusDgso8xwpg/lrEWsREOvv7v+YxYCK12IxYl5aYhrivELaRjs0D3T9kMG0ccJA3nxhsELI7q5h3caR/UR5tCXbJQu7abByS4VknZUJyFQJZ/YWBdujG9WblwP229/OvZUwHU16lxMAkVLI2Ff1hwyrL4DmSjtFksocTmMH45vG14aKHAMGyiXBCfMeUMCsW+wYqcnLAZwkGKYPs83urRdQIRLM0JAqReIzrOTX5IkedsqM10rzCqverdafWFiE6op0a2gI21lnUQmD+6QfnxLtvmlqjOQx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f695c884-237e-470f-4c78-08d666956795
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 16:08:39.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0675
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200130
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBEb3VnbGFzIEdpbGJlcnQNCj4gU2VudDogV2VkbmVzZGF5LCBEZWNl
bWJlciAxOSwgMjAxOCA5OjAyIFBNDQo+IFN1YmplY3Q6IFJlOiByZW1vdmUgZXhvZnMsIHRoZSBU
MTAgT1NEIGNvZGUgYW5kIGJsb2NrL3Njc2kgYmlkaSBzdXBwb3J0IFYzDQo+IA0KLi4uIA0KPiBX
aGlsZSBvbiB0aGUgc3ViamVjdCBvZiBiaWRpLCB0aGUgb3JkZXIgb2YgdHJhbnNmZXJzOiBpcyB0
aGUgZGF0YS1vdXQNCj4gKHRvIHRoZSB0YXJnZXQpIGFsd2F5cyBiZWZvcmUgdGhlIGRhdGEtaW4g
b3IgaXMgaXQgdGhlIHRhcmdldCBkZXZpY2UNCj4gdGhhdCBkZWNpZGVzIChkZXBlbmRpbmcgb24g
dGhlIHNlbWFudGljcyBvZiB0aGUgY29tbWFuZCkgd2hvIGlzIGZpcnN0Pw0KDQpJbiBTQ1NJLCB0
aGF0IHdhcyBjb21tYW5kLXNwZWNpZmljLiBTb21lIG5lY2Vzc2l0YXRlZCBpbnRlcm1peGluZyB0
aGUNCnRyYW5zZmVycywgd2hpbGUgb3RoZXJzIGRpZCBhbGwgb25lIGRpcmVjdGlvbiBiZWZvcmUg
YWxsIHRoZSBvdGhlcg0KZGlyZWN0aW9uLg0KDQotLS0NClJvYmVydCBFbGxpb3R0LCBIUEUgUGVy
c2lzdGVudCBNZW1vcnkNCg0KDQoNCg0K
