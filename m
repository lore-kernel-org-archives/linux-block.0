Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B6C43460
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEE61155
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhDNVUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:20:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43094 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhDNVUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 17:20:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13ELFvW7176458;
        Wed, 14 Apr 2021 21:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=TXVE9LEeb5Hg5E0kTeemqA9teCC2YWBiJDwc/unnR/U=;
 b=kkMKdc2PV+cCLd71ZoCFodurcH7lEGk8/oh1WjADxFGngvMJw+uSrRWU/x0IbSejvTZ0
 kQ6Egbz7etZzxb+KdNpUw+R0sEjxczPwPTej4+TwwcDLf6YoENf5FsbLFgBQGT0Tb5og
 g0AlUFAElbJrY1IcsGVsOMHFKD1HQlgKzG2vn3RTmXY7fDpYyrLghcKrECgphfzH4zaZ
 RkTIbM0hTIG/R3ce7sE15r48+QMHm8eMviqjOfcHVm0W7GkXzOSGbXHtBCj7rl6sg7I7
 AVDunN7G90YCjXlJWWpMhY0y+6OdrrTMoestQfkk7WDoOFm4g/E8L58+N2Q7uiHPndkC Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37u1hbm06x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 21:19:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13ELESTO101158;
        Wed, 14 Apr 2021 21:19:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 37uny004rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 21:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtorXHRDlVRyDAoTuBTboeT8eX6aJoA45X+dufHOh77vkdWLVVykWIPHn2whls8O9STQ7zL6m6mo2pe8db8rWkKOG8DOJJnVr02KznIoM0PGtpnUlzjf4ri1WoyjDTQDGUqXioKUFSO2AJLca1iQBRG/4YFn5EM1551wpVMvELzAL5BYlYJnsdsX3ZuU8KwMKDWT/nF/JLw3wDanHgvrkhf24KfacMft0BUKshUszTgNG0rKTz+USaDyOZ92hosi85bdidbiDu4sqcZxok3OGPZ6HWowaTD4DmqWtPiflxA+YJf1Ba4oR04y324NW2tzrewGnXwRvnmAOTZfyGmsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXVE9LEeb5Hg5E0kTeemqA9teCC2YWBiJDwc/unnR/U=;
 b=TwaaKSGU9zk529Qi797W+cRaVtVnAsUd1/bwD0gzOYeaZKteZ98uhK4AoLMXktTi7Xf3M7cs6lL15AQfNPsQC8Cxh8fldNjQ4rsGtmPUYFrlTXpUDakPjr24t6QZOcprBYVU15iT8FRakqJJDxnVU6AiYNYI5xcI/o9D/T2Z7KJYB6aYmSMaYPEpMtePXyjqhY7Hh/HWdIshaFgziajcvTKbTjfw5FkI4dLoTWjvgVpwF2H+gOhWw8IrkB+tbm9fimd2QVZRtrqOEvJrgwA2/pzo2gwVqoPKuP3j63cR1sBsllAqq53Kcw0Gus2DABrJNgaLDgCXcKB1gGdz+vpO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXVE9LEeb5Hg5E0kTeemqA9teCC2YWBiJDwc/unnR/U=;
 b=QzbljKNFI8PyoVH69aX0bJdchB3zH50foxqBY/Nc/gFeR4yE8uhVJlgxJ09HIII6WhSF7+i/QYo0nkrpZjwq+dhi33Tk0270/KpfSFLsACkMhLS3gEsUz+x3sDCYd/2lXsfs+f8WEZiroVWpsGLmuuohWMK83LaeJV4HMkm36rc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BY5PR10MB3940.namprd10.prod.outlook.com (2603:10b6:a03:1f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 21:19:48 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 21:19:48 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [PATCH] block: fix io hung by block throttle
Date:   Wed, 14 Apr 2021 14:18:30 -0700
Message-Id: <20210414211830.5720-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-238-183.vpn.oracle.com (73.231.9.254) by BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 21:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6d7833-a947-4a79-e808-08d8ff8b08ac
X-MS-TrafficTypeDiagnostic: BY5PR10MB3940:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3940F32DE27D75BB3975071EE84E9@BY5PR10MB3940.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKTl/dzIAXlpM+2YXl18W2WRN1MfBgD2LbQS04vqBGW0bkoO9tPckslC5MuTEDYe4O1vQPFkuoLxX03Viumggz4X3PkGJSk1As4yigXEMeu4iO3WRY2eYuxIb9K0jGClk10nNLuHvNW4usmWPbFVGWcv/NXV+Piw9LaXY/5Rn3x95glYDLCvZqCLUwTkAp/fpTq0iwypNqIrgTZdBU90IA6hF6+qqKNLAI7gnwFokgi7Syr68skfZP47V+4xIxVvktPeGemQNEpo4btoyb3V6mAdTUFbveEz+Uo4PptF9b1xPqSfAIMau+nlV9HnaGpHBmpW0jMSRaVfLhYuXO8FXR8Z+jTiLOo4DZB/iIiatAEo8h1uki++Ena9M0L7RAPEhZwS3GfRuvnLP6tH3GYC/gnVEjDLJyrCgEyIjnqzw2eN/8yVZGfGq5c2fsmtR5z/fw4HWh922WrWiisDdheDJJqN0gB5XwtaTNu0xXJcIcIuBDC6C1kDR1fvV47pCvICezISIsBZRoju34Oq42QplsUMlgLwWVkKu/CqBXtn0n1WdtHMLutikA25ZJ/BH3GJXIFPg3efgiX5y8+D9zoChGrmw0abkCrwSei+odteH+yxZsF/lDOcmJIaQGUQas9EMQ8PTq2FLZDJuNUbKBm24O0tzXUdFIP7Qdm0wTS2qEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(7696005)(52116002)(44832011)(1076003)(6486002)(8676002)(38100700002)(4326008)(38350700002)(2906002)(26005)(186003)(16526019)(66476007)(36756003)(66946007)(316002)(83380400001)(478600001)(5660300002)(6666004)(8936002)(2616005)(66556008)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uhd9wf5bsxcABdnJ3TUjA5qo+fEjEacEssSI2HcCG73MsP2/0ktOLHxxe+DX?=
 =?us-ascii?Q?TonLaRsAoCPbScbqhch1lJySYp2hvlE7mLiznBKjbQRZNaG28FRU2CSt9Qho?=
 =?us-ascii?Q?5UmqfJrZyk1m0qFPbDVm3MFSQCjZoAoixWbU45oIscHyimtsPAYUQxpuhY14?=
 =?us-ascii?Q?BFjAavsu+CS82tFHLsXnRU9NTCp4nDJ19UsYwiHcwdecEuF5z5O7gwGy67sT?=
 =?us-ascii?Q?mw4RCGFOmL/TUh9wH41+/OBMMFWZy5lXTs+hSg0utcZhwxphSczcJto1VD2K?=
 =?us-ascii?Q?qfQpwj+X5MWoJalrEOJEF6mULL1tY/92/e1mV9lv/fRuEpSMrhg6q+ROT2hR?=
 =?us-ascii?Q?eRhlcBQXUBZUBMsB28maptsUqdE4QRQK3DbbLs/IbnLIjkC6GUKqvOaQqM5p?=
 =?us-ascii?Q?fqKzC022VRuGuMrzsvD7GmhIcQHBYiLWjB6biMZ11JJXIzVhuX4D+ZOLf3xm?=
 =?us-ascii?Q?QPyEQ5fk0bdyDrzzGl6p0jtEra2HI2G2+UvMlZTv3VESmETMMQuu9gz81u4F?=
 =?us-ascii?Q?UpAPQwprHqm/7nNBTrn4I1qZrPS+ChN2qnVPIzob/o60fHi+4xKBM3/Q+UYF?=
 =?us-ascii?Q?16h+D8U71JSm9AzTRbZsUS71CPVQryhFZiLr86eBKhY8sq2dfWk4/8CeYI1h?=
 =?us-ascii?Q?0klYjQqX4M42vMpJYnf4zZplFbnZlS+L/v6pbEEKsF+dakcoICqo5naMDVCW?=
 =?us-ascii?Q?nRHr94CGqhmPrx4uCf0/vHUYVGj/Gpck+8j7EpftUfI1WAX5z4hTo7+I/y+i?=
 =?us-ascii?Q?PNXC12sjJEZ88jlxU+ETpkfnVeFzbnrTGSPecrwtb8/wugFtJR0LBs102hfC?=
 =?us-ascii?Q?V38OkXYLC3eTGkJQBke5N341MAcCyI7TJqPnxdh4qIOse+cHXJQRaQYsQPIl?=
 =?us-ascii?Q?tk+9Nke8eiaX8zr/bmVe+eUMV1PGeGR9PVwmNvBwqg4llBF6EF9Pwm9cTvT4?=
 =?us-ascii?Q?p2VjDykjWP5mnWK196Ku5FOek0ruEpm7OCn00vBl1HRnvJ7WN80W6Xxi8AjL?=
 =?us-ascii?Q?tdkrkn3EyXKwpCsj4JhuCpdLm9Hz9JeuM0ER/sZt79hJstsO4Aq1RFg7t/Sr?=
 =?us-ascii?Q?FmYDZt9Tq+rnd8fSd2aOmHG3NDHwqZvMwe91tdG+l8fArR8oy6ZcsQCclOFY?=
 =?us-ascii?Q?jQjGTkYn2vxYUPoFN4G0klivYJp+WLmckFwk//Sz0BYqyRDdbYHe+DkOXSjy?=
 =?us-ascii?Q?1loL3v0ySs1RXbm6etQK9qPPInxp8Nq4OKGQ0TD1GnBfNHWZodljY7G8Uhpd?=
 =?us-ascii?Q?cB30xDasDcImWvTG3eyYEQP954PGrY/GglEBEz+hXVYh4Wi/9WacVoNxjRgH?=
 =?us-ascii?Q?DqlRHCk8ZdbgbMQDLj6yDGa7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d7833-a947-4a79-e808-08d8ff8b08ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 21:19:48.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YP4el9c9+6ZhZhAoTQ5hXU5C3aLQmi4+QFqIlIQkq6RiQlI5sni0RymQ4MOsge3JRGB1XmJ8g1TaSPwAyqrfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3940
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140137
X-Proofpoint-GUID: VBj_4rb1LGXDqX2j6xI-1ze-NGQVVl8G
X-Proofpoint-ORIG-GUID: VBj_4rb1LGXDqX2j6xI-1ze-NGQVVl8G
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race bug which can cause io hung when multiple processes
run parallel in rq_qos_wait().
Let assume there were 4 processes P1/P2/P3/P4, P1/P2 were at the entry
of rq_qos_wait, and P3/P4 were waiting for io done, 2 io were inflight,
the inflight io limit was 2. See race below.

void rq_qos_wait()
{
	...
    bool has_sleeper;

	>>>> P3/P4 were in sleeper list, has_sleeper was true for both P1 and P2.
    has_sleeper = wq_has_sleeper(&rqw->wait);
    if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
        return;

	>>>> 2 inflight io done, P3/P4 were waken up to issue 2 new io.
	>>>> 2 new io done, no inflight io.

	>>>> P1/P2 were added to the sleeper list, 2 entry in the list
    prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);

	>>>> P1/P2 were in the sleeper list, has_sleeper was true for P1/P2.
    has_sleeper = !wq_has_single_sleeper(&rqw->wait);
    do {
        /* The memory barrier in set_task_state saves us here. */
        if (data.got_token)
            break;
        if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
            finish_wait(&rqw->wait, &data.wq);

            /*
             * We raced with wbt_wake_function() getting a token,
             * which means we now have two. Put our local token
             * and wake anyone else potentially waiting for one.
             */
            smp_rmb();
            if (data.got_token)
                cleanup_cb(rqw, private_data);
            break;
        }

	>>>> P1/P2 hung here forever. New io requests will also hung here.
        io_schedule();
        has_sleeper = true;
        set_current_state(TASK_UNINTERRUPTIBLE);
    } while (1);
    finish_wait(&rqw->wait, &data.wq);
}

Cc: stable@vger.kernel.org
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 block/blk-rq-qos.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 656460636ad3..04d888c99bc0 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -260,19 +260,17 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		.cb = acquire_inflight_cb,
 		.private_data = private_data,
 	};
-	bool has_sleeper;
 
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
+	if (!wq_has_sleeper(&rqw->wait)
+		&& acquire_inflight_cb(rqw, private_data))
 		return;
 
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
-	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
 	do {
 		/* The memory barrier in set_task_state saves us here. */
 		if (data.got_token)
 			break;
-		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
+		if (acquire_inflight_cb(rqw, private_data)) {
 			finish_wait(&rqw->wait, &data.wq);
 
 			/*
@@ -286,7 +284,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			break;
 		}
 		io_schedule();
-		has_sleeper = true;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
-- 
2.24.3 (Apple Git-128)

