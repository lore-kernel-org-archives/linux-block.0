Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE4C35296
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 21:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379245AbiDDVTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378972AbiDDQNX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 12:13:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400C2F007
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 09:11:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234G0182006378;
        Mon, 4 Apr 2022 16:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mCmat2kyRImUEnUcsJZFHMHgUF9ZMK6jvPkPQbywEWQ=;
 b=rdntlevTI8ogtYC783Z0VtjHW2Vm59aRg9aC72au73ubuidJUeDkcO+NqKUPGd0HLW8Z
 HHRZJB46IJJfZXS9TyIgmK0KmHGzjR23GrSnA4g2qLYIED0WhNVKsMZQaB8Kc+vnxPB/
 HJ1zcyaestv33M/5L3AKY+ivpGMUJMtUEnqgPuXEcv9FmBKCx/e6rhsy1iyrKgrA9a9a
 gMmZVwPtwYoaZf5D05dFXlhjDTgSKvyomRZC/X5fSn7hQ/swv87RY2bkDY3wHS6Xi3gq
 D4jh0o7ikB+k8GPhn3QKwwsYTijTzLzMIoN07E2vHldEu8ybybW7DWv4STujzts0/kyO 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bs6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 16:11:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234G6jnD021593;
        Mon, 4 Apr 2022 16:11:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2mwjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 16:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixUlsAoNY07sPymfck54Jt9yTqesKJ940ClUyh3bKriYzBiSqRE5s2bDc6iWVdR2ATJej/pVR7rl5B+pv7fhbpbXwJnQ0YwTneMBE9l610ca21eAfL2jfZqY+aDcf8SzNRk9NeZPVvFuIZczh87lOTUnGaW5Ls+mvN6tgi2bXw0zWGgK0zGi5CmJ5EkOZ3TnIfugqXEnxlTrbnaRcRa/FIbMHiHb78SwZd4E2GZtRE1tysOA5vQaZiyGrFc7Tb2Mzxh8vDJVtxn3Sa+/sBjkOsQP/9G2WWAnG5ItbR7zcpU+ayglBnkl6YLD4yhjz/bHHQYVXhlrt/WcB9yInF9sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCmat2kyRImUEnUcsJZFHMHgUF9ZMK6jvPkPQbywEWQ=;
 b=SE1bGDedlFno2Wh8oasKy/2ttHMbtNbskFRiteyCpnhfhBsfMWxUD5ZVMRGhWKiPKYCMo+wC4aVtkRMIv5aF2stApPOdBZWpDFnMV/O7SHhvT/AAj5nzZCat9JyoLbrdy97L0fhY3q1p/aeUv2+Y3Xkdw/n8R1sbG0jzl6P+4h6yHvyVm8u3GhQ4It10jYiiI25moTU0GU+bAUYqIbb/JJlRSDQxKtatfppntmD78Re9F9BzQrG0Qok6rMhaU5Aufww8+d5D6sJx54mV0RIyJuPAggoS6cda5jr2FzguOAhkw6BXz3oCinBDBxHjpBj49uKz8Q/gU9UdjZvfCpv6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCmat2kyRImUEnUcsJZFHMHgUF9ZMK6jvPkPQbywEWQ=;
 b=IEPXwIxIJieAvFdKjiIGQMDA0bSgaafvlHqwbR47veidjzZEXxZxD3fDvTcaCkM3PufVxY3dk31ZxfzjSl90seAj0DgdscpoBDSbCLtbPR5rB/xMPSr2l2Liv2lf6WzH6zsI3l4l5yVErQG8SEqh0fFuGAloZHwrRLaeHuLHgRU=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by BN8PR10MB3203.namprd10.prod.outlook.com (2603:10b6:408:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:11:14 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:11:14 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: Issues running nvme-tcp/rdma passthru blktests
Thread-Topic: Issues running nvme-tcp/rdma passthru blktests
Thread-Index: AQHYRUjB7B8SuGFkOUKkBTNdBTVbSazf8qSA
Date:   Mon, 4 Apr 2022 16:11:14 +0000
Message-ID: <19889C9D-608A-4772-8B43-E2E4B118D801@oracle.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
In-Reply-To: <20220331214526.95529-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 062b2163-5079-4e24-dac1-08da1655be00
x-ms-traffictypediagnostic: BN8PR10MB3203:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3203F2AFBA067F519D1ACF08E6E59@BN8PR10MB3203.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0uPh71UIOoYAjK7jJlWK0L/ni3s12fTvL/+HYu3xsyVX7akLAYju9ii5elyAQ0J9JwZCE85/cuRfGUrnhfh77816cfYNzdVKrWjcBZ1DhRzhv2zyyj4MWoEsY4tV5PaLyqlQCuhcTWney95ZWUJJvTssO1BvA+aFAH5HlntNjH2evx+uL4cjRHLLiBI8VE3q5x9UavOUMmctoAE0yc7gujbJ3mOkknIkihAROjoeTr80ozQDBgK3GKoldR/AEnSYx9HMJm4uCzXfq+EMF8ZIUDrylrhS2XV9eQr2YHFw2QcKUn9IQrts6P2AKpB8PYJBjDLLP7QgCDXxsTF+d1Wqy4QEcLCzOEY5I/YCidfWeIkC4+1VvY9Mi2o3o0pvmNODvqqG6jo4X1dHqV6WG/m9lxK9Pof6MX04m9XzTUbdMGy+khgc2uwMmGRj/qrWnLpC2d7IAKc9/4+/BXQRHnzVOY1C9jHJjBrKP7dFbRwaA3r4WIp+sytIpLPtQT7W/s7LOjjHyMPjwJiB2/VF8asbVnKYYgUTCBwdQv4DJHP4bqddi38Jf0xh748YYJH8qAE9wRgty9QMu3kY1C5C7XUyE1P+GECCgSUKYa9bUIN/KkdkMR8Pz+h8w1gjU/Nn2okd1pSUAiey+GkGWJOIlPV/cEd8k9wfXTBoBQMzSvnRlxIP4OImiINABzFDbGNwUH/e+53bVoxAXJNr4huviKd3XTPzZax37vAHuKCMRxZqh9xjcSNKfObaYVgYfLZvxuK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(33656002)(6512007)(508600001)(122000001)(26005)(86362001)(6486002)(186003)(2616005)(38070700005)(5660300002)(4744005)(2906002)(53546011)(71200400001)(54906003)(37006003)(91956017)(6506007)(76116006)(6636002)(316002)(36756003)(44832011)(66446008)(64756008)(8676002)(4326008)(66556008)(66476007)(66946007)(6862004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yg3TQStnJj0DhwPg54HkL/hph6qSYoKgf3xKB+JjyQ7NV/BcTVCdEGEHIqok?=
 =?us-ascii?Q?J4VQMrgUMQB/xgf4Q9LW8lwpJVShqNeWsStSHoQVFCXom8oMnSymI9x3uN+u?=
 =?us-ascii?Q?KMJshNGYcGZrOpY+5L1TL/cMlwXMo82i6vry79WQ9Rq80/vh/H+FLtImfTCP?=
 =?us-ascii?Q?GeVDqHHUvtHgWQuyCuPuQGTHS6FgNrv7iJetLfSgnxpMYTPX440yJQzkIvMD?=
 =?us-ascii?Q?1IwFZURA52dH7CU9uRhZktcaPV4lUcZJX5qYUKPnwOOaUcv0stcMyM2zawCc?=
 =?us-ascii?Q?DtfeZMpK193kSs3kDtVJn8rrML0qJ3vHeic+6WTSkWNzEPajbyyiN0BXFVgn?=
 =?us-ascii?Q?7qAZPOd3z8Jn9pbooSW5XPZY6HbgrVvmyMgR0wvggAAc6Hq6zVRXb5PSAkH0?=
 =?us-ascii?Q?NIHOfXNRd/TLesvcD1ASvGI3+WjTaBNrD7yv5rfHVhtI3VbTl06TikgOPjrd?=
 =?us-ascii?Q?/wpVTKghnz6wrwJs1e27Y/ZLuYi10FYMec/nec6IItt6AjNSZf0zbpveaQDb?=
 =?us-ascii?Q?EdeNyMyhRreUDCMfAUbG9wd/yuQGk/9QBGMLD+2bbEKRQeBZU+XlkjsO24vx?=
 =?us-ascii?Q?XW9/XU8q4CXd+MX+m0WuNpMIWT50v9zchwvfMz05utvnK/iEOmXDOD5pfq/n?=
 =?us-ascii?Q?f3dglLh7xcmXqAnJEcbJv4TJcLr2fIFLR1UrpSHcYpfFrhlXhtGt4E/hZ0DK?=
 =?us-ascii?Q?jMEkG11ZAg7HZOWb/p1nMCiZVMxEMiPxCTpO0++4dyoNrE702Blsv6eg4nfz?=
 =?us-ascii?Q?weQPWR5boDi6G6YfBp0n5smUL1W9y8x1PjHOIizpFuLJx4svA832eily3Sxp?=
 =?us-ascii?Q?WkS994Z1H4RJqg8y4DdrGm/Hiipt6leVuAsOyJs3K4i9dRmDtsi84AcAhYfK?=
 =?us-ascii?Q?EhkHxo3LyUyGkpkcBacf2oNqc+59iOHzeCmb226n+vYxwqcSPLBT9e9v2hId?=
 =?us-ascii?Q?RjhV1vZ4ueG2yjKDmsIxQHcPODlXjo+aRB43ScnJ8QMTnWqS6yU1ic52FSVx?=
 =?us-ascii?Q?ojVZbew6mEkCe6bcL8pVFgpvdVj31YGf06SDUEzwSL041o9FLtgXHLqz6a5m?=
 =?us-ascii?Q?cTMjnF9lavbMFvoVwcIvL2tGtAeFkJuS/lxqOs1iD4oeSbEdgTZZqayFU3q7?=
 =?us-ascii?Q?3nno6n/4WAHSiFO3lm5ro1hu5L57GIkmG2pXcy6z6mJWj5so9KlNYFDOjpb6?=
 =?us-ascii?Q?akEDK26JjUT25LYKXTJ4ElnImuqwOQqHQgXcU83QFFeXH3PKayU3Xzfq/X22?=
 =?us-ascii?Q?PgBiS1OVVel2w7v/S7mz1LPn/yh38fD43UpGK+pTDVMgMY5bMTQNj1/FL0x4?=
 =?us-ascii?Q?bGB28WDPonNifb53nL0GNdL1bdjffl4PqhfHF4ielFv5kxeRqRHBaAwoZ2Mf?=
 =?us-ascii?Q?OnQ6plUPfGrrHJexbMiN1+eOguE728y7pMB+UilKn57+v6cnCb6FSmZ00ycX?=
 =?us-ascii?Q?PtEpgHN0Dwch2SxzEunDGXeUrTI2knjsNypi4M+ERxxZb6VmiiYSMoJOM3BB?=
 =?us-ascii?Q?KGAFR6iQ/9FRyM49hJh25y/rbQpib4+FkCADdmru5KD6Dd9QEEQ7i3LQV6nK?=
 =?us-ascii?Q?KmCrnLiW7igVNnSJuinDyR17wdFBZm5JIqAxgnSQCAG6QRu0BdLq02OMh5be?=
 =?us-ascii?Q?fwYW4fZ4C+xvRAcfVp3IDOjChmscYQxs8ki6RWGsRgbFDAyzyib50yyr9fUQ?=
 =?us-ascii?Q?E1CApo6KpmoxjE0wMlYkPQOILMkAOkn0aOlvCa5DVcO5R+35+nkbjFX5lQOi?=
 =?us-ascii?Q?4sNTCBSR+WiQIOGeEldEwyRr4OFQeESag3TYO2T0k+xNEU5RTmpn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <066640EBD930A348ABCE0C8A59F92E83@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062b2163-5079-4e24-dac1-08da1655be00
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:11:14.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZzey/9SWF4W9BWS1URx+9Mybxq+EwLB4sy5YMpDYj3EGkZKxQlkYthb+f8Sf86nd7txXfK+cvvbERa4BrwU6aq/XhwWvh7D99rsWWholTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040092
X-Proofpoint-GUID: -XI4Q-XV5eOA_2VOVtgHY9XCZnV3zfMQ
X-Proofpoint-ORIG-GUID: -XI4Q-XV5eOA_2VOVtgHY9XCZnV3zfMQ
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Mar 31, 2022, at 2:45 PM, Alan Adamson <ALAN.ADAMSON@ORACLE.COM> wrote=
:
>=20
> When executing blktest nvme tests with tcp and rdma, and with=20
> CONFIG_NVME_TARGET_PASSTHRU enabled, tests nvme/034-037 did not
> complete.
>=20
> This was because the nvme/rc helper for setting up passthru targets
> hardcoded trtype to "loop" which resulted in the nvme connect to
> fail.
>=20
> The following patch resolves this.
>=20
> Alan
>=20

Can you resend with the patch included?=20

--
Himanshu Madhani	 Oracle Linux Engineering

