Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F84C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiGOIMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOIMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 04:12:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679207E828;
        Fri, 15 Jul 2022 01:11:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F4jjfX024279;
        Fri, 15 Jul 2022 08:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=AAW0uQoD8OrRNmlRa8e8A6WESg1B9GWhxxBkZXiKdog=;
 b=0A553V7UHVQq72khENHG2aGhY4wzPbR6RjHYGvtFF8ewc50BNdiYGl70i8VTzYZprfsD
 u659PTWp+9wB93U6Ob1O6AVFAOs0lCbaLff/GvYQH/WW8esO9PcHPW0p+Z0k8EKtWNhO
 rjJsGX9NWyN2Ddnj7czyroluGVOUSH7gn4EYePoYByiwcWHpzxEyA88rnqjxPJ9Uavjs
 HmcCuTrTZeZ0csJa2P2dL9DGlhOO3t6S9RkuXNakoiz7PliHqMlGMvHG03ROTiXvSz2a
 BtsoNm5yzEwWVvFM+BMZmZi41dGH4MaAhCNDHlOGJmnOU9BTxQlUcbKZIPNST2rOYppd 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scfbth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:11:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F8BiGR009716;
        Fri, 15 Jul 2022 08:11:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7046q5k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKudJHz/MMR/EA9JkyCFm2xI+nKeruzq0P4eaaaahrDFeRaTehV6WMhBSz6ZENsp0GoKRe5rQHppgXibrMYAwLzoK8tVS9fQT6R3Kwl9NVktXHXMPiTR48+ZvF1vQviwwuZpMfDSESvOmkAbvmgr2v1rg6cC/EkHwXvwMSl2ay6zPz7b+pYfxqwJ8wth4THi9Y1fCzA2YcymeqVVHw6BNambLndqRrtZo/vjjw0vSEgK55DF+M2nSqO8Cmg6cMPCEAuGCqVk/+JSfZ0mw33dVtBFpdVW+aB5N6Y/lZpQn1pmIvWgR1vhoM82Q8Dd4hfCN/zZ2DK7xjd37wvqQvRiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAW0uQoD8OrRNmlRa8e8A6WESg1B9GWhxxBkZXiKdog=;
 b=fjHryeeWaFYURD8QVcUyuZKp5dmGojdWdJmm90NpWOfar32tKCgTgE4sMlqrio9x5Mm//hGpFCait4FN222Gr3yRlAWolsKZa15favcHc/EQv7MOFdv+VKj91tZqDU/fVp+WUvSDai3Cykw+HrrhFwZAdyDvtSr7ZLzXtbV2pZ8PfUSb5+Y8Pa1jK3BqB/w1UOdiMNB9/9fOkht4Wki4LujiJ2SRTFRxrJR7WD7DjNsJGFf3NP+g7L7rRM1mL3YbloMjtPIkKi5MmBQP3L3g+f88Mx4yMAP3S7TxKbF6TtVK8APMWyeWkzrjlbh8eI2AIVorMzS/eqfz6c+x0vlo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAW0uQoD8OrRNmlRa8e8A6WESg1B9GWhxxBkZXiKdog=;
 b=xdN4scS7/OrqddEAZxds/pRxichCn3ynD3cI/L5Bfss1MLKz9xstEPoNEdO9CYVUXJ/IKBC0DHiztiz6xm0YjOunl7LonqkVcs5LC4V3lhDPhQrOM6MeNN9mxmBtEHeC5gOVssys4EmryYyB6TSyAdg5EQCONCR08lflgooTsHk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1985.namprd10.prod.outlook.com
 (2603:10b6:404:105::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 08:11:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:11:03 +0000
Date:   Fri, 15 Jul 2022 11:10:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Vincent Fu <vincent.fu@samsung.com>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] null_blk: prevent NULL dereference in null_init_tag_set()
Message-ID: <YtEhCjDq2oe2SIkS@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044323ba-eb4e-4f1a-2e35-08da66398f43
X-MS-TrafficTypeDiagnostic: BN6PR10MB1985:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilaxIZhNda3QBBw7Mc6nBKnhXDawfmnHj9RpyOYTO4keWHW52cleDDFH94s0BXADTTxI018xELkynBpj7E9Mtb70NkwrLCtcjrQ45ZUmjYBf3Dsq6LgOdLsv64kAkUeAX/2CxR2llU1rMhLAhpVIxfHeMRrs+TAtVqBGTR5Zp+VKeuxPNUcpE9vb6XZCCD+TBEziWuMU8qqHI2QMgltqFiWTHV5UFlujVifTpQKlVRT26Pm3AaifCkgNzcjE0pu7HzH4xZ3mIOMjkSasYzrfy+sSDsHtyuoWFvHJgqDcCLHaEaMsxS1HRZPPTeFxSCbwn2o5GNibK4VC6S3v5J6LTL46ImnIP8Fipt25U5JhHTUMgfcUJ24CixOpPwSyNPYZ2DeAXgyPOdc95yIZE1PvVQKy6LBGBfb8JwtxrWK7QRBry3eP+dJMaopgMhnHlfEh4QPmoY8kSW/C2oVPXcda0sweQm9JRIz+C9z5NLIZWFRS9tINn+Sv5J5ADffiCQvsT2vdg0cEc6FlBf5B9V8nHlOCBVWcfVC5KguMs68LCFCKrHSm6q+s4r8mcNAUZmEJQkwkjaddORrOrgGfd85ZmMShrxh8EOBDnYzDKoPSsihOXDctB1oUsA28R3k7qMD/aLaD0LLL/A2lXgITC62el5daef6D2nTEJT4Zv5AQweepHYDJ143074awNMF1NY0G6wD2jkCc3Tp139XvDC7kOY3oVy3SI3/VkoxMLJaw+6sVmfkQbQFwlMF5/hd7rB76mZBum9wyabrPDvIP8iQ+P1DSluqZEU5GeZnD3GpgLaCJqhf4xUUpN5cQzDCDMQ8e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(478600001)(6512007)(52116002)(6666004)(41300700001)(38100700002)(8936002)(6506007)(186003)(26005)(83380400001)(9686003)(38350700002)(44832011)(8676002)(66476007)(110136005)(33716001)(316002)(2906002)(6486002)(66556008)(54906003)(86362001)(5660300002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYGB0iXajpWM9rorBBsRGVRxPjKMEDMnVdvLsaFv+m5HRzGq6PN0FThIH1rI?=
 =?us-ascii?Q?X4nmRctROJSzT4bOnkkD5zyqYoojYk8atWK99Rz/yrGBKO1SHaJ6zu6PxuNU?=
 =?us-ascii?Q?EUevI8kdXP5YiQQ2HAA3wQyLkKjsaJoeni5TuIo/rXBK2QD/YsbMicJiyaQW?=
 =?us-ascii?Q?j074z18GvIGnCeojIov4oyNndhDFtLhDmF+Pl13cRcJE9QMck+ksoeTSuFZL?=
 =?us-ascii?Q?Hhp+60sGDrwv2oBQb3AiS2vlsofoDBdNjeg0WPlfWDvcoNndNlOo6zWKiwR4?=
 =?us-ascii?Q?2utY1/SOwf3wfpb91OKh1HWUrJSL1I+3qJVNyS1v86W+Dcx2gMj8dhzBt/zE?=
 =?us-ascii?Q?KN1Qqu2zHIgcS9E5R1xCbs61/rolyJRghUe1Ze4PoLjccSgbvXCVvyRX+ZYY?=
 =?us-ascii?Q?nYyQbCRUFVtb53eOnEF/bzUkxHSIv3fQUqMsAT3Ou622c79vpajefmGmHwPr?=
 =?us-ascii?Q?GOPHHnmxHriK08g7ZxIb6F0dkZbv+JOFGAdSIVFosc6Ni0pyCfVwhp7scAnz?=
 =?us-ascii?Q?F8TmnOA9fd1ArNuulqp1sELUp3fawh1nCRjNLKX9uKEv3b5rJdGVP5hUqDT3?=
 =?us-ascii?Q?YVPLC2eJ8oWdT5a7IEZMfhJ6C1pd6fDWlMW6MyC3GpH4PCr77F5QSAGOAR5m?=
 =?us-ascii?Q?4IAk70MKHCZj0tpp/WRU8iIzZHDKSSTpsZsgQVHjXNHhP++TUCcmKzLoPb81?=
 =?us-ascii?Q?lRo7riYSwCvYTHoGpJi16xCHXm3BuNFgG0cdz/xcJnqeet7wbsOJIlgqwxeJ?=
 =?us-ascii?Q?X/uzNRx8fKUwaP3u7JjEO1TZ/7RHndJJjB+MVarjQrvmPI1z2pqYGZi57qZ+?=
 =?us-ascii?Q?NMS7ker0bNRY17ZocJA9MJZ1o0eWKqICJsfGkWhkGjwsY7MeaBj+SNqdmuvO?=
 =?us-ascii?Q?8SQs2CnmOTAg6bGidSwxxpBc7Jnp0Id59EqnIp6EjZKCe2eqW6iguaNS0kt1?=
 =?us-ascii?Q?d0nis/gUznhphEqDDjT+w13tXiAf69NXoy3VatZr7qkM4P9gMrLvhwcnah7X?=
 =?us-ascii?Q?K2Zk0J03ARrB5yTyUqFJopGJxW1IP0B4mqmFv7liRt82M6BCoV2hoAfBIDgW?=
 =?us-ascii?Q?SvlBdg2bGa7FhZiqBDezbdhGT9voCkvJi5MIRtiy55qENNVvyUzpYsbuOugh?=
 =?us-ascii?Q?LaViMbXys0579Lt7541GltuVyirqaM9vkwKIqLIqmAeko9ytXyUWc4NsVOjs?=
 =?us-ascii?Q?6IfQhhKDtaJLI1qPQx48E6c1ZC8nHyj/89wEJOx0h4q5h/u6IotGn2omvw+7?=
 =?us-ascii?Q?TDH3MCBP2ZHofTy3nxoXHqeND/QzC7AzZuBSSbneUH8wkrNnfQFVPxmJLGtw?=
 =?us-ascii?Q?hlkWLzbg9HADCz/+Xqc9i/J4VwZgmk4MTFOillXFv3NejUZZHLNhvcZ12K6s?=
 =?us-ascii?Q?RLYxx1SToyBA5V3DIr3JZkvG55qshNO7LQ34GfSNXnn9FnyP9bqyBMQ8OXDa?=
 =?us-ascii?Q?8Cny7gqCov/jGe23wrOA1dZfiQTbXQK8DxgX9030YzqkfTuebnheu1Q/xDoS?=
 =?us-ascii?Q?w4tAKQll83QH1ZzqF9G2xRCzah7m48z8mbFGwWMaVM8vL2ImwVitif7v0tN2?=
 =?us-ascii?Q?QTcYJtj7qh5zmm7lteisMjOzbAz8JpBB7zXZdCAzl/MDa+hUUgIwXE22gOH7?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044323ba-eb4e-4f1a-2e35-08da66398f43
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:11:03.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPvyBvbv4Dj04pQ/Tl3yQg7cby/V2NbWU0uFaaX0spFG9VpseOk6lou69kWgAZx/dnLnSYH2Ij7IogBKM866m5DiTiJqZwvPLSTjyU+N8H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1985
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150035
X-Proofpoint-GUID: dZGt1sU2E5oOib5mn9xWzUii5HE_6-JF
X-Proofpoint-ORIG-GUID: dZGt1sU2E5oOib5mn9xWzUii5HE_6-JF
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "nullb" pointer can be NULL.  Smatch prints a warning about this:

    drivers/block/null_blk/main.c:1914 null_init_tag_set()
    error: we previously assumed 'nullb' could be null (see line 1911)

Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 67c17e5d2c99..016ec3a2f98f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1911,9 +1911,9 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (nullb->dev->no_sched)
+	if (nullb && nullb->dev->no_sched)
 		set->flags |= BLK_MQ_F_NO_SCHED;
-	if (nullb->dev->shared_tag_bitmap)
+	if (nullb && nullb->dev->shared_tag_bitmap)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data = nullb;
 	if (poll_queues)
-- 
2.35.1

