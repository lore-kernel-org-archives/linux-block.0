Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2809C7EE2E
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFISrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFISq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 14:46:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70F35BC
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 11:46:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359HvNKV008527;
        Fri, 9 Jun 2023 18:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=72RFkVIkhSLYCZpiFkH62EwvVXswaes15DniJa8g0aA=;
 b=xSe2WfAUCFMJLczBKXO+XqvK+bNj67g7rRb+8JTbo5aKi5o159FBHhh6Vt3+d2tiqwv/
 PXwckNlDe2XIllLr4xaNV00ysKvmKGXL7b3SWoYqagSGI+nBGNTs3KWLWxz6cW/YDeb2
 +XZOPRJb6K0z6wYAPr7ORWi0bbb3Z46cTVIiXF+O+SctGYY05XVbsWDpjk4LFzBsLxM7
 jrFN1xXIgZWZDQO6uqF+foZuNBECWNpQpOuiuOE/JxvPpQGwBV6F+9+i4KjMoaIQ5IuE
 /EJ2sZSWRfcnm3teLMFNhlfmlqd7A+inu2sab1cdlJdoN1IDW8ANxMlhFeOB0gyqdo38 TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uf9gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 18:46:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359IDsgt002953;
        Fri, 9 Jun 2023 18:46:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6p9ru6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 18:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSYcuanHR/qvteaxznsPOxgSOvi7+SFIKSlXWks+bMOK63zW64xlI3S8i9lSCrHo7zLVwWCHsg1DggQQOOdibEjh5sY6dfEK6j5i+pQRcUZRZIMSaByQM0YBUBEGtgOfDUBBgEJ51KcCoe1nUeRoU3EmAshBnLIRTWM2aY7NEjqmTp+ZRRPv5etsLeAj6mSj/PSIMa4tEMHaA60fFioLlN+0Iabt2HCcwwBTJJG7XDdpi6HkFPBrk+veiuIIsmHrcdtoXL9ama2VgwR3khbuoXi6eGS5CHhfxACpbvFtsMYkc+zV0DZch3+I26SE8EDGbKHZ+sS9gvzH4zj8Gxfm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72RFkVIkhSLYCZpiFkH62EwvVXswaes15DniJa8g0aA=;
 b=lzYMB14aZNLlmridiL9j5QbVnCbItmjABJcy2NNFQKCJzA/Sio3MykT7sSAxkC9YwvhUAeu+YDks+jUV8/dC7FL8zeR612nSbRVxhBDAQpYYF0c8fJcML4WEpHeXG590Y0p1RAVvXb2jYVDVwQY9xNPt8/NSKnvzpOdh564gJ2nmXoUlf8RLFKYoxBwr4wfdOPTLRLJzupGuNIZKi4EJ90va6iR91TRKr2saF3ru8VcidabklD/oGBVdVLg9nemGQQVgErepl8vBKa+Ohz80djppoKl6hVdvQHCp6YaKGhwPn5tFmZKTxDWdfia2/2FepkS7JD0MUnKywjW72FXXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72RFkVIkhSLYCZpiFkH62EwvVXswaes15DniJa8g0aA=;
 b=z/Hqy+gEKQ+/Aig4ZU3lOKCBCkYjP8t6+BTVlT8pxZtxBZwCGpvTNmYb96mJkU/2WiRvPUZc9F3VS7rdFbHakHugoUYid7/ePrQkyfbXSmpkpViSdKtCpAOE6HfD/2ds9KwJCF3PgWszipMbHXHtGXOmmUqU5F4NmU8bhYHBiLM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4952.namprd10.prod.outlook.com (2603:10b6:408:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 18:46:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 18:46:51 +0000
To:     John Pittman <jpittman@redhat.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, loberman@redhat.com,
        emilne@redhat.com, minlei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: set reasonable default for discard max
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
Date:   Fri, 09 Jun 2023 14:46:48 -0400
In-Reply-To: <20230609180805.736872-1-jpittman@redhat.com> (John Pittman's
        message of "Fri, 9 Jun 2023 14:08:05 -0400")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2453fab2-ea9c-43fb-dec2-08db6919e366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IvhhWJWC6OEwpy0niBz2IcQmIRc7MLptJvN6WS9xw2TJ6T6IPOAlpkR+glf8QKN5OT8rQRSVZ/wvsX1TZLsMZYuLL8vpvKrl3QxVvp2UQfsSaK6jn1En+H/LnKjNHII9gkdBNRfiq7hdeMm3OLIpqnl6msEcBlGd5/41BWRBFSHtZgjUd0Rb8QHCANDJ/hFwe2U2iikzLVjzHJXDgbAf3jvYqOcHT1j/FQV4SIbrc05/0KzneIcN7yU6gOe/9BUakoRJD6GuXlbOx6QZZ+2Sa6+BnSpb4GpSAfuNMnOtAT9/XJt4j3fg//QL1Rppyt9AIyzTSkTzK88Bh+qwrjhinr9ukZ+uFLju+1HbjAwAkpuSy1jRKfm9VPW4ypm6NCR6Kz84eBTRmvK798u9G4ZDGyrSPvuDA0RahYVgJkhNxlsPf9SPcNTIhUPD81jE4ZTX3UXm61HATWjVl6kdam8GVlPZ1geyyrrQBivj93Ny3OCasDgR2WvcvM+PvXe8IEZv5QEPvWtg8lgbOscNBT3pk70f0a9hi7tGbqFCuzHipJLmDC9DbwkThjal7LNAb3f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(26005)(186003)(478600001)(6666004)(6506007)(6512007)(8936002)(86362001)(316002)(6916009)(5660300002)(36916002)(6486002)(66946007)(66556008)(2906002)(66476007)(4326008)(4744005)(41300700001)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5fjM23KrYr5IPHUL7vQmv9FTStvJyX9UPyFxxn4H9+TLxpgUV1xITwOURGl?=
 =?us-ascii?Q?y0B+86lTUSnsA7lWNKjnWMWCPru2fhJbKjyy+J0BPFiLDnYC63RpxLohy/Fh?=
 =?us-ascii?Q?bLvfh/F0+ho0zlA2mlZWtfDnH+vh8/+vCLisUnW3jFbSgVLjb7bGxUvk6w1x?=
 =?us-ascii?Q?CAQUjgPj2trFmTC3DLfki3GnUMt1QBMSCfrUxQp6TJ2MDBmTt/3QXAjK9gTw?=
 =?us-ascii?Q?9pnxWzgU6RUGP3n4DTATzF7uLQIGnsH4OT2jzlH2WNbxzeskVVS6KfPtXk84?=
 =?us-ascii?Q?tPXE19WIk7oIhtvf51P6H/XfmsBrK6wOgf2R97X1F65/5b8efQyM1A+zSvl4?=
 =?us-ascii?Q?evjvKac/wg9kYG5bJr4ZR2YN+UvOdRb77HhjnTeHuX8XdiZCe2j1GwWxT2JD?=
 =?us-ascii?Q?7N8LMCgAHih11/GA6v+cgUsiA9ZTwl0+pp7Pahxc7BTQbF2/fHDWRr/r5wgL?=
 =?us-ascii?Q?x9EKLaGa2s1u4X4yLfPSpQrCiCsXCLK0mBZFkh1Wg/muEFc5Kjo+bKeH/D8o?=
 =?us-ascii?Q?ORRCCPj+ylbSFDKarJYQ0HqX8Zala09acTv2CoDxRFpLFijJte0iELbJsjer?=
 =?us-ascii?Q?dVAiPhG47yjw3/RTfoFSvGPt6VWHk4LindHyNG7nvQM6N/9kVM0Bxt0FC1DP?=
 =?us-ascii?Q?DMebyqehrR6Nnz7mLHYuDTusf69Jd1CyBKZwbb8zGRa2NYk6VMUZYX35+frU?=
 =?us-ascii?Q?e+j6f5QZxIIK+jM66n1GDmN34A7hSXySzbjYexLigPXUMHsUkkQu5A080t3u?=
 =?us-ascii?Q?P+HSl+D2oY75RXfzAaWlLCOSEUcwi0LyxGTEa/ywyEkQ0LC8O/Gs/rjPuX0m?=
 =?us-ascii?Q?BC07Bbbsd8u1qWYWT+5Y1WukszHpZab8RJzbwP6b6tonj5KTzLsJ6mRlPQ8h?=
 =?us-ascii?Q?RF872nkkNCpYfLAUagEr82/KQJHxDRLZD99E1ee7Y5lHOeBdCeMxgTNLZBUd?=
 =?us-ascii?Q?k1d3zuIEL4SLNSPxQKpaYsQUZibNJ/9F7kyVjJ1lXfP1juCkOShesBcZkJph?=
 =?us-ascii?Q?y7X3BzbPrEjY3B3LlKaYreL/b9rthkGO37leUd2P252Euch940V4a8l2gPHi?=
 =?us-ascii?Q?E5ea/VnjQ/uXjd8NBtYFRpu8eoZZLg00i2VrEhXDt1TmWWoQGnkEANMG1Pgn?=
 =?us-ascii?Q?hU7aUDldJ3gvYmQi4v3Q781thRGNuxoaCMRBu/HPEEfqRIgMMII9E3SdoHTv?=
 =?us-ascii?Q?fO0J/kTpvkQFtkktiRGzIaWxw4nrFz/L24jLuJbI/EbDdFo3JILascU1fjax?=
 =?us-ascii?Q?+ROyqfZFgWd5PrfoaA4TgCrmvxbUz28emnrOvd3c2QmmyKiSUIbDKX1NKoDl?=
 =?us-ascii?Q?/MzygKGpH5fTW3+35vfYEDxXELbyv7yOD3FqpsjehGaYcbtS9MIfoeXEsbAI?=
 =?us-ascii?Q?u6xLdTqlzdeUQHOlmTpQZQtxK8RTbP+Q18Jc7tCKRNEBwpDdgEM2WyOdcFAe?=
 =?us-ascii?Q?QrxP3l9E0z5N06WPYyV0Aig69PQDgKaYHXGvUt5FjEX0d01nvXvKpfl6vAci?=
 =?us-ascii?Q?xqoFQhHoC3/P6KqSoyZi/0yGLy/7I4KZbnP9ldeZJmjK9ktCV3dGwrkS0GY5?=
 =?us-ascii?Q?YIevJRaF5bJ5/zAmmKT405NemaLwaU7vjLOIcoDMMl8lXV0WdbdzEMI6tpkb?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NtZ7BGyKpwgLFtXZo0JMuEy5WDrcFc/TgXgpkyyyxy0AbmE/SUkgX8My8Y2gElBAVBrrW0Wht6NhP6vU7tDu/x8XCfwTlCJvcnYQBcKOGXWJgKBm5rjrhVed3b0nYhFJR4BLaMrDGApSAxvVfV0p0YnnOccq9UuJP64+hFLGS2jvLu8GYP6nJslkCTityptg6RxHvYwGxKHbdoylm+VKPfAVT+hsTBBwOZIdi1EXKl6hRjCbRCKGjnQc1YD/HKMB4gU+MyquEJbW8sPU2Sg2+6+yhKSta1xM7bzJ/SSLVm8yj9mYhnu/sELoETRXBsiUJpTr/5NS+04WXamFesfLp1eN/D9fDgfaLq91sTOUpjC9PZQBtpbOUu3og6gRxHQFuyg0VtgwkAeUgPQoWBs/NqkfRN8MOORjH4NcX9F7lYLdzaimt5kYyrFe4i8dCAAqAMP1tzHeGbgi/QiYzC9NFLH6ZhZu4FwUf0Xy3p9+tYMiQxuh9RZVvOpYGZBMWBv0tr3yeoE15K4oL7PIRgAdZHa6zxRgLFhGOCXl3Djdeu0WiyzpSAgMKeIjvU2yR3Ik+DjEGwQHvb9jS7yKXNslHmOw95IlNBSHWuUd78hFQByCxZQWmqh89wNFGqPqQXU2i33yk6yR9K3lMtGHCzTcKSmiV7zIpX9YQEpC3rJCJ4FidZfTlfJiV2cTHRfJNKHaqVe/MrYXKoQAKHMpRILkZcvlE5rRh6N+AlinovII3V2ht7omJypcUnplbGJU5NOoNmpmqfNG7M0gqxwMTDR7T+f0lbow3XUfOmzAxIuWeVAmpDq7ET1etr4YXPUkdsbU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2453fab2-ea9c-43fb-dec2-08db6919e366
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 18:46:51.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5elheObTBnn/QVRhrmGW5fMfiUqlqwBzHnkxCoPCZzwd650v1pZPeIoHz46Lndkn3aOpPvdOYpw8/45EGl4QGQJtpCKa+7ICi+1EBLAzVeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=473 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090156
X-Proofpoint-GUID: u_azXOF25i9-sZeLx0pPxrm6Zi1axJjY
X-Proofpoint-ORIG-GUID: u_azXOF25i9-sZeLx0pPxrm6Zi1axJjY
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> Some drive manufacturers export a very large supported max discard
> size. However, when the operating system sends I/O of the max size to
> the device, extreme I/O latency can often be encountered. Since
> hardware does not provide an optimal discard value in addition to the
> max, and there is no way to foreshadow how well a drive handles the
> large size, take the method from max_sectors setting, and use
> BLK_DEF_MAX_SECTORS to set a more reasonable default discard max. This
> should avoid the extreme latency while still allowing the user to
> increase the value for specific needs.

What's reasonable for one device may be completely unreasonable for
another. 4 * BLK_DEF_MAX_SECTORS is *tiny* and will penalize performance
on many devices.

If there's a problem with a device returning something that doesn't make
sense, let's quirk it.

-- 
Martin K. Petersen	Oracle Linux Engineering
