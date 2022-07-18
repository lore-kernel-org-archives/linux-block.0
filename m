Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 11:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiGRLOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiGRLOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 07:14:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988223896;
        Mon, 18 Jul 2022 04:14:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4X4H029439;
        Mon, 18 Jul 2022 11:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Q8PvU6X6YA6TpvEazIojhDdlNr5ecrtoSNymode+Cik=;
 b=QIsHl/eWvY0+bewVilwt6NYuTHG8SoLBwgxcvj4mZ2hA5VTrXE7P+kiRm6GW1hFFwl5x
 LFYbYyf0HPhVuc48RdqMErVMG0M7NnWnScduChUNv9ODejfxgD9bJ7aOIbB1JFUMiIL6
 d2DamZ+8laORYZebnKNi3Mysf+Ba5fBGeB1oF8XlATtYhp517j+YrkLcg+I5UPhpsr5R
 Sy/Oekg6I/BPTO/sQj6HQ4PCkCsi3EXorH88YumLZHOQyFLN+OhbAZs+HeSFkjnDZkrN
 bY4ovT3UX482lfRti3PyTz5llZQ80qQMhJQ34KNyQi9Y4vB8gIQDiWbjAnWlIYwQq7Ho jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0u106-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I845XL002077;
        Mon, 18 Jul 2022 11:14:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hqwev4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiboUjqHniBwjhTcvaWRn0BS8hGd1w55YjJC+2n2ifn+IFhW/LTd345ubOJ+uWWyseSXODuZPkbpTRhKgUxvxV1IO/IT/joRJXa47oa1EKv6YUIOSls66Qh2EmFyz4sgdfu2tgTFSuRWraNYa0YE8AMm4PY6D5VQ0vdmlkMqfd7QNn9S+zjepLNtBQDWq537fKwsSAmAQqto1lWsc3sOyOG5Q6KD5gmfIoPv65Jstof9B9KgUVaoL5A7hjGKsWqCiymL8Zqegftfywuow3rQbXkeiiVZ8/QDu/lJkGaVLKd691s4sVmi6eYVcd/xDkSe8D+EFVsqA1ddLX/lHKCk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8PvU6X6YA6TpvEazIojhDdlNr5ecrtoSNymode+Cik=;
 b=OTsrQEzn8JubscMofw0mAnCj6M0/0W0ZjNxU2mmIw7FfLFgYjUv9DfG477vyPTHnxltv/AXjUIj1eExF+5kvdMxImzIQbnmxEoPEumf7im+ynck3ppXaRkuA9LFRwuHho71BW/mLlF/YEeJZm0IMEiVPa4i95MaJIjsK+kX8KJVR+WeZvJERHtdv2/wQxxiiK4ywUYM2hhOyYWSgWQWwtriRWRyoO2Qz5DFV2pJZKx/CT2ymKIlezuDzdlAKL+IeVe3peXPWRy5PA9+1BsPo9Ft+8NHcIndP+fVzO8h8CfuWuHq6NiPEA3x/FE4XYskg3D64Poa/oStHG5QD+k8Mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8PvU6X6YA6TpvEazIojhDdlNr5ecrtoSNymode+Cik=;
 b=V5y8Xk8t5mzcyGn84e9Y3pAh4FaoeitZvPeV/bNPMnkZyzZLJsM7dgSFf4gOumwM1T8Ccd2P/JMEkUkMByeAE2PQlErYvBIrehH3IqpQ1fFJ9pBd1hONVKFaSOlCjuK5U0QdfJfYiYcNePTRNarzgyjMpMXGV4HV3KAPceM2YTI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4757.namprd10.prod.outlook.com
 (2603:10b6:510:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:14:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:14:37 +0000
Date:   Mon, 18 Jul 2022 14:14:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3] ublk_drv: missing error code in ublk_add_dev()
Message-ID: <YtVAlDAfLLRolN/X@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe63659-fe26-4465-4f77-08da68aeb381
X-MS-TrafficTypeDiagnostic: PH0PR10MB4757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTxpmIOn9TFOy72mjFB+FTFhoXhyTCuQw25lg13BafJgRx0JDzPBgpmSxTUeS6TUMf9PFt0GW2mOGr1gLkbTRSpDeL+GgPHISeNr8ZxecWkq6Yydfd/JVIO332QB6L6BvRfWpzcH7ANSWq3Zio2XWbtDJIKrf+Jbmdm2SPMF+IwuI0ly8CftyN/ST2Tuv9zm8mwiZ/UAuSs+jwpvjgTLIAxpUs/R1K4j0vYQM13AtVpJ4D9m9cdWJ9bJN1OlUf43oJfYS0R1bN+zNoCPREOuEFv1yiHTVTMOvfGx50h0GvxqCann2ZCQ8fuB9IR56eUhQCZJjiIVA+AZq4SXhZGnBBu9AWTV8soQKOEgUkzJmHGqYUF4H8pAgpXoClKckamiGOhcihRt0rF9LIuW3Drq33n8XIRs/xIcUCMhQJn1Qrzl3lKJhLHGe7GiN7WHCDH+haBJ8C+TU03N2+T9plt5K0AwdEhYmbhRHrYlGnpEDTypIx9bG61nfI55pA2rnhNzuhhktBOcP1Qo82Bf0D22yelra437qgs1EAEd/vrxBZYCEj2hOyj150aLF0MyGG4ofoShlNXQgtfrQCZ1/+3CgKh8SIgXwFfV9oTLiiS2o0rb5Lg6ToV2jlkqijXIFEzlJ0cAhvRTZDBxBzclPzasd3SiwPd2vDJR67WD9FGOPvXgdsmMjxmrG4ShdYIcsJ5exIfOKi38TMm+CrvmaIEiN4n/TaNM7R2n+cTnYBxKNVjofwQm1eJRx7DJU7Ztr3WH/5fMQ6uOwQ7ute4yFuroa4dFzxyd/Yut1ZZ+wJWqaQmrcL2+L8t1XSmhAvsjvS76
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(6512007)(9686003)(33716001)(52116002)(41300700001)(26005)(83380400001)(38100700002)(6666004)(2906002)(6506007)(86362001)(110136005)(5660300002)(8936002)(478600001)(8676002)(38350700002)(66556008)(66946007)(66476007)(4744005)(4326008)(44832011)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCaVkDBT/F/L7MCH+lC1FCqdxWqju/ToGcWjC0KT93faMndlMzrbLXgpuW26?=
 =?us-ascii?Q?ZAKSvinlTxNEi719iaXzLdt7kJyx7yN1aUF4W1xpo5s0YiV1tHK7W8o8ID75?=
 =?us-ascii?Q?PUwigb/lT5T7WVxRuPFf2Lhpgzq4ImkPCqMA5D+ZGQsRp6j0E8fEGrh0cpaI?=
 =?us-ascii?Q?nIIxyVetencBHmHGPFq2Pm8PFsegcNokpTBU1DqZG0Cl5bSXwCIpr6+DtrPV?=
 =?us-ascii?Q?Y//4A0UY0SLCWI2ZKlWPvfb53qIxUKpiMiur+D1r+z5Nn/yX9wNQUPqWWb5z?=
 =?us-ascii?Q?HaaTr0Jt7/BtC39ugEsyzCYDJuVMAJVO6SLu6OUfNBLtZb6m2knwRKf/o0iF?=
 =?us-ascii?Q?McbneUVY9ahoNh4J2XARxyf8uVFFWRRUon7Yf7AzNLyF5OAiXQ/OpXIcfhzt?=
 =?us-ascii?Q?bh7Rb3bT7f7BQOqcVGjg6x8hX1ihxZxVpS3FbrAX4hhzX6+pQYkqGPtzQQJS?=
 =?us-ascii?Q?UmQ3KlA7mNXlmkez/mzUuaCPQXbCmxAwp62WeSx4DJuDI4P2ok2ToXXpnrGu?=
 =?us-ascii?Q?OQNIGmXylvn9v3ShgZ1ShJqinxjEqp077RyKq8q2Jo1D+dxMO+At1a/ExEB/?=
 =?us-ascii?Q?ymcP7QW/+MGucnYLRsBucWH2W+B1CVDljRHGvZ/Vm2K04bGFNqwoKMjZiQb7?=
 =?us-ascii?Q?XVLndZr9qddXHfkXyKkpV+eq68UY+2+HPjQF/9g+V61Bhwm0oonim//cQAjX?=
 =?us-ascii?Q?QGTb8W5sEUqUGfq+O6W+R7GRIkjTCsCtjFl4uWSpZZ0Iq5HFfVeQfPiK/m/q?=
 =?us-ascii?Q?rqFN7qShZE2+nOn1v2k+4tIGPxYyAtGGTvdaBE00rVSrRhoTGdS0S4AaRyM7?=
 =?us-ascii?Q?I75pavLrkjTkNw0aZKnnaWqR08QVie8OMhKegFZkUlHaVagN9SUXz5ImQuiV?=
 =?us-ascii?Q?dJMVIA48VfICn76TjSBSGHDyVKqnI6PoG5qdIEuyIOLGVmQt4TgUIjel13p/?=
 =?us-ascii?Q?g+nd+rYgcLo1EL5wRvRgRlU1Yco3I3Jyt3pwHPcXch3nnxeUWf5LjD8Cm/Mo?=
 =?us-ascii?Q?z5e8lzCTs+rJsxUx8PbhI+ZQxBpTQkrw9/sqmll/jTCcyRZKw0oH6GaDfkgV?=
 =?us-ascii?Q?QDEOTpDb/45hgUDS9JeLtjdh64VuWI7PQu36HEoZ7txnDfU9nUzHM2iRcUwu?=
 =?us-ascii?Q?Mj0hM1+pafLYg2dpLVwlD0emltCKxkzgYD4JX8wBNpP5lHJA97G9cIsxbEyk?=
 =?us-ascii?Q?VllRLoAOvdG+csZBInUqC3lcksoFM929tP1BC4DOd8hkNLuhS13nvrrW1a0f?=
 =?us-ascii?Q?SJNrfNd+jG+f5NSpNyeGF9M4NlleiaAHhiS/OBZHJQVZDOp9KVUfsYQfVg+O?=
 =?us-ascii?Q?1zm7oWTWFIlQcxtRvDQIfshy7EJnp/C0woc01tZkPAG+6Shh56RHQjz3D1BV?=
 =?us-ascii?Q?EFFrh1ZDDGvFH+U358qF8bHbZw6vFmebkWDSzrw7vQIEQ6smTFgUZMTLbgxV?=
 =?us-ascii?Q?bIXJ/fIDhyL3f573W921u7aLTkxJyYD2Bn/fWSn9WKhFecYfEBID7mdYe9JM?=
 =?us-ascii?Q?A900F7m27tqz7vn5Z4MM/S7O+zdiuwX/v7Eq6NGKZHINdH4WfTPzRf64zhmR?=
 =?us-ascii?Q?0I5+Xy0Dm8lTjg8BXwfTMFH1DdFyQLQYoWZox47+D858g1LLrFxPU1KpBwZY?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe63659-fe26-4465-4f77-08da68aeb381
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:14:37.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo2eof9vvwjl881RjcyaQa1WeHyiTH/PXLuYyQPrib17fAQXR//RLZh1q2Zrd0VDMPSmdrCo87yZWPKeK5qmBsH19vL5craKWtu4Jwtupe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180049
X-Proofpoint-GUID: OuWOVK_kNIydnnsoO4SXn_sMIKIRS5ic
X-Proofpoint-ORIG-GUID: OuWOVK_kNIydnnsoO4SXn_sMIKIRS5ic
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This error path accidentally returns success instead of a negative
error code.

Fixes: cebbe577cb17 ("ublk_drv: fix request queue leak")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c0f9a5b4ed58..332472901ff8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1169,8 +1169,10 @@ static int ublk_add_dev(struct ublk_device *ub)
 		goto out_deinit_queues;
 
 	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
-	if (IS_ERR(ub->ub_queue))
+	if (IS_ERR(ub->ub_queue)) {
+		err = PTR_ERR(ub->ub_queue);
 		goto out_cleanup_tags;
+	}
 	ub->ub_queue->queuedata = ub;
 
 	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,
-- 
2.35.1

