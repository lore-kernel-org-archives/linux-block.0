Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3A3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3502260F50
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhIUNkR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:40:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhIUNkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:40:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LDDBYt017239;
        Tue, 21 Sep 2021 13:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=axQstBt5t4739OeCzjvynTyC42sIv6XxgB6ZTSemTJY=;
 b=hiKIk8s0qTWgUpmA2Iy7YnGDwEcPBlsS/ElrFu7hLz+XSrhc/IlbYl6VUI67blSG91qc
 GhGh9+fW1HtmnxoimNlYX3vKm3KF6Q0CtCwch6F0r2k0S4Pe/Q90a0aBZ72jYEYRyqYt
 FExXLnbkeoZRkdh+KxJ3ed00kq3xUtr2P90LurxhhD86gg2gi/uxTZvYodbACnIqE2rj
 5dZySgUUVEi1yWJj0bdhKyI5gj1ppkb+O2nx8RTe8Mujnq4eFkUwet1rgDthobLNJJSj
 voOd29BX3BOyoGNLbzFh4kX6Z5x2oUMaJVjgIqNjXKKxhlb/1XOJK+SZ6DZoQ8MTN5uL PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b79adhw4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:38:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDKx7e125120;
        Tue, 21 Sep 2021 13:38:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 3b565e2y63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWl0funtvJaBgpbb/SLZHPiFhFCrjVvdE6MVRhw7eSfSV65m9QunklUmsFgnfbVgrOm45QIDEvbK84O8pAmc8i+Hbqt8cBHczg1NaVx03OqnLHyjZOgzQBOJtE0NFT+SzyYuJvQScvezjTe+E9bxvOYXwFYN5loDMrXJM+Sv4zWR/hif3RW6PMA0l90X00pu35v8aTaZjCSccyUlOTdVaVCAfVLzs6f0GhJ9eHtKgVvJR+572G8ijNDD+bRRv9da0nEEyQqTM5w8Frx229sZc+cXcrTh98BA27cC7jrMJkVX4qoLKga3VhZYq6FoD4XgCIkxbxSJH3U1SFLtnjslTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=axQstBt5t4739OeCzjvynTyC42sIv6XxgB6ZTSemTJY=;
 b=Qx21YX6iStCuCGHrOSzQWzijbvmlaUovF0k9vZylOBJlN1rVcnDlxQCkVqcRLmrVhAsdW37QMUeuPI/NjdT4kLieWeum4XrsXgDqpXwMP8QnZ+leWCrJ2fTKaTlsp3IAI9AQJ+OU+MbyU52byYYI9tJyLyP9RaXos+EoqeJVgPWw+Vog0ys2XhTBAM1lBmVwMtOzydsPzFezm1JysD6nh7M4ZsqudpiKhkJ5jOXSjcNiFoe6nFo/aok5xc1IYD4LNZQNc8exXWBo7xxspPKTRojKqA+8J1fkc6qSS9Zn68ddly/q1iekBZCT+qs8nR69QM1P2wYyZuylureqeyQD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axQstBt5t4739OeCzjvynTyC42sIv6XxgB6ZTSemTJY=;
 b=OkIuoFqB1QBgh21Jvm5+Yz7U2fmZnoAGtZB0+JBSUYRciqjJ8XDX8LCgsiVN+Gy+fxa3nMgcZVY+YT546no7ighJ6HfvdAeP1dFscDOuSHQ35GxWufgUCJt/dCMbVWIpMgSol8wqSYxMdNmn/EEyZTTm/kWW2xT22cSw6GTY/QA=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3453.namprd10.prod.outlook.com (2603:10b6:805:db::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 13:38:42 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:38:42 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 8/8] loop: allow user to set the queue depth
Thread-Topic: [PATCH 8/8] loop: allow user to set the queue depth
Thread-Index: AQHXrspGg7Ii2Rl0kUq9onSVI9VUo6uufmIA
Date:   Tue, 21 Sep 2021 13:38:41 +0000
Message-ID: <8870CDDF-ABED-4417-B095-0F447B3B8D0C@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-9-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-9-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669c89c0-856f-405a-f652-08d97d05206a
x-ms-traffictypediagnostic: SN6PR10MB3453:
x-microsoft-antispam-prvs: <SN6PR10MB34537AFF4FAD518DAEECFE70E6A19@SN6PR10MB3453.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noZ1nSDPJTJ7NIFteGS28NsipVlAZCU2Y8gKrtPKJ5Si4R/Hkn/7D27Rnm2LtkV4HsJmsbNdDWE6Q80n15WZxVJmrhjlAoejYQ5rGVJ6wh7lz2AkwTNoa5GO2t4uyFGAMVl2Y/3J9RlGHIFwIFEXKadYaYEdWQolGHg6Uxm68wRndUpCo+LdByR/zy8tVkEuMDlPaPNxGS574EVnRsRMXBu8JerBB7FPZ4HKD4xpzmMVAWBuZCmIxUq6wGkT+sMALMKr5y8nn/lwnD4/nEHOB8qQpnjoCedqjaxXmbbxTdH9U2RsHijfK8aW8tYp5B9Kjpix4NeaS3OQIXbZqlbb3bV3N9swQ/GBkvt+Uu0y6/c32Y2YIBU0+tIu9vgOQ5AG2GCNZUq+so3EzjDp2B6J41VJNkDRPYcwLlQT0+O9iqPazghOKknsYsbzu4L2HWjyptLDfE5WVO5ru7zQ/8SkM9iq1e28gT3AtwaWsQ4Mh8gCaIaaAoUy8nfdDV5oC3/RwPOm6gG6W7ZSzJTz4y3M0OjRG0pd6X48gS2J0/kjyYmoWq+tEReiZnAJ8CbcqieKZfYTw+yuODjRaVmcrBz2PmLmGXBsD8jzqGzf7N+i/jrBj8BYUaXFKaFzl01qMcbWTvkcQxW1/sgAkze5dupDDYvX+t88VXoPSPIg81OXHfCUbwrEnJXAB6EBRwXn0OgdblOiOH+iOqjRBXhitEKLaJFez7zkljQ7Mf6ZeT7JjVnw/GPAb5Gql4LVSfrEHjL0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(38100700002)(122000001)(76116006)(4326008)(71200400001)(44832011)(66476007)(2906002)(6486002)(2616005)(316002)(66556008)(8676002)(66946007)(26005)(33656002)(186003)(6506007)(36756003)(53546011)(54906003)(5660300002)(38070700005)(66446008)(83380400001)(508600001)(6512007)(8936002)(86362001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?us3MkeAT+a35mA786MzRDdwlZy9DL6JmItjjptfw4ZHGozhiJCFz6D5BjgGI?=
 =?us-ascii?Q?DkjLFLSNSQr7rgZStohBjPelWVKjpYJRuLpjMsWJqzz/VLA792UIRRck9QY7?=
 =?us-ascii?Q?/TUErG5wsOpei0iWgfngVZGm2JAPdmoVbXr8Rq4KSWVO75keuSPBhPyJOx91?=
 =?us-ascii?Q?c9/XbxQ4AwUrxxNsvan1iSvoholn2s2vUydv1NKDDVbfmd4FXBhMTUgMFrfY?=
 =?us-ascii?Q?QrfwJMagNKVFZkSyNK0h33nF0oL9JZn5laGXJmYoGytm/8Gng3AS/mA7hE4z?=
 =?us-ascii?Q?O7DRBj9j46qhW+B/RvjuHCkQhhPzQ+Gc05IngVY+iV33Bt8jiWdJ5hWBYBBU?=
 =?us-ascii?Q?HEPulTArIzfdpEQz2Mtu8S89gCYqJ7S1Nvky9I4xNm/nFaLVzITtEuHjsSTQ?=
 =?us-ascii?Q?Kav0ktQC0nIc2kAyFnf3sxRf7J8SEpDWn39SdlvYhO2YD/sWN0P1uz+FUVw0?=
 =?us-ascii?Q?n5nS5hPSNbqwPW6fTxSabczt9IKjPbTrYQIVqOJ23LU7j0FwfG2RlHLWVeB/?=
 =?us-ascii?Q?jngsGctWycgRUIpa9qFvpUh8PPF67e3lscksO1DZMUptgeb9crzgjQIcSeDW?=
 =?us-ascii?Q?PyKtLOV5nfMJl6+8ox/HiZmvkTaf2ojXRFCs0tPM9Hyzx2V7UnZx/UIFI28o?=
 =?us-ascii?Q?UliTjDbjtL9Sw8v5e3PprjbH5VdgW7twOJq5rs03ISbtWHVAEtib+6BHvShV?=
 =?us-ascii?Q?gT45LPtDIrEwAUSVOe7tmV21OS0MsOuR4fGR/71CVlJ1pLdVwyycF7m/EdNq?=
 =?us-ascii?Q?4KN3r890WaH4RW9heQwC8aVnb6CRYl5BSLrbQU0RqpumxB/wmKpZwoMAWj7l?=
 =?us-ascii?Q?XLoYLxcNbW789d56hp/OkLhWUoQOPUT7YcVj/bSFFSLLfNS/X++ldq4DXmTs?=
 =?us-ascii?Q?yMaZNLBkwFaQnsewaWuc6ev3BOOx/tNF76xaH/gM67DLKZz515WPrMireOei?=
 =?us-ascii?Q?IIUJ/yY827jMJeWnlLCGg8PkhIAQ++bB0nFvEz7ji16xfK4I9pnAxIS7LSi1?=
 =?us-ascii?Q?JrBBm7Nxjo0xI7AD5/92J4MTm90ue22Ngl0u6xXdo8wxn9qysV6KAxt/RH37?=
 =?us-ascii?Q?UI62nFuy1KBIK6h9ZV0FVc0P4Bt+OyZCDOWP7mBgePKLp42k1l2p46gvMl2R?=
 =?us-ascii?Q?uk15+hpMDBB0xZx2FpSrQxt0wSyoru8aXRSSaxXRfyidgUebSlVQ/jJsqRdU?=
 =?us-ascii?Q?86zWwCnPGPffE9QChPLE6tgbjdk9bMb7E/U/CFDK2UxbniIVyXI0JJaSFGD1?=
 =?us-ascii?Q?BoUSZ9cNe9O8g/Dx1N/ZSEaiDPz4mKib1lpZwYT6cq5HP1lDQJYz6E+JisoE?=
 =?us-ascii?Q?+iVOXMcYTwb1GY/ru6U1IU6DJK0mvspUAr7kKpAmObvFNg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD00E27CB6CE1D459396B3BCE095256F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669c89c0-856f-405a-f652-08d97d05206a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:38:41.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKfCkzN80SA8QO/EzIuwaOZ5qGJ7nEPwgDn2fb5n970WKbl4I2+9rJgjKeY3THSm4IpQgtaG3QkTEEjwVkKDzKdovyKGWRxTpcrI5Cwftnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3453
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210083
X-Proofpoint-GUID: 5plTHFj6izGihQ5CiKiFyCgky50CmTsd
X-Proofpoint-ORIG-GUID: 5plTHFj6izGihQ5CiKiFyCgky50CmTsd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> Instead of hardcoding queue depth allow user to set the hw queue depth
> using module parameter. Set default value to 128 to retain the existing
> behavior.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6478d3b0dd2a..aeba72b5dd2d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2096,6 +2096,9 @@ module_param(max_loop, int, 0444);
> MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
> module_param(max_part, int, 0444);
> MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device"=
);
> +static int hw_queue_depth =3D 128;
> +module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
> +MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. D=
efault: 128");
> MODULE_LICENSE("GPL");
> MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
>=20
> @@ -2328,7 +2331,7 @@ static int loop_add(int i)
> 	err =3D -ENOMEM;
> 	lo->tag_set.ops =3D &loop_mq_ops;
> 	lo->tag_set.nr_hw_queues =3D 1;
> -	lo->tag_set.queue_depth =3D 128;
> +	lo->tag_set.queue_depth =3D hw_queue_depth;
> 	lo->tag_set.numa_node =3D NUMA_NO_NODE;
> 	lo->tag_set.cmd_size =3D sizeof(struct loop_cmd);
> 	lo->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
> --=20
> 2.29.0
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

