Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C62EE78480
	for <linux-block@archiver.kernel.org>; Sun,  1 Oct 2023 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjJASzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Oct 2023 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjJASzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Oct 2023 14:55:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36163DA
        for <linux-block@vger.kernel.org>; Sun,  1 Oct 2023 11:55:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 391HmHtm018086;
        Sun, 1 Oct 2023 18:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/bBaV0mECT9VIY50DIBP7J53sleG15BnuxAJGhPVDm0=;
 b=pss8H6Eafh1vd5L7ogdAYNHi324+P18P+hgXbOyEaDv61N2rC242T2XG8nEE3WAP7Qg+
 pxpAVE9dUYlbnKj2FCWgJVICbq0Oh0sjr7NVneZ8trNWQzsmjAIZ4CJ8lCgG6gapMIWe
 jYs1sY32gfVRq6sXcXzEwdP97Mqgd4R1RKblljLX1yJG8UyaP9PtLXLuvJ7F+p4Pv5Ny
 TCW3K05V6lFut8+ovq76tlqDNfDTAAI34SdLbg2sJZ7C+X7rkbPd4u1mtQV2HuaKWyfp
 q0JmFVxhJBb82b+9fI3GjnsTPgWdENfwLs2YcUsyaQCdIj1J+6EhFZ2+YdC5JG5t4vHo Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakc9fgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:55:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 391E9adl006657;
        Sun, 1 Oct 2023 18:54:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea43x0w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnPWHo2rbdZKkFy3LiEk0P4KkRfIqNdcAKKOCxz2BJzmcRcePBD0DqzXtylZIhy/CYr7g61K38pXixszqDwxiW1xSv+fYUcdzSkOVQCPREj0pcgWUSyeV0wVDT1LrcggFRqNJmpeEUiLC28nFA4AOFrBM0VOPrOq9qXaUxSYUboso+mxAWue6xFZ6ZEmXQPbIcvD4nY5hdMQP6enFHbZXsc0chMJ3g2TEufBqjovfQRTMHjEYHkO9tPsSw/qFttJxUhOLmME/b5mIiKJSDiQBDyBT6cSYs+18jx3VJdWh9kF7TNl2VvSNfPo9eqk+A6p9ct7Vxmh1GKAMGnoW5FDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bBaV0mECT9VIY50DIBP7J53sleG15BnuxAJGhPVDm0=;
 b=k5t2JqHkUVofuAh+ojquhUZRRBALZ9lQyOVjzHqjlz3PwupgVRN0KOp6L85EiSTcx7pAVfw+2tjRwPF3iRf3xnFnwS8CRX/9WzIZVcvMo1yd6E+7BCMXWbQ3XYkXDjCtIVyfWRDbiB3FaLL2oOECepAaWlGIlUFpYdaMM9hKcyltzrs59sbro0AkLEjnfi7IeZMvO8YU8l/R3gfrjH07oMrh4mvpOE/5cqsRgKTTP2XGaL2HwiAL82qZmVsXXfs1diXEee1qR8ESqUJKPqGyceYbq4i6fps4w5VQuWw1WpP+1PFqSp0SH0jRnyXfVGaz/M6mBoRlwN+vN+L0L7/zAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bBaV0mECT9VIY50DIBP7J53sleG15BnuxAJGhPVDm0=;
 b=ktVVVMjhnr5hWYYeWGJai8cIfR8m3bDxbFABCL3xDVQDvviHFAS9kBGu+t9dcQQQJSjgqSlRS50LVsxZE+NQd/nI7nMv69w0MwgYHtRQT2iN9vMHYNWpS9Gt1b+B+97m7NJkdPKVLm7wfOxpXkvgeR8z1yeZFkjeIod8AhIu1xg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 18:54:51 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Sun, 1 Oct 2023
 18:54:50 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: [PATCH 0/2] ublk: Allow more than 64 ublk devices
Date:   Sun,  1 Oct 2023 13:54:46 -0500
Message-Id: <20231001185448.48893-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:5:177::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: f473b357-ed0a-48f7-e9e9-08dbc2afe431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV9cwlav44mLn8CUIoArvt4ZnPWVfoYi9Lwzk2+mxWb7SF7mS+ZEarJ1jLyD/jvKwqofz01HIbr08zcO6fObTBZxc0k+VD6e9th//YmNJjhl8KGD2ZvwrQW+pdXkgZj9rgJgvrqogVoc6CUakYklF7QkCPdP/vkXsrLC8AIbdMzWIfxwCQ3kRTmDsXzg6K+OioJ5/P1vmkKtcvW3JvD6HnEDKa6n+6isDvmbw15E9RG31fs/cCcMKiBXhoARXGjVuv6mXu1ORLSzT3L5WBDv/amSFMHo33bmcDOlDJEiIn0gKHIL8l7qlS3m4zi/2rmoyCvcc+d2zH5vTMGS6GJxjh7PfMqwXiNiy9yEHbzT8rzdjvc9/4bqpSTrxJU42lVmYfrzXnfK3DRi2JeLAzdnSLh6K7p0gf4JiZTrhWup19lKFd642Z+pUA4gL8Tl59Becr47hfcgzewPjXSdRqDlYwR5mlpnEo0kK7iqFVXVO6TzVmkwO0X0vWIfgUaYaeTr2rk0PopnwUL1YyCRGm28Rrh+vbDlAkpd81S7vilHhnO23iOw8TDw5wzhMXNsgji3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6486002)(478600001)(36756003)(5660300002)(6506007)(2906002)(4744005)(66476007)(8936002)(8676002)(316002)(41300700001)(66556008)(66946007)(6666004)(6512007)(1076003)(2616005)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Ysbi45UwMIpbeeHR2NwQJGWvwUr5a0toDUMW4Uu/H6451bEsQzw/gwEfkj6?=
 =?us-ascii?Q?GoGYe1EfWm2REzI4wFvHOAo3m4n6/faZRC8AvjBwqf3rxJLPSB2Y4udxCku8?=
 =?us-ascii?Q?5JH/95uzsBApee/Lslmy395dJSSvfglyw8NJQ+f+437EYTCH2NKv9UkUTAKU?=
 =?us-ascii?Q?gZVRydT+UG3e7aUk+2oPh5qTZTDT/LPy0mNDzIbGP/96U0LAXBLOLWohZKV0?=
 =?us-ascii?Q?EcibsSee4ewM+oxL9LGFZoC72VYiXkLlvxFcJDN3H0t2VCdaRu4orb5ikriU?=
 =?us-ascii?Q?mzaNtk5nu8HFZsY2pE5ij7YJXeAXFVAuLqEZMZWM9wI90DMVbX/8zCZqr3FR?=
 =?us-ascii?Q?2WPhHyEm/DyQrqaGn2a7prgC0I1SOoMhfHxwGN8ToK4aAVVHugyNYG6RHot0?=
 =?us-ascii?Q?KlSc1ppb4d2KHt3Qg0oyoqEuHbO0gWwb/ooTQK/2DgH+1BAqp7GZLQzwoo0E?=
 =?us-ascii?Q?sfjNfF1b5TjoPghzlaZJsdkrRk6HYI83LkUfgkf7d/WyxT70KGUG8drupewm?=
 =?us-ascii?Q?5u8q7G/qtccCAFfs4akUSe4IBQGPEa2IHicypVBLYSMhLBrSwcoxIdgLjw/P?=
 =?us-ascii?Q?b6Cs7lZPwVqeWDt2t86kP9exJAn6ftnCIXiM56rAM1ESj9B3eRal/7LcH/xO?=
 =?us-ascii?Q?Eh/pLi/hvmJdpzvdmQzKTTHOFpD9GIEuXerlYCLyWGG8DnueeLy9R71un77f?=
 =?us-ascii?Q?dwL+RA9mXW/hBpjgshsmlp50kS3Hc+s/yV6FX6C/FKPDUbm1811vCoOo+IvR?=
 =?us-ascii?Q?jyzS2ROzmaggZDtoc3UHyFz4M5+7V2BX3+GRQYgmX/s5GhKOQFxkU33S3IaT?=
 =?us-ascii?Q?RHrXCak0arWmgPsFz8Ip7EHWgb6rAbSQgQLFi1umA1vkE/+K3cuAup95ArbT?=
 =?us-ascii?Q?/RimLBzoe8Foql+kLDlvnAzh1z0cGGA6DK2WrfGp2eeaxfRektfp2K+7N/wo?=
 =?us-ascii?Q?UsUA+JjqyBHyMEPqgZ1IBud6cHTc4qmN4lKHqq3WJ6E2anmthWseuZVmVDQZ?=
 =?us-ascii?Q?tq/bg2CrRVEH21EnM7uInZMcMbEzrlgl87D5eag5G/EcAWMrXsLCRvuwV447?=
 =?us-ascii?Q?hYSYexAdorl1B4j0ysdHlBUdvLDm0TQFP3ajzp28htlc4KeXuBnkxU21notS?=
 =?us-ascii?Q?0hEQCiUBFtpEdNR6NVrTfi/huqZPXsLZN2SYlcjuFfCw7o2vamQuXiXAEsj5?=
 =?us-ascii?Q?6dZZ0RdCm0GNNC6hEK8NNBgGcl2iCVHjTC0+GzJrJQgjW+Nt6sPWeMHQZ3Cx?=
 =?us-ascii?Q?Wv2vgQOg9PCbYPsprowtInIRVD/J9VxPSfxyaOd3+dldIJAStgnrA1bfrEwb?=
 =?us-ascii?Q?myDPku27/Pjh7dG/8VccLUjStOvtpEkxTmSMyHqDjKO8zUOKhj489qI4gxBY?=
 =?us-ascii?Q?KpRureN+Op1wzjVOBbRDbssZSdpZtTDK8+8OHvnIvsUuXs3lLkJeKcREvvMD?=
 =?us-ascii?Q?BFpnJWREzhR0F7tmvSWfGcxhDurAYJb+ZP2CC/W8G4aSSGMrJp6b0KooNkjh?=
 =?us-ascii?Q?NsglqTfVExevuer9WgLD6iqTAh02fs5Uvs5S/Qw+kHg071d9K+4rYebR7KDn?=
 =?us-ascii?Q?Rn4TRyTXzuQrxpsSL9J+sDBM6jntha6ncemKZbHBH2HBxwjh+GBq+Flob3Iq?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4tMlH6a6+MMMLUIF1F73JYdOU0FiAJ2EekYG/DNinbEG15OfeR904xI4SKI7uesYNVX/6glZljQLaEL2uNwqYLzTioPOIlFic/VxSsAZs56bumCd7CuOtb4dwGo1K7SFvuOF8csI7VuyJ8Io8/1lxHZJx904Ft1NpN07QOqwboWORl9geuHPlvytIZFNMFLApDpjjkODJCiSLyy2VC6aQnCU8fyHrNcmeU860fUJHtgP/PTb+0BErzzZm7tP5ms7Kx214cD1rj4k5UFqIc4S8kZj9y6mmkvO97+xi6IJnWC/hDez2dbi3Mdo/j4sYA+pL+92LjExD7NTLk8aeEHyCft9dEH6yME8dR0Kg8vzaDqNgXv4sVaZK0JNsOSQa7CoH3Vap4a9FDrzuH63cg95GpDma+SEV6lfPNC9tDHTtEZaUVn1Z4wdvwT9duljnPXqGIpR+8rrVIx5pSIdTWkZhgmxjBVEH8qYPHKVcgez+Tur0AG+4qZW7XZioa/FgM4lF+rZo0mqzacKAcmcwYVARnqMJPqdUlRUkivW0V0xYu2TQ7sC9wPmCDUSLW8nDQ0Dge78K28K8bSq35PFQGsS53M6Zch+9yN8InIfF3ebo8emstYBv40xddEun1OTyVQLGU1P1fmn9Li26OhOWSfNAhg7O/aRxvOhPK5wLCfJ0niw5mYEp6Myy0QTI/WY1QOjawgXOu5FOJxyBA/YhvWpVVqzBXxTEz3yesJfB+vtfvnXy1aKWQhnbs6G/f1nJ5VDpWnNHt0q1wAXRikOVrCA+cy8wIoTkBfkhv8aIhHd33yOcPfHQ9yDfD5e+WwgodAy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f473b357-ed0a-48f7-e9e9-08dbc2afe431
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 18:54:50.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m3KGGxNmbg5JqaRsdmLxRqqMRzzGlvdAUs4uv9LiGkLccmw9nluXjRWE64KiUIMcoeRdS3xfuPZOyzon55olO3Z72WzCt939d4o/vjXKX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=725
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310010151
X-Proofpoint-GUID: -rU-XSq6cGjf9hbmsB2YHKkdzSHF63ND
X-Proofpoint-ORIG-GUID: -rU-XSq6cGjf9hbmsB2YHKkdzSHF63ND
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following patches were made over Linus's tree. They allow users to
configure the max number of ublk devices. We are currently converting
users from tcmu to ublk so the 64 device limit is too small, because we
have setups that have 512-1k devices.

For the second patch, I've tested up to 4K devices, but was not sure
if we wanted to continue to have an artificical limit or code it so
the limit is based on the code. I did the latter thinking tcmu is
used in some clouds and they will want to convert to ublk like we are,
and they probably have larger limits than we do.



