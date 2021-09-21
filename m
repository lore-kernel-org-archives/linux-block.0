Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D976FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BD260ED5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhIUNiC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:38:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56222 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhIUNiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:38:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LCrqVo004965;
        Tue, 21 Sep 2021 13:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EMETHiqv0qcyy29tysTAlkVSgoxE7NxjDbnf4W/ecCw=;
 b=kuzXgs8pxxd7aOsyVpDvBqh/Xf8ornSvz/MAzDp2l6pZTkVxEf0UkO6WO4Cvlk33M1vP
 hclB81X4x+BsYxuRFUiiUEGlFUx0WuaHvBrjC8EIgpcGmeDUxZOvEQpImfLY9cmy4Pfn
 4KdCji1pUhoOlW/nObvcePGGIkaF2F6D80gGlVQKmqL18broB3BkN5PYNrwb24s9hPqH
 QiBUg43CjsxWcUdVisZKJ/hCypgjl3IMCsZoteLmsrhvXjUAGy3feR5OS1m46RXD9riu
 qMgOnvLTXP3AsUNzqyQTk7Ug3VrLyb3WQ21YC6W8vm4My6Y9k0bCcJcYfCR2YOh4ALPh Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b796ca0dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:36:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDKx5b125120;
        Tue, 21 Sep 2021 13:36:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3b565e2ukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1bSFNM/l7Y+FmlWbo7YU+dQ+fIUlUGKYt11qYjoEfaZr+zrSfhkK+VQR7Q4Toe1IT20W5xBtj/8bn8wVzSeQx/+7d3DdWC5qgom5vG/nv8AEZdi7SWt6eEhFXvM5naRD1Fyyw1SIZbcJnypGDsWvEdfXub+9rOLbEyqO/8bFyJa4+sGF35+yjnynx+jz5xsFhzcBemXzufNtIbGblGjs+2DjB2EpLuefgZgQUbZOFhJUXCFiydTMMKoWYFnzJjV8JrNN4WW7CKU02/BAthFktp5xlVBVxteJdL1kIqQHhMwIzdnxyJQN85rLVnmrJI72xyilHlEn0BbiojiAEw24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EMETHiqv0qcyy29tysTAlkVSgoxE7NxjDbnf4W/ecCw=;
 b=TYzhFuHuOG3PYoCUATO7o1r36NLyH5KR3aH+1EByln+VOOz1Om3EPiLZCkPC1zZRBaFKFdWaXBizQjHVPJKXk/J+82StLytaUmb8+ynbdj4Fth25COzUyfpQ20ATEY5qciAN7WrpcfCdyDs/pGuaXD4Y5i6Nx50WthxGjBOTCckWxJuP7v6ECHA5WFgIS+EPFVdKyTUMWzRFSXSu2/fUWCkzqON2B7+HKpHJ10z3txsPrdcGpbWf9gx4T7ECffCAs6GRHa/W6JhI230Ojyti4oa40NIRmG03oKAboBf3M8LAdm1HpPaoPltkiQ3V9RuASAkgkzRJB9DFmFKfLbNc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMETHiqv0qcyy29tysTAlkVSgoxE7NxjDbnf4W/ecCw=;
 b=Bck/MUShFv33xKPyk76yzzXOBBT8/XaxYe0ta+t0D/DEKG4RPHW14+rquGwvPVNlyk/XOslOZ31v0x1T7HpDBHQKCXd8/Ywu8Y1ewsGNZ9ZIiLxF7X9dWCzVllVnJUHnSrY66qVfLyLJaYps411Am7NUbmq+zcDE6/0XIvqJLXo=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 13:36:29 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:36:29 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 6/8] loop: remove extra variable in lo_fallocate()
Thread-Topic: [PATCH 6/8] loop: remove extra variable in lo_fallocate()
Thread-Index: AQHXrso69L1+nMj3w0yO/KoU6/0B+KuufccA
Date:   Tue, 21 Sep 2021 13:36:29 +0000
Message-ID: <3BED55F3-BB2B-41EC-B14D-0ECB3EB2794C@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-7-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-7-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 431aa8d3-cb7f-4c4d-1096-08d97d04d14e
x-ms-traffictypediagnostic: SA2PR10MB4604:
x-microsoft-antispam-prvs: <SA2PR10MB4604F1541223560D89B2A390E6A19@SA2PR10MB4604.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UfDjEzEjfIxuDU055lM+sBfilgsJT9EfqjXSZ7wFo76pYID8Cpu+Xw5SxLy/uFSqj22hXGIn/IYPQG79nR7HumZ3q9fWUHeFs/MxUgfZSiGiVKtncaOrndUG2MfAWgmhqmMuM7qCJ9nlsPf8czzayd2YOBbBNz9B9YvXg+9S4HzAdILuBlLA7hgfUUbf3kvjp2GYxYFhlRPPibhYl93bVFOSGTBk6kryvgL915nQO+RRl8ZzcwqghXKV+t6GCM4Vag2yck+Z/tNGKtJUMg56c+/pwqBYE6gEtXK8MOjwgUSRNkdddCInYPu7ZV+Xg+AQsuc0LVeuFPrkdbbOwqD3iuUjaDSRq+WaAx5WELL4BF3dZRhtFPzdG+lLp+szd2jTe3AFdZWVR5XnpUIiS2CTqLqV7qUyFqnkkeW0eOjgnv1TKct6N6yUgG8h8yqaHBV3UZy/uuB1erYtJGmxELsFAvRiP+hf4iKMfCFQARF7YS+guyd7BogfV42JkUoERIMNNlSODUEZvAmMApwxkJfGigM/wzOinN7muOGcuZecGd6Oy8dVgH2cLjHwtv2HS9mIqBTDK8PkPqHePeg5gJuJNqr1fQlSheDAb1HiKVUIks846/ESgapr9Ay7ZG63Hgx/kW4ua6GBL6yhWhA5S6V9a0kCSVUAn7Us3g2tuIOOw/C9FYxObYkPHz+uPabNbeTRH/KznGHbizutmXnLsZLs+hZ593T5b6V08QeumGjKTp4rcsbjyiSwSFBEtFcWlLKE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(38100700002)(86362001)(186003)(4326008)(2906002)(6512007)(6916009)(122000001)(26005)(33656002)(54906003)(316002)(8936002)(6506007)(5660300002)(66446008)(6486002)(2616005)(64756008)(83380400001)(44832011)(36756003)(66556008)(53546011)(508600001)(66476007)(76116006)(66946007)(71200400001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1DfZXDP5kuxkBYcNtj++xkMxAWpyZ1h63hYyXsuh7VzGDASx8CzR7lqLZrqL?=
 =?us-ascii?Q?wfBC8tHmfO79nf4EyHFohiCMaLWjiU9bPRpnWak+lCY9K59yto0rDijNNGVj?=
 =?us-ascii?Q?c5degPqgiX08MNF/iS8zucARgDo9o2slulMqZqjOQ6smCJN2cHnFWOagwSik?=
 =?us-ascii?Q?sbOwBkL1rySJcXw3MK7sFZbBy1E8z1KH9uNaYT889xdaHuCmBdeTsjEP0Ze+?=
 =?us-ascii?Q?+XK6z8ox0+ICtAyMka5hFWvwnMVNLUoVLC0cQ3580YGCkJ2ygvDI2jIBrDiR?=
 =?us-ascii?Q?KH3ptMX66lFCnn7zE+VzLsydja9S86eTecQbMHOlsLUbGiimm3pJKjlMg/VG?=
 =?us-ascii?Q?Ekhcz6/URuvrWW88mQ/XVvQONirMwmfJrM/eYxDYgPPq2htFKIGD+5T3zmsp?=
 =?us-ascii?Q?wkSBWYmh2ACRMe5XcfWtLiZJQPR3Yw1ZgPhUAyGcv7hOkGXSKwE1m2g4wL3k?=
 =?us-ascii?Q?mXp1rCLmBBI7W6afziMxIjHzUI5dfkpNz04VHFuEhx5fbrO/g7iBjk9aOGVn?=
 =?us-ascii?Q?J6VB2NInYht/+3tCp25Wnlg7cuWTP3XFPmkF1Ap5KXOaD+XFPoRE3SAY2rOF?=
 =?us-ascii?Q?X5znv4Lyp1xvMpChzW9J8sBDl/iB+u9EiQrNiCpE3sSMioDylol7a4lDPiTp?=
 =?us-ascii?Q?bEs7d/gwu8Xf6ybigV9YAH++TcVmPt0KqrGdqC5ywoYRuZ/s+RGA8fgxjZVH?=
 =?us-ascii?Q?mWXV+/MXDpyudHp93MfQFyxYDxcAY5qstwNZ6BPOaElLUhd4+61O69yn3pLG?=
 =?us-ascii?Q?nWsgyNcMIunVE0Ei47PV9qvu+UFNPOe7930i4haJv5gkZv7HiHLjC9o5/ceb?=
 =?us-ascii?Q?xdNLBvh3vjmYFjwYxuZWt4uOiFCe6AlV5xWdf2+48z5Hai4bCaaPjzmXCTZH?=
 =?us-ascii?Q?yyROPVRrId9bX/eZy9O/qF+WhtZIPSg7eyE86Zkiz2NNIVmYHZe/xd2cgHTN?=
 =?us-ascii?Q?NBvSZNvrjTRlchJ2MjhLbXSwIGm2f4urgwtMH2jOHYv2adZ6/AxI7WgVyVYc?=
 =?us-ascii?Q?7M7XF3S3cBXWYM2lFQXOdI3LNC7XUpxQKo7N3Je0IvyM74oD7lbh/+uZjHwy?=
 =?us-ascii?Q?jSamjmSwqHNq+XZgZwGfev3256d5FvrX7mKPGsivO94Gwt/qw+OOZkUC4Tl8?=
 =?us-ascii?Q?cMAeB8nFCrFu8CRkDtt49Je1vPfqzibCH+rxiT0Ip1OqB67FXbYNUNHmQ8Pl?=
 =?us-ascii?Q?wn0xtoqbjway76xhlS8bAdjMYiWoMP5N+/LLc6eY6vAmcZ2nYDvl7Rxb9Nub?=
 =?us-ascii?Q?gg2JQDxXJL49bO8ANkqcGRzTQEUxpZQMXa6gVgyVM8INaIC0VioQcdYkUSdp?=
 =?us-ascii?Q?5gkjt5cuvFLx78UmoQKu64v3fSC9/G57adlFHTBT8EQhJA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA547793AB76294D910B54CEC8D51C75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431aa8d3-cb7f-4c4d-1096-08d97d04d14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:36:29.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpbBs+7jG+sFiJqIMXI5AjxVb0UV11BKmoPzgn2W6cTEtx8byEIsj/LV7zIbCHnc+qZh2hp7Z+g9rDePPSjV5rGCL8BXCmdDQSESeu4oVQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210083
X-Proofpoint-GUID: oKXnPpZO65jkFAENj0pGGR4l2qhOSkAf
X-Proofpoint-ORIG-GUID: oKXnPpZO65jkFAENj0pGGR4l2qhOSkAf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> The local variable q is used to pass it to the blk_queue_discard(). We
> can get away with using lo->lo_queue instead of storing in a local
> variable which is not used anywhere else.
>=20
> No functional change in this patch.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index fedb8d63b4c6..51c42788731a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -480,12 +480,11 @@ static int lo_fallocate(struct loop_device *lo, str=
uct request *rq, loff_t pos,
> 	 * information.
> 	 */
> 	struct file *file =3D lo->lo_backing_file;
> -	struct request_queue *q =3D lo->lo_queue;
> 	int ret;
>=20
> 	mode |=3D FALLOC_FL_KEEP_SIZE;
>=20
> -	if (!blk_queue_discard(q)) {
> +	if (!blk_queue_discard(lo->lo_queue)) {
> 		ret =3D -EOPNOTSUPP;
> 		goto out;
> 	}
> --=20
> 2.29.0
>=20

Looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
--
Himanshu Madhani	 Oracle Linux Engineering

