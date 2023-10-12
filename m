Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65C0CDB46E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 15:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379171AbjJLPGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbjJLPGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 11:06:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA147C9
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 08:06:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEOJs9026501;
        Thu, 12 Oct 2023 15:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LJ614RvCf/FvT4jGQ5fUFNXsyGNxdBPHPUsVoq5rgZg=;
 b=rs9ew1YeOnwq5B/4ZsMwiy2EYh6Z9/ErScufCQJgqVs8QlrzQ+WyYr8NPgBzbTTb2xUO
 CFxb36zvBr9ZexJ8P+JXgkOt+n3m4PY4MsNyr+Z0PJJOnM7soTgfYVlJWn3DcuonIxBo
 itZpjiLck0vG33ZfoeFtKRSP9EymjR7IjKZXorebVgzn9+Qkw8wGw/MBR9ckNplbJlvb
 67wIPdXa1bCaOBtM407y+uPeGY/A3hCagCOaP7k2JYq+xsFwbAl7OEtXUTZ6qhqde79s
 1xY3zsni8QEYfHEMk0AtLFUEtFP43nNJ6swjGqXkzm5sU4iSGqc8L3hAIcNhL1+IIZ4I WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2b3d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXlJQ010600;
        Thu, 12 Oct 2023 15:06:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsahd7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQQmHG+ufiFbt5lfBl81oAoPuiOXNHj+rxVVp5BnZoKORi/WCSWdUV8EhbnZ78rQNLzz7memDzUOhe89aJBcIg0jBNykq1KeXIeoorfno9rMTqVXusboAZ2q7j1pJuDhfuKt2qUqQTFFESaEKLDA9tx7PoEr6wmyyo9HQ/+QHwBAb/gXt/XSHZQXXvcxpwXzCbrs8xnON9OeHpeQ12lveKKjYoSUJzMLO7bwfTzeoyrbQoi5lGeFynp5/gEvvgKg0xExxP5rOpSxR8kHrzVGx/+z9+DThHRvBGKyrbBIXnbcJElexnfaq3DwvHNXrluofTyOtM3yrA09BHufsP/sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ614RvCf/FvT4jGQ5fUFNXsyGNxdBPHPUsVoq5rgZg=;
 b=E1NSR6gBQiG1fW8UhdedQYG3ZW7PhBaNlGhq1uWVXXl023CuxQvWkDVbBSa0hzXFU6kQGil6p48Epi6e2Bp5E8ShP1QNM00VdfGElGInaJ003f76ErcpQWK10u80bjhbm5rkyHg4EJ7LR3NYKLcvhEW1k9pmJqD1YAjpVbJGupeSUobnvOXSquKP52zDkp3K6W60i3pvlUyMstxs1ENd9JpQB8ACeU+8LKMPFZhHf5sY/3lmy7gkCOPFUtA5VXtHgo9FNWI6xtYg8jM6pS6b91J8t5JMmTQRcmvlTSVlaKsPPpVVOfyvHMYxGvooarzeYAt/9ACZ5oNUA4/EW8BXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ614RvCf/FvT4jGQ5fUFNXsyGNxdBPHPUsVoq5rgZg=;
 b=yv6Dr2pbfgfCqPb3WK48DrDr9QsdO4g3WtLtSDoOarmxu1vuBiiwuMOH+k8xAJigrjf2s/0w2WxdvGw7ydS8et1MXWxU8FsDuzlEGLDN0ZQnAXTu4rXs476jrKeDWTtvh85b3Mvq1TMauDWVivs0tEEPIKqo7Mgq23BgC8aT6BM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 15:06:04 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:06:04 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 1/2] ublk: Limit dev_id/ub_number values
Date:   Thu, 12 Oct 2023 10:05:59 -0500
Message-Id: <20231012150600.6198-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012150600.6198-1-michael.christie@oracle.com>
References: <20231012150600.6198-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:8:2b::26) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d16493-4ea6-41c9-11f4-08dbcb34c171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dq54hWrCUedssjES+Mlz9YkjJGeRoAxF17RBm0EgR0ig3X+uh3E3Suf3qNwXA784IlX0zFEGD5YjM/pBpeKfHHhCtJ7lsWLzkiYZZ3bYgn2AH5WTsjTb5Gl48RoyZfiAkOj1qdie31LHEHzQgcE8sHnYQIw26TYTEzlGgQs4IxaKDXxGFvnw3HRa5IB/vX0IbQjChEnmt9OIUO8XvCC1HdVhLpakQPuh35xI3D4jQyMTKV4Qy7D8jiSM1oa1EirdE5Ku+TitwrEUxC5QGh4d9Bi8XXaEbOxrvK1uVNTjLhvq79mZpdb7/aa4rfxpcL8y8nh88D5oBtZtbu8fWE7bxNbnr4TsxHzH7Y4hav1w9g7lPw91wk9ohPEd6Q4Io0NDMHI8aI2m/b34Mmzj2bnXSFO3G4Fqs5CAdcqET4UlYK7PvT9kJkkEzY7wa72nCgI6NKPu5ibVzmEUd7fmeYQs77asLGgEOzFxK+hN4xqhDIxYLYD7HdiuAt8IyUDU4/4VN/4e+H60+kq7iKJaYKcFugEBkBUE/vAm23KEoEhKbgTP4Vtu/29mPpzF5X2+QyuA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(2616005)(1076003)(107886003)(6506007)(41300700001)(316002)(478600001)(2906002)(5660300002)(8676002)(66556008)(6486002)(66946007)(4326008)(8936002)(26005)(83380400001)(36756003)(66476007)(38100700002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZQRe+GSPKfifwPENbjjWKOGvkapJt1UvRVJb4Tg4lrUW0AsTz60GkV+YaXz?=
 =?us-ascii?Q?6J60dSmROeEKTESNjusbxKZjgMb3cakT9+GDpC0Jf+RjqHkBaKnkQ9Y8jj3/?=
 =?us-ascii?Q?B9BVycAZ0F1x14mdgmIHlwP9V6Bpqz5Tn/3PE8u2axZTaHQDMFUm/7ppYljF?=
 =?us-ascii?Q?VHdUGmzw/e4gy4pxUhYV+Y51Nbpv0wcgOCOmrLPygDZ1I7ujx/uYs9GMHx6R?=
 =?us-ascii?Q?yshUWLhWOxAZnK6APe5L3V5rr8n3y9HAkAchElNJ/k+JgrcasYDu96dOFI34?=
 =?us-ascii?Q?7GBMtmDpj5mevErao41i4vC+q+qS1qTsWDRQHDeN4WwEkP5wyIai3AHW2OD4?=
 =?us-ascii?Q?rbf20JvehXK+IVJuKQLHJwSuN3Jd1Xn3lEmla8lRrKGb82v4WUBT4d8cdSLi?=
 =?us-ascii?Q?FfM5XVdqkVKkjGyNVmP258vAgqHNAVPR1uCjfxFbVXJwH6fqYRxxTJb90NK0?=
 =?us-ascii?Q?NdkgY9mkaj52pLVtqCCrWl4trUeeHoX4Wq3lD3lRpsNDCemwdSv6uLWEEtuD?=
 =?us-ascii?Q?kH0J1jw/je9RbuWnJj0QaysOmWkXwNCAnSQDjEYN2rzaKoun8zvZL0a7KDxi?=
 =?us-ascii?Q?0uqJJLL8jbAwa+XQ6u18cwSDYmpfwZ80/Df9t27NQjJRL5x3AuF8FvFeViF2?=
 =?us-ascii?Q?MZu79rZ8gWJXRg4ZslfkvoTZNrkp02vr0H9Db3TbK2PHDIT36dkP/xNML2oM?=
 =?us-ascii?Q?1Vri6YFvwJIqerstFmLQht8/6PV3GaFcAjGRssL5AJhzQOrdOGwg3Gs+qY/z?=
 =?us-ascii?Q?IrN9oAWThXHW2KKhL76kwNlFoY6atxB85fTPmb3wZZ5IiXG1wy7+Xyw2h78X?=
 =?us-ascii?Q?oHXztLMLEopd7w5UseXCB2KEeSaj23nfpgPuY6nhJbkjA4Rz9M1abcL5/qOj?=
 =?us-ascii?Q?BCWa4w+zhuAicQfNNEnD1jSx7hy0w2b0tFn45Xa9B1r1aQ3Jce6DZ/pEDvDV?=
 =?us-ascii?Q?XWcVSW+w7TSJdRhiJkSzvgxKL7ZwzzCmoa+ZFRNo1irl4Az07cidUQGPnEoz?=
 =?us-ascii?Q?ILZqUWMuBEpuHtfAVLenSOWJTsH6tDNTyGOfWGfrsE+I9xnu9UXnA9TovP4d?=
 =?us-ascii?Q?ucdJWBjBriODo2HHy0jHRjRXz8LsFYolStLEk332xV0l41pyihU9dDNywM50?=
 =?us-ascii?Q?1IWGh6mJvYgcZ/GQNJnmfKVMIbk3eKn3ClInFsxYOpsJtZoRVdYPKVnSrbjA?=
 =?us-ascii?Q?y1+J3PjMTQTh71mquQFYorpOzRK5avSJ+m5lb8Ad4WFhf8snHgRJPBfLxN15?=
 =?us-ascii?Q?5ezqkXB0pFqjx0AmqWCerfXP921rOiQSDoML86slnFA1JUAiYAryIDuvbYh/?=
 =?us-ascii?Q?RmTM4WKrw2zBAYKYnRABxvMihhGvZu9yN4Jc/2Y+iGZ8z3mtmIWj1tmpNu/x?=
 =?us-ascii?Q?dbCV8rVYWcHOFAOUzPBUm4c6a7A3+81pYZwUwAjS3M3mOhO9m0+OL/1sVB0+?=
 =?us-ascii?Q?iG4Vr5n9+Kihdprpfo+dAe3b5zbY3XwkYOozx7AvqR6urgw3iDnO0zox/oSi?=
 =?us-ascii?Q?ECG3LQOPKPNbP3cTSPrqdi+Xb35+U1qdLCLVyPZO3PRDV6uRN/s7wZtbpcVa?=
 =?us-ascii?Q?W5L5ThtFytPNcY9rLiMTXYWP9yHi2USCKQuagcNXZbvHUqIeHzn0mCjbyDge?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 95Vq52W/EBi8RQRxNTAFQXyNP/cWlgccpEU4ntv+tAmgEz0epkGp8roEgxu/fcVuLn/iiajXpwya3DSJk8SA9wT/hjEpmyRZ/Z1XEdH/bH82+u3btqPD1JD+4MaB2yyJ0A5qePCLtjrXcynPEALdsfsGD0lCARTVENU+dRB9nmYVMDfMSP0hHu6bQyDNORz8Y5JemFXtOzUVVxL+lv4EPoDfpTevhm/79IUTaLOrdq/xKhKXyBiC7y0gSYVTh2NgIW2w2Vdf3HhKD33vDrPXtYY2z0gXeZCd94m/+ruzS03nnpUABm5tqy4k0NQ6dTzUc36aILAMYrvJKw4TZG0qafC0B/tK/ueTUscawkSIk9CIAPvi5hqb2LV6no7qTTZAQJVPOcGZWIUHHAo0p5K65hFkM7MX2Fq4ixQcljxqlI5ak4As46vS9Efrm15jdZDTg4cJAFoAtV3XtYCy3TELOEuRgd1i+d+60X7E86D4AHylWmVxmu79mlod+GNu5e5PkzSQK6TFLfAsFJCXSNsVAbTrh/TLBIlVqkuGBUbZFSt+T5cdo5UHnYXAXQC3bA0PBui1q9wmZKm5K6Lx7oZeMHF1liOnzZMlRjOMPoJy+2fnhyyKddiq78iedN4Yg4OH1rRQ20CiwZTuFTUziXws6gIHS/sbklUvGgU/9IprdN1LmGHbBR5X4uKAxXdJfBk8HIahrlizYpApuh4MBpNBoucFOS5Yff/UtdI8f7o3XO8epKgeqOWnHz5jCT9jl8w56HMgsFzY/SANbx4eYkCEzYlimfStuJjfwzhHz4V7yymI8xpivnqzTNGmORUC4cRa
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d16493-4ea6-41c9-11f4-08dbcb34c171
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:06:04.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqiKXRvvXVzcyG8ejdbWO1NYnY23/5SPu648Nkq+cn6haX5rCg50/y+hKzx/l2Dp5d7XEhB8FN8SIMkQBvqjT4lnanIBeiK5YUOOcMZrgOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120124
X-Proofpoint-GUID: j7FgstRGiVh0HfdTkdxlikBkLDApj4Os
X-Proofpoint-ORIG-GUID: j7FgstRGiVh0HfdTkdxlikBkLDApj4Os
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The dev_id/ub_number is used for the ublk dev's char device's minor
number so it has to fit into MINORMASK. This patch adds checks to prevent
userspace from passing a number that's too large and limits what can be
allocated by the ublk_index_idr for the case where userspace has the
kernel allocate the dev_id/ub_number.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/block/ublk_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 630ddfe6657b..ba7c6f9ee136 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
  * It can be extended to one per-user limit in future or even controlled
  * by cgroup.
  */
+#define UBLK_MAX_UBLKS UBLK_MINORS
 static unsigned int ublks_max = 64;
 static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
 
@@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
+		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
+				GFP_NOWAIT);
 	}
 	spin_unlock(&ublk_idr_lock);
 
@@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return -EINVAL;
 	}
 
+	if (header->dev_id != U32_MAX && header->dev_id >= UBLK_MAX_UBLKS) {
+		pr_warn("%s: dev id is too large. Max supported is %d\n",
+			__func__, UBLK_MAX_UBLKS - 1);
+		return -EINVAL;
+	}
+
 	ublk_dump_dev_info(&info);
 
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
-- 
2.34.1

