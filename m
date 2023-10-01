Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BDBE78480
	for <linux-block@archiver.kernel.org>; Sun,  1 Oct 2023 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjJASzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Oct 2023 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjJASzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Oct 2023 14:55:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E0E3
        for <linux-block@vger.kernel.org>; Sun,  1 Oct 2023 11:55:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3912icmb015517;
        Sun, 1 Oct 2023 18:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GwJG6NHRsSD8Qkl6TGJnRA2qWKES0des3OCGoTN5XpA=;
 b=p1CQgolxM0/gJc5Rb4Ck7iQQOw9jmbk2QoeRTniVuLwehySxHaLtcZ4+jN06b2vUstzQ
 c9AriG6MMkdlsIIcycIw61n8hMdFOsCWjR4i9amjwRQvH2Q8s/umVzfkLmjje0nWxYMy
 nknk3A3ZJqiBpNqvFkFHTvwIjrcaQqn3OmR+EF7iFTE7ouv3oOxlTLM4OUGFl+REGvee
 I0e5qQ73KogQVeac+sMZf8OoWZ3mxs2iKcBovadTqBf+wRwNstf7kh34k/pvQY9eZE+R
 M5M028x41Y2KUMsj6Bxbd1+csRF2XHA7CwS9eBWA3ZQZtN7wcn/ZqXkNlyQ4iOScOMSg wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakc9fgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:55:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 391EhsvL000731;
        Sun, 1 Oct 2023 18:54:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea43t3wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzkmChP9c5gyBMUksSrsrSzrQtzKo9FAM/9i3mHCXW5RM3NjeEfRNM0j2EryYnsiKhnRoRo0ca+Dgi9gbe8NXOE6hFRIUov/6mcqDR1xGwt7KBOD80f5hz/g9LEyemBXzogky8vPRDG97iw/nxkHlklqEy265iIzW9WWda1Z9exwiR+zA1CL5kWRNOmNryHqVcs2I4XyGF/yLhxfZ0dtfXQVWB3tEb8MaNbd5mOghFwgRG1EznSsy5VrfDHmhS7c7oSSSebgAFvWNSQIpHToQrDAhZeXth0oYuL9NVVmAaXgxqMCNDM7PD/Ge5YBQo8VvGGikdxvLx7HhhSXcVa6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwJG6NHRsSD8Qkl6TGJnRA2qWKES0des3OCGoTN5XpA=;
 b=N4CP9CVcfSTcSnWQLMw0k4+vqUUnqJEMeZeoOEwoD21muZBIbTFxZ4bpmUIUTSPhdNv1xuFaZGSMjM07faXrFh4lKX+v61lt1bXvWrE/oAHauqrb0yzuthvSmJn0q7izP18I/utlUPPYT5scs4kGq9hz5zWFcIkYpAB3Z+Z/ITwk0Azvt+dHILlokT0cGdTGrGLSMg6qq/18Mu2pdYQvSDWbkMMts7ijiBlFiObxVqgkKEbFXHZGGT9Yb4RHpV3ic2hF44xrBZENx9SnSYe6qNtBLdUelON2Kw0xicD6+sjr/ql1y8v/Xh9XttqT/5NaO3C3RbFAVHSl4HwtSaS7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwJG6NHRsSD8Qkl6TGJnRA2qWKES0des3OCGoTN5XpA=;
 b=Db/Gxca6nxqqDqnA8aWD+cFNAfKGFYkLsxo11XxBFKIQylEyEpKlpEXgC3ZHt/3CCx2JqQtAO2lxAbrANCD7TET/5268qYWbFsa4TvBSoD8yNC9CFWaZwieW+XkejNjvLtq4ozwWwam/qW+IqfLPF85r2CIon+d/hphL1GDdxNc=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 18:54:54 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Sun, 1 Oct 2023
 18:54:54 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/2] ublk: Make ublks_max configurable
Date:   Sun,  1 Oct 2023 13:54:48 -0500
Message-Id: <20231001185448.48893-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001185448.48893-1-michael.christie@oracle.com>
References: <20231001185448.48893-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::33) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 9656cb99-3e1c-49b1-e128-08dbc2afe621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3zgC3/6Zat5sVpHr6y3e+XN6OTOEHfj/+VJQxi4bAnBiKJqvv5yKmuQT5H+mFN9F9/22Xo64XN//f4+4V8Km0JPYaO4F/kNpZugu/r+d8dwT1WxKcsfwMvB6Tx/bV3/aTY2YnKBx8yHpkPxbFn25MIE/f2ePexSVDLQpLruI1bwaGc9UK0S1nvpdLECVJyayxA2fcsV5sdbooKpyvS4kmmEp9J2LDU3ctUMAgYKBxbQpAoETVr8+kpwm9ynpW+LDR50Co+pIZ5Ot2pQ1V98hTTKnRTWhyg5ni3TDXhD7qUqpCIcYR3L1LKL7MHQIbGduDW+5KNK+UNbhRqaL0sSKgNDV0hPsP4lYEdWGg0PNzcby8gFyD8Bad2ZmQRJ0onU2GxUZ6zgOXoGjrWdBv9jBLVfb7yZQVWrTgC9Z2jKv2GqcZ2LUYYDyueCsQg8uQClb0EKDkavvfsS2XemHY2J/vph78jC2xAY83n+5lwGPYxLS4Gwd/KmzEdPdc5asMQ9+6XvmHzMc+rp5CMbNjalJxArnqQPwpxYcfcVxbNXd5KncnkYc2FsQQmcDLd+4IFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6486002)(478600001)(36756003)(5660300002)(6506007)(2906002)(66476007)(8936002)(8676002)(4326008)(316002)(41300700001)(66556008)(66946007)(6666004)(6512007)(107886003)(1076003)(2616005)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTDTLMZbaXB+Q903NCQOJmBvMG0WSOzhC87aRcjqg0AkXgG2DUoESuYTufuU?=
 =?us-ascii?Q?hUNqZ+ic6SyCry3qJbb0iKD5OBNUtM1+FtaG//op2+SLil8uk3vAZ6KDqZOz?=
 =?us-ascii?Q?2HJnLCFM5AmnT9zsS0x951n83nQKC26/MOtV92L5Oj4lNLgLNzZ6VpsQ+gHa?=
 =?us-ascii?Q?0zBCzWng/AdnzG0Wrq5qi9yD9oCqxzI+PB1zFWYseD2fe3/GbEbH4tC4dM3m?=
 =?us-ascii?Q?avlYBK58rKR1BEyNVASXgWx897O0lt56iFtr08E6BNCUd4uJu3t1ZKXD+4fq?=
 =?us-ascii?Q?l2TnJ5fsQfRgcil0ng4L5s9Fu7CZdSQr6HxaMT+wlPhmbUDklIATrBPF3dCj?=
 =?us-ascii?Q?mG8/v9vt3w875Ufv93Wl/evpLfJeEN7Q5DVIlo8v8SYzQ6S8b0c2hs1mMfv/?=
 =?us-ascii?Q?gvD27wXi96bxQK9VSW3RVUoy16Je9BbAZOaMWNkFPazIDzFC0whkHpWW3cYu?=
 =?us-ascii?Q?p4EouojpE+5ihdDEWLhIZyR9mhr0moXXiurMIIFZx0S4g2da86bQJRztbpnd?=
 =?us-ascii?Q?Jb/Of5cXaoUFEOYFhH/20CtSw8wNabVkEMJdKOMhQ0gxMpkYccRtPCijF5qc?=
 =?us-ascii?Q?kVwhinOWDp9IQh+YC+zWUqxBdKdLhm3Jt5sQpOPJIAWpIESBraCZJ7pYpG6C?=
 =?us-ascii?Q?4xVnNtz8xAwYaK/LNdRR9he2PQ55qWyF1Fx3f/bjT9xWwsYCL7UpDhWs2/bV?=
 =?us-ascii?Q?ycnoIVersLFwGpjQyTJRrN1nX2755lZV4pYMkzO4V0p1+/eHJprnL3vA/PRX?=
 =?us-ascii?Q?1rSOcBB8wu5djMFJlFTEPpEQhn/eXluFDezQid+Z3ZJ09XjBvqrBfY33mkdU?=
 =?us-ascii?Q?k39zqX4KYJr4AnTsy53/WnahRjb6jRBVmJALvWKcD8IZ+Ngezuugf9lGFeHp?=
 =?us-ascii?Q?OfBEa+e/Q7Z4obL7m5lCZAyPA7pZ2buhBqhQseHou3OJrf4vPlUakvhDLAxs?=
 =?us-ascii?Q?45UBFOtJ1Bu6qP11GWPgpuyOg1Wt8hp0guFHvmG4bEguedv6ZWkaZCGmFpBX?=
 =?us-ascii?Q?/t29Gb6ZqSUqVM8mzGw0/Y5mopjvLRCmljXnyIADNQfu9R/OM3d4pApuIX5W?=
 =?us-ascii?Q?Z0ehM7qUBNeh9LMZ9q63CVrGGA7PqF3yLn7LjlxLQXNxbqniYDW4Mukpm7AH?=
 =?us-ascii?Q?rbjSyvzdOYU1TFeHhoz5lyKrotU2DWj3EFr98j3IeUWqHXJ35w0xJI6zkt/v?=
 =?us-ascii?Q?Wq1YaqY6eArzIz2Ud8QcmtKzqKr/q45Z4xlZ0CYH/10GvPBDV/sTMes3vIbm?=
 =?us-ascii?Q?LNLQiKuFUTLc812ubnvnzwNMHLykItSrfm4t37tcolP4hqVuVRuejOP/5GZL?=
 =?us-ascii?Q?Q1L6qDYVdQx/Kbe3SI/q3Dn3o66pKH6NKD69NGQJ8ZqEAvRAI8bZ9bgKueYL?=
 =?us-ascii?Q?ZXYklfFqKgMkNnaQCiVcFL+sFT++iOrNgJK+ewFj/f2VTvbjKPixDaYWSXm3?=
 =?us-ascii?Q?BQl7qbqucv4W1bAzayQk3AaR2oSHjH7ng55Zuey4cGNvdFO2CGtv2+NAcnnH?=
 =?us-ascii?Q?t4SkU/wVQgW11zbGtJzzR/OGD/iO6ePmN3pRu3MSeiWcmhxtQkSzUeRC5+V4?=
 =?us-ascii?Q?8TX81fe4YYIpjVKao6oLv48fRKrcTieihasIgOyO2VsuO0qOWVhWWXWt4eFW?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JCmLA4ogPNqXCRKMLjxGr5kgUxQ+XFskWuIVIgFa8hJleT5/i+/0+8WhqQTcvi+rydJSbGR++VVPpIjmoK/pN/evXHYVrbSL4oOi5fB/8z0LI1epJjqZhH/3QScISza7cR9AZ6qy/vayS6Ds2yvEclmPRzCPy2aH5GWoKdqZU0U8HH/Elsua1EtLKUbbRnzzzuvfKrR1EKFWzW/ISrBloleT2cxqDjZYZeYj94FzeQnr4TkiN4wEOBoed9Ryfg1CXj2Hx3z3A2IE55k6chO9xb23YUuCeZ1t0bowLEtYUKK/VY30Gkrb357Md7FUPld3rDXnuq9Oceu7G5615uxoIq7jqWn1FM+tNrOw63WwVnWhspUM0LmRY4rzRkU/YTKdsTM4UzalKejV5eMIJvxzC4c4fxGEcw221WdIRIzas+AduaL19L2fOZOruuefMjkvq2FGK0tRcVZabxzP2s9hx16PjzhAi7HpZuFGxxwqvW3mJMQD91Af7YhCK9mPVmCQys0YPF3NA5T/u1rK9ghdB5DoHPd+2zPg3keCF3JDtgCOxjpjxu8+rV++hPrtrL5NJ5cW3rePCzMxalFD+RQgN/t+kkbZJn5JN+Hr1DxuME3I/v7beBvtY1Q3QCPINAGKz3GYZ2Twakqrl1Fi/lpt1aDg4eMUzfY8A2u6MlVEOxqpHInEHh0uaZD1C55lUs0SsjzCkq8Bg6LUDjy+54n+uQroxPH56SOEc8jlq+oNawgpc4u0SFHKiUBNgqIxc24tOMDGzcgLBZlaYJd5o8QAYbQI8b+NvUMDZB1rBAICzshqXw2ZtbIDEYPiUIpsHDeR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9656cb99-3e1c-49b1-e128-08dbc2afe621
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 18:54:53.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2wYLC9L/L8cZ9DAGL5q/6c5D9T7ML77r48qULERLtSkbs1Ag8t9zmkjdxkHqnYajj9sf9yL9ucQhOGurF2fjq8fBE95EoSx5i7Xr2IYxug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310010151
X-Proofpoint-GUID: LksWn3GDgmSXh-8yv9GkPtOKfcAW_EES
X-Proofpoint-ORIG-GUID: LksWn3GDgmSXh-8yv9GkPtOKfcAW_EES
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We are converting tcmu applications to ublk, but have systems with up
to 1k devices. This patch allows us to configure the ublks_max from
userspace with the ublks_max modparam.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 18e352f8cd6d..2833a81e05c0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2940,7 +2940,36 @@ static void __exit ublk_exit(void)
 module_init(ublk_init);
 module_exit(ublk_exit);
 
-module_param(ublks_max, int, 0444);
+static int ublk_set_max_ublks(const char *buf, const struct kernel_param *kp)
+{
+	unsigned int max;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &max);
+	if (ret)
+		return ret;
+
+	if (max > UBLK_MAX_UBLKS) {
+		pr_warn("Invalid ublks_max. Max supported is %d\n",
+			UBLK_MAX_UBLKS);
+		return -EINVAL;
+	}
+
+	ublks_max = max;
+	return ret;
+}
+
+static int ublk_get_max_ublks(char *buf, const struct kernel_param *kp)
+{
+	return sysfs_emit(buf, "%d\n", ublks_max);
+}
+
+static const struct kernel_param_ops ublk_max_ublks_ops = {
+	.set = ublk_set_max_ublks,
+	.get = ublk_get_max_ublks,
+};
+
+module_param_cb(ublks_max, &ublk_max_ublks_ops, NULL, 0644);
 MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
 
 MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
-- 
2.34.1

