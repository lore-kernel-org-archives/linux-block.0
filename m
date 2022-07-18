Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF6EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 11:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiGRLOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiGRLOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 07:14:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA0C100F;
        Mon, 18 Jul 2022 04:14:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB3wlF031661;
        Mon, 18 Jul 2022 11:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=JJd3ujgoVFu6+8fH9V41njZNVSc97wTTTX3RPZwvasI=;
 b=g1ckdfapZ5ALET8FztHPAbPuvpjbUazKqCmfo0gfszB1G35jBcTASLxGk0zXuQNXk1Xd
 vBaMJRixkkqEucr17/l5SnD1+Xbc7u5AVHEcPPOE2g0T3JIvMWk9sSDXOOJAqAQz0fhF
 jUR8PzIAqEJ+nUNR0g5sl0GkA0WKXVCVfaYLJl7vRfRp/++2HzfjyaluSgE188ZY+BA+
 TJxResszI5KrMMzikBJ3dmfPFT4ROC53RVPKWYW8sk8BDVkKv2ETmKf0S6jBg3J7lSaY
 xgNvnBGoUQdiR6CLwBFYT36yVnOZtD0SghXFxOLwMhtciG67r2gDAC5kbAhoHpA3p05m fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs2x28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I8HSTc007936;
        Mon, 18 Jul 2022 11:14:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ekg4n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELaQ0cPR+zg3MquLPqT87ElRPlOvn5Xj3z4sTNLRoxjEkKVIpBphA0chZXGq2lTtCjVZ9rBkM9QPX1wwPfOWpwNw1CB0Vqvg0O2Nlyga94VDQoiWMU0qJiyj+fXH4QIQ7X6+058uOly91WvDZjJdzRWT/Qm8MlBSv5Mg7rBcAjD8NyRnuLE36H64Y0BjEhjCJfiuCVHd8z/O5dwInl4uP36ZB7BVFAWPN0LmJ9zVNr9IX8F6z0rBatfGpcxa2TmsFc830D0KPa+P+ye73dLTzTxYfgALUpee2StLvhx5pC7H5dAqMd763+L4vWyNnAqT7k2IEijcPbBzAyqpPa92KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJd3ujgoVFu6+8fH9V41njZNVSc97wTTTX3RPZwvasI=;
 b=JbfXtt8jWk3fQMXviKMEY81KUQ+k8AWAaPhbvje9W4LUa4sbjzv0z80ugDrSgJmm8mZG1AfgrMkYkTW8s2JnVyhLOewWSH5zwHaP7Vbb5d8CZZoSF0wO7ExyUOugIkB5fHeOuzxEVqrhSu2mn+WelfrOocZY/doBbZbVPZJHSLwnSNHnDAMzuzixbggJQ3YUV1DBZoVQ3DJlksw0ToRRQLWraZX5oMTRWEP6JD4USDMb2SHd/zvfBM3DK+feVJWgMAWW2N+auVhp1jM/4veB+w238im1JgyVHQd9pdwcaAz0QWrhQC5dmpqKlv3Y/EZmtZruG8D7u3gXPmR2toROpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJd3ujgoVFu6+8fH9V41njZNVSc97wTTTX3RPZwvasI=;
 b=RZ4zVs5iw65mK/IFDJvjYLfORmPXHoySMyfWM1dQRiT6MVkran3R8FB6z5Ey6VPI8vGeddH/kP91hvhb8BIgtMTneW/LpMZYZ1bXlPM2/VY0DuqJSgBU74ZJxiSrnbBH4BtjnPxkPkeuhKR7O/MS7NYqgamSQJFSVbBhbZSTkKM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4757.namprd10.prod.outlook.com
 (2603:10b6:510:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:14:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:14:28 +0000
Date:   Mon, 18 Jul 2022 14:14:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] ublk_drv: uninitialized error code in
 ublk_ctrl_get_queue_affinity()
Message-ID: <YtVAijzg2MTzfMnh@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82c36ec-b222-4c9a-e306-08da68aeae47
X-MS-TrafficTypeDiagnostic: PH0PR10MB4757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoAvg+w2iK9KCju2wcepZJtWmcc5Lhk03koCCUdPnTmP1TzojNqaF7SRvHDNjK7aGvHaBXTN1z1t+9SZSUIDFCRNWuKc4cSHijKxsIKH5EzOWPdDuIN8cDSdMFdCI4+9sKzexmRAzqFHKR/hJS+9xlCbGyajob6xh1Ca7qbZY2rN3sEUlowHOliHmCWjUUDpLW2B6Sh1mUIE0iAFezis44X5Jyho3zboVzvozF2qeZwDH5jM+fN9VNZk5rhNDPaf7KeAotcCurzE/tYiHbPE6L6DqyUeoG28x+6sm6+vGIGE94CfPu3NCXGxzIWm4rxQ1/DjulY2PGTlAKsnEPo4QZhQIphAx9xFjSZGjk15F88kApYV/CjTp29QhxnHQGLRmKfN41YmbJQribPGEMiKo6lM/MPGYrqr8udfO7VtEwUoLRNmE4sEXupckGy7Z/9qXenWxFjd+VHdsvSH3VPbYhDioa0D/llJ38sVUVqZmiT2PKtzCWtZzPqWio7LGU377khVvOx/1uXOZOVs8AR1cae//oivX9GYXCvKmDu71ux15VHujH7L6t94ojBBDmRYgUBcCqwdMwrV7loisv5zzCnuwzCJeuBNWKog/Izop8qaPlRxvsm14uOzmgaN7dKKBOfEKXm7Tz8/7kP/w5h0HF9tH5q5j4XwgzFi2sgg0SNAXmqfuVMmd1fjHVqLj8Bg6fyM6WBIVzKqI+l3QG7LBg2IL0NRqMColLtiTsoT0GaRa4GRMAaNMdz1oiSqpB4gQzcXa5fMciqD4wMiI4YiQj9uePPironqllqniHPJ7mZJO2xMa/GK7vs81CkBUbpM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(6512007)(9686003)(33716001)(52116002)(41300700001)(26005)(83380400001)(38100700002)(6666004)(2906002)(6506007)(86362001)(110136005)(5660300002)(8936002)(478600001)(8676002)(38350700002)(66556008)(66946007)(66476007)(4744005)(4326008)(44832011)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Nf35VOHkkIcAJSIDe3v9054gJ/dWoH6BXATP3MOtH1PyD/ER7gqMaDWxJaT?=
 =?us-ascii?Q?fjyf1KWxWGBpCqV2LjkWy+zCod2J26TpU/+2uiZNwi8f76CaFzo3wFk4IuYb?=
 =?us-ascii?Q?X+xNbP3v2kieB29OIfeASLFHAzlZJZDlnytsQWW+XpFsuIzdvR3ljkzIxOBf?=
 =?us-ascii?Q?SxnMLs0b5Bfvm/tGigKuONovS8cibZd64H+e13KM9ts8hl9/E34SiHSrDwWn?=
 =?us-ascii?Q?zLtgxETr5N4EuD4z1RCX3KtgsNGiQiK7E1adhSLqJkpdvGX8s/8yCy8jxEAP?=
 =?us-ascii?Q?5F5uQMOjQ70IdgzAL1EeNjjRVKXGJDySN4MONjqZxbdqpQvRuBXgsv6lTa7T?=
 =?us-ascii?Q?gvvYEQcMtYXqCwLsPNbnCYP9Tq3wtknDKFgVg29cIk5sifc31+Xo9oAh9eJM?=
 =?us-ascii?Q?MRQPCr4dme0iVzFqqSGvEz8IYLyPViQi3j41TTEJ6QupK7fqmdWLcALfCe7c?=
 =?us-ascii?Q?UkNFMOAncMkmiURJqBj2CYhpqYDixqvSDhmBsS5I48crXX1T4T5YhpwAXuK3?=
 =?us-ascii?Q?jJuZWehjoIu/p/xSAbEtme2lrb8ED2405tdK9eZ6bf5uvSionTjQZLl11h3P?=
 =?us-ascii?Q?ZhYVCyfBTXUHcT6BSHC5lLsN7tsNYErUtG15i5ET/PL/++BCRZwUSrNUHgPr?=
 =?us-ascii?Q?ebL4sGnvAgFBEKrU5lPV6gx7boW1Kx0X4wEsaSvyBYagekQFBuFTlyEvgnAN?=
 =?us-ascii?Q?VAI61QHkwKWx90ewC72/tala4WoNVGij/1msgraYFqAm/7/ChCD9lyKPS+3R?=
 =?us-ascii?Q?vPRSy5oOmrEN04Z2FrJnvh9HV7Vx/z3S0TOQZuWFGmvhpEpKssxB8QUmzs1M?=
 =?us-ascii?Q?OdIyVeBhSDz354pQf6SyHnFPYgDLquxMKIAwJzvr64DaSS8RpBsdpjjFwO99?=
 =?us-ascii?Q?0YglKh/5z9b5kHYzhPb2NJs1P6DfVL7dBx6UhE13IsVB4SkL/4zd0tzdcbd7?=
 =?us-ascii?Q?x9lHIRV3sQ9/tyfJGuCU4DEM130AH12Ld6dR3uKZYFbnrPQqwxXqOrkkjQMm?=
 =?us-ascii?Q?3L+4+VJoOjtfcASvwwLHTlJTmdpZTCMwISEDvdwTigcvaGL17jcmP+Ud8Toi?=
 =?us-ascii?Q?4u3Bz13Z2yGR4+aAHbIBlzjy5kgKYbqS7Fvy7rdvWHyNcsoKeMfbdb9KEMO6?=
 =?us-ascii?Q?HZQOMAW1Qum1Mmr7B9eEoxGcVYTr7ziO1M9EYTWeOb3jq+ZIxgMtoJCKeiZ7?=
 =?us-ascii?Q?6buGZoqqg6giYb3PkjakODf+3XHYO40BooIO2NUIDAVL+bxEk289Y2JzuhbU?=
 =?us-ascii?Q?U2c+Haf5FmH4H2OXGbdiMnCnzZTeynTHGuWEL2I+Y4t+6iAJSilj4d670RLr?=
 =?us-ascii?Q?daxNHZwyzcGAJzW8jFyHiVpambtcNoWftmzRGr/Aogz3KM0jNYzvEwYEe9Yr?=
 =?us-ascii?Q?aMyhiOIgFxI6PD+xZXnBxahM6KitLRtat/3hYgTisPMaa+9NYoDJfITWeEI+?=
 =?us-ascii?Q?00NoZL83CZ8JQNgMBV9kINNPyvRg9z7fzR1ywlwqcTkPH3pq5LaZmwkTDM8Y?=
 =?us-ascii?Q?XyqCjIJcLH2Sn7Lz4AEjnAN8GYEBMHOfbBJzGXcI1r/O7JSoAajU0yB3jJ9+?=
 =?us-ascii?Q?a5DJBcff5p7jbvdppQ9D8NYgO6w6865DFECLmIE0bgf1izqOID8H0RRr+NMK?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82c36ec-b222-4c9a-e306-08da68aeae47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:14:28.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmftyONeD4ECe8dncYNzv5/L5eC+LzFfVqD6yUAYAUUjvxiX8vHNwDwPttbXZtD/9KvWGS2R7vVQ8i1DJRkry5hWB5+xfPw29uAO7OF6NRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180049
X-Proofpoint-GUID: prridjUFBPNvUohz62zb3cVvtXm3ITS1
X-Proofpoint-ORIG-GUID: prridjUFBPNvUohz62zb3cVvtXm3ITS1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Initialize the "ret" variable so we don't return uninitialized data if
ublk_get_device_from_id() fails.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ublk_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 97725d13e4bd..c0f9a5b4ed58 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1298,13 +1298,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	struct ublk_device *ub;
 	unsigned long queue;
 	unsigned int retlen;
-	int ret;
+	int ret = -EINVAL;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
 		goto out;
 
-	ret = -EINVAL;
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
 		goto out;
-- 
2.35.1

