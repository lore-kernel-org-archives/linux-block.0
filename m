Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B0C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1632339F
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IJqfMuBR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ka2ySBfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHUQO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:14:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbfHUQO1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 12:14:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LGAFow025591;
        Wed, 21 Aug 2019 09:14:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sxQkFpEqNkD6VuPFB3BOEKOkoYKJvoocu/i9tUjWj1I=;
 b=IJqfMuBRYz0i7OLydSWEmcnY5uxGouZM5N2MxGDH587iAaLGfoulnvZ3/XTxE1gJiOgu
 vcPP9g+Kt+RWfmzuOHUwcbzXFRAoFLNAMvWPzcnSLFqBFuu562bNmFaTubk5VCCKQTKi
 7IeWAgWfHKIVnpSD62GYdUZ245/iAUoI4RA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uh31g9ksr-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Aug 2019 09:14:14 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 09:14:13 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 09:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/yJNb9dGLRq/Vn7jA/cEELL4EKAx5aGNu4sEWRbqS5cZSVfSG0xguUX5OwBlICCiD9YiGvEIcrs7hHHGy9BT3KNShx0gXnmuv4FyXsdQ4AeGLuM0ZqfDYoFCF+mcSemLM+0n0TQQ4pGjkwNLXIJcfA7xFCsu3jIuWIxZpTVHOyWLlNJw+gq+aWGZ8RVokiilJ8+GP2230v6GempXLDwbe5RmFHHWRbHLdBmuh50gHnoMX9fr0BYmtGpsAvL4aevZQFKfRS4/Qzw1Sp3+a6c6ljY6tpYMgihp3F2POPhZsnSliFe+qTIz0LQcBHw8aXFSm5FEg+rxE6KrDKJZpvlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxQkFpEqNkD6VuPFB3BOEKOkoYKJvoocu/i9tUjWj1I=;
 b=iByf2BgdT5Y1Fg/mqwXQdOIzUJQOSEcQyy43+3eOlw3S89Njyb5pkkx3ENTzM/M5EAET0h0/ekdHftLuFXs9jPlntKvTkrV2rzNyeqQlxLj665P/qHc8NIKdVttJJoXY6RjtfnXDwoIPzYpM8Xe0vbUpb0+aScjN5Ul9COzR5tIEE6cc8hqxwrgANI+lXKWNU/92kY+ZzkTZhHRBfdgkOh3+CofDCfLXpTxzgC7p6//kU9RBC5sz6JIj/392uls99CAfQIfzM4bdy0lxp0KGpyo7xmVB4MsLhnKlRlY1HvXTKa6UGME/A9PXm7Oo3LJSU8aSJlSnWwxXrH8zw1ACdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxQkFpEqNkD6VuPFB3BOEKOkoYKJvoocu/i9tUjWj1I=;
 b=ka2ySBfqX+dpwPIZTFIxN6UQ2MXQAk5VGGGL9WKYCNXDaWSmg/jJOfiil8bFnt7KiLvS2LytfT/VqE61XXl7g19tYMlOeOs+SkFpob9agN6byNGdL3Hk+nIIrq9OqWwmuUy6IeiFM1lUxWvDTYEKPNFeVDZAMa+oGthSPDq57/U=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1198.namprd15.prod.outlook.com (10.175.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 16:14:12 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 16:14:12 +0000
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
Thread-Index: AQHVVDhL8QBv9Z+6F0SUg0XP9Q0BPacCynMAgAAFiwCAAAdYgIAAA/yAgAAuVwCAAqPugIAAIOWA
Date:   Wed, 21 Aug 2019 16:14:11 +0000
Message-ID: <B7287054-70AC-47A8-BA5A-4D3D7C3F689F@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
 <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
 <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
 <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
 <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
In-Reply-To: <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::ede3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9979b89-6330-44f4-4cbc-08d726529aac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB1198786FE54B404676570B37B3AA0@MWHPR15MB1198.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(346002)(39860400002)(51914003)(199004)(189003)(486006)(33656002)(7736002)(6436002)(186003)(50226002)(86362001)(256004)(6486002)(14454004)(71200400001)(71190400001)(102836004)(6512007)(6916009)(305945005)(57306001)(54906003)(25786009)(4326008)(2906002)(53936002)(6246003)(36756003)(446003)(11346002)(478600001)(6116002)(8936002)(2616005)(476003)(46003)(66946007)(76176011)(64756008)(66446008)(66556008)(66476007)(99286004)(316002)(229853002)(81166006)(76116006)(8676002)(81156014)(53546011)(5660300002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xecIQ3IP2fwhpdBmPeyKm1X4J8YOKtNYqxKMevbCu7coIam3azi5WUvLadxJERhwjbT8tUNdkTqQtM5LlVPG1Y1Zh/4AtC0Q0bFMQ9UOM77IulEMR9xoBfzQygvv40zpLisMADQ5+CdDxnqfLN7HeX8cKKwrmKg0n+52Pn2WZRz82oPqpkxSTVOOMQ9eHEOPd1k1+rfgrXvoe5iEi/2G1KrDDpehQ/79LCkonQv9UPVN0VAyZlYcTVWbVnwSMkV6JXs6uE33UuZCR1JLjsVnY6mf17IwFXN+75r6mWnProyHj617W13nIYUiInF+HAZww+oLGjsgSHej2UORh/eDMlN9GhfDuJmk9POMEBHZBWQ8l45wg9EgGB70I7xTawlQBqthFfMa90HbiDF/2MYv3i4b9VWllDTpJps6Vn1uxPw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20DD6B80B861684FBAEA1CCA40A593CB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9979b89-6330-44f4-4cbc-08d726529aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:14:11.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQf/XsJ2/NUj2REurktt3ZhR3CX8NOz7jDrVNqPhpgns3UtZiU5VVJi1KBst8CJQLwNT1FAg3CWoZaPCHevEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210168
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 21, 2019, at 7:16 AM, Guilherme G. Piccoli <gpiccoli@canonical.com=
> wrote:
>=20
> On 19/08/2019 18:57, Song Liu wrote:
>> [...]
>> How about we test this when we do clear_bit(Faulty..)? And maybe also in=
=20
>> add_new_disk()?
>>=20
>> Thanks,
>> Song
>>=20
>=20
> Song, thanks for the suggestions. I've been working in the refactor, so
> far it's working fine. But I cannot re-add a member to raid0/linear
> without performing a full stop (with "mdadm --stop"), and in this case
> md_clean() will clear the flag. Restarting array this way works fine.
>=20
> If I try writing 'inactive' to array_state, I cannot reinsert the member
> to the array. That said, I don't think we need to worry in clearing
> MD_BROKEN for RAID0/LINEAR, and it makes things far easier.
> Are you ok with that? I'll submit V3 after our discussion.
>=20

What do you mean by "not clear MD_BROKEN"? Do you mean we need to restart
the array?=20

IOW, the following won't work:

  mdadm --fail /dev/md0 /dev/sdx
  mdadm --remove /dev/md0 /dev/sdx
  mdadm --add /dev/md0 /dev/sdx
 =20
And we need the following instead:

  mdadm --fail /dev/md0 /dev/sdx
  mdadm --remove /dev/md0 /dev/sdx
  mdadm --stop /dev/md0 /dev/sdx
  mdadm --add /dev/md0 /dev/sdx
  mdadm --run /dev/md0 /dev/sdx

Thanks,
Song=
