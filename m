Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44AC60F48
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhIPNFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:05:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8712 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239809AbhIPNFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 09:05:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBEDWo028338;
        Thu, 16 Sep 2021 13:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tmHAENlpl5x2CprSCvB6Q4hzJRcyFl36lLDHVP96UV8=;
 b=Bja0OD65gjv6Jl1GqK3BR54tlCVrlwuMlnprUy4S7VvAgACmmiFwuKpYm48TnnnS292l
 8e9QVY/Nxa23NUbdF/wXT1divTrSWQUc7eJQwJo0A0cboL0zlmtg2eMnaUZCAwlB22r/
 SfqZDOSG7Vk13dwiT8aUbwXayXX23mQTocL1Gfab5J/HzLVQ11KBF5wumWjIvbr1YWBn
 mvP2JZBi39WoMPGNeqJaQ4DusbT8OosL4QCtjhZubbPMdGFe+fxsGFiKamhAsYlFns8i
 cOX65BwEBQ04EfCv3EqwPlugStm2DO21Ns2oF9btwKy1HPC2o1LWDKAzmhseV45fi7ec 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=tmHAENlpl5x2CprSCvB6Q4hzJRcyFl36lLDHVP96UV8=;
 b=yHO1ITBAB8I1DYCY9MsdsmxE8kN4tLAe0voV92nH6Xjqv4k70SbgwKL8jUYdjCl3iaLa
 pi5IXxNMd9Dy7yPPS1NBE+IHy5xywirNsJIKyMH9VC1Envagt6VAbDxXaSC5gHomGF9C
 shdwGrBiZKBX4vnizYKO34WML/gjJj5fUJaxbWUc27t0VKQlQKiBbSWVOOJatMlf7g8M
 i0IBXeQMQvb+f6Bjqr/fN7RUnpZ6fjd6wgGcmOglE7E5ariv0sxcE+RDwYbhbf8t6I7D
 clV8f/suAK0fYc24MpPHyqUGd9pTsNLBQNReZDOzmI4PQKFPvDSfnf7L7PcH9SmHDeru Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92j1y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:04:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GD0lwU081422;
        Thu, 16 Sep 2021 13:04:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3b0jgg3p2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2cSfNkMTQZE7zubf4ApUe9amQ1FlYfX5l22g9NpX7XayTHjxqjUjrkwpDtGq6GzmqXqZYxZe2YY98vnWgB7uWYlEedntjE65H2IlKSKq/90mYx6ToOQjfl1T0uiDAH9Y8/+hhl//HI67aqpF/NOs4CappCjNt6GiqR1T1ioXf+6njAeZ0E7J7g6/CFlv3W6TXdAdNQxV5NNaDUYkkEKZZZtlWb2lf+Wh2egg02X0K0UEQB2tgFcQGVDxw7sP0ocAUqB+qYOpid4XMJUFnWFTNn2JMYGUB9f1FFL5KFTyL2AfS0li9OhE/mbtWXpBCAPwLSchjh2UH3UFH5ae1tRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tmHAENlpl5x2CprSCvB6Q4hzJRcyFl36lLDHVP96UV8=;
 b=Cbn3BITRleDWmrqe12TJ15mSPeA5R7No5BxFLYpotKjdVUlPrywTHpONmKZwmqWp4a4WyZZNGR58JaCsCDYc5OkPipfCTyDYHuuoZxDNo3ATXHGWU463yTL2lt5tGOH5APpkvLwtz+bPtrKj1vcWI9UREvumEqbDt97d73j56aDrZe4yKSyKYuTyb1goRhN4uINv7k/kv16Pe9/OHV+nqf8AffXAiR6GnnmgEVntMYvvyDIvh+Xh1ggMCJaXznq3uzWg6F45zLXZ+lQbxQrppT4tV6RHPwHMnO3cpQfCC0wmMhdaiXUvRLS2Dlj9uthXAzWRVl9Fc22D7gqAEbv8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmHAENlpl5x2CprSCvB6Q4hzJRcyFl36lLDHVP96UV8=;
 b=sSw0rlhj9r2BeiNmSNCxeuOpmZDkJxsD3PVpWZ9xNlADPYMNWHAXo0U7hOPmqVEm1mVdW0YAvMnmAmGXcd3ahLXE4B9nMgr5QVatLGM4d4XaqP4PtxttaNhOtorvbudtqI5HDbmodbZLg4qwmzCddVvzkUU7TpGyBf6c3KGcXJs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1246.namprd10.prod.outlook.com
 (2603:10b6:301:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:04:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:04:15 +0000
Date:   Thu, 16 Sep 2021 16:04:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] zram: off by one in read_block_state()
Message-ID: <20210916130404.GA25094@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend Transport; Thu, 16 Sep 2021 13:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fadb398-5a8d-4c5d-fb07-08d979127c75
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1246AF442FB7AFC11670689D8EDC9@MWHPR10MB1246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AHUsEs5PkzK2/bmeP1zV7lXdjmvfT1YKYs3CCj2778LLEMpSyaxSSjQt+1PqYpBiz8YnorxB14DV4VTkRiKP59JyTkr2x/ruxxI7GCun5qPb87UVcPqhwTQrsk1BUn+sBxXeeFE0ASDtkJRQAWug2iv3ghW9BMHUYZ83RPp+LYIylZDwVCuPLH+RC/Gm72VoCnVGgHExtPr4ICn4D4LGitxvTYZ5jgEtANbuGbUBsXdDdPwxEZCdyIsaagqSRkYbpptJfkjCDJBnngWSdWeaGtpxjVr99NTLPYCeeSjEOQOHX/cd5lk+H+TFas0b83vHeZL4stT+lxMDg8W9ByrFec1INv182q8/h26JAl2WmfhqA3BRXU8E0YxSC0tkz2vgZDZl/7i8NxQPkKh2jzA68pJblPWmF4tcEJwG6B9HkaD6QqOLmHzK7eF6OWoIpgxRPRtVI/79GLruTo9cOvdxsSSjg+eTjLrW0o2urpnNLaflAoO4RorStE++y9mfhGj7GMOcug9WXpuDsTvrEwv0iTjXuRK4YHrVv1+04GFchTlUZrdRIq9p5YckNGMz9JSVX6FHVmLno2B5IkVSThS/wGSY970ajmHqw/gV750BHJQXsFVERepq8aKZ2f3nyhN50RHMUqFORJ7i1NAZ0kMpAhaL+2A3BsCZpP1SrevHr1lKcVyqz6u2LhLCfUhEG2vKs6tFw2uDCN7oYfN4fv1pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(83380400001)(44832011)(4744005)(478600001)(9576002)(6666004)(33656002)(86362001)(2906002)(8936002)(4326008)(8676002)(33716001)(6496006)(6916009)(186003)(52116002)(9686003)(956004)(316002)(55016002)(54906003)(66946007)(66476007)(1076003)(38350700002)(66556008)(38100700002)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bHfSEQlA4zsWJ4HYPldAyIHSinlXq27NA4t501EFjwoEJwkS/NUvmA08BSI?=
 =?us-ascii?Q?jVjLUEhBAgrivqd7OP+6aZx1iDDbbqtlwVZlpOHVfLVFsHPUUmdqtOLkOu9+?=
 =?us-ascii?Q?4wFHPJTFacvZlMf5mU/1idiPKsNlNgFJJxPOyGo8ryf97dUhXEKUfalOZAxr?=
 =?us-ascii?Q?+qBiqmaD97Z7S5NplFQldRy4kp0sPlUzX+tNxTf3Z3BIPGCMegAW4cyEQbHU?=
 =?us-ascii?Q?PyyJAKl4TOPPRt1rauLxR3lGvkFPOF1O0VwuXRKs8OPnotEgTYU0nSM/GDk6?=
 =?us-ascii?Q?XwtDyHbtd6D7+WzhcXw0E0hQVTy5UyWqLZb6EJJkbqCB6yhRSxZsIPXmPuyO?=
 =?us-ascii?Q?QkMQq/0wPX7FqmIvFbWKqxhw3v+EfW+Cys0RruyB+5ozCjdjLggNvCJFiqff?=
 =?us-ascii?Q?5op7FUM4ArG0PsY1RSCYcUwPEIbJSuRuDGetPkXzIeNcAUPXWO0iBuSGtmkB?=
 =?us-ascii?Q?1QmLCZpbldVb+0w4E177ce66hfvZ3cAF7LzF+zYBIZX8k3mkn+r9FJztBF+a?=
 =?us-ascii?Q?+MKN6aZeurbC8U5gPLJsRBaPnYydoJi+AU4IsNB0gMDAChO+auwVVg9bgvRu?=
 =?us-ascii?Q?z9ZvMlagffyO7B6D0hnQ2wEApfYk7b7wH5QpgO0c7rWAeo5lXdxuVmrv3Dj9?=
 =?us-ascii?Q?UwBZotcCXjWJwccBargK6ryCE3Ul82iu2IoPbN4OkH2NOpOeD7AggOARMF+9?=
 =?us-ascii?Q?TtuZioen66LpVidzDzpX6/BW1b0XyOCwg46I05qgSxnqG68kzZJF0E4gKSJK?=
 =?us-ascii?Q?qdT+fs9cUEjLQeFEYx28bebe/pl1DWHMtJZ2OCOq/cfH/GHCxct9Lb4a1Deh?=
 =?us-ascii?Q?c9kt/jcI1ldZy53IdS4PMJjfNoqcHagLL4wi4uWf8Dm9D/Czg4+YKgIZSrFE?=
 =?us-ascii?Q?f3HzJRBwFWbPHclVT0TGDpXNUUFKlnRQ0OLtUQbvj7OWm07LidryMA/QVGVB?=
 =?us-ascii?Q?Uo3XaGfhM+zkx2Vyz5ga95Aw1dXbomGD8/Iu2dv6az0r0oNbgSY6Dnl1f80g?=
 =?us-ascii?Q?RzaU1LlmhDjHLYW0n+aOXK2JIAEmz2UAdjN/lu+4pvUKorTFfVwyaY18C7Ll?=
 =?us-ascii?Q?Kw1nKmBMF551Rqko5kR7k4cWLkz2zbWdVDjRpbOpPeNB8zINTPNsCkfbvM4H?=
 =?us-ascii?Q?tWQDrsrV6zRjRvMjOZ33+RQNZgrAV7PdjyvfV8E4g5BPdBUJGMkGXQVKFApd?=
 =?us-ascii?Q?2dahVzQy9I/20JJFXjZMSXuOBV7tM+eTFFrLo0GRfMssdO6DLUgDAgxQ2MwR?=
 =?us-ascii?Q?IJ+m6TbAGGHzULwOZPdBQcU9skDr/+PLgiBebRvCS2bZRtCLD9c/36PN2PJ/?=
 =?us-ascii?Q?lJpuGAI1jj7mTdL/B3hjUWjz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fadb398-5a8d-4c5d-fb07-08d979127c75
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:04:15.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDmDF6r5Rs749zx1eJBCR+1Z0Cv38VmHa0e7aePBCdcz2f9IqvY2wW9pZD+3oBkK6L9aPn+OWB3wQNv6vU/0y2tXNcdFGGK65EMpjawTtWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160084
X-Proofpoint-ORIG-GUID: MLOMjTCwjYDAS4MRaUkh5yO4jt6NxT-J
X-Proofpoint-GUID: MLOMjTCwjYDAS4MRaUkh5yO4jt6NxT-J
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The snprintf() function returns the number of bytes it would have
printed if there were space.  But it does not count the NUL terminator.
So that means that if "count == copied" then this has already
overflowed by one character.

This bug likely isn't super harmful in real life.

Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..6383c81ac5b3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -910,7 +910,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
 			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.');
 
-		if (count < copied) {
+		if (count <= copied) {
 			zram_slot_unlock(zram, index);
 			break;
 		}
-- 
2.20.1

