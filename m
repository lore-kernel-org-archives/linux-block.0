Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533D8C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1728F218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UA0kA9RH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bIlfz4Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfCUOPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:15:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbfCUOPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 10:15:24 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LECmss028841;
        Thu, 21 Mar 2019 07:15:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=y7xIGjAo71ZEiPY66qDuUIppJzk+tzlGIyeGN2MQLGU=;
 b=UA0kA9RHBHYpuRvS0F7Spp4lCiCBqZhjISRp9nBUIHynazBsbL9Smta2bUmAz7ESkLty
 SrUbetz591xRItQLpk/lDvbsduft9B8BwlFq7awK8KJKBF1jpwS7Z3/AP/upMmW0vs6a
 BC0C58yWnhQcVIf5+ADNY1lspBNNq3PKA58= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rbss2kkfx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Mar 2019 07:15:17 -0700
Received: from frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 21 Mar 2019 07:15:16 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx02.TheFacebook.com (2620:10d:c0a1:f82::26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 21 Mar 2019 07:15:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Mar 2019 07:15:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7xIGjAo71ZEiPY66qDuUIppJzk+tzlGIyeGN2MQLGU=;
 b=bIlfz4AdeTYBJYvKQh40wnGY928C9FG0woTHvURvuzCQKHN4QJARz9nABYi6WcTDLfYKzOU30oLhGyldYoMkpiWbcy/f9NKYFFdCWWlLGh9OWJ5q/9Hxkrx+w7AMSXZk7vmCpH96HuxsQAYSJ0N54rkofzkSqo//BP3tXcqrbYw=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1510.namprd15.prod.outlook.com (10.172.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 21 Mar 2019 14:15:14 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4119:34fe:7e7c:1919]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4119:34fe:7e7c:1919%11]) with mapi id 15.20.1709.017; Thu, 21 Mar
 2019 14:15:14 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Linux Block Layer Mailinglist" <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
Thread-Topic: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
Thread-Index: AQHU3+Hy9VBNEVaPrECP2cUtM1mUXaYWITmA
Date:   Thu, 21 Mar 2019 14:15:14 +0000
Message-ID: <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
In-Reply-To: <20190321123045.32396-2-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:3:13f::21) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51399c27-2078-49f2-c524-08d6ae07a2ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1510;
x-ms-traffictypediagnostic: CY4PR15MB1510:
x-microsoft-antispam-prvs: <CY4PR15MB1510DFD47A1A638C26A0C439C0420@CY4PR15MB1510.namprd15.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(6486002)(5660300002)(6436002)(14454004)(305945005)(7736002)(36756003)(316002)(54906003)(106356001)(3846002)(478600001)(99286004)(6116002)(6916009)(2906002)(97736004)(105586002)(229853002)(8676002)(68736007)(8936002)(256004)(14444005)(11346002)(446003)(4326008)(31686004)(66066001)(386003)(81156014)(102836004)(53546011)(6506007)(186003)(71190400001)(81166006)(71200400001)(6246003)(6512007)(86362001)(76176011)(31696002)(52116002)(486006)(53936002)(25786009)(26005)(2616005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1510;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KVD6KLCg2fErzfZtpRhmJFKneW5GC4z/18um5Qz+RxfdIZEsZL2eNIEP1iwKFv0ilHvDUGTJcNaG9jwFTkX68odl+D4k7/EibXzXCPh66w7+vGGu1yeLKYYuU5caBB/2RWS2BPbY5MpGG6L//z4lrc9Nf5MSbh4/K2IA8eF8zM/+qpd+eszsSQV/qK221qg3Dx6p0vGTiYv4JddxdH95CYMHlio+ocyrUtqNs84z1NXpiRHL2d03v0VWCCZAc4Rh6dVBM8b/pnZWWf4AFGV6JNl7MU1tU704eJOsPktf3eoZvPNK/kx6Kh4k85vyZzJjcyLXoZCZHiHMtWAvWBm4s5IWhZJChCirWGKXYsmoSmOOe0JNz1DTDrlzlYSLrCKFRTukw6gPHf0jOjRJM6X35p9Jq/cnlHzRQgCOqAFaAGQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9540E9D449F91948BC65F7C91BD5286B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51399c27-2078-49f2-c524-08d6ae07a2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 14:15:14.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8xOSA2OjMwIEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IFdpdGggdGhl
IGludHJvZHVjdGlvbiBvZiBCSU9fQUxMT0NFRCB3ZSd2ZSB1c2VkIHVwIGFsbCBhdmFpbGFibGUg
Yml0cyBpbg0KPiBiaW86OmJpX2ZsYWdzLg0KPiANCj4gTWFrZSBzdXJlIG5vLW9uZSBhZGRzIGEg
bmV3IG9uZSBhbmQgdGh1cyBvdmVycmlkZXMgdGhlIEJWRUNfUE9PTF9JRFgNCg0KVHdvIG1pbm9y
IHRoaW5nczoNCg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmlvLmMgYi9ibG9jay9iaW8uYw0KPiBp
bmRleCA0ZGIxMDA4MzA5ZWQuLjhjNjg5YWVkNDZhMCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmlv
LmMNCj4gKysrIGIvYmxvY2svYmlvLmMNCj4gQEAgLTIxMjYsMTIgKzIxMjYsMjAgQEAgc3RhdGlj
IHZvaWQgX19pbml0IGJpb3ZlY19pbml0X3NsYWJzKHZvaWQpDQo+ICAJfQ0KPiAgfQ0KPiAgDQo+
ICtzdGF0aWMgaW5saW5lIHZvaWQgYmlvX2ZsYWdfYnVpbGR0aW1lX2NoZWNrKHZvaWQpDQo+ICt7
DQo+ICsJQlVJTERfQlVHX09OKEJJT19GTEFHX0xBU1QgPiBCVkVDX1BPT0xfT0ZGU0VUKTsNCj4g
K30NCj4gKw0KPiAgc3RhdGljIGludCBfX2luaXQgaW5pdF9iaW8odm9pZCkNCj4gIHsNCj4gIAli
aW9fc2xhYl9tYXggPSAyOw0KPiAgCWJpb19zbGFiX25yID0gMDsNCj4gIAliaW9fc2xhYnMgPSBr
Y2FsbG9jKGJpb19zbGFiX21heCwgc2l6ZW9mKHN0cnVjdCBiaW9fc2xhYiksDQo+ICAJCQkgICAg
R0ZQX0tFUk5FTCk7DQo+ICsNCj4gKwliaW9fZmxhZ19idWlsZHRpbWVfY2hlY2soKTsNCj4gKw0K
DQpKdXN0IGFkZCB0aGUgQlVJTERfQlVHX09OKCkgaGVyZSwgZG9uJ3QgcHV0IGl0IGluIGEgZnVu
Y3Rpb24uDQoNCj4gK2VudW0gew0KPiArCUJJT19TRUdfVkFMSUQgPQkxLAkJLyogYmlfcGh5c19z
ZWdtZW50cyB2YWxpZCAqLw0KPiArCUJJT19DTE9ORUQgPSAyLAkJCS8qIGRvZXNuJ3Qgb3duIGRh
dGEgKi8NCj4gKwlCSU9fQk9VTkNFRCA9IDMsCQkvKiBiaW8gaXMgYSBib3VuY2UgYmlvICovDQo+
ICsJQklPX1VTRVJfTUFQUEVEID0gNCwJCS8qIGNvbnRhaW5zIHVzZXIgcGFnZXMgKi8NCj4gKwlC
SU9fTlVMTF9NQVBQRUQgPSA1LAkJLyogY29udGFpbnMgaW52YWxpZCB1c2VyIHBhZ2VzICovDQo+
ICsJQklPX1FVSUVUID0gNiwJCQkvKiBNYWtlIEJJTyBRdWlldCAqLw0KPiArCUJJT19DSEFJTiA9
IDcsCQkJLyogY2hhaW5lZCBiaW8sIC0+YmlfcmVtYWluaW5nIGluIGVmZmVjdCAqLw0KPiArCUJJ
T19SRUZGRUQgPSA4LAkJCS8qIGJpbyBoYXMgZWxldmF0ZWQgLT5iaV9jbnQgKi8NCj4gKwlCSU9f
VEhST1RUTEVEID0JOSwJCS8qIFRoaXMgYmlvIGhhcyBhbHJlYWR5IGJlZW4gc3ViamVjdGVkIHRv
DQo+ICsJCQkJCSAqIHRocm90dGxpbmcgcnVsZXMuIERvbid0IGRvIGl0IGFnYWluLiAqLw0KPiAr
CUJJT19UUkFDRV9DT01QTEVUSU9OID0gMTAsCS8qIGJpb19lbmRpbygpIHNob3VsZCB0cmFjZSB0
aGUgZmluYWwgY29tcGxldGlvbg0KPiArCQkJCQkgKiBvZiB0aGlzIGJpby4gKi8NCj4gKwlCSU9f
UVVFVUVfRU5URVJFRCA9IDExLAkJLyogY2FuIHVzZSBibGtfcXVldWVfZW50ZXJfbGl2ZSgpICov
DQo+ICsJQklPX1RSQUNLRUQgPSAxMiwJCS8qIHNldCBpZiBiaW8gZ29lcyB0aHJvdWdoIHRoZSBy
cV9xb3MgcGF0aCAqLw0KPiArCUJJT19GTEFHX0xBU1QNCj4gK307DQoNCkxldCdzIG9yZGVyIHRo
aXMgYWZ0ZXIgdGhlIEJJT19OT19QQUdFX1JFRiBwYXRjaCwgc28gd2UgY2FuIGF2b2lkDQpoYXZp
bmcgdG8gZXhwbGljaXRseSBpbml0aWFsaXplIHRoZSB2YWx1ZXMuDQoNCllvdSBhbHNvIGhhdmVu
J3Qgc29sdmVkIHRoZSBpc3N1ZSBvZiBub3cgaGF2aW5nIGFuIGV4dHJhIGJpdCwgMi8yIHVzZXMN
CnRoZSBsYXN0IGJpdCB3aGljaCB0aGUgb3RoZXIgcGF0Y2ggYWxyZWFkeSB0b29rLi4uDQoNCi0t
IA0KSmVucyBBeGJvZQ0KDQo=
