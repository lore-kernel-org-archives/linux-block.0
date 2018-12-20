Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E8C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786A21720
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BqEcoubB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hf41rUaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeLTRI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:08:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60138 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731469AbeLTRI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 12:08:28 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKH83u0021549;
        Thu, 20 Dec 2018 09:08:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cMcXGK4vCoYqSAoydb+ELhPwhzqXjOIP/gleJ+dLsFE=;
 b=BqEcoubBDKEdEoDGxqORKBA7SQh8vezbEfhdEQoPHwUCRWTn2PtkIskXqtrhhVw5Cv9u
 716n26kVnZLxIGpXj3a+F8ko/cZrmtdM1XDJ4mEbtqBOWmRPcei7YwbtxmuwDvwBJTS8
 SdkROAqHllmafR0noGsmp7emhOm1urcrO/g= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pgc600s7b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 09:08:24 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 20 Dec 2018 09:08:22 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 20 Dec 2018 09:08:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMcXGK4vCoYqSAoydb+ELhPwhzqXjOIP/gleJ+dLsFE=;
 b=hf41rUaOQPbyd75HMHy8dhkZHydHHRUodnv8tuDkHMCI/SFSA2rzazzSOTg/Sq0MuBR/P0DPTM3b3tq3xRLti5K+tLv1idQQ/LEv0c1E6vNY/tFNOOwmawYrxvLWu4ra9WVFo9if9jQmzvo1xExhSfh5EFUmrTfnheojbe5HWMQ=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1287.namprd15.prod.outlook.com (10.172.181.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 17:08:17 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4084:e0a:d6ef:5222]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::4084:e0a:d6ef:5222%5]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 17:08:17 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkcg: remove unused __blkg_release_rcu()
Thread-Topic: [PATCH] blkcg: remove unused __blkg_release_rcu()
Thread-Index: AQHUl+xweO8FPKKRQESCpOKHQf5uSaWH3VYA
Date:   Thu, 20 Dec 2018 17:08:17 +0000
Message-ID: <f23e7319-307d-df88-4bad-0e9f71331677@fb.com>
References: <20181219224353.32763-1-dennis@kernel.org>
In-Reply-To: <20181219224353.32763-1-dennis@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1287;20:4+S8oSrCJBVhw1FQ7MNo8M2Oiyzhd2cCCapTZBuTPrZ3spTj8IevtiOAQwlSUXj0hJE4KGSdUN/vMr1PCtm8pVB2A5GXHzx6jy6J/K79SG5rY8vxlhJwenFddurMf66TF2ojE7cE1P2ZQWkN/3ga0omI6c5di+gnCrKShpXj5ss=
x-ms-office365-filtering-correlation-id: c54fda3a-2b26-486b-5c76-08d6669dbc47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1287;
x-ms-traffictypediagnostic: CY4PR15MB1287:
x-microsoft-antispam-prvs: <CY4PR15MB128796B12C3D7F8705B56AC9C0BF0@CY4PR15MB1287.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(5005026)(6040522)(2401047)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1287;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1287;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(81166006)(6116002)(52116002)(68736007)(4326008)(7736002)(6246003)(53546011)(8676002)(66066001)(106356001)(53936002)(305945005)(386003)(99286004)(102836004)(6486002)(186003)(54906003)(3846002)(8936002)(76176011)(81156014)(110136005)(6512007)(6506007)(26005)(36756003)(316002)(97736004)(2906002)(2616005)(6436002)(14454004)(11346002)(71190400001)(71200400001)(476003)(229853002)(478600001)(446003)(31696002)(5660300001)(256004)(25786009)(486006)(105586002)(31686004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1287;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2+8vwX16vSRDHzaPZcs8u/UHa6hI6reBeHkTNjTe+gQYzeFh+0oyy/DtB+GrLibfIi+HYIXfJp3mUK4oubqfK2Hd2yRGGkgtoNcsbIyJFxac12OfGB/pzBrkx1denUDCJKiqJWu3+xavaE2smnw9qrQ6/NnApU/W+1Rqc2GNm/bwkFv2yghu1+ustHiJu2x7OTQC2x7B8LotVbVCIMpC0m0FFscSM6ouWPb6kWozDCDa4gpH8623cTdmeuS+Luywp7GKVOXAbz17FpIw46n7crLPQquJBtNDEigrxvrPrb/MoPbW3egHmb0xTo8G7KeZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD3FCFA0EDEDF49BC60965D69A44107@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c54fda3a-2b26-486b-5c76-08d6669dbc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:08:17.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTIvMTkvMTggMzo0MyBQTSwgRGVubmlzIFpob3Ugd3JvdGU6DQo+IEFuIGVhcmxpZXIgY29t
bWl0IDdmY2YyYjAzM2I4NCAoImJsa2NnOiBjaGFuZ2UgYmxrZyByZWZlcmVuY2UgY291bnRpbmcN
Cj4gdG8gdXNlIHBlcmNwdV9yZWYiKSBtb3ZlZCBhcm91bmQgdGhlIHJlbGVhc2UgY2FsbCBmcm9t
IGJsa2dfcHV0KCkgdG8gYmUNCj4gYSBwYXJ0IG9mIHRoZSBwZXJjcHVfcmVmIGNsZWFudXAuIFJl
bW92ZSB0aGUgYWRkaXRpb25hbCB1bnVzZWQgY29kZQ0KPiB3aGljaCBzaG91bGQgaGF2ZSBiZWVu
IHJlbW92ZWQgZWFybGllci4NCg0KQXBwbGllZCBmb3IgNC4yMSwgdGhhbmtzLg0KDQotLSANCkpl
bnMgQXhib2UNCg0K
