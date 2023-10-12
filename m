Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC06CDB46E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjJLPGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjJLPGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 11:06:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA26B8
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 08:06:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEOMRH026240;
        Thu, 12 Oct 2023 15:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8pOhU4tmYaBLjQIur6IGw0wgZqSDYPDzuUIoCZdW1ik=;
 b=njaLATdUQZaMWonnJGRj9f8WjhTk9/uV8V7urE6N7icuZ/0vJnAXqGWvtcE/8SAPZUrR
 1/qs6565QTUuRgUJAQ+QhDN2XYSudhhLZA9SzYfHf7QE2bctcFxlg2XPVaQo7jhp4X7E
 /xUa4AOJb7TtvNl4p9hH+wMqz5BqcUu0ypXMIO5HjDjeduA0XtLDPBEhZXdoGAga73nl
 T/Xio/LMSQ8GKIT+bqaQ59eAFAioEaBKIB9wNOBpgvhj0jn/QRGVcQgKkZNzGY5t7ycU
 2FhYUKAJ6EBGBBjdctyJH8UXhGjT0u5MdSv2uZUnXmDEmIoJeMoliGUHbYOoHAMOXQJn sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuu1ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXm6R037425;
        Thu, 12 Oct 2023 15:06:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhtk7d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA5k1ZSArvQqnTTg1o9sQIWwMuYxtg6qbaOABJ17OoPamXxvzWc906z9PuT8/AuvX8iQoxKxKpqpXR9TZE2gpLKvtxUc+PGBHj6iGARWQfQGQcCAy11hH6xjBqEbRkzuJPnhe7v179VAwqBc9MxNjOboqC28bV+znQN0jBNY5KbDdwb2RkbkNn/2UG6WejrBmi/vmC6sojaBm9Ip2zk4g19CcRbwAQQBZQO/GYNgf7U2nEB4O8AucqTgIo2p3TtBjM3Q3W6ged3pvKpF1/spuHu0fnJn+uWLhcRNawK4pduNfbjHZVsYaf1jJwV0MljFxA0Tv3TY9w9U8zpmTQys0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pOhU4tmYaBLjQIur6IGw0wgZqSDYPDzuUIoCZdW1ik=;
 b=ZLACb8B1PrHROtjlyMJzdda1bxEz27mqkEozxloQI0iJporz/BEBhNMvxef5qWforSW0Hkio6hkSbnXBEWC6fgF4f0eRB0aRHbxaxqAPBbrxL2HvHIN8aVS3sGTqA2VhreCAQn9rzbnDVs4Z5yvy5KwXPNuZqFDmYAuRXPr5aHYm9UkSR6YE6PoIbJrJJsQnpmb+tHBxXQPwsX7ODNUOxvbft53HyhAODyRtnBBfanGAo6raovUt29Ha94PV6T7iXBEXv9hzVoshz+EshMLV4K2/Glp4gLk7RsULfz22T9j6y7hglBxfbqjjqMeMYoKZ1bJWATX4eq+svrEwg5U2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pOhU4tmYaBLjQIur6IGw0wgZqSDYPDzuUIoCZdW1ik=;
 b=dI+9q+tmrQTnAdguVCq05smU67R9vIS5i8vvs8JcWhzqHEmPpbF5FgfWh5dH0GOmoTHgCzL/2YRdTmDlBgXYvuprWjJPX6xgVjds+cd8riB6HBAvxusfWaoKQ9Z4+0VhEtNkIdiaufZ5VYbQCxnN1UvVp3yD9OBMsV3ZLW0KgKc=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 15:06:06 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:06:06 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 2/2] ublk: Make ublks_max configurable
Date:   Thu, 12 Oct 2023 10:06:00 -0500
Message-Id: <20231012150600.6198-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012150600.6198-1-michael.christie@oracle.com>
References: <20231012150600.6198-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:8:2b::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: e081ff78-60b2-41ed-5ce1-08dbcb34c258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbLbhups03vcZ9qz0EYaWu6D6LC89PK1J66nqUQKFsloa0PHQz5a62CFligWA/TcphrlYnM1aBtbmBzJOyceSfpXUBS/KNMH3QeLor3tOlLTuB5LpDNIbXNb0k5SABOJp6kZjWEXezSAkeIl3WP7n7pn3pc9JSFuEW7LTQAFeVKLa4zqT8F7QN8mP5WWwnwyNUWuWy+yCoZRyIMw1B+pZE+mNOzSJNFR/MjltC7X9JjTbx/FpLupVkynp62+1RvVCTdJT0hujbA7ABplhlBfqeIYSkM6KnwBaEvZjfB+syWMIZpWy5IpGKM62I/I4W20fbaRCaC26j9gduRJ5vedfoSgaW7JjakIS9Jy+sn9dtBm1VOQ4pQKXKHPz4HaqxpuFDjb9Kj1RQtE7ElBkLuyNK/eu3IFM2ta7ZZpVWScwQklJWAEkq6Upx4aewGEh7BnWx5bTzAi0enwsIHbo/JqE62OxrKtLvxmrbVauIA3LtEEtDvo0CZ6O2sie7biynI9UGseNT2tXcojc6kUGNJGpRxcYEQ6U9H7ywGXJZF8uGUY7037TnpuShrCKmQYLbEz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(2616005)(1076003)(107886003)(6506007)(41300700001)(316002)(478600001)(2906002)(5660300002)(8676002)(66556008)(6486002)(66946007)(4326008)(8936002)(26005)(83380400001)(36756003)(66476007)(38100700002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYqdFJqZWEwqtuFJTarPv+Ujka384Mi1anbvbFoLVyoL4s4OhNZRWpCHoRvh?=
 =?us-ascii?Q?2SAexteBUfwzvYZQhbzfdXVmDe53EDzEy9OWjgLvXxwqLCJjz1oPMUOTNBBH?=
 =?us-ascii?Q?XLz5OVwON4Qw0MiujuZwmggw6PE/yEdE9DKmca3JmFfHey9V+x5C2IyDkHxz?=
 =?us-ascii?Q?lHGqgaEUiHjecMn3v0sagqVWwQttVqIjMaRRiXlA/YRQP8ESTZTVxyGj8VCK?=
 =?us-ascii?Q?AMHxc6jM2ehPyx1KwCIMiKUfPdT7aQ/sBxnZfAuwyt0BuUUjSuSj+7yuk7Kl?=
 =?us-ascii?Q?kF3y30zBks+EGLxTdaYDB4euOWyaWT58ylLmcdxx15CLi8js7soV+iCyf+bD?=
 =?us-ascii?Q?J8Fd/OjOUgSlVMQnu4ydlJPpaFNE0Qnv2Ri7JBqPEAfSbP4F8Rm6QMFQamgT?=
 =?us-ascii?Q?/sLyl6iaiTvn2ipRhXdQZIgrQ4SsnfwFmyRpATfdAtTg03j5gkcAfc4/oC9x?=
 =?us-ascii?Q?Uu7QFaLti0lWIsrcktBSLW3kyoYOuQsw8BZSbTatJ6erC4f2KFxcIJQ4qHqp?=
 =?us-ascii?Q?0sAdqoh5X1PaY9cn/2GCSZMn/1EWkuN4efaylhcHzJ3O2ezM3fokI+pCDy3j?=
 =?us-ascii?Q?PwyTUINXo/9m3TEOrVeaY+DUx05xjhUiFN3BFRVRiwUh4H1hPmbRSSxoQwXb?=
 =?us-ascii?Q?KoWnjd7sThsNswKksU/SWOrD+o+oz3NyC/cMedUoB/LNL2axOyC1IBZ9clzf?=
 =?us-ascii?Q?t3zAL1YUzPbdlTQ+yPM+poJ3hWjJVBZhu4CXW4v0aUoP4vX47FSryRyxZG1S?=
 =?us-ascii?Q?0a1gr+g1eB9EZF1oIKDvLBoIzjjBqOyifUZykOb1/DBqvObgUb+8PlumweWq?=
 =?us-ascii?Q?0Ae9hN4LAokK0IQHmsl3u0cdXN3i9tc317h554EHndiWUXUCgbIcOBRlTlzR?=
 =?us-ascii?Q?WtsEIxuK/otWDCly9UQu7AbO6B6B55hyPUvoBicEqMQlzF8blcMx5+1oJN/v?=
 =?us-ascii?Q?eK9W19oOF7kRaiIzTC8lgo2Mm/HbP8azZ0iYGeV+ZAT6d7oZTjdOLf5Yz6NA?=
 =?us-ascii?Q?zNn9zaLRnwj15Q+JlFZ9Ap66e91MyHeAkqXMwtlXS8HWGOVucpIhIBCTltzs?=
 =?us-ascii?Q?mCIwasZMA28b3v1dTTwYLyROkTQCOip/wYYGayZ5XLVELkZFfsQ0CZMdZ30O?=
 =?us-ascii?Q?fryRZBHVFDUDahE+rRAsUHFthrDtwVi+pDiKdIQZfnsVPbQDNnchBVlPGebp?=
 =?us-ascii?Q?TAuOadOStEpJL2zZp5TJjgynIBQORHQgnO6a6EOwF44+dW1i1zmA4ikSOZ2U?=
 =?us-ascii?Q?NYAqvanbUI36oiWsqm620QQYzZl6CU4LOQu39xq2aqaz9+yyBxuzrIjElUWx?=
 =?us-ascii?Q?zOupkR0ZkzxR2tVCzyRxMg9H/vGwt+guX2oNIpf4V4PP4tjut3iSdNCDXbzM?=
 =?us-ascii?Q?uqUllbTB4YQaaQh6Qv0zXo3nE30T4OtDcqzLZ047foU7yZ9xieQdGUAvoDZ4?=
 =?us-ascii?Q?iaglX4Pfj4FNz3FPivLS/9gWXWGusnp8BinqUKbAg5YvKPThRcFrUxxE+yQs?=
 =?us-ascii?Q?r7CRuoTXlRI2EGmSen511D4fPmQmf2+GWITBbK4rj2X6XpiipEa93Wu3IYje?=
 =?us-ascii?Q?PEp7qT4rg2c0V27Askfl9cOoxju0/BEvtc0Drw5ZWyjWYGh68+QK7/jOrnMU?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yhTrwULzqMyExTnKIT36a6aCEIv1l0cUmDvzjWzXpuG5BIoiOVUnd4EmD4C4Ewr4rwVs0tzRXqHVY3vAIpKwOgdzZYeL+2Xxriuk8cmSQO821sdH4CuyhiZ3J3AhvlzYXgt7OFs3dHOwqccqn5RZHpEQaKubInsGr9OkZhOhBRA1y39KFS/UQAQw8B4jem9qqWWw+Q5+rfyQgcNk4XxIPwJuzbo/y7AJJfF1rrWEFW4gQHYC/VYARelbRQkaIuDwL46FeYwSUCtkAkoIVYhISgXrdDMY/Yef2UFF3uLwRv+k34KTkgJSOHe33b7wIIWwEN+/lUC2UJNt7dxNYGJuMBRnu+fQ6fe/uDSPWVOfaXgn2h5l8jeW8+sd8x4zZRAEWWQfw7vQKsHhVn6lhdOOiWNpWr2KdIdT4CHTAkP3AJ3XTk67h5SNleo1cxwIESyZlzRBuE3aJDKcpAw4KiadsAJkAca8qkBLEkG04bquwhiOOAdc7NQD5LKWyi9pwCwk09t88/oeuQ60hXzI7ijeMCAwlnhBN/WOaJF9H0RN2EeLlOdtBFm4My5PbG4E+I5njDe08itgSExEJWU87cTGEUCfAzkBtviuU0XXfnBLpb4CX6Y8H4TAEXB2y3CcNIkRGrETxqNWMIfkZfm8hrXaw2wSmoXay3AhfoDXwa/vhuLmnda99myUYmkOqAqairR1Bzq/yC+1ud0Wx9pXJ41Z9LTkicYayIvzhJVCb2pUDzAFXnYbaTI0EyB7vDW7gndvVDpOsCFUXo6RGlfywJR7XNwwMFeyUQTdb61Om1tx2rComQtYP9UIroYHITgibM6m
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e081ff78-60b2-41ed-5ce1-08dbcb34c258
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:06:06.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/2UkbdePbA2PV7qO/a4+tx7aIpwXMaaMiLOOxLwL1xUZyvwYXzRq3YvlGvt764dFw9ZQ9EGtiM3KA2TkDkIuT0kKiGqwSH8lMYh6Jcl3UE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120124
X-Proofpoint-ORIG-GUID: 0pKo924kb4np08T9aruUhHVHK7tr6Qzf
X-Proofpoint-GUID: 0pKo924kb4np08T9aruUhHVHK7tr6Qzf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We are converting tcmu applications to ublk, but have systems with up
to 1k devices. This patch allows us to configure the ublks_max from
userspace with the ublks_max modparam.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/block/ublk_drv.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ba7c6f9ee136..b0bbda08ad45 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2940,7 +2940,22 @@ static void __exit ublk_exit(void)
 module_init(ublk_init);
 module_exit(ublk_exit);
 
-module_param(ublks_max, int, 0444);
+static int ublk_set_max_ublks(const char *buf, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(buf, kp, 0, UBLK_MAX_UBLKS);
+}
+
+static int ublk_get_max_ublks(char *buf, const struct kernel_param *kp)
+{
+	return sysfs_emit(buf, "%u\n", ublks_max);
+}
+
+static const struct kernel_param_ops ublk_max_ublks_ops = {
+	.set = ublk_set_max_ublks,
+	.get = ublk_get_max_ublks,
+};
+
+module_param_cb(ublks_max, &ublk_max_ublks_ops, &ublks_max, 0644);
 MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
 
 MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
-- 
2.34.1

