Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF13C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E83A22CF4
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ON8JRhCA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WXTxWcWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfHSV5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:57:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbfHSV5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:57:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7JLuZhi013569;
        Mon, 19 Aug 2019 14:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pgVev8umeU0h+Qmn+vGss9mRkxkuDIAmroDRG5TIaTU=;
 b=ON8JRhCA6xi4yDptR/U+5arCVuRd6z+1HeBjFkz4rG3gdyoYLz36NPoB8h1PTGrQXxxc
 QYM5BNeG7cjDx+tgJz6nab4FigUt5hVIPX96HRk38XtbEZUNsYQeSjkfcfl4sBJrLY8A
 j6zeFkouzQ8lM59zvFoYn/ixUo0G0Fuae9E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2ufypy98sx-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 14:57:13 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 19 Aug 2019 14:57:12 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 19 Aug 2019 14:57:12 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 14:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNnozbZcdbbeaGg4Bh3IER9EanEoRF03IwJFc7WS3ojaApA8zPBaxpQRhJ26y19fYMvYKSW6Jw78Er1jXxLFQAPIBBcze3rIMGwRdFbDm6VI2SzTGGPSICfXMW3qDIE/TezQHmOIbVQSLmKqR1LuxPQyYOia/pQn8+KjHQNa7FFuHzwr3iuQIw89gydG642qIziZfWrAaVHJAbJai8wQJK3cZN89mF26anJpm+eEQSeqBe6ZQcKMV6AL8WiNh2hGVT7CVdxJPmRCYZ5kA4W/SazPjTEvI6gn6WjbRyI7PlkZTlt7cK2kHicpBuFXl520S0Ut0+7ZXoTpDjLGgmvBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgVev8umeU0h+Qmn+vGss9mRkxkuDIAmroDRG5TIaTU=;
 b=bvbn8zyh97bahwChDFTKVSR6EF2yKAMlGFab6+Kl7816AMn4tQrNP/ql7youhpxUDAE8KmlG7Ry7PSz1QTDZfuMvsciBBPhBlVNPyEPwAGiXxdRRpc3kkd9/aV0tZYM9WIfO5YhRZSLSKKmsNL6OS7ICUsF+Y+lnqDkAr3Z3wlfK4/3imbGcOIZC88X+GEU3008JMsvuu2xNDEPe2PhvV21P45G/sqjMZ3FD0Ophw4xjeZElb8wd1hNLWiUBm8NmhnpcICs4N+X+8Q4r1St08HFQJ2filUJ6wnvsaaIAybFX/c+QApZcS9o94k4tqjF0Htsi1LSYBcMSnncwbcnzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgVev8umeU0h+Qmn+vGss9mRkxkuDIAmroDRG5TIaTU=;
 b=WXTxWcWMMnh+EtgcSBjGSDe7/wKNUpznP/EPoiqWXL2dRGi9F1FJ4iey/ZkmwenwQaWpAU/uj69Bpn8DBnknPYwvU0UOsk3RjHrXjX9nfvNlDUEax2w65tQhCbnoF/BvS/4j9Gsrap8RqYlV4WsB1DwXGtZnY62C7PlPD/Xprbo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1662.namprd15.prod.outlook.com (10.175.140.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 21:57:11 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 21:57:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
Thread-Topic: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
Thread-Index: AQHVVDhL8QBv9Z+6F0SUg0XP9Q0BPacCynMAgAAFiwCAAAdYgIAAA/yAgAAuVwA=
Date:   Mon, 19 Aug 2019 21:57:11 +0000
Message-ID: <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
 <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
 <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
In-Reply-To: <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:a981]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3f6859-aec7-4d2d-3df7-08d724f02ff4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1662;
x-ms-traffictypediagnostic: MWHPR15MB1662:
x-microsoft-antispam-prvs: <MWHPR15MB1662D95CD665B5BC2FBFD99CB3A80@MWHPR15MB1662.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(66946007)(54906003)(66476007)(66556008)(6486002)(316002)(4744005)(5660300002)(66446008)(6116002)(6436002)(57306001)(8676002)(53936002)(8936002)(64756008)(2906002)(86362001)(50226002)(11346002)(46003)(446003)(2616005)(476003)(6916009)(6246003)(76116006)(256004)(6512007)(102836004)(305945005)(4326008)(478600001)(6506007)(53546011)(14444005)(486006)(71200400001)(99286004)(71190400001)(229853002)(14454004)(25786009)(81156014)(81166006)(7736002)(76176011)(186003)(33656002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1662;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mtF1nF8M6yoJ5PWwWfTKU23lP2QRv5DCzEziICdqVANXnbL2jeiGC+2I7F8I1ZpMqlbH1dFUhLkfo3m87YyqkHbzfOdO/OudB+l+vo6xzlpoFtrcJFdZemoOiefJTr+C87fnfzZZNBK0eOIuX1Sb2Db5ZpbtUNx1bF6WV8yhjlomF+uL4ouxiWYDNk4R2ZbiaGEVfC+9jrpAC5XCwGic++trHWtRlC1F/EFdNGXE3K7GeBCe4Iba5LjY9f2rocwr3WZLivGDl9HLaHFJDoJ1Hoc9exP9PobFdIvtFN/LlYWyd3mc202VdyjMp4XIDPG7h0ZUdBC39Hk6DcRF/xYd6Jg6aPKpg/CmpsxmvkkeosWAAL5yjJtVbDcTbC3JK95qsV3HPejkZbgC7pb/5Ky9h7lAEvn7fqsEdqs/VjcXnqg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <701F7D3BDA043B4FB7ECA9A65B7F182C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3f6859-aec7-4d2d-3df7-08d724f02ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 21:57:11.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhobteCgl1tTdt90fvqandWWddafnFzTKNUqfXop3psP91tTSwzgmVpzlPy2U/XYTXmfqagBlPwbpuh5mAO2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1662
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190218
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 19, 2019, at 12:11 PM, Guilherme G. Piccoli <gpiccoli@canonical.co=
m> wrote:
>=20
> On 19/08/2019 15:57, Song Liu wrote:
>> [...]=20
>>=20
>> I was thinking, if we can set MD_BROKEN when the device fails, we can=20
>> just test MD_BROKEN in array_state_show() (instead of iterating through=
=20
>> all devices).=20
>>=20
>> Would this work?
>>=20
>> Thanks,
>> Song
>>=20
>=20
> This could work, but will require some refactors; it'll simplify the
> check for a healthy array (no need for is_missing_dev() function) but
> will complicate the criteria to clear MD_BROKEN and the detection of
> more members failing (we would stop the detection after the 1st failure
> if we only test MD_BROKEN).
>=20
> We will always need to test the GENHD_FL_UP in some code path, to be
> able to show users device recovered from a failure.
> Where do you suggest to test this flag?

How about we test this when we do clear_bit(Faulty..)? And maybe also in=20
add_new_disk()?

Thanks,
Song

