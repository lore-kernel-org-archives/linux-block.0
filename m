Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E69C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6F4613CC
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhDFUWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:22:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33302 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDFUWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 16:22:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136KEBZh120120;
        Tue, 6 Apr 2021 20:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/TYw5dFg0iYoDypn4/qXJyEc+4kO0zJcHuve95sHvNs=;
 b=g98p+zr2GEz/HaAMKTtzgyF5QfgfUZ/iGrH4KDw8xjCmk/U+DnLVjl2va4O0sCb5TyI0
 fC+vac9/P9/39moKhWg0/sop1QobHWze24DKkn6LTO0dyzJkVWAIlbF4TO/XrkBMxC0P
 ihW9S5GSCs/By+bJc1TM+xW794NwWUvnP5uwF7btw4KSYlaDzYeLoX4GocDO2PJyMKs1
 AVNavUuARjGMmqqbB75/Ju7jQbZNhQ3fEOX7iiFRyLB6bzWaIX/KHWzX0AQfQmWAZ8u1
 OpAfO1K8wCcHkLLScoS56bxFSCBAveFhJRYn70S/esWhsTA5gr6zjyIdmFo7jCIopvV2 YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvag8e67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 20:21:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136KFIGs143376;
        Tue, 6 Apr 2021 20:21:45 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by aserp3020.oracle.com with ESMTP id 37rvb2vwsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 20:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhxUma0+0AM0Waat4L4oukv7bPmtauEwrkHGn86bvdpnWMaa/LX9waFu4ETnzsU0Oalu0sJBzg4MJrT+ou1WCw4iSCoCYhY03F5SVbTd8KCyxx6X+j36HIiu0UKHBC+ddilwadChdwvRoe8IwYc5Fp18itVgrzkhTQRRcXfyiPI+RQ7AoJpHfv8F5R2WJWvwIinkWiLRAeP49Ini8R1Ba2DFXnRCQDUeJgXx5XCsJLCkWYg8Jn9x6rFi2Ktaea9MT0+RTsVMui8tTMiPsnVGEBprKlgWw1XM2kj4kl1JeUMyEBHnAqGpvtU8k9FZcYs06O85F++CZIV1b79hYB9Y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TYw5dFg0iYoDypn4/qXJyEc+4kO0zJcHuve95sHvNs=;
 b=T8S7lFIvRE4ReGigZt9E5nQfHPOkKXswPaTvLHQm9e6YAlglC6mHWjJvGpHtSE8DsKz+e2GhQJOetalKSR3r84scSnV+1n7YytY1nKrifGg5/OtSFgDwydm0/5V+ONzMr5uy9gw6uLF3FdjWDMX/+iBggAvHel+fSM3cqWJOJdJt3v2Ob/aoq2/nhDhcpB3v3O6RlTqrWvTHQ1vh4Q4tQLEaQMy52C0usUixr+f7J1w3dP+HiMfm2CVLYvEDd/lnIZ2N2w5Dz8cVyqFHmxbSl6aKmRSA3certh2s9XYb7kJ97T6fkghikSpz4xfWeQm+7+UvOVW4UA8gmSzgQ724vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TYw5dFg0iYoDypn4/qXJyEc+4kO0zJcHuve95sHvNs=;
 b=PTPfyfnZ1tXMB07QENYQhwTdBuXY/FiijduOJkIHGKYMk87JUKgy35JZDajYfMHStl8qClDlsr8gblRQ9bPS0M3APNESINBKgCgMeAHcJ2FGVsB/p8UghB01BNvRvvonRu50K4Zknui4H43hFROi+ugLVoDDIg2O3RyCVKywz1A=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2558.namprd10.prod.outlook.com (2603:10b6:805:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 6 Apr
 2021 20:21:43 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 20:21:42 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Thread-Topic: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Thread-Index: AQHXKyChmKODSjDsO0+se63BRwk6oqqn7qeA
Date:   Tue, 6 Apr 2021 20:21:42 +0000
Message-ID: <BF78901C-096A-453E-9FC7-ED410FEE17DC@oracle.com>
References: <20210406200820.15180-1-bvanassche@acm.org>
In-Reply-To: <20210406200820.15180-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 717f5ffb-de14-483a-0c71-08d8f93997d5
x-ms-traffictypediagnostic: SN6PR10MB2558:
x-microsoft-antispam-prvs: <SN6PR10MB25589A2BF012D7061844F56BE6769@SN6PR10MB2558.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W698DBqZMc0y2D9/H5ulnqN5RIzeWYj6GFPiCb7onDRr41ZcgPo68kVFZ5/RPOQkkuSdn2F6w4/gPjlnR1aZO9VBHl5Ws+zXSJqgrlYV2wbkoUCvDFtMr+VMfKeCYTGq9lVUVYRuZZylL9GcTMCMZk07+Hnw6XhckSICGv6yXiaCQWCH+Nb8f5BbT9auHwWQj7DlaabKLLKHUXMHReUeWkr5rPe6UPg0nYeGv1imzlbeTZcRuaxv9+akZMFkGRYTiyqKwjQVfguN+rJ8sVhSGLArYAH2eAA3xyW0mwNB6QjXJq32WujqO/9tven3LQeSWLcplKj4X4GWyaVmMvvYrQQ7g5bXkREozbuuizWsR+SqgutHzfOom8PePD6JDS6QneoGAgsfhhxaM6gFmvMlw5sqxMqgit99xTh6MAMIJ95kzpS2fQf1vNuqvJm2WfW7YmWBgZ/1HYfw7xTdbioi8y3dXoNyWRQ3MtedSKwMsq80uizdAiUxOWptg6DT4kr2jxWbF2NVo6FVKw4icQF1zmJ+KxEzxqgBWB+WZxzZsxV+/7mCp7ZZRMcKvKH7kYADpr0bkq00/Is71GNKpLHN+hLo42DjX03u+o1heu1tZRPPFydmDtTRdGZ+1aCotUBV6ntGsH1hMVzh15U6joNOlbW0l7sxGbzbb0TChB40efzcxdKyhEAoDyg7VY7mwhhf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(346002)(366004)(36756003)(5660300002)(44832011)(71200400001)(2616005)(76116006)(66946007)(33656002)(38100700001)(83380400001)(6506007)(53546011)(86362001)(2906002)(66446008)(64756008)(66556008)(66476007)(478600001)(4326008)(54906003)(316002)(8676002)(186003)(6486002)(6916009)(26005)(6512007)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5a7dezGfbEyY2kL/hHxVVCLS/9SaVqx7mubR71hQLwRJxocVAhk2TEGTxYou?=
 =?us-ascii?Q?+M9+h2YCBsaGUJvrm3jFxUr+L1QgPOatUJqorIIr1zAGnrQfvA7w5bpJUU2P?=
 =?us-ascii?Q?D0TFytSzCvUP8a1ePK/sREzvFcyYsnlHOsb5V6jHeyTfEphXaYwlGqCQQy1m?=
 =?us-ascii?Q?VeXTsn8chhoETZuA4DUHYTFVYvcJk+AgPiynj9/k+WBeRZIICRL6HxBG20qc?=
 =?us-ascii?Q?GdpdVoUeUr7RWKEmM+gr6qcGcltjkhVGRpmERdfOrReeDB+jxJhBfJYl3G8f?=
 =?us-ascii?Q?hd4uP1TU4kLurv112/FskBKUb/0+gdMkuj4blQZjnVEs143T+KewWlGkFKJ1?=
 =?us-ascii?Q?tGU8CnIJxlmVpfDRn4wLLZW8DIDBP0wK5w1CKkLHTu79iNM3nP/h52g3piWv?=
 =?us-ascii?Q?GuHop4DOhWk41fK9CZWZmTdbo1TdLHqwzEs2bq3jj8XJyL3DGkZQVQT/anZC?=
 =?us-ascii?Q?hgo/wBUgUj2c4P4kv/efH1OlhABY+MxZeIJkaAXpMBWSJL+2MMlvOj5Uj3Aq?=
 =?us-ascii?Q?eIAj2ddA3kzbAc3IvRF5p7G1QVKzk4N4OxKon+rPkzY6YqBodYkzgRGJm+Ev?=
 =?us-ascii?Q?xVEW4xSoCEA/xwVOLsOMAhFxBkuAjGcJvInZu+vu1Z/3rKwGwm6EYL2Jz0e3?=
 =?us-ascii?Q?3PqXLEbaQ4cJ3RFtQ6gdJZzbuB40I+ycNFH9bmpi0580Q5Xtoeve/vGFrDUL?=
 =?us-ascii?Q?o6SqO0d/6afd/8MMV20DqvAYft2tKtql9PWmnGv7gEXTZdhsR7gbA/flQD3G?=
 =?us-ascii?Q?saml2dP7BbzGQ+DMaaORDs/qHHyDUJsFhvBEqfeoBMOKYgmj/+4bKLlsh0h0?=
 =?us-ascii?Q?MfxvOqaEFt4ckbavQ4A5zJi0cAL3QvU1Oo0PZCAsAPzSlJ041JSMByk0ZyEp?=
 =?us-ascii?Q?e8yjOzfkEfjcc7r+ZB5QgxKsVXzaOzLTGGS37Zs5/7WSAobbzEyl+vszHyVQ?=
 =?us-ascii?Q?Q9T/X12hxj+5k/jatvJV2eIPx9KHvzD5rGmrzoftzkwy+rNf3mnRFb0+9pYr?=
 =?us-ascii?Q?TtoXzYqMZdq2zCufgd23C2/lrraaXB9dNlG768vsPKoZ0iC8WWlblcGoB3Xf?=
 =?us-ascii?Q?HQwOWJbWND4J6XJrOsmXgTjHept+199e2cCUUPAyW+evzG+no2YP2bwWgiXr?=
 =?us-ascii?Q?gZSGf/rRaU6tu6M2piDEvcGI93iEfK1QFvFsVtI+BNBFCqXfnQUjO6qrxkar?=
 =?us-ascii?Q?v6guKG79sB2UKkAJgYzjFTSYbymVBCNQ1TIM8nOQF0UuH0+NJUgt1MmIdUQE?=
 =?us-ascii?Q?fDsM3mLyOoImuR3UVvE5+2lt2YgknzdIa1bpZXZhyH5Vu7IGkjiqI3RsbMyn?=
 =?us-ascii?Q?W2yyVkOm1mC40rmwn9+6Fb7nB2qdL97am2rqWvjGX25HIw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AF35C1BC2E6EB45BABD4246188CEF70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717f5ffb-de14-483a-0c71-08d8f93997d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 20:21:42.7729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcmgfcJ0TSnvhQL/FVin6mqzngXJW+6mt1sV/CTSFo3xHIbZLAEl3OZgkB7AY49J2YK9ikkE4ziUWfONHa8t0Ks9kdv08afOjeQCsVZCfQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2558
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060138
X-Proofpoint-GUID: 42AnYpeKAZUiSkwv15xhonLHn_AmApmC
X-Proofpoint-ORIG-GUID: 42AnYpeKAZUiSkwv15xhonLHn_AmApmC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060138
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Apr 6, 2021, at 3:08 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> Commit e76239a3748c ("block: add a report_zones method") removed the last
> blk_zone_start() call. Hence also remove the definition of this function.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> block/blk-zoned.c | 8 --------
> 1 file changed, 8 deletions(-)
>=20
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index c0276b42d9fb..250cb76ee615 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -52,14 +52,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_=
cond)
> }
> EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>=20
> -static inline sector_t blk_zone_start(struct request_queue *q,
> -				      sector_t sector)
> -{
> -	sector_t zone_mask =3D blk_queue_zone_sectors(q) - 1;
> -
> -	return sector & ~zone_mask;
> -}
> -
> /*
>  * Return true if a request is a write requests that needs zone write loc=
king.
>  */

Looks Good.=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

