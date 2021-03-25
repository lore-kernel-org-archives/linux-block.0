Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF0C433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 09:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F48161A24
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 09:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYJWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:22:09 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:25377
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229798AbhCYJVw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 05:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G281D/XElcggJpkGlzo3zecyTtKB1N/Ql2VYTbFYV9uSBaDkaOrHNKVhmlUBxJT0QWhVp8+P5z19EX5dUIcyAExhCYjgBPVPL3myB/vG8zQg3JbvmHTPVOJT3WhhJWCKPGOdME/6m6y+ObsDO+0WkIMI06JETArmJV8SQiLLTXu5wp0E6tGNQ8DmpSzTuMC0AC8CnelDiyqx7In1UaQZQAS59ctEOROT1nKZuj5pVSUPuTzAMLEuLm/X5O0TMDNSWaHBN+2w1CF66MnDSDJ6NS/V1+urX/XrId8cmU5pyDR47roYLvsD+ims4bcLygQ6G4WnYc+P8batcanojGP6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/fTf0YL0iyoT5tM1kx/jkXdf8P1uJumZOwojw3WArQ=;
 b=P24S2adGr2B+TQOY+K50UgHEKikPe5MH54VY3asz+tvIk0YlSX5rvSFMd6AiaUxQ0Kam1wN84tKqRis0VeFqNGq+XPdpbLAn8ae7Zq26yNnlpinHsCoTA4QaMj7CJ456dB+qPum3VdvXijOrIgiS/8ls47ESlmmsB91PCJYD0lxMcmXOZblQGZOPwczPDTBPDrvVeCnUr2cfQJ0nsEI1PH7zWGuFp1S/i97Hife7BbI//oaRn8cG9eYsvwYNqvng07JmLyP4WxjRownqdpDi/yvg9b4BjTlseq9hW0XllS7tGZVzaW+Q8FkBwS6SJMklVRkO6XmfdpM9fmGBH0VVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/fTf0YL0iyoT5tM1kx/jkXdf8P1uJumZOwojw3WArQ=;
 b=nC/CZ7ZcdsMT+MxuLxV3p5Yds6bJce4+secuqzMSTg2ZDRa+RCoqkzst+2TnPxSBgwdNfTvZmuSITb6jcz1RiIvMZaezIj6tXXZlH4ibkQGOkRD91wum3VGgzDUhJ6b/x8gvnM2uUEM+1UK0VWZNlbMNf+LUz6wp31HNk2Zyf1U=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM4PR11MB5472.namprd11.prod.outlook.com (2603:10b6:5:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 25 Mar
 2021 09:21:49 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 09:21:49 +0000
From:   qiang.zhang@windriver.com
To:     axboe@kernel.dk
Cc:     pasha.tatashin@soleen.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] loop: Fix use of unsafe lo->lo_mutex locks
Date:   Thu, 25 Mar 2021 17:22:03 +0800
Message-Id: <20210325092203.10251-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Thu, 25 Mar 2021 09:21:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f59434c5-45cd-46ac-b887-08d8ef6f6ace
X-MS-TrafficTypeDiagnostic: DM4PR11MB5472:
X-Microsoft-Antispam-PRVS: <DM4PR11MB5472EBDB3BB8C05CAD27B0ADFF629@DM4PR11MB5472.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNuj+4k7e6/Dq/S94TzupU72mM2vb0y+j4QTargu7MT6pv6+r39tGTzUwxGww5jptbN2quukiYh4BTylHiciUWpopaXO5I4m8LPCSU5hG1jqRXxnzz8NH+9WZYC2IeOArEWVKPW7a7rwq/+TwtGC7ufh/x8IU9P874mxGnZYDxsPHKLkEY1rcH5J2zlg62usJXpjpqlmSyce0NJo9OKKboSEPZ92wIJO2D0vJGeNeD7YDmB9EJRmGJ55r2jATfxh6niaGjgJGiwVtTy0oGX5DasMQI58jWY25usK0NUXJ+licUNBFkIaG/ui3wpxcFaFhXFcAOWjyacOrhDhK0k04akDfgmI9yoi0SGXNOmCGWbO9ydoWANrlN45R1Jwzj0uaoblP3XCZKdBTALh3z1nGlO7jWFhKP68FvOtGTTG8Kzcp6BeNxepHd/zoQOEQIZpEaZlafrVPLoDyS39BzDDWjHIDvX0SyPUr6wbrPYGEYQ2GV/ggkqqQ/jQBjBkMpjY8m0ks70u35ZQxtwG/1O0HRH+SUTAwF+wAXXZsJJ35Bh1j6gZAJqsGT95DDlsAq3chd4ob15Hp2AqnYS1T/f5Wq6v/gKKFdEcbwVSMyFCWVqBK16sl7aXAp5A/JaQGCa1KtaZ/qjmm+eRWdWSYheA1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39850400004)(8676002)(8936002)(478600001)(5660300002)(6666004)(1076003)(86362001)(956004)(2616005)(2906002)(38100700001)(9686003)(186003)(6916009)(16526019)(26005)(4326008)(6486002)(83380400001)(6506007)(36756003)(66946007)(66556008)(316002)(52116002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m29OpzSH4DXsah9hawUX81VBHwxgsDleP8Ks99hBuZgvolRtKinGqg2mRy8t?=
 =?us-ascii?Q?AUXcjCNVVVI/QMrazsTFLXWJHgnga2P7yXgKW0FvdM6Rhn0tmP4OVqBJx2R5?=
 =?us-ascii?Q?YNIK7Yf4eF0It5PaW8beo+0e9GhlLOVMw0r6LeQn+VV/ah/jXDLkUZOwZqH8?=
 =?us-ascii?Q?gQ+P2Hg5bGpzYJ1mGzdJXvaTreW9ohd4rGq54kWEALOw8NeG6Di4hRJEv47f?=
 =?us-ascii?Q?nT0MUDzn7FTGkA7C55AV4Y/ZgO1ykSSXKDrwe+kXqAhYOuztZf37NizN1Vu7?=
 =?us-ascii?Q?p2hxzUdl0AhzEyefhTRDMvjhOMQig430pTufWxOVO4dTP+J50OsvrdjwVGMz?=
 =?us-ascii?Q?weNCwPLJmOk6yQ3FmWZW0+BVCcI+8EO8QtlO5PiBrPSJCxPNhQKXTa2LY0nl?=
 =?us-ascii?Q?cRv9qXv6Zk81klr2s1XYq9xdGvfCVApwZNEczOQBO9Kms4cesjKUVMvy6x5R?=
 =?us-ascii?Q?68yDUXhIbi+61rzB1heOeHIVT/apUvYwGQmXzmc3Tfhp7IRK3+1KLt9EtKSK?=
 =?us-ascii?Q?VtobUZjWqD53nE13OlCk6dFcSeNaXnT1wuxwZyHcUT2QO7p/1Z+FKOAGWDbi?=
 =?us-ascii?Q?rhgViYRUnsJZVA66EMyQidUDtI908KqhVZRqxOhi0iqahq+C0k4wO9FjJgkE?=
 =?us-ascii?Q?Ak/bU50UOQu8zdmuJSRYijrhMs0dyXXpH/0XVQ7wjWpgCsVIAFLSO+YWw+pB?=
 =?us-ascii?Q?7u0gJoeO2RnLZLC+WvDKplOj/52cDrt4LGXHK/x3C4pmPqhvtH7+eSBEHmbV?=
 =?us-ascii?Q?jywXEm7PdCz94ayOYwuwDjQdZzBNwhnafn3t+NMfk7LKjM2nxAVcINordRr7?=
 =?us-ascii?Q?ximLucm2J1CKeyjH8LmADvmhko879kLcERaBntxmm3UmZzOdZfRWg38nW1nL?=
 =?us-ascii?Q?z3LldObqrli7M/VrHAMj4x2a/AigrgOqSAua7ZbvGVTV8oLwuof964XxO/tV?=
 =?us-ascii?Q?yuixM+k1lmn1qxDDM8Vh4ShrBEPrxLlJpctD5TumcOXHJW28vL1F6gsfYs6T?=
 =?us-ascii?Q?XgX2V5Rels+w8f/WmppSWkwYMNIsiF9TxZ+kb57z3KE4IG03TpW72HjGQK0x?=
 =?us-ascii?Q?YH1RyDKWmfMOZ2xdSRT2oQlEvsDlMTTCKsnsHOmqmZDOmz331f2dixGpuxCO?=
 =?us-ascii?Q?dpPG2hfTwsLjfqXNrA4j4vGwvomeCXdGgBY+NoJ2Vks8O0/6Y85InbK62ln4?=
 =?us-ascii?Q?Yxyx51zHYXfV13VEOITxhXXuJ4X3ShCR6AIHdb1zTUyK/t4gR+815/KloxCy?=
 =?us-ascii?Q?W1T8dBhDm2oiFAsTZVFQnCqPmNVtqk+f3w0q5HAWVpDqvL8zcS9hVWrMFyHX?=
 =?us-ascii?Q?4hXvXsPu1MtN6VbnmoYl1uEj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59434c5-45cd-46ac-b887-08d8ef6f6ace
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 09:21:49.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrmOXtLAhhdhYzO3sPQ/Edk7YMaQbPJBz9TvpFdpZp6f1FjFTtkZ9RFyJGXFhFrUYsQvH2LOLp21YDusUUXnscCoViLQp7wCVnoa8TjjHD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5472
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

lo->lo_refcnt = 0

	    CPU0                                 CPU1
lo_open()                                    lo_open()
 mutex_lock(&lo->lo_mutex)                 
 atomic_inc(&lo->lo_refcnt)              
 lo_refcnt == 1
 mutex_unlock(&lo->lo_mutex)                     
                                             mutex_lock(&lo->lo_mutex)
                                             atomic_inc(&lo->lo_refcnt)
                                             lo_refcnt == 2
                                             mutex_unlock(&lo->lo_mutex)
loop_clr_fd()
 mutex_lock(&lo->lo_mutex)
 atomic_read(&lo->lo_refcnt) > 1
 lo->lo_flags |= LO_FLAGS_AUTOCLEAR        lo_release()
 mutex_unlock(&lo->lo_mutex)                    
 return                                      mutex_lock(&lo->lo_mutex)
 					   atomic_dec_return(&lo->lo_refcnt)
                                             lo_refcnt == 1
                                             mutex_unlock(&lo->lo_mutex)
                                             return

lo_release()
 mutex_lock(&lo->lo_mutex)
 atomic_dec_return(&lo->lo_refcnt)
 lo_refcnt == 0
 lo->lo_flags & LO_FLAGS_AUTOCLEAR 
  == true
 mutex_unlock(&lo->lo_mutex)              loop_control_ioctl()
                                           case LOOP_CTL_REMOVE:
                                            mutex_lock(&lo->lo_mutex)
                                            atomic_read(&lo->lo_refcnt)==0
  __loop_clr_fd(lo, true)                   mutex_unlock(&lo->lo_mutex)
    mutex_lock(&lo->lo_mutex)                loop_remove(lo)
                                               mutex_destroy(&lo->lo_mutex)
  ......                                       kfree(lo)
       UAF

When different tasks on two CPUs perform the above operations on the same
lo device, UAF may occur.

Fixes: 6cc8e7430801 ("loop: scale loop device by introducing per device lock")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 drivers/block/loop.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..5712f1698a66 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1201,7 +1201,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	bool partscan = false;
 	int lo_number;
 
-	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
 		err = -ENXIO;
 		goto out_unlock;
@@ -1257,7 +1256,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo_number = lo->lo_number;
 	loop_unprepare_queue(lo);
 out_unlock:
-	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
 		/*
 		 * bd_mutex has been held already in release path, so don't
@@ -1288,12 +1286,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * protects us from all the other places trying to change the 'lo'
 	 * device.
 	 */
-	mutex_lock(&lo->lo_mutex);
+
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	lo->lo_state = Lo_unbound;
-	mutex_unlock(&lo->lo_mutex);
 
 	/*
 	 * Need not hold lo_mutex to fput backing file. Calling fput holding
@@ -1332,9 +1329,10 @@ static int loop_clr_fd(struct loop_device *lo)
 		return 0;
 	}
 	lo->lo_state = Lo_rundown;
+	err = __loop_clr_fd(lo, false);
 	mutex_unlock(&lo->lo_mutex);
 
-	return __loop_clr_fd(lo, false);
+	return err;
 }
 
 static int
@@ -1916,13 +1914,12 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
 		__loop_clr_fd(lo, true);
-		return;
+		goto out_unlock;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
-- 
2.17.1

