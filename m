Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA73CC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8C61A8D
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhJAM3C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:29:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354366AbhJAM3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 08:29:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BRGDS023263;
        Fri, 1 Oct 2021 12:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=c+Eq40IYVTG/iMva6jC7io7x/gzH+prxPG9ABw8AIrY=;
 b=0hZSjWumlKx3K83s2TMVt1OWUe5Rc/oJ0L1TyAplmu5633KfsQnFNVNXkQaEQxAb8diV
 9LHpHCgzhT+C5yya1v5UpDUcrMQ1NJ2oYBTFIZbfH1mM2UA0vHzG8gbps40cjMFk+OUt
 7eM4V8mB6bwDJKnAL+EIFfIwNmT70Yua5ASuHeQ8x5X7iq7Ep7EvVkVpD9+33H892FB9
 BC4I6tLq15zYocH2H/3dsTUywuWjEPxrfBfERwJHOsA7rJUCAYRqdDJVvO8SiJAypAD3
 pG3+3+e0PPX1lMmNuKq1n+rj/OYiOb5h1EZViV+4Ctk6JQhNs4x5YGdpVTGQWtkfkPTD Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdcqufp5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:27:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191CKXtv153933;
        Fri, 1 Oct 2021 12:27:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3bc3bp4b37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/c0d9aVxmPEtGszkHauey/Vy4TGd/QSuV4Zj31ooFKKHs7Gr5Wukd8QPSvxfrxPvIwJMcLEb6onKMFu+tJdMSlx0Hq/F6CUiMeS5wQ+b1hgpC3vtBfKJAcpytg7Uo9Sxxo7G7j8iT8xBFWgDSCgfS+fYz2pO/OYi6L7L247r8yb7YjRJ3ASCHcQALdL5pYanhN/3ibzxOobdHQmCpACDNWkuguR+B9LGB5l8h/oFoOe3nk22kxluMC5Hfe4eHAGtpqbiSs3wGLYLAmtX1WQRvhkWqFSVmcVhW22MaGQ8fWSUOnk21zDpeD9vFaDxPZN8aESfU6B9jUQqRdsN6yPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+Eq40IYVTG/iMva6jC7io7x/gzH+prxPG9ABw8AIrY=;
 b=J3h5GFR0cvlR5ITjTm4zJtmv0PGU/tnHYtZwu5CdkFqebYSRy/UnuCWVPKbJYTQrmTZF1J40RYg6RtOiLcdec72XKFfeyeaRjN9F5CXXGliNXUXoqQr/b1vRavIRxZVC0qenVScMkxpA/aJjlil0k601umk5CcTvrQXjfIMfyHT6MhnWrB4s/qaG2Pu+LYlFOZLm41Bq2H4NKrlSNO27ti++Rs0wQVMdNS5SUukPw8LfraL+CpOGZmECDxqyf52zV5fFJq8K3DZt2/P2Nd6stt3zZ49nELWckhERMXyHUJTbLvQCffu4G1YtgYiXmepPX4Yda7lew2bqvyHxMNixjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Eq40IYVTG/iMva6jC7io7x/gzH+prxPG9ABw8AIrY=;
 b=mWkYFkMt6b7dwGGZZ4OJNtMnIfv4Ou4kgvK4FPMapDH378VOK6MIHtKrcdifdTLQrsjqSGDAchO0hPWPjJxkfrXBCJgN569yEgRihEFvjhiw3UP9AnJlK6XNdJcu6S+fK6/v+zMENLSucoX31NjXabU/b7RVJcs6Uey339dXhpo=
Authentication-Results: cyberelk.net; dkim=none (message not signed)
 header.d=none;cyberelk.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 12:27:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 12:27:05 +0000
Date:   Fri, 1 Oct 2021 15:26:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pf: fix error codes in pf_init_unit()
Message-ID: <20211001122654.GB2283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 12:27:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e36ae9d-b488-44d6-e5d2-08d984d6c743
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB231916668D95C2EA1C43D7C18EAB9@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1iOFWLcW7uCi4eMQN6jbpZGRB0TUJi4QzK/appwbCnfe96b5sFdQpw6SER0YUtq0OLsovD/FhUk8rv7cje8IV8AaJaNzufwKZXbqwxWNoKZAuzsoYAQSH4PKbEALG8ApDGW9lk23v/MjYIZoJfOWzoHxKEv3yWtbgFLQSE6uSXAfNTn8OdsMosKaNgjnAIbAozC5Waeg8u72NgyJIE/bz1+UIhqzeZ9+KuYPyDJRFydogO3UefMuCDTlAe77TkU0Q1adRXDh7icBjrvD2V7a/FkBFFvS6ZR01djEwwnvs15F+W3OekNDGkTX6Mgnkyy5CWa9q7g9+7OeW3SWrdyaVAf4DazPztvVFUVg7eB4JJhf/+7VAxWHBAMVhblEa9B/S8gx7IlXQ3kog+pJTkEzAvXedaYjFcyAT73r3UtsYWV52CjenLWvcJ5BGIOzts0/TcjA4cXAy2hP9mPzILdkYX7Fuex+rVN7QUzkvdIwP1ZDvDd4xxKWrBCGkrGwgKEn8rT50GZI5krLZQRe2eXRMy0mnsXJLkh/v1VV9pE9oZ5hyullZ8gpwsw7OJAZ+sNpPhr4njR16/s/IEImICANTJrsNrCJB1YAnJ05VOle4AZfIhBRAob6m6QbNvYg5l0UdD53cnlgXW813Z7LP8aZSLdnWrwp1cZYNDCn6aBAM8M0xcgqVZxdKIpmkfTypyfq7Xpy+xwKwCqey5hIPSMpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(110136005)(9576002)(86362001)(26005)(44832011)(1076003)(508600001)(83380400001)(956004)(2906002)(186003)(33656002)(55016002)(6496006)(316002)(9686003)(5660300002)(33716001)(8936002)(52116002)(66476007)(8676002)(38350700002)(38100700002)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QXtgosbJC1QSHH1oj/wSzH1Hq/hzzhTjMbx65t1x8/wG2fLGpYjU46ypL8l?=
 =?us-ascii?Q?48nbj9WaWNC5X+3Y81HcAH9D4fPTWsnzlfWuVo1c3TVfjFWUjQhgT4oYkQU4?=
 =?us-ascii?Q?R/Xr22doVrFC/rKqhjbl6uLRDp385d54vGGh2UDKrwKZw8fOEx66s2Muof+w?=
 =?us-ascii?Q?DCuySL7wbEGZqCFa7TIZi8PFcq9Wrd3woRxeL3bXG+WNpA7d+dR59BWKw95X?=
 =?us-ascii?Q?WIqUR/iXhp7GkaWjnVsdYUPaB8YTSdZgE8xEjXgqSMeZY3ETKeQQaGQm1Wus?=
 =?us-ascii?Q?GEl1YqeW/mTOzIdy7Q+nu3xZ41Tc6AM5WrXf6mL0kRPEnjpj/1RwDut4BMuT?=
 =?us-ascii?Q?G6mbgUtKNOZfp6xqlu/lVKeTlejVc5whpma87O7fDI4ICsm5+IKw07HuzYmt?=
 =?us-ascii?Q?WILfqRhfFCwOvdCRpRYIsxtZVFf53paeLT+0MJIzoOrBUz8bncYdxdf93KHm?=
 =?us-ascii?Q?cid5Z5s8gGZzwgynMauJzxuZ0GwgyzbhBCXNPHXjTkDwfjwxRwfOuB/0C5wK?=
 =?us-ascii?Q?6np6DYEhudqYTTcyeQJuF5/Va62rDfCU282HGiwSbw1S1tNd0OljoqL/qyfv?=
 =?us-ascii?Q?JrXDRlYkMomqtzzeCW7DWfcMo3vERRlVMdj7Hn/GWRcNydyEb7RieCeZs/Va?=
 =?us-ascii?Q?iiQuH6XAjrJN9oWX9Yei/DAHCDp0bAzmCszaTArBss2OxPpnbonTrFoNFsvT?=
 =?us-ascii?Q?49WkCBaz4HQR22g5dC0KEo6+5IODwjmVcwgOg/tgI0lpMDZ4oVS27v0KlOnm?=
 =?us-ascii?Q?d+jPF+TL/m1QT9THtXzhr6SxxdklPM+cChaOQ1+RVGQgCCR7VBNp1BXvbb2j?=
 =?us-ascii?Q?dd0SjsgszR5jBnvqOnQ23vUDHyHrN1N81kP/vNNjgANabC1H1eafjHS2djus?=
 =?us-ascii?Q?aSZ/oGmu/rR099XKmy+d6SwsUuZPzmfH9wsNGy6/UJGjbbzM3oPOwUmsZtRf?=
 =?us-ascii?Q?wGHvemA/cMY++MQscaCWINx1A9RB824kv7wEs8zMBrUtlelJEPFKGRMSdbPe?=
 =?us-ascii?Q?0a7qlxYALvtZGE/dExex2SMxaoCk3MyxcdsREx2NLe8zudyPzYBC+swMQcj9?=
 =?us-ascii?Q?VeBYZtC/qoD8YVEgwBXBib/pSx8Bv4uktWG0HCszVOC5LW6xB9nnVE+pHoxO?=
 =?us-ascii?Q?ni59Ndbv8CGl83VLzfnPxU9O+Cwon6PTCup51J74pDv2DORb1t0klNZeCEX1?=
 =?us-ascii?Q?0HRT5KJlaY0uS9QhgvpzmF4PK3oe5NF1kcr62AiZVRWAOL8Ln4Xxi0Q849pv?=
 =?us-ascii?Q?X6o2ulbjY0b7qVTxXQjMNO3hOaK1qUR31OOWVXOCJS6HK3Ldrxnh2VGmauI/?=
 =?us-ascii?Q?RAaIralABIgTeprCWDyf765S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e36ae9d-b488-44d6-e5d2-08d984d6c743
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:27:05.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EyzF/Vf3H84yR7zEOYD73hWM1nonah+H8CMqgzhY9TxfoeyVGMe0U5Q6vXQiL4TBCGw7OsX/V0qgnBYf5+fqU/Nj9zlf8qzhcXLq9mdMzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010081
X-Proofpoint-GUID: u3bI0L_LSp0FYU_tCFXyceonsUZXFhF-
X-Proofpoint-ORIG-GUID: u3bI0L_LSp0FYU_tCFXyceonsUZXFhF-
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return a negative error code instead of success on these error paths.

Fixes: 327638dec0ce ("pf: cleanup initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/paride/pf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 380d80e507c7..bf8d0ef41a0a 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -651,9 +651,9 @@ static int pf_identify(struct pf_unit *pf)
 	return 0;
 }
 
-/*	returns  0, with id set if drive is detected
-	        -1, if drive detection failed
-*/
+/*
+ * returns 0, with id set if drive is detected, otherwise an error code.
+ */
 static int pf_probe(struct pf_unit *pf)
 {
 	if (pf->drive == -1) {
@@ -675,7 +675,7 @@ static int pf_probe(struct pf_unit *pf)
 			if (!pf_identify(pf))
 				return 0;
 	}
-	return -1;
+	return -ENODEV;
 }
 
 /* The i/o request engine */
@@ -957,9 +957,12 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 	snprintf(pf->name, PF_NAMELEN, "%s%d", name, disk->first_minor);
 
 	if (!pi_init(pf->pi, autoprobe, port, mode, unit, protocol, delay,
-			pf_scratch, PI_PF, verbose, pf->name))
+			pf_scratch, PI_PF, verbose, pf->name)) {
+		ret = -ENODEV;
 		goto out_free_disk;
-	if (pf_probe(pf))
+	}
+	ret = pf_probe(pf);
+	if (ret)
 		goto out_pi_release;
 
 	ret = add_disk(disk);
-- 
2.20.1

