Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F1E78482
	for <linux-block@archiver.kernel.org>; Sun,  1 Oct 2023 18:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjJASzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Oct 2023 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjJASzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Oct 2023 14:55:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D85D3
        for <linux-block@vger.kernel.org>; Sun,  1 Oct 2023 11:55:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3914f4R4023727;
        Sun, 1 Oct 2023 18:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=csv6HwzijVo2CsTRLqDpBJk/WpNgu4YweolhQfzUOVA=;
 b=2LHkbCh0wdUqcefVeCCgdMovHRssBuPui6SAD2sseISqRXq+eWWYEPxRL2ukuZwH16HS
 /eprllk0+Y3W4aHggiS7UbZmOhkfNJ1huPzSp0Ii2F8Pc2fsvYVd6XrtKPo7kYtAE4OK
 2tSle0jsEep8xYj8pY7sc0AtFxj42x8bSm6+9lc6V3kRZP4gSbmA8CUhQSLuJVwh2M8b
 zWKFwzZCXogqDc0o1HBYzdpG4pW2ZJeEMXdcuRC6eo/HiG+8oZDWC7YTxbhMegrNqOza
 4hQScrkr4sAqh8gmEGRDb/cBsISTlwQrEKnlF9n3NErZI+fsf4DomecFWyzfw9+3RzIV Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea921fkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:54:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 391E9adm006657;
        Sun, 1 Oct 2023 18:54:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea43x0w0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Oct 2023 18:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZtyeR8mCGA6Ety79db2XFsUD8EBC2FmY2Q3wV0M6rZF2tuqp59d0Qqo9CNm/FURPgDXeEz+cmx8JMP1Il1aj8X5Q9e83qVlYj05sQe96w3WrSBFhPpOTJV3r8BJS1ldvEo9lWtj8c4Obup5nzEWhgNJN+n+k6R5yv7Pw0BSY6TS9pEP6EQwyqb7igzh7A+w7y6/GluroV2JaYOekgkqNxCcuCW0LmAj4EjCoOh0vIzUyf5qSz2+IDMfgLN1kU1D99UAi5V+Mvn+QE9ZD1h2Z6EZqfqn5Yq/4+QG2F7RhCm8/0pLMLK6qBl+dE3vSqp8HxRe3x0AFk5AujkOmImxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csv6HwzijVo2CsTRLqDpBJk/WpNgu4YweolhQfzUOVA=;
 b=JBfOyd+VNEbfBogtfq8VF76/3EXP5fjp/QSUZQkA1HDETx15weQp/++hBSYRHFbA8FLhDJQVPwxhpYZw9X7YBAg18r+IwkUN89YAGNUocvxKgrubH515l/w41Cik0tnolxG+IcMS130Yp+YrCr+aHXFI9qICeKc7y2LCAdWVPuGKO22M1GsGKl3N8Hh1P0Adwz7ZUMXR0UDl6nsKYkBM90GbywUY7/HUa6Rsl28ESmnZbixHsu/upYBkPhpRSrPQ1ET6piglb129Sn1vSNWRHu3apHPT1JtLzjeoajrFGbsyRYO+F0DRItH+O+yMEY8j/z9YZNrf6knkn2rWOo+kLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csv6HwzijVo2CsTRLqDpBJk/WpNgu4YweolhQfzUOVA=;
 b=ZHv0ewbD9yUVHSCoCvu61S8wGIcA23n6AGJ1GeGkkynIKWbo/Dc+rGnb9z6es91JGyIIZnQWleqBQ/CLd3XhjiYD/sFilYLXUtaaZGvdpktxgzSKaZHntRikwV3KJ9K3AzpIim74Vy05vvLLUwfaOgodimWUUmJTJTL1OuzCR74=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 18:54:52 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Sun, 1 Oct 2023
 18:54:52 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/2] ublk: Limit dev_id/ub_number values
Date:   Sun,  1 Oct 2023 13:54:47 -0500
Message-Id: <20231001185448.48893-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001185448.48893-1-michael.christie@oracle.com>
References: <20231001185448.48893-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS0PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:8:191::10) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 093c7369-2d0b-4e1e-20b3-08dbc2afe525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awVanfiaks4SmZd3Xm8oS0V+g3qoevWmrQxqf5EZofV7Bsbd2BXVADx+pbJuBo2GjqckgdPsTlyct1wyNF7J1KN007h9vra/Ko7z62xciQkqmguBMP0V7J4M/ZtSYK2pKCF79m5Yh4QIL+Nip/rLfhFUuKe2JVEK+jk6W0TwAUWBQc9iUuu44HRX9pjM+TfRp32kkeu5DAXHuOc6LNTxmoOudcCdIt/y9w6Hu7DnIEcw7V1gwbWSZL+UvXdziYqfGeJkGlmxCTft5i5iPhs8y0HXCjtQBSD89hAzE/5RTTCGDC67+zD3Zl5ccGcBjJ8W1Rrxv6xoBf2YFRsYiW9b2B/E9J2JEG3ZW4DuV/FDcMMGIAxY45qgzVExc+vy86jZXgDDpf7/tQFJL4H22x6N9b46ZsxSWCDR5NRJwzLdb+tWZm1CMoMhKHHU3aGEo1tbfbAZi7VbhYKYlaFfE1HzBfwGYffMKVFZn8UD9Pw+QpxHwJki1AMZBDBTn2I6CcDDw8Naitrksc51UyKto9HpF6hBM2GL6Tm+Ua/TN3KXpESBdgs657QSe9LagseyTZN9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6486002)(478600001)(36756003)(5660300002)(6506007)(2906002)(66476007)(8936002)(8676002)(4326008)(316002)(41300700001)(66556008)(66946007)(6666004)(6512007)(107886003)(1076003)(2616005)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNvo0d85K/MVFcxCXNTWPSDzb3IS1iZnpQx8Y43/oZHNnILTftnAhKRzwpB/?=
 =?us-ascii?Q?G70JaYYwM3JX4DrmdNedIUUWCq/wjvFTHUVciT8r+63B3HecR+ILHFGCNgZl?=
 =?us-ascii?Q?/W7cEvH10wanzPFegbhZv6LjjruZhsEb5SUySo0gtR65s+2e9qLZdbt90oVH?=
 =?us-ascii?Q?laf05A54YR6N+oW1bYh8vQX09EUN3rGKjDNvi+gEJ9Ybhmpqq+MC9K5tFm+s?=
 =?us-ascii?Q?kUKxG6xYDDAD266XehCCwkRnRmHmoeQN1c5BjDXw24rljdqob3v+lGtUnX/t?=
 =?us-ascii?Q?OWmG9BYA0hZ1Dytcnn19RXGJaKoH6NSnkKHe/Wll4wLtoDNuaUdpzyinl/So?=
 =?us-ascii?Q?Rn0PcQgI2YNkid4tV6JmnXMhk+mFmakNCOFb4ZjGmh+eOEnMOXZvrA597J1s?=
 =?us-ascii?Q?4G4/nNLnY/6GCXo3up4VNwAdBAtvCSB5BBVupc+Yr3R4wxiPZMGeC15Qsfjo?=
 =?us-ascii?Q?aq4dzxUySVMhLpRoHZny7Qaq47ab+4yiyJqurL0E2txanA6MGiPESsDMSb05?=
 =?us-ascii?Q?QptLhNI5puV2e67Lmn50qTF/5QqzgRiaWJkqHXElW1O7oSIVJ4MzQJLCf+NL?=
 =?us-ascii?Q?h1tf+0FxwpIQ/9T/9RDd6HSGNZDnqxavKzrssBpD52NZLO1mJFTK9EtEEhze?=
 =?us-ascii?Q?vmQRVckliubIFFPI/jRhx1OHMnlUy2Sou8yEzYEAR39Zoqe4NQHi28Ioc/RP?=
 =?us-ascii?Q?jhLadAv5j6FlOfAPg85f7xCVPA+fTAmNBmWGTGEV/bpZ4SV/hVhbmPO2qvBd?=
 =?us-ascii?Q?G+ENSTtOCpx/sRTXmmh9KJnYajKzEzuit/eAMFGRLOQcK0ybpWq+xLPs2uhC?=
 =?us-ascii?Q?LGmNDnp2RCC/L6fNk5gx1IomgkrPt+XiExn9JvBj5ixmUru06i4ZiNaKUTBU?=
 =?us-ascii?Q?h9TBrfmabwxRdnDd04uXzCFbyZpRkaIYyfMajgUKUdwr+GleeehHhnt5Q3ef?=
 =?us-ascii?Q?aDViUnPS6/4HIlTTp04K3D1/Kz+b8T7NQ/VKu6x7IyPwl8YbFGPMN7/RWzQ+?=
 =?us-ascii?Q?yYMKU/QPJJ1VFf0uxI/Ejs/WQo1HMes5VlzbaLfmNYfmygyfyc3f8FWtkG3R?=
 =?us-ascii?Q?ljEXWJZFPBIdvwN9LU80hpClQSHImfFtZPMxBX2f4su9fU4U2uCQfZff8HHy?=
 =?us-ascii?Q?avWYL4hJK0BIX/OozEivxoLaiHUOENrqXAHvMwAjiB5/kEWGGSMvo1whsoL5?=
 =?us-ascii?Q?XhlH8W9w+Aiw/onFkNArzyNsyVN0HkXqYNrjRvG92fAprRhudm2LPi0iK69t?=
 =?us-ascii?Q?kXhfnljpYCaypvcJX2ZlUdwaH0ZXDUQJpcvbBbRECPIiLa+/Dh7YGNrR9quo?=
 =?us-ascii?Q?OLuePKiyaiVRsUs+Ln++ENDawm8qldCZSGDNmU7cUprEK6qjDnCZzSR/JMTf?=
 =?us-ascii?Q?a5ydYOxD28RbWsRD3Ymg4cuaqnkcF/wleUraXFSYbAJwnscaCn+3V2qiGfBC?=
 =?us-ascii?Q?/b23/yTqExwMOC/6mDhpGuABn1+7RPXkWmIzcp7vkcuNTX+aB9ITmhlQEezS?=
 =?us-ascii?Q?Wf9AUhIZMQZxQKkMXeRNVbvSnAWSY2xDsVeg+1OqjXxvNr5ihm7x80HeEE41?=
 =?us-ascii?Q?Ao/6iUxERuVDyLbR8PJlu9u8c8ukQw6mmplVXxE7ItSI1sPRNG0qR9/Xt7pL?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lQL02PZu3G1zSpp6Ev6k8cCMZBIqXbBP3KsCtGioOeOw2+IJo7DxNRGCguiyjZYVXbMKmVmA8UHi3h6EF9Jo5jzztXkT/awZGGqeUeb/8iQM8RmnWXnZzWEZlBKo0FddPM+zNySqAn3GStUmJ6BHuVFyY5A8oaOD7TOrjHJJ3fsQFyKy79uSYpDfDY1jFo6DfWts6zf8+GlY33zUeDqZ8LZxcGocuW9cB+QgRhp0D3pnpyR51qnQBcw6qScvURXmZRr6XXnuL6Nn4gbyh3uEpSccMZPv7XK/y/JGeUBBt0T4AUtnbYmZX8lDRBkGAriWdlLP259Tlz7JtMx+RDqC27Emci3av8T09hqT12dZFuyms/Sc17V3Ri2yFUnYPdKLHO3X0ztyCDzmcct5vOZr4jUxrCZ5V/FO4PaAN807/G69in3194oPx3aiK71Zd2WK4PTD+2gY6RVqXTFX1MW5N9sExq550vQlEQ2AHU3+hwRvASoxJ4wFyugG3msS0eFdaKlTe/DWMoNbVHsm/qp4lOVHaDez2+APTKSKrwOc6KAB0v9oeWWU3iN/IftD+LhR3GFtDbF2EOVrbZCgc0WYkBurkBx54mbPC9VHdr82DwKzMEVGC6mfq2NMmD4kQYxMqkUEtgUUreP3dm6n62T5DR3NyP4UVK4njXEW4K8CJR5Nm7LHy2NUOs0pN7Kj7iDF+bpY2dNovO7JvqgCO/c/rj6GQs04gbrgnzK+ORw9UucxKFXylV6Ipdywfx3I1S5K2uujUGAMqzQ8Hx+JNjpl7sy68zsSvDv6IRcawZz/EwO21+G6rQgbbstLEgd1Dq4h
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093c7369-2d0b-4e1e-20b3-08dbc2afe525
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 18:54:52.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/GR/b04IqCbi2K1KKUOfN71UnoBqSKny809479HQ270WVqcn+Y9IY4uriu8c0JB1V8J0LvDUawZ8axMln7yMIR5FEK0rl1oTiBQoIFzsh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310010151
X-Proofpoint-GUID: OIqzKPFDiBn1SQcZzDWf6NdNvNFvksUD
X-Proofpoint-ORIG-GUID: OIqzKPFDiBn1SQcZzDWf6NdNvNFvksUD
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
index 630ddfe6657b..18e352f8cd6d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
  * It can be extended to one per-user limit in future or even controlled
  * by cgroup.
  */
+#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
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
 
+	if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {
+		pr_warn("%s: dev id is too large. Max supported is %d\n",
+			__func__, UBLK_MAX_UBLKS);
+		return -EINVAL;
+	}
+
 	ublk_dump_dev_info(&info);
 
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
-- 
2.34.1

