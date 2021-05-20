Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E4C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F07B60C3D
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 17:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhETRiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 13:38:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhETRit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 13:38:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KHZNKF075213;
        Thu, 20 May 2021 17:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gmy1C71OxI67GiQu5l+f5XTzo4s9x+5fqEM4hmLj5Lw=;
 b=G27L61/4iwdcv4VZ3UiveI6WLUHpl81jQmoblsRSXcrOuru6f/bu1X1g8s3drnyy3BvP
 gd+OPFSIzGHBN8yOmWBMmeWVQpvTZ1Lmmx1kG4QuV2VqGHMVO5xIEGGeuiVdI+UfvvVU
 ga7ZvjkrILBbpbcwlHzSJT+iVW1blnEU5U+/Ri80j9NECskYhhQk2J5tetlNI2G4iSxE
 sayDUKq6CexCaxi+E3pV23J23Ym6WKJhwFe5angxHBT2OSBXPGSLyUOJsQzXitw0aWV6
 izboCF3oT2HbeXWo7XdxaZ5xME1IxCkyCGaC/oatOnRBqgKy/LuZcOkub9dghCTz1daN Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38j5qrdgav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 17:37:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KHaSmU187091;
        Thu, 20 May 2021 17:37:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 38megmrbp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 17:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH0rgmcLGC8Ux5XqxdEEYNqkU78iSZJyCINAjjEuz4iSVWInRUT3dFPip5hRXlWx8UaXLsNZjkOpQMXIZcsJRefCm7BRYZZY7rHzrRYFQ5+IA+KpsJZ7hZBbSzAWo+DulGTHTQ2A97kdykhcyP3WeSuImYbmXeT6livv48SvMxnhj1Ptm+VPkfx/mKIG78+xje4orNBVqYYjpHHoOsG9MRiIqhxUyCEoOLNGzhorYdyZQ0TvHRHv1anBBhKiu1AKguf9h8h7nSwztQ/HHTshW4XJDaUlPjYx3Y91vHs7Abgn+4mrYecKe6E/JiBMo0xldlAZ6++pq07x+JmuRUZXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmy1C71OxI67GiQu5l+f5XTzo4s9x+5fqEM4hmLj5Lw=;
 b=K3qAU+DX3sZAU5FCdfCHuJSxbCDzDlE0POnPDH7PUV7lQGnPrIYJMNLzprVZk6eRUicCAq95rhcrd3nnEl83GdcVYrwflKThKqjrTQwlsJifRCryCjdDWT6gCg82OTZgJkGZOUe5qXWDJ8IvJP2iyabKnoqLG/FBptlCX3EHNO9g83xO0IxbxQ44Bp3D0V+RIiJZafqltMzB6+/km51mN8ZMvJHXccCPULSzgtEFhci85h7oCFAmDRgbrCXcOZEqD7+8545AcfsjGIO063daqOPa6g3Kzdme4qLmW2wZhG3PPRpPsC8hBntgLT8wEdDs3E5o1M7GbggbXvnUhfESBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmy1C71OxI67GiQu5l+f5XTzo4s9x+5fqEM4hmLj5Lw=;
 b=g77rgPollHtDfhdolX3sP5wOSuoBxUYpuRXsTlwK+dSKzuUEB03AC/vx8G0uXsGwU29aHc1OcACxG+4t/5FZyooMg0utcj7Do+I5XT4DlijHHcVhkPvb6UgmCGLGOQ3lZ/lQHQ5bUiCG94MZwzg4fPXCWOiKfucqFpNqFbH0t2c=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by MWHPR10MB1837.namprd10.prod.outlook.com (2603:10b6:300:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.31; Thu, 20 May
 2021 17:37:18 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::442f:3836:d36f:f597]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::442f:3836:d36f:f597%7]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 17:37:18 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH 1/2] block: prevent block device lookups at the beginning
 of del_gendisk
Thread-Topic: [PATCH 1/2] block: prevent block device lookups at the beginning
 of del_gendisk
Thread-Index: AQHXSMOzLS6xnPx6DEit9N+PHlrT76rkF1CAgAiTqgA=
Date:   Thu, 20 May 2021 17:37:18 +0000
Message-ID: <CO1PR10MB4563BDF0F824F9E16EFBA102982A9@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20210514131842.1600568-1-hch@lst.de>
 <20210514131842.1600568-2-hch@lst.de> <YJ9rkRGG5SUyjgsg@T590>
In-Reply-To: <YJ9rkRGG5SUyjgsg@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [49.204.180.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fcdcf63-862d-4e8a-8a76-08d91bb5ea59
x-ms-traffictypediagnostic: MWHPR10MB1837:
x-microsoft-antispam-prvs: <MWHPR10MB1837049888483C2667F020A7982A9@MWHPR10MB1837.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdjuSltFrtClabNHX/nresq2LB1bHWMTrGsA7RCnmhx10tzv02JOGR6FeOcV1wsOa11Qb7wkPF2IKAMf2xcI8xVRYnH3TVOKRMRUTZBfNDss5btoXPPhT17CPxO1Rr3tfg4ZHqhtU/oQlOq2numBmRaXR6ynFpi8R0ErFRw7u9ENWYJbXHhk5775p0iY8AELYx8e5OrF1kqx1pRzCaotrVbJ8+DNaA/4wJUVHYhH3OpuPtsH93g4iMPftaOHFUG4OXcjuBZrQ+DaOegvbheCDLx7QWPsl6gyK8Vh1kyqEJ/9YuySVO90jL6S+fpGsNtU2Ok5jq86iVk45tcHiMqL10TK0kexfoBz7T1cwHgO5vzPwRCoqhsJpP5ywY39AFznN2tYtauhFSCArowzngepzKmMrLAkX7x2xBZoX7aBXnA2cPt3OlJnxQiU7J/RI/9dU6hO1oWgy5SllhltBzvOZt4T0qANWChSZemt7J1m1zbgqoW8leaVpyFQxcOmavUXNPLX2nvx65XzMxQsBql2LzyHSS1C2rARAfNcXUDxlgN6t1LbAdM8GiMILBjVh8fR74vieKdZnIm6wsa4Rirm+XPObWTbBRpoQ7gJogzDCO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39860400002)(6506007)(71200400001)(44832011)(53546011)(33656002)(7696005)(26005)(4326008)(186003)(66556008)(66476007)(64756008)(66446008)(9686003)(55016002)(122000001)(52536014)(83380400001)(38100700002)(66946007)(2906002)(76116006)(316002)(86362001)(8676002)(4744005)(54906003)(5660300002)(110136005)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mlpv+8vuS6MoWrxf89cziHWJDp4Tg3WkKWH+Ve3ZjUcvp7dATsMCEr1GWCvA?=
 =?us-ascii?Q?leR9KkLml4NlceEnco6d72xUbCgreuZ5rTY1aCvCtdQtAtBq6j/XywrckeTu?=
 =?us-ascii?Q?2fHI9J3Um3WtRHZaXpya1zzInAV6QxeZsq3vZJnTyVXqfAdSRbN62ANW8NHx?=
 =?us-ascii?Q?unss1e9cw9a08rwysaMQmv7gQh+IRmLT8hNbVxuRR45OFLtBUVWi6y1g20Vk?=
 =?us-ascii?Q?vgT0qWN00K6pxidHYWhPDj7cAWWl0TKV2fycs3qCv2l3rsbhhOjemqL4rdm1?=
 =?us-ascii?Q?+xPum98xIQglbqFQ3fsbA+CUIBmqpKIi012Gnm5k5a9rkvvulceEiM6MfCyv?=
 =?us-ascii?Q?1XjpY4kNoxJktIfp+KEjmD+wDPxilcnRpQgiRlD9pBcV8XsCE7R3PzGgsfNn?=
 =?us-ascii?Q?Dc1HJxjABLXxc1Wygxp7TAEWFCqgkQurrSRh4MKYErtFV96iE6jQ4UQw0gCz?=
 =?us-ascii?Q?5Rk+r/lN0CtZBpZJ2YZesmXcU7GqmY11QVAu9jfCpOHnxpfK8HKI6cn4fhoR?=
 =?us-ascii?Q?xqteU3JQQ8XpgX2Fn3EEONDxVWH86vdmbRKIZUH6H2IlWbtI2pIXSNKK0zhA?=
 =?us-ascii?Q?CtzO54xbzf7KcUkxlKgPL8ZZ/HHTSLmX1R2DoSnM1aym7Rl8Lf/O7Vjx6avs?=
 =?us-ascii?Q?GTaV8M7yDwEH5dphMvrw2rpzhu757rMzFGzR2Dqt0E3VKiFzjFDKVve9sfWT?=
 =?us-ascii?Q?gabtKbdkVdh+ZvmD5OgAJTMYFYdJKsda5WbE5ncwBbs7H/PTcG9UT3d+AlEh?=
 =?us-ascii?Q?y877hXszvsFJ2f7evqBg9YiGhfTY7jNEKZooC30fjK74m6/WtjhuvFIWySFw?=
 =?us-ascii?Q?oWG8j1qwGjNYP+YlP0F+a6OdlZGKroEUNamy553YMTDrBAMCZfPwQdc9sEN4?=
 =?us-ascii?Q?Qyb0DTxNGCRaiJHtS2QRPvGwuPEg4Lm/L94p6xUCDnrZdc1sHtO/ptQDtTQi?=
 =?us-ascii?Q?hG0KkkDG3PvEZOBgGQKiQehcoqekXqKdX6ENT7YZzX+OJAp3an39g/wN5Ag5?=
 =?us-ascii?Q?S+L1S+MxXjj5N0SuSTToQWkqoypw/ohokhmyTDhxedvYk3KjUTDAzbcGnUun?=
 =?us-ascii?Q?xrV4uQmQ1VaN3eZH1rzgM5d5NbrHnO6XuWADp+hppgyzcaNSOtIm/WbOSVPO?=
 =?us-ascii?Q?pQab4wl52U2OMgtbjUA34rBVE2G0Cv0qteVJKfHGdCuR0SJgvyoN/4Bg769s?=
 =?us-ascii?Q?ixUZd2uJpBwFysih5yHdkyEeQzrcevphr8+u7BFw5ciqkjIyHGh8MqekHiEn?=
 =?us-ascii?Q?llQV9SEU3ySvlMG/uamorC19ptIyDsXK7dyETVV8tICb7nXLgyO2NciV2Dix?=
 =?us-ascii?Q?eG2b/pKT4NoWzXvaO4gBIQyR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcdcf63-862d-4e8a-8a76-08d91bb5ea59
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 17:37:18.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOPeoS/cUlyQhp2AV1Go5BuJ97XMuKOCKTa/rTcdWvw/ytTY2/MFjvhjXSAIDz7J+Af52PD+PmjWO2r4ImsJ3NI0k4ax1SfQ2I78PcXK9s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200110
X-Proofpoint-GUID: X10pTLomx_iE02CcL4UJ80JbYRUcbklc
X-Proofpoint-ORIG-GUID: X10pTLomx_iE02CcL4UJ80JbYRUcbklc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200110
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



-----Original Message-----
From: Ming Lei <ming.lei@redhat.com>=20
Sent: Saturday, May 15, 2021 12:05 PM
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk; Gulam Mohamed <gulam.mohamed@oracle.com>; linux-block@=
vger.kernel.org
Subject: Re: [PATCH 1/2] block: prevent block device lookups at the beginni=
ng of del_gendisk

On Fri, May 14, 2021 at 03:18:41PM +0200, Christoph Hellwig wrote:
> As an artifact of how gendisk lookup used to work in earlier kernels,=20
> GENHD_FL_UP is only cleared very late in del_gendisk, and a global=20
> lock is used to prevent opens from succeeding while del_gendisk is=20
> tearing down the gendisk.  Switch to clearing the flag early and under=20
> bd_mutex so that callers can use bd_mutex to stabilize the flag, which=20
> removes the need for the global mutex.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

I have tested these patches on latest kernel in our environment and didn't =
find any issue. The fix is working fine.

Tested-by: Gulam Mohamed <gulam.mohamed@oracle.com>

--
Ming

