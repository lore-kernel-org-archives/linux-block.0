Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C7C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4622084E
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OqOUnsMv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EilYVisi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFTQdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:33:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48306 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfFTQdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 12:33:15 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KGSUYc023085;
        Thu, 20 Jun 2019 09:33:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2YqvEsPjfq2DiMJg87hKOFwMIS6NjBookg8DwQM30wE=;
 b=OqOUnsMvhRD/6dFyN6xFdHX4v7KJLNgxEZHpdMYGFS54UBccqQfpkEz3H97J/kXPMvxn
 yq8RM8QXCF0HvUCUbzrt6rV0wyB9RisUc46fGLLCTOhbqYWkKREGxV1CmnQ4+oLXXF2p
 /nNm1zH0Z70OZKFjTD4CThqrunON3bL+TKk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t7wrvayx1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 09:33:11 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 09:33:09 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Jun 2019 09:33:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YqvEsPjfq2DiMJg87hKOFwMIS6NjBookg8DwQM30wE=;
 b=EilYVisiMC3rFquYI39CMP5HeqqczhvZPr1epNBxzkBOv0wsR6M6KoHGq+i5gu7R2bs8o+cJUuM2vh/GCKqL624jZPb9F31W4QVUWeDiXZyS3jM8aljBh32pVnBaxt/DnFrmd97RpBFPRD8mA0aUKF9mHqmw3rh5bTN6F8elq3M=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1589.namprd15.prod.outlook.com (10.172.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 16:33:08 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::39f5:87bb:21d:2031]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::39f5:87bb:21d:2031%10]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 16:33:08 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Matias Bjorling <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: remove bi_phys_segments and related cleanups
Thread-Topic: remove bi_phys_segments and related cleanups
Thread-Index: AQHVHFK1+6Rv8AUtcEqRRWqHE8ZYKqak0vyA
Date:   Thu, 20 Jun 2019 16:33:08 +0000
Message-ID: <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
References: <20190606102904.4024-1-hch@lst.de>
In-Reply-To: <20190606102904.4024-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0202.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::26) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.115.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a000e5c-6b68-47dd-5926-08d6f59cfa0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR15MB1589;
x-ms-traffictypediagnostic: CY4PR15MB1589:
x-microsoft-antispam-prvs: <CY4PR15MB15890DBCAE745485C2DC249BC0E40@CY4PR15MB1589.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(376002)(346002)(199004)(189003)(71190400001)(6436002)(5660300002)(66066001)(14454004)(81156014)(2616005)(386003)(558084003)(6486002)(86362001)(31696002)(52116002)(305945005)(316002)(478600001)(54906003)(71200400001)(76176011)(6116002)(6916009)(53546011)(68736007)(66556008)(66446008)(6246003)(4326008)(256004)(31686004)(25786009)(26005)(8936002)(6506007)(66476007)(186003)(64756008)(2906002)(66946007)(73956011)(8676002)(229853002)(102836004)(71446004)(3846002)(476003)(53936002)(446003)(6512007)(36756003)(7736002)(11346002)(99286004)(486006)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1589;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eJ1h7P4SbUUTutkDgAJZhcHkE/DEI6LOnaB7ik3Z0gfTANn9GLVcHK/IGI/K1x4jjyWdllGrHlDwENZEygV+ZuxgHtJwEbzRe3JMF/5nJvLlhZlnjc7qDHq/AGFTFTJqTIuu5h2h/fI3ksLScOJzSQ8bKWz9ZjaIjV0Gw7y0auJdeS1w5Zqjn2WZnA0P1ARUO7pzUnBWqIzI8rwPRbqnKieDqh7T9c0xjqk1zbPK8J6bk8xuwRkZgqUKUQWp5Z1Fh5eslhL7viVwk2E+3obBzi7wsr01Zn2zSsL6wv99haG7scOpqmJ2vAaIJkLwDghjFTZLaPodrYCVfrvsgJ5gAzMChXWbl4gGZF0gBJbV3pLWt6a1vm/N+xcHdrvhJgH8T+vcMmsJXVhY15MtxsweDCRc88j+GPAfHmZ2EldU0dw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5080A99A5A8AD04FBEDE3EBDA2175961@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a000e5c-6b68-47dd-5926-08d6f59cfa0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 16:33:08.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axboe@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1589
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=880 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200120
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi82LzE5IDQ6MjggQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBKZW5zLA0K
PiANCj4gdGhpcyBzZXJpZXMgcmVtb3ZlcyB0aGUgYmlfcGh5c19zZWdtZW50cyBtZW1iZXIgaW4g
c3RydWN0IGJpbw0KPiBhbmQgY2xlYW5zIHVwIHZhcmlvdXMgYXJlYXMgYXJvdW5kIGl0Lg0KDQpB
cHBsaWVkLCB0aGFua3MuDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
