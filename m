Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F62C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7FD6105A
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhETRiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 13:38:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhETRiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 13:38:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KHYssT141111;
        Thu, 20 May 2021 17:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DbguadvJdd//Iqfvbrm3jLDEhNynBRiHhpzd/Qpedj8=;
 b=EeCI/S50GLbRMq4Lg4UjpwvEjfQlncwC3yUn2P8MkmAJp1ltL+hROnvTeJ+WvjrMkQQ7
 9OntVa2m4CWKgMVVqdM0sdmgU9PtKwrgfBB1c6HafYhKxxvH8dW+XgXJ07j3uBNOpfWO
 hHPsg69Fv/dAbJJNDUvtv3D8PX9OzJVGxmuJNKhYiBdeBQBwz/d+TFfu1riapHADWaRR
 wlDgYOGtQdUjqO95OHzJIXu14GBdlTC8zvgFkuF6hs4wLw5a7wGpARhAY2V+qA7AWGqj
 R2h9ciagBf/qvSfZcO01B6JYsEslk+xxvcrJDRlCXJK3bL/BpGaTcJAo/GP8GWs7WA9G 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38j68mnec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 17:37:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KHaTkT187143;
        Thu, 20 May 2021 17:37:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 38megmrbqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 17:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj6G4tgZMiUJoRKbIceyNwXc7SZqCzVMlh+x1J2DEeB/ucFqngwClQQovQ5ajP/ToVPhX5l7IIXpsjG224y1f6IMidKVxjpzExDpkQ4dpTL4SVKPHOMcoo5QwG5fYQ3VOIf+ek/RFe2vO8AG4JRn/+P4zXRpqKqXPMB4rsKOF27/1NNoY8rivfLimfVLQhyIp67CIURbkzr1A/6PD/R0KRKfbgpPWZUeCOmXhU9PCJOjdZc/zce0n964PZqWPaNAxE7vGpbUgO4c8+1Pq/LE+cVSnTX+MxkObjMPjwMQu3uK30CQT4dSW8Z1yetxrTAYGItSih5M4TKyDaleAYbRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbguadvJdd//Iqfvbrm3jLDEhNynBRiHhpzd/Qpedj8=;
 b=ghQCYGcAL4y0BbRxudz4I/9nN9bBYQWLbW0T0vwGqRFEuMWJVcTfTcn/xma9nJ0WMUBZ7SOPq7DlEMD957XOTtKy3zHRWxvSYxjrfsj8AkKdTvKCL73CLTS7+XSbPKa4mAq2ypgfjsnxpgs+h5CxgcWxsEQv1EQczkqv+qhoQ/VMPxCtSw1INCrG8KhkQ38K4SdC0/02rc9VBJ05bZThWFlXP3+GgDSacaP654Ech0WObwwv6F2bCQBwdnfT2XnR/XpGgpsasGNoXlLfMwcPji7ph8JBBhkAWzxzAFT6zQi2DaXpPiEzT2LZquE5go7+bMTmKROffKbjSGfRhqw+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbguadvJdd//Iqfvbrm3jLDEhNynBRiHhpzd/Qpedj8=;
 b=pjvAtp+t9qIeA5gGifdxZZHP5045L0YYPQ3rVp149Lz7e7/3adGq5+GxL0JmhAVgdih8Uyv+llN1Jc1sCBDx4aiy2TRydao2K4Ckgnoa6ZTtT0AetioXPCUDeAaq70ROBtEdFsf6l8E0HH1SNqTOmjSNGHXB2m4CLP5K9u15pSY=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 17:37:24 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::442f:3836:d36f:f597]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::442f:3836:d36f:f597%7]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 17:37:24 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPART
Thread-Topic: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPART
Thread-Index: AQHXSMOzpNp5DcAs2U6J8VGDITDERKrkF3SAgAiUVEA=
Date:   Thu, 20 May 2021 17:37:24 +0000
Message-ID: <CO1PR10MB45637EBA4C6C6364850B944C982A9@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20210514131842.1600568-1-hch@lst.de>
 <20210514131842.1600568-3-hch@lst.de> <YJ9rr+2GnIef3IXS@T590>
In-Reply-To: <YJ9rr+2GnIef3IXS@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [49.204.180.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbcd743d-d800-4649-3b32-08d91bb5ee06
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-microsoft-antispam-prvs: <MWHPR10MB1871378AA4C79926E96D2E89982A9@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VIaeAwZ75jCUs35GHusz5O1fE6yOeHOEkGBpajEuHEytzIgV1rxSo9UK39BSHAwc7yubat0ZdafLbMcihtVogO+qokGq1hxm7uIP47Rk2+icthxJvP4gFAWS5md5v3HE75XGfkhMt1xBH6puFBhpflz7XbIa0PPyOfgrkMRFPC0utL6st3SS8HKz/MjRR+9CyXiHYQdoCPz07nPxep97kogAG2+TlZy8bOKXW78flw3neG92UQwKxNwMVOr0kqZJSN1VFDsOHwtBJ8CwBZtE2A8En20qwVIFhkAF6qHubQJWNFKPUfI+4rCO/pMGxGj3m+mbnkqDVUbfMkv8QjJ0zFTXZ0p/AS1sLfxd1iHaGiYIWR9O7YADv64+c259XN2xhBr8Vm5Ge3jAumP789XhKbLC2b0f3bUvvSNt5jqxVsPGE3Zji4P2fVSE1fK5bivcxpgXor02MBHqqZ31kizEy3MlTNjSGJM97tTeoQ5738xW/S4iHXAnPoA3RENRv4lvIqfbK10GLy0QnpZpAZZlKW00hL4ATzJaNN9W9CMzsp4TUzF2Z7q/3Z4mwe6tAF43OScs2hgKg+8nmhMSBJVVL1P+8knZc//rmz63NXkTGrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(38100700002)(122000001)(8676002)(53546011)(55016002)(8936002)(478600001)(110136005)(186003)(26005)(9686003)(54906003)(316002)(52536014)(6506007)(2906002)(76116006)(66556008)(33656002)(66946007)(66476007)(66446008)(64756008)(71200400001)(83380400001)(44832011)(86362001)(5660300002)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RQaMqlDvaYbXIHgOJjPo/cfB0/5LvDDTzAn7mC9JfV0abjh156C3dGr7+aqC?=
 =?us-ascii?Q?VCxkJtbSu2W5abdKYqjKd0dL4mV3amVwjg1m245uQlLvmWCtm9iWWGaTrAlQ?=
 =?us-ascii?Q?Q4Vh+InIeusIwFgdSljyKid3fADRVb9Nm2Vynn68v0lc/LZaZj4ZwslEs4aT?=
 =?us-ascii?Q?a9IyRW7JNvbRqyUNAf0TmsG8LaFSUTtyF/Nbmwrt29nlCOmRv0HCODmkdBVo?=
 =?us-ascii?Q?dR10B/CJp9QI/MSrIJAmQTxNqSAo0uZgS0rvwLh10ZUtibPI8jIW0WcvT+GT?=
 =?us-ascii?Q?etCELi9BexCn+2bIURa5mTvtiryMlytly/FC8SRaq5JT5yV4vWdubbijmSNa?=
 =?us-ascii?Q?EjfzFcoMdYA4YWxkVaKRjdHA7uRvNYy9M67s4UcXZuWQZS9vwN4lB9ImVKz6?=
 =?us-ascii?Q?rKxGKr9G2BG8DrFSzFfsyWxJmioLWC6XOoUZ69B+9UGg6db5tgLelPNBQpR7?=
 =?us-ascii?Q?qi0bC+5KV0c2cgEo3VIMlldaYlQSMIIoon6hmujnzRNXDeEEqvuMAnrdl/so?=
 =?us-ascii?Q?zaEr4MRXVqDgABrqwxMtpIq25V7HOK2+0STTvZrI9KyIt/t+Ki+Al504eqx6?=
 =?us-ascii?Q?9n5DBwVQztBlTZ3gP5Erki3JxmTivfpIkpyddIWKKRxmdHhXeGcRmAJLwVqK?=
 =?us-ascii?Q?zFIlldd2wo93n9xopY7Xxiv/IkxtMrGT10bwWErMdRVmUje1pD6ZtUx+Eh7C?=
 =?us-ascii?Q?fFLejIWG6CFJNlkAjxGylDf5PgiqLwhRloa1QjgZTzwrVxsU/tIiBLP3ti1x?=
 =?us-ascii?Q?wI1T973w9x+iFEYLy/knJu010V9a88CPzTS7D8h4RjcY0KrSEeN7dnEmeTeH?=
 =?us-ascii?Q?lGddEx/yQBk4rY6RGv1i2331HY8B/ZBNiPQNDLYEHvBbo5utOYmVcQqOmGD8?=
 =?us-ascii?Q?EmT+IzB0bo4uFBMqiEspFX9nF62Ntm12rwm7BiVyYcEtoUxRQ5G6C3CoH+4h?=
 =?us-ascii?Q?qoH5axeeT5KlLiVz2MTUNgja+2CDXMIauVreAKGiqEj0QWl9eyiIzjgd3mmO?=
 =?us-ascii?Q?kdjieEC0sbgWIc8LjAaS6GiZD3gpMqf9DtsUAZiTgQeCso0+gFbwX97LGuO7?=
 =?us-ascii?Q?B9YjK41GTIv6Gq50Xi00mrpJ3p8BuHKfTXe9Lo/+m8BHWIiCsu8vVuchnT1o?=
 =?us-ascii?Q?SDVPbh2E53rEP/ORK6vlZsJ40haaYEfJltaK8mNx45cb8KpTFsCExjcQVdfn?=
 =?us-ascii?Q?rprS1yhjvjYGaCMJzVYrFR9/BwHUOpgo+BBn3X+h53D+qX7N6HFmdi6doabN?=
 =?us-ascii?Q?erC+IF7NBAoT5ELBe+fBxbhAOA/06Bii9sVqvcTUDRjGjm0AQdiiIymZf+D9?=
 =?us-ascii?Q?BpCfT0j20Z9Ej2EhwDedAvqT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd743d-d800-4649-3b32-08d91bb5ee06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 17:37:24.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0pg7zJ11mBXWOPgeZWQz/jyLmrMBEpq3w9GcihvycoNH6QqK8O8pwD/dMzHc21tzcF6oc0eeg4Wr6as/StsNg0hM97MqpUEz3tGpaayZM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200110
X-Proofpoint-ORIG-GUID: eljtfP4zkVSe42QoO4CPmc2XrvM_rsXZ
X-Proofpoint-GUID: eljtfP4zkVSe42QoO4CPmc2XrvM_rsXZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Subject: Re: [PATCH 2/2] block: fix a race between del_gendisk and BLKRRPAR=
T

On Fri, May 14, 2021 at 03:18:42PM +0200, Christoph Hellwig wrote:
> From: Gulam Mohamed <gulam.mohamed@oracle.com>
>=20
> When BLKRRPART is called concurrently with del_gendisk, the partitions=20
> rescan can create a stale partition that will never be be cleaned up.
>=20
> Fix this by checking the the disk is up before rescanning partitions=20
> while under bd_mutex.
>=20
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/block_dev.c b/fs/block_dev.c index=20
> 580bae995b87..4494411fa4d3 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1244,6 +1244,9 @@ int bdev_disk_changed(struct block_device *bdev,=20
> bool invalidate)
> =20
>  	lockdep_assert_held(&bdev->bd_mutex);
> =20
> +	if (!(disk->flags & GENHD_FL_UP))
> +		return -ENXIO;
> +
>  rescan:
>  	if (bdev->bd_part_count)
>  		return -EBUSY;

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Gulam Mohamed <gulam.mohamed@oracle.com>

--
Ming

