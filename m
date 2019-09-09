Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31557C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A1E206CD
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NxYZD357";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GIjzHF0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfIIO44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:56:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731919AbfIIO44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 10:56:56 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89EquAq029413;
        Mon, 9 Sep 2019 07:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eU4BCDMh00uX/EJ6fGbDIRqPXMIKBlDcsEgty9fdS9U=;
 b=NxYZD357rEE35tvxq5RpudXyChRQPAE1qz9b8zUp+xlnpo/FsGIAJUkY8XrqlPzrhZVd
 XWjG1afnBLt9aJcc9xvBpWMNSjFX9Is4RrRww1T/apWBxVQfDSdXLn86G0d4/vKc0Nql
 UYlYdyOVy4UCe6jIweGlKC5moDHDFBqhVrk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uvacgqee0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 09 Sep 2019 07:56:50 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 9 Sep 2019 07:56:47 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Sep 2019 07:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U73CLeTlJEjE1UFLF5ArYbAe7cmXLYLhpWIAcZZE/lAA8oyHjxitxZ1wmAT8K2ZRXhFIi3HMEWJwPkuPRp1YX1aZhfVu/EO2gQyoUJLB4Yqnpg41OVbSUyw1qfELYLHN6MJPi84VzRyukvUJGgA40DBooM5l6DM/SQzcAMKnKOHr0fIEomZ6ZYoK/BcE1FdCGdT3nC1FlI7x8xJszGfjrpov2waB5VMOuzSXgPmgG1ussl5zKzCAHAsSNN5DAPjdlR1F124ad4vnkacILnKaARMzib1pzr5K8kdVtlr280BWariB9VOWZH8hsYRsx1fiB1smHqpoWDtNFP761hppnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU4BCDMh00uX/EJ6fGbDIRqPXMIKBlDcsEgty9fdS9U=;
 b=F9Jf7WC3Sj9DT2ZqoFFzukMXvDvyie+z9uJyFioky41iF0qsluFwgZI2KSjMLItLPd5Y7WwNc+BCiiYP1+XerQelLXULuamr8v/GCTDbT/91YfAWUMDQzz3Gz7kw/D8a+3dvCnx8ynBaekzPkI7G1Ms9F6NKHLf9rt+aMU2Q/lJTXzabgQGdMLi2ubnkHiOLt4ZeUYNBDO6JTr336S6yU0q4lXhMVxUh67bkzB/p3/SoDnfpyQH1gQy1Zj+JsWsb4jue0s8aFmtcc2U26YGAQ8Nl+2IewzFDcu55tLVEAZkgHnIhfaY8SuPFbkZWE9rDRdHnB1HWAE+XODnGJ9W7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU4BCDMh00uX/EJ6fGbDIRqPXMIKBlDcsEgty9fdS9U=;
 b=GIjzHF0CD8vQrOi74LMGPTF+/c0KctslRY4Bv3qhC6/v0j9PLM0B2W1p6ZEMUQ3gwMe99EpSlP1BvKRiI++8a0h1wK40esdi81HI6etLJn/dxAsGae8isn/PtRzDmkaj5TkQXLxfT6ZkWi/8dX38OHNbRm6OUxxkplaXWaEx5yk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1616.namprd15.prod.outlook.com (10.175.142.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 14:56:46 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 14:56:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     NeilBrown <neilb@suse.de>
CC:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
Thread-Topic: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
Thread-Index: AQHVZtvuq+/vbU8ZR0SmUI7K9ys1D6cjb+CA
Date:   Mon, 9 Sep 2019 14:56:46 +0000
Message-ID: <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
 <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name>
In-Reply-To: <87pnkaardl.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::7d10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d21a4c9d-db68-4021-c295-08d73535ef84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1616;
x-ms-traffictypediagnostic: MWHPR15MB1616:
x-microsoft-antispam-prvs: <MWHPR15MB1616499E8D292691C76CF409B3B70@MWHPR15MB1616.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(39860400002)(376002)(366004)(51914003)(199004)(189003)(102836004)(81166006)(81156014)(6246003)(6486002)(256004)(7736002)(6512007)(229853002)(476003)(99286004)(6436002)(2906002)(2616005)(11346002)(446003)(6506007)(46003)(53546011)(36756003)(316002)(14454004)(71200400001)(71190400001)(54906003)(25786009)(6116002)(8676002)(305945005)(33656002)(86362001)(478600001)(4326008)(5660300002)(6916009)(186003)(53936002)(64756008)(76176011)(486006)(66446008)(66946007)(66476007)(66556008)(8936002)(76116006)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1616;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hEuaQIY3GTHM2PHeVByPNC84Ztwg3bRv1Y6wvuceGsQTpFe3pvXf/lVwPsmCE4u0bb4G5eiRtw+RrFvokGjYFC5bjrWJlBfiCNLOCbe6VHG+svg8DFnkwZQn1y8dshexNj9S5rRAypykaYTGl/GLv0TZmxbJAD8jUQlXZeEV4b1gOSCc0voq90/E+Nx4YR1Vf9+RxFnrP70u0R1VI3uYn6kCgNwKQn6HGenUmzQYACKVe+Y9Rc1ruGNmuVZLZTpzZ87cAKUqfdULJAHRCkt7zbREXT2UwjZ6kc4s11L4TbuHRkvBAdjIlGAIz5hVtUJEgw/KfUIZnTgoaCTbqSvhOTCG2MKm9UAMZWRUXTWOqUpy01obbl1/eivOjgGUJZdF5FunY8+zaT5d9/JdrjEkw4Y8V/wd8E36yLRqJYohTts=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E555AF0CCFE62242BFEC0DA687E43303@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d21a4c9d-db68-4021-c295-08d73535ef84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 14:56:46.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PeHSIezYIrMUP2haLsa7dwst3x58c2RpvACJYS8W3vfWAsh9TFGIFdJ7+VprhuPidhAMg8tA9Btt1GLEitGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_06:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090152
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Neil,

> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> If the drives in a RAID0 are not all the same size, the array is
> divided into zones.
> The first zone covers all drives, to the size of the smallest.
> The second zone covers all drives larger than the smallest, up to
> the size of the second smallest - etc.
>=20
> A change in Linux 3.14 unintentionally changed the layout for the
> second and subsequent zones.  All the correct data is still stored, but
> each chunk may be assigned to a different device than in pre-3.14 kernels=
.
> This can lead to data corruption.
>=20
> It is not possible to determine what layout to use - it depends which
> kernel the data was written by.
> So we add a module parameter to allow the old (0) or new (1) layout to be
> specified, and refused to assemble an affected array if that parameter is
> not set.
>=20
> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
> cc: stable@vger.kernel.org (3.14+)
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for the patches. They look great. However, I am having problem
apply them (not sure whether it is a problem on my side). Could you=20
please push it somewhere so I can use cherry-pick instead?

Thanks,
Song
