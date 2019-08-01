Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6377C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B93216C8
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ChPKrwqh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OgZ0Nt7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfHAWoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:44:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19574 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389970AbfHAWn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MgIWW017072;
        Thu, 1 Aug 2019 15:43:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ariXzKAInQezmuKRSY7MjObHIwxaIMDHy28ouUSmDLU=;
 b=ChPKrwqhoumWuQbgv9J4BUSlafzYdoFHFP8ArAZNTyuO4ItAsRF56444eDkazIftMndt
 t8sYY2fUxs2rh72n1LBVmdiQIU+KOXz1jmxM1gljlrVdBQH9tNz3xdfS5lUM2/rShrP7
 +2b8JXlMnCMTSuhAyYzdE7NVZyYBFMCn76g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u438rhfb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Aug 2019 15:43:51 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Aug 2019 15:43:49 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 1 Aug 2019 15:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWjFmCjWpO2lDglDiGYP0TmBKEqncFNqqZXFa2BljuMVUEQ0eTfA6HUzkh5DE0PeZDW1umsiQ3lz66TG8WAYHyHBlvPbrSqiT+j/DR+kvOPj0yQqM72qNe/z00iwxqnj+Ro/9p1Y1+e93ZWm9xkoznUPHvt451r/RD5WBfBaqttmLQJ02OsPeZqKDZ3qpGcqfKzs3u8BNgstiYy92PCoIvFkBqM71JDLOSJL/QG6WUxIsZjwzJMArGQFW4OTMruTkH2ze/sgMOf8C+OIwOEqAGfzr5zncMXC/X/r63suvBgKrW40kWbOzCJYVgbbuPuCLYkgQAM0DslJLPjPsUOm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ariXzKAInQezmuKRSY7MjObHIwxaIMDHy28ouUSmDLU=;
 b=TVW9LeICBWljGvaHabgX7FmdO6Jkf/EA1Pb2EQOPeH2NSPzZirQZt2lSeQOxLTyeOsCxzWk/XHBAWiARh1tUn+j2AMZAgQnFpmD7ZsEF1ByffAJ2zWwo9WvVpU80uVHe+N4JJdvjET2bUgnt8rtAqqeBhdWnZB8ZHvkcXQLhn6+KtwQNS7/d1EJb6flCjHqso2DctneXHcUmg3xqNFRAj+gOoPRMuwt1GAmwrsVXz55MtE/t7H3nllB5eWzNv5gkgfem7xleUKgplIQ8X1a9iOqJsIA1b9ForPiwA+uHHdeHzf9euTs4q+d+Z1jLpc9eM9EiNX4ysz/mto+Qk6JG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ariXzKAInQezmuKRSY7MjObHIwxaIMDHy28ouUSmDLU=;
 b=OgZ0Nt7glzUtmu5hJtkfYio7B4rfKYjUxIMFig7IC1Y6Ipi96Mehlg/V/oJkPuNBsgREJs9UNa6GnKK2nOUJ1t5kk0JvStzs64R/pAhwOq3D+CUOxC55z89I7jkY3LYJXH8hcZ2Cu6JQel8qjqMABNfx+iWmRcI3ypAFhtclTTc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1470.namprd15.prod.outlook.com (10.173.234.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 22:43:48 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 22:43:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
CC:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Neil F Brown <nfbrown@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
Thread-Topic: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
Thread-Index: AQHVRkSmX2LKohDHxE6edwD68oSJQqbiSV6AgADPP4CAAg5UgIAAALGAgAGbKgCAACXTgA==
Date:   Thu, 1 Aug 2019 22:43:48 +0000
Message-ID: <72C166DF-3984-4330-8C60-BBDA07358771@fb.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name>
 <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
 <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
 <CAPhsuW5zB=Kik4rq9YA-xBer7Z-h-23QV4WSCWe-jvhFgGc0Cw@mail.gmail.com>
 <9674ca8f-4325-3023-8a1d-39782103f55d@canonical.com>
In-Reply-To: <9674ca8f-4325-3023-8a1d-39782103f55d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:33d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8925af17-cb67-48da-ebf9-08d716d1b7d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1470;
x-ms-traffictypediagnostic: MWHPR15MB1470:
x-microsoft-antispam-prvs: <MWHPR15MB1470586DC779D5DCC7B359C1B3DE0@MWHPR15MB1470.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(51914003)(189003)(8936002)(46003)(33656002)(316002)(81156014)(50226002)(229853002)(76176011)(8676002)(71200400001)(7736002)(54906003)(71190400001)(14454004)(25786009)(5660300002)(81166006)(99286004)(478600001)(2906002)(256004)(6116002)(86362001)(6512007)(14444005)(6436002)(36756003)(6916009)(68736007)(102836004)(446003)(305945005)(4326008)(53936002)(11346002)(66946007)(64756008)(57306001)(2616005)(66446008)(66476007)(66556008)(186003)(53546011)(476003)(6486002)(76116006)(6246003)(486006)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1470;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KEdxwBjDBL04+MJv/m/8huFynbj0Hc2huJtSZtGZUNj5Oj4AbpdxxuIlqOTEDgwLjIFzr7rtdLXgkhD3JuzDBqMf6TQnvkJev0o80tpHOEEnTfKkyhsSbMTmBffIgSjXf37YSQ3XYU8Sdt2CpjP+9F4Zak/H55QllvPMlzDNNQ4/ShlRaZpUM/mzv0ZNi5a5AaZU1C8GwuNU+xU1bghOvjBL1WYnzCyFs0BfEt6KBoNmn6dX6uamVWic56HvZK5iUyeZbPqalV4VM7Km23J0lvVjtjOqxi7Vz9y6cloNM3zB1tSnH82aDJEqrRXxc2O53+ujvglIWDbkv3wF5OC+SkeTewIwyPi8A/zXInWky7ChOKzqtV783PZxTA3Jl/YJmHB7njLCogAgIwk+d7K9QNGdRTE8epjadL1mIgOh9GI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DB28A5D09FE504C800002670C1FD648@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8925af17-cb67-48da-ebf9-08d716d1b7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 22:43:48.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1470
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010239
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 1, 2019, at 1:28 PM, Guilherme G. Piccoli <gpiccoli@canonical.com>=
 wrote:
>=20
>=20
>=20
> On 31/07/2019 16:56, Song Liu wrote:
>> On Wed, Jul 31, 2019 at 12:54 PM Song Liu <liu.song.a23@gmail.com> wrote=
:
>>>=20
>>> On Tue, Jul 30, 2019 at 5:31 AM Guilherme G. Piccoli
>>> <gpiccoli@canonical.com> wrote:
>>>>=20
>>>> On 29/07/2019 21:08, NeilBrown wrote:
>>>>> [...]
>>>>>> +    if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
>>>>>> +            bio_io_error(bio);
>>>>>> +            return BLK_QC_T_NONE;
>>>>>> +    }
>>>>>=20
>>>>> I think this should only fail WRITE requests, not READ requests.
>>>>>=20
>>>>> Otherwise the patch is probably reasonable.
>>>>>=20
>>>>> NeilBrown
>>>>=20
>>>> Thanks for the feedback Neil! I thought about it; it seemed to me bett=
er
>>>> to deny/fail the reads instead of returning "wrong" reads, since a fil=
e
>>>> read in a raid0 will be incomplete if one member is missing.
>>>> But it's fine for me to change that in the next iteration of this patc=
h.
>>>=20
>>> For reads at block/page level, we will either get EIO or valid data, ri=
ght?
>>>=20
>>> If that's not the case, we should fail all writes.
>>=20
>> Oops, I meant all _reads_.
>=20
> Hi Song, thanks for the feedback! After changing the patch and testing a
> bit, it behaves exactly as you said, we got either valid data read from
> the healthy devices or -EIO for the data tentatively read from the
> failed/missing array members.

Thanks for testing this out.=20

>=20
> So, I'll resubmit with that change. Also, I've noticed clearing the
> BROKEN flag seem unnecessary, if user stops the array in order to fix
> the missing member, it'll require a re-assembly and the array is gonna
> work again.
>=20
> Do you / Neil considers this fix relevant to md/linear too? If so, I can
> also include that in the V2.

Yes, please also include fix for md/linear.=20

Song=
