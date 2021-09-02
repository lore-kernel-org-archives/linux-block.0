Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E079C432BE
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBD661041
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 11:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhIBLWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Sep 2021 07:22:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47434 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbhIBLWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Sep 2021 07:22:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182AiZAb010680;
        Thu, 2 Sep 2021 11:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JAETBTGoWPp8lzt6LF5NmcUFy7K3CQBZRglIvXW72Jc=;
 b=VqGJHiK27mABJf9AId16TJ/tfMki1ZIY9v92k5Gavv+BgSkDXOEWTT229h9j0fBXCCEl
 2gkF7UQSrmjzNU7wGgh+/VIniIKX6O4CfVU6TJJ4+Td7vFcA+RaSi/yAVqb/NrbQS19M
 sdDPW6UO8ild8SrOVjv+5evPht4Kg0SNin6xeUG08TZI53lnEADQH6eCr8X70RxRqjw+
 f21eY39YNlGj8e+GJmKpyHlqv7uXnuaQ+LoUk8KLrdEu2gpb3fllKAMrCaU7PNv45ReX
 KNCPkzE6vxLoskQu+Hut1+rPhkVYaOeIRg+QTuX5lx88KeH//i4rUEcPtuYE9FgDWPbY +Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JAETBTGoWPp8lzt6LF5NmcUFy7K3CQBZRglIvXW72Jc=;
 b=cHpfwBWYseM0JnR5pDfewSbQJijG5Jig/i0VT1w3cwqVS8ds1XS94RHDsCfUFz34dCt7
 722BssjZRCLL6YL8YaSxYYJz2nm1BM0H384CoZhP6uENdtosIawN5Gg+yI/kW7Saka5C
 KxRtmdxjAV6eoluPFH3vdu2jHoZWcURrEt+J3sSiWLdAXuI68hougHP7AdGFlwUugjUJ
 atdecbua53YEMEp/ocdg/BolZlgOM85/UjF4Si9zWWiV8QmgxnKAoxZbACJoSL56LS2T
 J519nKyG6ohDdMt/LPEB0tDezoGpsbDp/xln6ROQUVLHroi+82p9osIopUJEk7OGdmM7 HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw5ab33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:21:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182BFivH129223;
        Thu, 2 Sep 2021 11:21:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3atdyvd10y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0NGUuQzIX37zdDF1PjvkLVn0rX+HgLskEicvLYp1LHi5vGlsnzyps5+7jTQv4BeB1m1VVYEQKjQnSdZQqJFEJeTXawkMJ9Bic5wVlxPgi1OruAlgSNozGX1dQRBkfJ4XbZzD7CqacqoLLf40ysbsa+pNxgOmZdE9DblQbKeSshRWukDoI63zHFwBDMheWN7JXiMlSDCy6hnHXfEvdSJ46puQnUgs8waEtzrTFjJ+dIvrQAleDxuF6GkB+bablpIUQjqH2kzh4UWv/jM2Xlbj30AfFnlYWHMnf68cgrJRw5nUaaf7RfD/KXWoY31/cKRnpD6JWWJQBWuiKlI0w/CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JAETBTGoWPp8lzt6LF5NmcUFy7K3CQBZRglIvXW72Jc=;
 b=eOMRSdKv/yRjR+jm+z0SLXTQOhdu2FwQ43KBPKvmHivQgfpctgNSWrE/XpQC8O7ydYsyP8fexI7C+zwCL7cF1X5ZHydGdt7Fljcy4RVyhSQoZ+tU2pvZJ1GofecaBqg8ZjtH+1oNOiSzs3/K7SfiqBflpOsR6h9ea2Lz5FzC0lR05tpqw80luc/Ew+4uWytDF7ozekq2M44BvgE4R0XTbyq3ONxXF6he1LCY/ndP6BwqpAh8+VC5Dx2lbELVuoldAKJGa0AUeslSWS1JtUmXQjUMrpva/Gdk0I4ImONHwmd2zCZ8o98WLilOFwwjfrCxMbTTOYG2VwdeVyIsEon5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAETBTGoWPp8lzt6LF5NmcUFy7K3CQBZRglIvXW72Jc=;
 b=Gzp4bhdbScqJyERXjuzN9FkYWaPLWnHi1Os1Bh4xKCPdePAKWuJw3nYkEBGn7rF5O94xqgR518iJvPwmDFpk/04NXARESj7ZMmlxupRepkyqv+qrDZUzsLV59fSzMv8RDpCEq92OdlXHsK/av8c+HvxVkUqzDfYsYcEnOhaYFc0=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 11:20:58 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 11:20:58 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block/mq-deadline: Fix compilation warning.
Date:   Thu,  2 Sep 2021 21:20:44 +1000
Message-Id: <20210902112044.1276619-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0052.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SY6PR01CA0052.ausprd01.prod.outlook.com (2603:10c6:10:e9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 11:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de650ef9-baf5-4153-d59b-08d96e03bcc7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4436:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4436AB3DDF8905A5F4378E29B0CE9@CO1PR10MB4436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0+fga+XKTkEfh7IVRrstJNQpy6MCQtqprN7m7qKAlEJ/si63WSr+P8h0ROa3DIQ13Tor54AGtOSKgDGKMW/JgUdRcm9+R4nHBkhI4BdB+n978SlXh7xh+xUor8d+wkmMVm35kcIyK3E8PXNGrApJipstvZSSozswq5bTJPdTdlb1baP0+Skqbx15VTHQsx/q6MOcoGH4gPvfdJyQqNUaz0w9eD7Yu+atwkeZ1v399y3m2sjKQISScjDfCEV1vmWT1jywaal4M1QsrEKVGcaOCNt/E/tRzGbZP5++jqhoXPUp0sXwQvW0rOpXmHdMeR6C9dg7W36bjuonDE/xtn/m3QjNoTOm9ghREsHXUSC2bzx8MwgJQD/42Uu7zcTygAQC1+6wMoECTIz1WQcw6aepokCrulRplp1LPvV4wjrF2qTDKCyT1jJTxrNZ8miCE3Lk3/3mTCNQjffeLuNSfLqljbTdBE34JtpNTJj1vWA2aR8NUorM5Mc9cgkEg2VP9xD7NbUD+WICHQi9SEMu3ISiOGtZHmrRmGgaFp9DQptz8nGenm/eFuQy5JkNT+Q24Wow4pYcQHYm9XWrDaup+7iJXyAPwTZ+0YGKTo/NU4KnTuLOCyCcwDv+2TH4sEiDc3uuDM0TuUL5K/qKonj+Vpw18vbKIn8+5UaVBl1Kh1ktfBu+j7ol52+PEPBdxOk2UA/8mR4R1GN3SzwYTDnlqAqnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(8936002)(4326008)(186003)(8676002)(1076003)(2906002)(103116003)(6486002)(6506007)(52116002)(26005)(956004)(83380400001)(66476007)(66556008)(38350700002)(6512007)(478600001)(38100700002)(36756003)(86362001)(2616005)(5660300002)(6666004)(66946007)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sIx2QxAe/2JZ/yROATNO8NNGDfM+UWJvhBokYabvGwNFAQ+6jJVSHAgxF1Wo?=
 =?us-ascii?Q?ZwadzaI7c+MTuwhkTK3n0WiR5co9fEiBcUMKhw5LhpKboqkSJHFDZIa2EkqX?=
 =?us-ascii?Q?9gZ0Q+oAHiKcS1sjx0pMxbAokDFpCm7Adr7jHSV76zoZccVI4idcIycipyBD?=
 =?us-ascii?Q?j8kD5Ypcgwn7wX9su1mvRV6PTOWfDNb5HwQibusaqrdVeELQdP1ZVejGphmv?=
 =?us-ascii?Q?gqBX1mCx+v5F1qVsnHmt/RiRv4HXomjQxAT/yZ6yt98GN8FfYmShauCJNsX5?=
 =?us-ascii?Q?xnJPQ2YVv77rPBnbW94aKgmwuTwORH7ddLr6PjYb5ZIAa77pdVeOu0LhC95N?=
 =?us-ascii?Q?FAmUm4h4z2KjCmDuhB5TXINjDa0tIareNDs2X6m+jaHQH1y+9l4HlJ1Zq/ny?=
 =?us-ascii?Q?5ZR/tmz5WS/WvzFRUtMUDU2Y24Y3VSqTELsBR4wK/YkMm5irxwNSNDhbFJCr?=
 =?us-ascii?Q?xkaceiouFi5XFLvmKwObpwmdOaVS4OtW+r3Pc5/CaxSVe0dv8CS7xDkaQ0/6?=
 =?us-ascii?Q?zC4G2w2fiJUkDTCOR2AcUI+ewcPeQXUxcZH05zyEbD3/ii9shvsw89PF0PeD?=
 =?us-ascii?Q?FKONDy8NUNutaTkpwt0HchIHoO9/nAMHF1OLpsYnASr15jEgNXnnSjoKFEwV?=
 =?us-ascii?Q?HDu4O5zmcFqpSAsKipQHwGcaU1BC96N8utlY3Ie5gZy8or2kGQ4AyWBk6OmA?=
 =?us-ascii?Q?1EB2TEPy/4r+coCzp5bUJlcjcrb+HMA+ulmt3YGT7ntfEgYbgCQxbinFGuYJ?=
 =?us-ascii?Q?sqmZzbGyzjhHUAS6lolOalb9T225t8UQKad6sIYz3XUR0Ug5smu24poE6RK5?=
 =?us-ascii?Q?XAj+PmcxfczCFk3HKnSBmrAl+wbchRyFexeIYfiIy3FaIYJCx5ydKlYnKYMP?=
 =?us-ascii?Q?VP737m++8JuLuK4RxWhF5o9R/B/rXg9RmjWDYslApAC5140u6oBOh0CeQU3B?=
 =?us-ascii?Q?yS9TU1ZSZjqjSKB6tO/wYyJmlA10NupHfTHJReKsqUMagc5A3Gg2QgoIQ3ox?=
 =?us-ascii?Q?hgLGVYz8gLG5njb7r2VdLVxmcsxgENQO2L0bvP9f8qGB2MaoKen+upKABfPV?=
 =?us-ascii?Q?iWt/cpuxNCIb/yE/IqtxDZ4BzwP6RQ1EwffGUiM9BucZxfRanJ2Ccg8tyMkm?=
 =?us-ascii?Q?2vmvqAu0YKVGTCWshXtyMGyd4GenCgvh0tkxQNNTgMsV12zSnktJ4tHAS499?=
 =?us-ascii?Q?jX3xWnfegpOktlbQnxARcRZrjf2RxOBR2hjqfC+ItlcDOulqX3gTd0YKCHnZ?=
 =?us-ascii?Q?SVgXMn14svZaHFD+WRi42gwMjP8FE7X4U28kjklpCEUsPB/683VPOrJmNWXk?=
 =?us-ascii?Q?iptpnj5DrUrGuPnL1cY1hGPr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de650ef9-baf5-4153-d59b-08d96e03bcc7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:20:58.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj1O0qgfJcT8M1ygODVkb+JW0uDXJCC1ton/Ir0AYBa6UH6Us7gJHboc/YlrFE8AHqc7QQN5SXKz85+ATx+u7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020071
X-Proofpoint-GUID: VfFbOyL-XZfQMJcocDU5jypr9Yuys49p
X-Proofpoint-ORIG-GUID: VfFbOyL-XZfQMJcocDU5jypr9Yuys49p
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dd_queued is only being used by show function corresponding to queued
attribute. So compilation without BLK_DEBUG_FS gives unused-function
warning for dd_queued.
Move dd_queued under BLK_DEBUG_FS to fix compilation issue.

Fixes: 7b05bf771084 ("Revert "block/mq-deadline: Prioritize high-priority requests"")

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3c3693c34f061..3c45838daf12c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -926,6 +920,12 @@ DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_READ, read2);
 DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_WRITE, write2);
 #undef DEADLINE_DEBUGFS_DDIR_ATTRS
 
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 static int deadline_batching_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-- 
2.30.2

