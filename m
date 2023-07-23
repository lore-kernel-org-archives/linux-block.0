Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B6C001B0
	for <linux-block@archiver.kernel.org>; Sun, 23 Jul 2023 20:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGWUxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Jul 2023 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWUxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Jul 2023 16:53:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0FFAD
        for <linux-block@vger.kernel.org>; Sun, 23 Jul 2023 13:53:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJ9vgT026576;
        Sun, 23 Jul 2023 20:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=pWBruFeVFoYdw6TXqyDi5pvuQKeaL80BTNy4vdrT4Y4=;
 b=Cse6GoaAYmrNqywTcHxAQhJ2WW74WeoAKfK0YN1NA5zMrDrlJ8AwW3/VBH0qZgpPZwtz
 0TrtD7BHW4FbVPNYvi4i+rI/Ngt5MgYy529UdgP81wAFXCgK8DI0w5Qlh8IX9HTSxb6S
 KuZ1PUbDmreTWObEOsVsUmHoDXNBVsR+R4X4LKCRPu7YyT41VeQSo/reaH7UHNfDKX1Q
 xsq858fMGrQE3O+gjDrBc7JMGj2llb02wssQpLGMwKAzGkJg3MCuKCQr8RRveyiZXFOJ
 Bm87wg1a6sv5M1KluSDsRzn/JAuS9evsJ+SJQXlzV8H76PfO58r7bhTTevFJSezO2Rx+ 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1sj2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:53:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJvdsN003875;
        Sun, 23 Jul 2023 20:53:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2q6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTS9IkHkTNGbopvHkvVNDjCGZV0192c3X5mrFVQ7gcntARdE24UUrV2woN3/jzRoLbRVoxnL3TkIyJn0ks09+AEvaoOjNBlMdHSBgmjbxJgCsVYcanMPlPPzYdFnQoK/W3+xlU1GuD7FvUsASUO3INltrBreJbFJ0JPxac3jUMbi4BFs2Kf2LJE80fg50zkzOWSPssSa18A/N2mCYgy4TCek2lK2RUYELu2EmpIe0OiaY7ozc5xI0hzOdjrdBnr5YC98DTi0qaXS8ZE+Pki2jR1xqWYZ3WxUhnzLOxeEG56Xn7TpDYNLEQUHn5KcIti4SuOT2JFAPCuHBkM53AG65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWBruFeVFoYdw6TXqyDi5pvuQKeaL80BTNy4vdrT4Y4=;
 b=KcMR67ZZ7/Ra505/sljPP3JRTBzVvM5aVW3kO1B/jGwEJiXtIGoy5l1q6OL/p3ajxUalG/uizmmsHMA9kbN9ogHTYHtMWa0pxFyZG/mSsuRTJ92RoOEAx770XJYcTblTRLW2obLREgmbKwNRIdfL0iNSWv21gu2fDaamNLNSZ9cvYYqBPaslFHwOfxxAH3TpkQArqB40drcrtyuYHwHAtWAUeihJxf7JZfZoLgk6jmHpoglEvm4IiivUmu8fKR/QZ3EW+SKbV12o4LHH7BW3Cm8ZEYmWtUkzVUa4bLdOdEiIP6EshxFNjGfT+DxK/IHA3qTQTp5PSxutuyeFWdFREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWBruFeVFoYdw6TXqyDi5pvuQKeaL80BTNy4vdrT4Y4=;
 b=UGV0HQghlAPEhhfLt4tIbd+bHnTIK1rfLgLEiKl1zjDSUo2TD4lSfUmcp6jKtwMp0U3PTgH650Sy5owq2uSWBKCze+ztAGDIU+gp958g/emrGpT3quXgY2F7BTghvyeYfyHrhLeVJZquAc7bA6NBhAB4FMSyaFp9WXIUzg/8aYw=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by SA1PR10MB7709.namprd10.prod.outlook.com (2603:10b6:806:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 20:53:22 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 20:53:21 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] scsi: Remove a blk_mq_run_hw_queues() call
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8ea2vuz.fsf@ca-mkp.ca.oracle.com>
References: <20230721172731.955724-1-bvanassche@acm.org>
        <20230721172731.955724-3-bvanassche@acm.org>
Date:   Sun, 23 Jul 2023 16:53:18 -0400
In-Reply-To: <20230721172731.955724-3-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 21 Jul 2023 10:27:29 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|SA1PR10MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 346345e3-03ef-425f-5854-08db8bbed9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUIcGRO03N8uMwjYXQuJmqpi+cUgKdzrP4CyYdkZTQZCvYLkSJX6TXk3/k1UYuHVpri3vQdya5y7ZOd49CfEsp0ds0q+abq7XvUeB5KyWPpmKeu1w+IcUM9i/Ul/RTcATnrGyZnaikJnHP8Npqe2HIx7aTQlaTbVj+ufnP+TjAgRV0bzJVBaAqHxE4MgNM1HyV35Xj8Cvh2NbTmm+TmzZxXN/EpeYWgEsZCYFEHzrN3HcmiXnuu2LRwtGCPr8fUwnUeaN+zoPR1ale13GSAVaKamqWkLEuXSWqK5yuA0USG7yshSZdAUXlupKklO9mXhpXX7JHZWZnSLETrVy5jlok9veLyXIf/GhuxxdIeBqYNXag/NWtVoNTsnf0m4Jo3hIWreDp31FTm5HYSvJYwWGah5dyp/mNcCDKFzs1RgwJK3ppddnoW1B3th6fBpq4xHf8fcxXk92W1VroGBG9JUBC2Ri8ZDy5Z5wIQjQR6LTEYnPp4HfpIwTqYl3nG3SP2g/kwUuuZVqtuokb70a8K+fgwxRufesT5CqAEEOTuRY5AW+qtWN8OxabCigyHLJnib
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(38100700002)(83380400001)(8936002)(8676002)(5660300002)(478600001)(6916009)(54906003)(66556008)(66476007)(316002)(66946007)(4326008)(41300700001)(186003)(26005)(6506007)(6512007)(6486002)(6666004)(36916002)(4744005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyV+O8vLcDE6xBVcL60AwhOW2ZRJyK1oZ/fY9yxcxnFmuaoLqdkoJ5A4iWIk?=
 =?us-ascii?Q?wwex87+q/nu9BCnQpo5w3Vr7CA2Yi/Boi3NL6NSa6cY14PKnRkLBN94Ui8/b?=
 =?us-ascii?Q?w8BgRYX7DRJBI6Yik+7qf233mIEDRsi2TYJ021cj9XBfYhD5w3dtrNfk4oeL?=
 =?us-ascii?Q?rUs+cY8ebihFn+aqDg529Hg0HuIZGzCNAECVqnEATrk/h6SocA6k/R+/Le7s?=
 =?us-ascii?Q?cUAmM5a7Zs8GuN3VytmlCA8fpmo3WPEODXwYhsRFc6FzcGsS6118D7avx6y3?=
 =?us-ascii?Q?TFwaeYbgrOB8NVihZlcmHJ69GjsFP+6aKVSBj4tapPjdEVAyXKnGWBJ5Dt2c?=
 =?us-ascii?Q?5FkibUwgM5Q+3fSDjiTSk0EW/CDajcNBAiWSTiDYXwK00lWFDRfoUDv1SZOl?=
 =?us-ascii?Q?DLgn1whYt487UsoDFg1nbsnPwwZbSGN74OmYVHGVN6XqTGQ3WRStYKnKsV/d?=
 =?us-ascii?Q?dPEk7iuTpVbq7N28carfg+wUKwQf6s1YjPIKHr5d2qAsFpzQtkbO9wIAEr4u?=
 =?us-ascii?Q?wsnpmluLY9Vy/59YZE+t3pByV4xY/8fy/SyPI98aa3oiWjZAtzBRXH+h6Ezy?=
 =?us-ascii?Q?Puhkq+Q8K2XcNqfjFKgMGS1YKuUkCGF3XCKsaingf9IbmOkgv7ubbWa87VUK?=
 =?us-ascii?Q?Rep9xcaow4G7A7CHIYd82UwZ9DCVkt/lmRgAhtURAABdqmjmiB5pvZQHurTl?=
 =?us-ascii?Q?wbtbtNRHhZBmpWfNkY4QejonoKelcxPVRy6U/WErUZTxA9C/gQf4gpRYtru4?=
 =?us-ascii?Q?eu6qK+IUbjnEPNd1tEh0FH2JvsRPxQP0FVXf5fiuoPyiBTGqMiDYb7KdKiie?=
 =?us-ascii?Q?Gaof4BBeItMj8EOjJf3it3g/aadNIcnwWJtz+ShE+yYfqd4Lmd8y8pyS+zQQ?=
 =?us-ascii?Q?Aevlkov8ugWpg9RHr0rJJaKq2NOl6mrFWKToQirrWJgwNDtRuSlazq919MCL?=
 =?us-ascii?Q?YjVKLOAkaGoMY2ioOoB5gvqc4H2MPgZNTwCp7kAkb1dNxsH/04zvlosFPVgX?=
 =?us-ascii?Q?1w8sqoC9rSJpjD9ays8ceqR1JbE1j5zBHVxa8IzUsIFRjkl8y93ywryY3ZSU?=
 =?us-ascii?Q?QH5GL2UC7vqDE2pWSZUyDgMkdMPxadDrvu8lsF7rn43CZvAt+omPQScsSgNp?=
 =?us-ascii?Q?Usav8pTtU04hdNKznfIC5PgnxRyZPObmVZ0ttXzObV8Y9Kz0Iae8J/twq+wG?=
 =?us-ascii?Q?sppI3pFfUy8Xh1vmetyXfDIb1GAm4hOWfNMzf2Oj5E4Drud/0/Fa7ebqZRwm?=
 =?us-ascii?Q?1tEdtONHCRBlzckxCOOU59UN6r1wBebpeq5pMbTQ3BbDkQlImOaXPb00PLL7?=
 =?us-ascii?Q?5TK5i9ADxa1dHAtAjLG1Bl2JyqcvPSW8QZ99avjQ8LLPQRI0XmYghuRbCnJ+?=
 =?us-ascii?Q?VDhjQfsIR23Tz+uwnpEKKdNFB0rt4LN+e61kTrh1HNEuE21MIv7xKZh3sDqm?=
 =?us-ascii?Q?uYpojWxaGst0KOmbTOTxaW1Y630Q7udlZZeluIjnRAehQ+okXkKNTqajg1VJ?=
 =?us-ascii?Q?qyH4fxOEuOIJqQwVnW0dBF1Dm0/IwJ8VI8sK3w9OWejgw1U9FMJmxKa0ARyv?=
 =?us-ascii?Q?SOYAxDyKK/xo8wz2rnaYcGY2EvS9qf7cZxjbl6wkNjagrzCPinlEID9qb1EM?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xfL720UJwzk0rhHRRsFejm79Onfl7J1XFuxuQ+iUOFN0yQ0Uwo4KRg/YMAanhoedY4TfQnuR0J9ieLiUVBhw/v38P126NxXiTGhuDMEaUzGgsnKz+Qw6tetXVAErOmuOQ5moUsuWjDes6TJ57jPjEj/JMcfiGDnEgHQirqGteU4gTmgkzYexGkCb8DutlWPUsgyh1/4UfO4qaSuzH3BKbBUu2ePBHeStESL9UmD/xSDBCUloytKgzwoS1X1u6VDmYFksBY5SV4IQpUbtRQ8mGXK7USH6pWR2q/iAe9BF4HalGKWVT5UQg8Gx5m11FTgQKxxKrN/ILEIn2dIy1W98W8mad7iIItNBUHg5Gx27Si+fUv7z44bzomu50LjD3q2Q/u7jQKklqWZe3fILxsZr2WiptqkYBkzhSpRlm0WO/Wx0TolCvfQLUVj1MyqDpxHyK73E6/D9KW0UwG6f+ejTcafzJqNVCgPAA5AdEygGBGmMz/jIz0nuvK9BFs04jyp1hJZ2TpauQ3kHVKbCVlvrghudnZZCLjWceUKdwVszgSKCSNKIZYObIYGhBr5l/56/HkHFPPWaSAnLS6F5+8Ja7jfxZrAuS7P4QBDIqM+61RrezacO6Y4CLkJzEDeOeeT6+OhbSwBgYc3MEJaJLDsm+IAQM5YCrSg5TS435Qfdm7858DfYTYBe+4wax5CZWXAbFTrqrxM9CxKryEqi+Iji7ckfabUIlEWWK9gsS9661ZSa609ab9TaI3RbzjNIgRtlPOwuKLyMEJaLAJLeGCtDwlyX+T1uyF6/wrprK5qNGtRzcfMmrxiOuaIpOWL0GgVEdkzbR2rt9345mUc+WV4nxBylmktJJmzvZoJeDuac6EQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346345e3-03ef-425f-5854-08db8bbed9b2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 20:53:21.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMmBDcbpxcoWkuo5tirNDwjaB/E68HLvK5zwO6iJs4Xhe27L5co0jMws61KTKaaMaT5zpXTfCg9WuQgydGHxFQr1c8Lu3S1Sw4DY/wpKd9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230196
X-Proofpoint-GUID: TtAQyCHFZbyVYs8vEXAzEsNevab3POKH
X-Proofpoint-ORIG-GUID: TtAQyCHFZbyVYs8vEXAzEsNevab3POKH
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> blk_mq_kick_requeue_list() calls blk_mq_run_hw_queues() asynchronously.
> Leave out the direct blk_mq_run_hw_queues() call. This patch causes
> scsi_run_queue() to call blk_mq_run_hw_queues() asynchronously instead
> of synchronously. Since scsi_run_queue() is not called from the hot I/O
> submission path, this patch does not affect the hot path.
>
> This patch prepares for allowing blk_mq_run_hw_queue() to sleep if
> BLK_MQ_F_BLOCKING has been set. scsi_run_queue() may be called from
> atomic context and must not sleep. Hence the removal of the
> blk_mq_run_hw_queues(q, false) call. See also scsi_unblock_requests().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
