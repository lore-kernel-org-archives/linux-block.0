Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F4C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D570F61131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhIUNhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:37:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57802 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhIUNhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:37:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LDBUcX011110;
        Tue, 21 Sep 2021 13:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A+2B6e5b9emfPe32ORhNehRkCyEDMYdpB/uvYB73U+g=;
 b=zM/KGmB/T76L52lr1lzG7iNvLwGQvEkLtheWyOeLv7RMVhOg/WaVjcXTLjfSQZI12WnB
 3E1+1WCU1kKNRVjW8N+wBzliGmfEUwDTlE8SNcSzdjYEFPu6WePYHHsX7BNRw60hBCpZ
 +XZSzsM6mM85by3I/hVHg4ES1LB9R7ZlfvfZutnKCO+yRhncDvOm8W5sQWEn7yyLz072
 o77+tqCZclB1zVXeWebKYe9ov+6+28YaG9bvJy7TcuHuSLF/D6HWNhSx5bwaJuNgIAOA
 jtRIhwQ1Q+xH45Jh9OvFDi5GJAQaHJtjmnYmZGKIOlwKaF6aASYmWe9iEkdvO74keaWP vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b78fwj22x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDKwQY124987;
        Tue, 21 Sep 2021 13:35:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3b565e2t2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G33O7HWmv8yVq2H80DuL+HRIgqEqsiPT+98znA8+f01Hf+iZ0kB8UJRU9Gqgj5v114nWc+WmV+B8DrgflERjMGX5M3tZNhXaygvDMhUPJL4pItgQ9EOLypYjaWmqx4+0cZj8JiU3BMvwUDI824PT/KhQ1tr9QQz8OGCTEUV6b2PiwVyXP+6ab4PZiEgzCLUI6J68GTb2bGKJlcAfq93g1UchPcolaEsSHiw9myfDx0O8V0bNfDfKq8yE34UpL59HcWm7018mSx02T3UUcq4AmyNeCBl9uoM28L1avumsTlfAmHnTz+6RVb/fdLiOYHxaQFLcsBkyoxFL7Ni1ohmBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A+2B6e5b9emfPe32ORhNehRkCyEDMYdpB/uvYB73U+g=;
 b=ZmQNJA3wnQkz0dTb3d2RNYBiYrje4f2Y0wYYaxfL7vnGDkmnHVqJkGf+3GFvHPTy5k2PXAXepaPXu9AgNTIRvjLblIqOuCYaQWNOxjcYZRU95VqhTEslmVWt111cfmgHe7tNmzfpp9bRKU2OLv4+/jZwE5w5yolqwp4ElWKxGS07vY6XSxGc/9HbEhN7xqDfVxXTEnRV3E0Zs+tS/KQZLRRrVrRLorpwWDNan+1BWVTnGqEsb7OTNz8seXNEn1brBxmdOE2MJkkKAFrc/LaEkTlDmNO4DkcZOiK114oMwa87wvCMBibHY8i3o77QgYM+3Kd4ipjIZFk8ShXDdSE7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+2B6e5b9emfPe32ORhNehRkCyEDMYdpB/uvYB73U+g=;
 b=K0w0LHY+rfhoBmadh8O2pMrKelAj1pybu/B/a6ErgXvQ6ysUG/Gqtgnbd3+733ggS0tO5QKd+BCJL4UqOtXzGF9pK2GJ6jVdSLB8OIzSmv9ju4rerS4XrO2c8uyoxaiP+LciUab7dvzq3BunaDS0gN6/ooYHv3Ad443vZhk3NM4=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB5510.namprd10.prod.outlook.com (2603:10b6:806:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 13:35:45 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:35:45 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 4/8] loop: use sysfs_emit() in the sysfs partscan show
Thread-Topic: [PATCH 4/8] loop: use sysfs_emit() in the sysfs partscan show
Thread-Index: AQHXrsovoGMZrlElCE63Ykn3xdA7CauufY+A
Date:   Tue, 21 Sep 2021 13:35:45 +0000
Message-ID: <3FFDA789-2428-48E6-B5EA-E70E2111AABD@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-5-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-5-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc80ede4-6cea-4960-f6a0-08d97d04b6f4
x-ms-traffictypediagnostic: SA1PR10MB5510:
x-microsoft-antispam-prvs: <SA1PR10MB5510A774CEA51AAE14A4F20BE6A19@SA1PR10MB5510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2mNOnOUYmwGvSX/mOY+vnBiykal7U9GyoLTerrgp2gitJ4LHMVOqSO3vF//uh1OzeiQqZvIAjmtHDWNKVVrRjpovopSkuXqcsM0uGCrwD/zK0czVLoc3d6/cpFGOiljULG3PP23t/gxl1i9Zo3c8dT6RGdfKB3GvBY5nljIxT7KNUj0RPl7gsBTwNIIUNRq0KLerRdi3vv/O/XCd28mBNbomF3YnjSGrXnB0EfE7zQVlnN651t7GldJYBdShy7DGrzf6FDPwZVJM3DQHkCDbOHVfDO4vIgQInr95dXfxykU1oGtO2khrISEjo7kmZ/B4op/r/HCZkJl9vS4zOj+MNPuNd3HpcP4yOSjmGbMcfnBWoT/vuvxTCGky1YhwQhEi61vsHjBtFZA6AfU0NlFnjcNHSC8zLGu7sK6nB/qBOj9OdqV+mTGY2DNaAr5YwDIfCCLLm9xOMQWkBx4hs9EaI/H3kBSAe/OqwpB+7Q5plNhB4owSQRkL05HnJb+fU2rjdFVK7xFqK27xP439t9Ec5+NAZcocQodQ39b2KzJ6ENH6mytH5oYS/9HiPuvGzMZc/hmcHCJW3GevUFFgZoIaZfnmqWKAwseya5lFRcK8wMLzFOm8+SdRmrGLo7OWzsb3SrgKs//cOaK+k1LZZy27KHW0XTbre57xQEy3x63ZBAEcd64sH2wHm1AjUICN6M1C5zccoTYR8zOIkO0snCkbnNx+q5AKPs65V76mOwccaFsr9aQNFQ4Fy4zef/D2Rvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(54906003)(122000001)(6486002)(76116006)(2616005)(4326008)(316002)(44832011)(71200400001)(6512007)(36756003)(86362001)(53546011)(6506007)(2906002)(508600001)(33656002)(8936002)(83380400001)(6916009)(186003)(26005)(5660300002)(38070700005)(66556008)(64756008)(66476007)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rGp6NKJo6/FK6osSO5IaK8Xlc9Vm4bCjNyyrOeocut09blFSYVIDhu9GXaEp?=
 =?us-ascii?Q?6WdgdiKkHSJWP4weU+ywioY73GwMlHDXSdNlaTt8g7UoEme6Nu9y9CykBjYd?=
 =?us-ascii?Q?H3kMmfwk6k970DYUjJWIIL8TsDxwinDG+U0VRw/31YIwUjj5bX10vyxLWIHh?=
 =?us-ascii?Q?5/kG7NOqu85xYs4b8vwZaxd1PVEgrcVSCgtYTNnLQCFF9W5ZX1KgYDRtMujl?=
 =?us-ascii?Q?tndaZlK/YkXgrpNKrV+jsfvfzksePvi2A8hgzWpxOEp35CQOB2ZwaSUHxmq5?=
 =?us-ascii?Q?hWjjeFJg7CIVrOl9pP18csfGDtS7lCgSarczW2hI4S6rfW9MqzxRgS8ZR3A/?=
 =?us-ascii?Q?nAefhYa4Ujq/DSy8YwkJZRf3JJhp5rd+j2dmyU87h24sQNYgpEryng6/ItsB?=
 =?us-ascii?Q?aYKdwqjmNVGUcupap+BIh8b70DDKsQuCdkOdd04o2xYGpNxM5Dlk2lBlBbTm?=
 =?us-ascii?Q?xJRfQvmCm02OQJLrR879v6kB0uJhOYyLxfX6+Eu6dXtvpR4HeSxC81xKKKa9?=
 =?us-ascii?Q?4rxX+K+u4BpCWneX9Q63QROjvr2yEs1CK8od9XCALK0yz6rQMw/DW8eQ8f8q?=
 =?us-ascii?Q?lp5Ol/ke5R5uwJiE8Qo82HSyViP36Jpa9fL+5TT/5IvC73pPshbkyCPHHyXW?=
 =?us-ascii?Q?3azGZzxUXFK9WytKXWOR46ukAKMed8oEPpcO1Kihhs9vQ/xrLkW7/fKRfE35?=
 =?us-ascii?Q?CMKFtVo5P5LCp85HfCKr2UqE8GPo1IomfC5RullLXB+wjeu0iuFUW39yTcs6?=
 =?us-ascii?Q?t2BM+ktyQ/aTcoAuajV4pZG1NZ9wrBmCbGOPi1rN77nZXNW4WKyB5LSVTl0+?=
 =?us-ascii?Q?CIIWtLsJW2k833ob5n3KR/kX7aOO6lSbZvk7wbR1JUm//f2J6yBSXxKX7hqj?=
 =?us-ascii?Q?ejpjikMNpTSNhNLyRzAwxDvxUOOJL9/56tQqLiJgM4KKi7mmX/vBvOiU3KKI?=
 =?us-ascii?Q?ZUj42rN3XlZtNQC55YyidOjZmvoOsTe4cxlSmVXHF7O+bV0+BEkR10BngxjT?=
 =?us-ascii?Q?05zy8+tWee8VuJNMBSxzGeDvlQY48mvh7yDg7+WiZ77fo7SKbaQOxQ94XbpD?=
 =?us-ascii?Q?xU8EEJGou+/0BnQXGht3AxcUrzrxN42NLqeHEcz5aQ6TbC4JkEf5i4a2dZM+?=
 =?us-ascii?Q?FUdN1iaU1s8PlxdOIGeAl1h7BJXg1Uh3EPtSo/C6a/uugRKsY84ShTACPogl?=
 =?us-ascii?Q?yChs3WO8Aso/BDOJxbwxQ18skeLOWpNk3socYHOrvKVn49pYYpXVA9C6dv2r?=
 =?us-ascii?Q?EiX0Nx2cLnb9drGvIXrbItbgylBVCEh0ZMhufS/TICCeih28bsUAHvYAPX89?=
 =?us-ascii?Q?c4gLjtKxfKO88ef9MUZLeZKUFCcIfbNUdPwffxz/4k+8yQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6697F78B3940C42958EA5595CA7E150@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc80ede4-6cea-4960-f6a0-08d97d04b6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:35:45.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYdwu3hS5rzSwWJyEaFjDpaUkiIk+47TMAB+sGUS4ap5SQ0095AcXTwYRumDDOwg51S4wFKGFm0/dyTwBokZEPIFOIvD61CYmqwdH/SAthc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210083
X-Proofpoint-GUID: -KHcqiCfEY6yPrcjaXIg7ABNdWlcIyuo
X-Proofpoint-ORIG-GUID: -KHcqiCfEY6yPrcjaXIg7ABNdWlcIyuo
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> Output defects can exist in sysfs content using sprintf and snprintf.
>=20
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
>=20
> Use a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done for partscan
> attribute.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index fd935b788c53..63f64341c19c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -875,7 +875,7 @@ static ssize_t loop_attr_partscan_show(struct loop_de=
vice *lo, char *buf)
> {
> 	int partscan =3D (lo->lo_flags & LO_FLAGS_PARTSCAN);
>=20
> -	return sprintf(buf, "%s\n", partscan ? "1" : "0");
> +	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
> }
>=20
> static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
> --=20
> 2.29.0
>=20

After fixing small nits noted in patch 1 you can add=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

