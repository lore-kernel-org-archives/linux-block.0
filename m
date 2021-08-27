Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62FC4320A
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D98161004
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbhH0KBf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:01:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244751AbhH0KBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6Ig98025578;
        Fri, 27 Aug 2021 10:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2/L9ivNLUT7gSkdZgYy5hsKGC3S0XOpB+9d3IiMWVlk=;
 b=fojWmw7Rrrw20CcqNWevh39R6Jfd6rrHBgaomfFIvp/MrU8+brDY/EGZkpVt0JBihiPN
 vsg7gdzZQ+84rshWijzT0UQLTDnPkt1/faAClILUuMjUGu491tfWVI/k/swSzl40xtj5
 KvtYa6u9P35sqBp5pWQjJYTXvpfOvzNuhmtJ5JdPULrTn/txKwCmQ7Bd3J2JvtMhbRhU
 hXvHLvH4z9BLoLWx7+T8Z69LhAWOdnZu1u/JrLsi+Uoqze7VYrwUCG0C/DG7XJwZQmzG
 eTBwvpzHiI/BcOWEVlC3I+dH2TNGvBorINOSUZo4AZarHU7MmPiwypvAsOqB5+zLjBbp oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=2/L9ivNLUT7gSkdZgYy5hsKGC3S0XOpB+9d3IiMWVlk=;
 b=x3bxwmWqovAC1Qs914Wv8SSQdVblR9WMsJvkAOB8n4Ngbjh/hnF1o6FAu+JL5sqg+jCB
 1OBTyShUVm94iI1VyFHYlqZAfNAaDN/RT5472OaRRPZW2fZj2HlrRE8nz0i5+4t2k25O
 BNHFVaDI1f0S/PkYZGvfdEwqE2GwOz60Xl1zdtrXEmUUmrxb+KYgonQxaQ1gMnTRASWs
 Q0S3GzDvZ316l3IHKrV9cvCZ5vo8M7sAwnHyeybHTDxpCY20QUCVM2wo9Kisz+hpfrKr
 y1T91buv6P8aPb3V29SREdc7/HUjGa4Yc/XxHQF9+AYyiXtOn7Ej2FGS5g2/X5FxrsLW wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap3eaubma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 10:00:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R9tbH7000895;
        Fri, 27 Aug 2021 10:00:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3akb91u3c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 10:00:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8lj6BFccUyCm7UhBuwIm2wfJNaSHeP8IECCHb5sIoGQCcIIf1LQlNndmJTYdv45R/RWUKaG9cy4Yd6VcI2VL4u1pBS/G3Q/P+osaNtpSD8TvWa9RDz+kaXq7prJ4/kTXKSKybyhJVCsvJ39veSh7j9zyrZ6gbXvw14pXN49S6kvoQ2f6c3dAgyV8WOLEonHnWe+OUTNBq5+6pyRXYb6+FlE2+OY2vR9gwSzkksp5p0wg86BcPuIn39XfUfKn7C0M4dHh9NqAbVUI8+ngFfNxHX8R4a188DHoUkhBpM12Dy7+t9VS5PLJ/OJvf6ncWFIWHncM6c752Fw9ouM0CfXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/L9ivNLUT7gSkdZgYy5hsKGC3S0XOpB+9d3IiMWVlk=;
 b=S3ienioRS0417TJiDDWnfDIhhp6HWKyPmMCSgZtd9+P1+F6TtlbQoyBaJHS2bBQ/Ef4V85cRJ8+0frb+I/Cer29v5WdGy5ZbIcmaHVP8lYH4SAsEeJ3fvWI038QSKLUbiacW0ERHLCp6hAdVeivolSn6DyE/AmrjroKx0KRupR09sWD5lf/r2zEGQXKYY8TAm7CdPY3MCH/ZUDCQRHqgWjVDBWC04Q1cvS5pKWCBe/e/WLcg6obQGaEdFkgI1Ks4ljfkIFCwYXdmKNAT7zeFIdk5EsDvcRgBel6qQoTfRh7Rgxo8CQI3/GqMaAH0kXr9VouMG3JguYl2qYkB7LEwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/L9ivNLUT7gSkdZgYy5hsKGC3S0XOpB+9d3IiMWVlk=;
 b=eJK6mwPfGmDEd2QdwclKxLJGB6OCfRMC7gS6qGCTWw5ZvAhinGoaC5Ipbd/VuSUxjhahErN3+zO/U3v/iG9U370Uvk8yT6tBu/0MQy3jiBiMhKynP4QJNe/kAXmlucqHXldVnQUwjMycRrw9+35tRXixg1iUrGAyuccF1OfChRs=
Authentication-Results: cyberelk.net; dkim=none (message not signed)
 header.d=none;cyberelk.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4689.namprd10.prod.outlook.com
 (2603:10b6:303:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 10:00:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 10:00:35 +0000
Date:   Fri, 27 Aug 2021 13:00:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] pd: fix a NULL vs IS_ERR() check
Message-ID: <20210827100023.GB9449@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Fri, 27 Aug 2021 10:00:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b26a204-a964-42af-f291-08d9694183bd
X-MS-TrafficTypeDiagnostic: CO1PR10MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4689B7A9D3AFE719DE8D27A18EC89@CO1PR10MB4689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ki+OSQMxtGBLfvxP5wSpTd5Nwkvu4BbWKm0dwiChf4Ro/hKJmNxBYbU2mpZt5d3Vn7NzgIb9WYW4rkFiPxq2ytvj2vGOxg14uFUiwysgnUxp7kl1VC5Crf0Ao7KgqcWqrbQqaqmdB0iWMDbH4geLPWKentqtfUpWZTLEzqi5p8Cn+HwZ3W5MkW1lPeQMo+CPvi8TZTMc4cbgPeXNm6VHqTSb+foLQsXE4rP5ySI3eGYisztubI4tgtf3An/0aiq+VE38o6bIR9CVornRn06dxU/b4QQhibD0BpY/Wr24yHgVqSHH3oQF5ZTfaJaWT/T3WK1H7ofYoI0PSbnoKxvAoo48aGl/npLZBPJUQr87G+5spagWPXRtGgLKrI3RmhyuO2rgijp0wVL/2rBl1FYXCzFaIbqnl6mJKls9kmFx3ui34FRXKnAIO6/zYM1bqdU5ioUHAXyawlAmsThvVvEq1UXoiWrFLivrEaLXo9Oefex7IeWhuKMkOy4Kk7m6pzy4qWO+rJTwMQkGWgLOZcJcJhCHUKYy/+nNilFMdjwloxlqdntqP+pt/QGX5CnLJYDmBS9isM5bNpJjlfyAAr2ikO6WBzsLFb9QDFDQxvvpH7AMxTMPo+f/kNdurd1g74JW7vokV1G7OBeq2ZUbqLy6uid3W8PTj4tW0luO0LQhOD/TyyT3uIYAH2j1WF5kaTImXsh1myiuItbCdB2lehpo+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(38350700002)(38100700002)(478600001)(66476007)(26005)(66946007)(6496006)(186003)(33656002)(8936002)(5660300002)(44832011)(52116002)(956004)(86362001)(9576002)(8676002)(4744005)(6666004)(316002)(66556008)(1076003)(33716001)(55016002)(83380400001)(110136005)(2906002)(9686003)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZhHY6SGBYFrJRp24QUQrfhh7Lq4aBt2kotDGQY6xXejwYyRudXzD4Pueyqa?=
 =?us-ascii?Q?MRsJ1bWJTsrYmfJAZBlco1Yxxw7Ej+fkcDy8/2a+1lSCH1C2t2fYKnMySZyf?=
 =?us-ascii?Q?VU2Xm+mQmgtAJ1gDx3yGEFXXgc388ydLFmRQKWrhU1fJJHVsJkZW+aiKZ2wK?=
 =?us-ascii?Q?ZqSfnldsNb0vGAMVII3jJpOYsnbJztGsPsdLDl0eBq44BVKCLGWHzkFJAUiJ?=
 =?us-ascii?Q?AsEn0YBufxoqKw7JNcGnQQ5zv+oshKRTJ4rnoHd3Pkz2z1g+OKFXmvDHW4hZ?=
 =?us-ascii?Q?6aEBW66HFRzS83Axb9rIThKSggTTxmA90E6zRmXVu16jarFIQe8fIPIvx3tw?=
 =?us-ascii?Q?OPgyaWEjgOaMhk9VmMcTdiOEXkSzRHLDO8fqRwxOWfRCpNSQ9Q3R5dSko/1F?=
 =?us-ascii?Q?n6oqs1nfmMqa9digcWpEhuZ012nwwYfJGIZjSXrG9h1t8FZBxBmUIpW0ZH4J?=
 =?us-ascii?Q?vHE8oYXjSB/+KtOXClPVPk7dUhEHniLpY1aFirBDvTujcfKnAy/Ith5gVo5U?=
 =?us-ascii?Q?5/bNLEbXshq+4aBsfwjvjVVCQOi/043L13MTZjJKj9yZpWaQ4mhHAwoIsKJD?=
 =?us-ascii?Q?hcBfhOUKa6xcYHZNBh1GDbDjf0JAyBmFHjbyBrTvB8rm52bUDwPVuJvF1Om8?=
 =?us-ascii?Q?HkdZP7VMZvnnaSHYMUOfvEGwwe7XSMMR+9Uno5fzomtZvRXyl8UE+aV2wlxV?=
 =?us-ascii?Q?IcZfu7w3FOZi2XrPGtHeQ3K+DBZY5ITKIIGS8EHAattQ1mqMjRc3Ee/Gb+vw?=
 =?us-ascii?Q?ayaPzDLcT6SQt81dDXgdw8VcuI6XSYP2VoT3j7xQmQw87cpJNiH96Nsbx/yE?=
 =?us-ascii?Q?J5AyC4AIfLpzQjmD4gwd4R/o8XuWY0XR6iH3oMP60aSxwK250358VwEFLiY/?=
 =?us-ascii?Q?f6VQqXkisW+VnUWezp23p0luwK0BAG5zqT8kph0JPlFJ0orq2AM/Sg5AQuOW?=
 =?us-ascii?Q?FdfZVyJo2WTfY2T68BubLnUJxQ/n+Dvv35UPsmIXuDl7icaZjdybKFr/jLte?=
 =?us-ascii?Q?lAV1Ft3L/Mz7LZIpd74IBwNccPqTVHQ3ULO/JZU9D+viCJz4ItdIhcgMP3wR?=
 =?us-ascii?Q?EXfAPCnXXUqIoRy6/JyJ91pHT6O4cQu0zhIoaeWKuwGAmyPs5zGrK8awFlQl?=
 =?us-ascii?Q?h7h5Tixcr7snPLWe6JudbCikOc2s4b/cJiq43Xfo0xdZolW1r3gNQBGPA9/b?=
 =?us-ascii?Q?fMfQgxXl17om+8SEM4XRzXl6fz9CgGTt+L21JKjkr2s7/0uUjLOIQ2dTIwlg?=
 =?us-ascii?Q?Buy2e8WiCYK5bpKq+FuBMETo/zz0RLjrEH5B7Y/15PqzwbPizw44Sp094uTD?=
 =?us-ascii?Q?K6tuO99+T1j7Fvd5aWUZiuNm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b26a204-a964-42af-f291-08d9694183bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 10:00:35.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knTfjnkWzb76bcfOu/Skc1Ly77wxuSsjSZd7BgK1QiS4YwVyTVrmKcEAMdIQXgzSwNisN+oBKPbLFFxCLhHAPEE97EXHm3QsnkGw0l8siVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270062
X-Proofpoint-ORIG-GUID: 0RTgir-qIk-5cJLstTa_waYhQmKHQN2v
X-Proofpoint-GUID: 0RTgir-qIk-5cJLstTa_waYhQmKHQN2v
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_disk() returns error pointers, it doesn't return NULL
so correct the check.

Fixes: 262d431f9000 ("pd: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/paride/pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 9b3298926356..675327df6aff 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -892,7 +892,7 @@ static void pd_probe_drive(struct pd_unit *disk)
 		return;
 
 	p = blk_mq_alloc_disk(&disk->tag_set, disk);
-	if (!p) {
+	if (IS_ERR(p)) {
 		blk_mq_free_tag_set(&disk->tag_set);
 		return;
 	}
-- 
2.20.1

