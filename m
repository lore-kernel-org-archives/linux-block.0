Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE8C4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644F0218A6
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O82K2QI4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AwR/1g8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfC2SMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:12:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729809AbfC2SMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 14:12:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TI07J7022534;
        Fri, 29 Mar 2019 11:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LhR82jiilKwTNcM0XTXnJCDcSDWLVRdcJLiz5nwPA2w=;
 b=O82K2QI4Bwo4+E79pKPB3GwCveK+XBQyRP5rL8x1J07Yna/qVYUiiA9V5E4IyzGdc77E
 W4U0zvcZ806rL5d3Asp6RPs19U9KD5bU98j9D6Scm8kRgkRdFXwfIUam7GCcUO5U1KHv
 4gS0QeajqU+QKki2ReyVXisTIiqAmwV+mKM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhr14g3mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Mar 2019 11:12:02 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 29 Mar 2019 11:12:01 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 29 Mar 2019 11:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhR82jiilKwTNcM0XTXnJCDcSDWLVRdcJLiz5nwPA2w=;
 b=AwR/1g8FdnIGZAZ9Cqc5dLKnXfj7a9Am9uW3Ld7Yzb0cwD7fi6h5Jm2UPEB/+7yT1hthuPWK72V/fHU7JuGewiMcH4O0o4fkJAWVglIudYCbE47l4nJj4tH8zttGdFsuFzVaoinHTZ5faP2jU6odXBVpwhxr9dh12HqEzkPutgU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1389.namprd15.prod.outlook.com (10.173.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 18:12:00 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 18:11:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "xni@redhat.com" <xni@redhat.com>,
        "ncroxon@redhat.com" <ncroxon@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Jeffy <djeffery@redhat.com>
Subject: Re: [PATCH 1/3] Don't jump to compute_result state from check_result
 state
Thread-Topic: [PATCH 1/3] Don't jump to compute_result state from check_result
 state
Thread-Index: AQHU5ldflUHySDdYDkmg0QLY2VtZRKYi406AgAAFzwA=
Date:   Fri, 29 Mar 2019 18:11:59 +0000
Message-ID: <4E82467A-B5D3-45B7-A394-C23F9E35C3E1@fb.com>
References: <20190329174617.3670341-1-songliubraving@fb.com>
 <20190329174617.3670341-2-songliubraving@fb.com>
 <97dc86ee-b9d6-152e-ba5a-b485ac6a3fde@kernel.dk>
In-Reply-To: <97dc86ee-b9d6-152e-ba5a-b485ac6a3fde@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::2:f139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971ceef2-a3b5-47d1-e3ce-08d6b472099b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1389;
x-ms-traffictypediagnostic: MWHPR15MB1389:
x-microsoft-antispam-prvs: <MWHPR15MB13897EAF05BB0B70CF09CCFCB35A0@MWHPR15MB1389.namprd15.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(46003)(54906003)(2906002)(6246003)(4744005)(57306001)(316002)(256004)(446003)(478600001)(99286004)(53936002)(86362001)(7736002)(11346002)(14454004)(25786009)(6512007)(2616005)(186003)(82746002)(97736004)(102836004)(305945005)(476003)(6506007)(53546011)(4326008)(76176011)(81156014)(83716004)(5660300002)(105586002)(486006)(81166006)(106356001)(6486002)(6116002)(6916009)(71200400001)(71190400001)(36756003)(50226002)(229853002)(6436002)(68736007)(33656002)(8676002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1389;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Esp0i1BLVSjAP4TOIC68wxVpjUEyeTsJxom1hz1zrpjG3GCEAT+JrVeallwmEhV9w6UIWYe1NI7orfwgdpLsnZDz9nS05GvaaG4/br2q0i4vMmCkp/278BKeRk41YqrDP+WEKaMqZ7R4gigdb3NEUhsCPb58cedoYVvqyTavK5njKSnBVCR6RKd6gbAlZWuKGFIMA+zQHQ2Wl9msmevxIYUiHWS7ZexnBz3jOsLdgIv+g+AfyMusLrf3qGrgcaPB5ONQTe1JY6LFv+rTnFxDTuPObfd/nz9q9QSMpDaWw658Hr+4jjdvtOYeII9MAjr/mZrnICc9w6a8TKe23ILEw4xWd3pjnR0nt6tz51qz843LIEvbQIWRLSk9Mg8HnBhIFchGckoUaTA/4Usg2o/XVvQW6Vb1Ax+iLEsBMRbkYHk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB21C3E4747C56449E03380328D2BAAC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 971ceef2-a3b5-47d1-e3ce-08d6b472099b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 18:11:59.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Mar 29, 2019, at 10:51 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 3/29/19 11:46 AM, Song Liu wrote:
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index c033bfcb209e..4204a972ecf2 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -4223,26 +4223,15 @@ static void handle_parity_checks6(struct r5conf =
*conf, struct stripe_head *sh,
>> 	case check_state_check_result:
>> 		sh->check_state =3D check_state_idle;
>>=20
>> +		if (s->failed > 1)           =20
>> +		    break;
>=20
> Not sure what happened here, but there's a lot of whitespace after that
> if statement, and the break is using 4 spaces instead of a tab. I fixed
> both of these up, but please review the style of patches going forward.
>=20
> --=20
> Jens Axboe
>=20

Thanks Jens! I will be more careful in the future.=20

Song=
