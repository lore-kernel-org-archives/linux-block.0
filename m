Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DDC433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F06619EE
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhCZJAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:00:52 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:56129
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhCZJAn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 05:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJULEFLT7xqhTRcMMk1G/V1vffq//PGpe+bk+6Iiu9E79EMlHpzOi4nSl5+1XYW0FWVZJQTRs+GQp4ipGdVqVlwywcX1vTUGSoB3PBpSEKji0O5d3N2PZy719fWlMiGQzGzVMsHsCFSpc+Q18QnT0QQIhTIqXhKt5xwduqCvThrKa+fApIkjFATGzgmyzLxq1uwSLbPPc6f38QwUz33kIZLAO7Y7cx6pklGu6sfyXHN3nS923bwKZ/Ju508aAHnQfzWzRh1V5IvSc8j8Xu/b+rbuaft4x0ZyJ8WKhRzpxO7h6IHRK8gF53YUjbCHRxpcVRJPuxhOdCyzKUJs+YuLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR5QB6U4BgABRDAGRwqZWomyw2ud4TfdSUu5Dxit4f4=;
 b=XGdrepKUn9SJg1PwEdHkp4to6VZ2vlChhXRF/gNhny5h3m/FtVacEM7p0MWEMYex4SURXJEcbrGKsPyvzBiruMLZs5vSQq8COx/FvGQ6zBP5nnpbcEHa82G3btXWkP6pk8EPfQHBcDmZE9nkVsuqPv71tPqeBFTF+VxbuUQtMm+ldDE5f2VHE3ZM6WGXI3apwri/w3lDDxAamQz4Xxt+eqWuMtK0GfnR4SzpVX5q+Lwz+VB3T1wm5GsKi6lzBc4+y+OCL4bidqHz4jT2VUOC6XXxScUbkXpMjT8B0DhL0NIF+c8ErtW5gn6I+szbewSsrDPleLphOzrp/SaGeCO0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR5QB6U4BgABRDAGRwqZWomyw2ud4TfdSUu5Dxit4f4=;
 b=jRahuSYxIQq10K2UwxIPKE+68DMfPSjBNlJUUxehACEVKy1dKxgBKLF6B39JYUiv+kOosfUK7BfvjlsDWmEtIF7vIaeHg7/CR6sKExNpWvwOkRHFg2pX1ox9df27cQEVmj2OZpQtGjBZgj/10rpIHUWSlnJBIAMmL4pA0v8XqNs=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 09:00:42 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 09:00:42 +0000
From:   qiang.zhang@windriver.com
To:     axboe@kernel.dk, pasha.tatashin@soleen.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] loop: call __loop_clr_fd() with lo_mutex locked to avoid autoclear race
Date:   Fri, 26 Mar 2021 17:00:57 +0800
Message-Id: <20210326090057.30499-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by SJ0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:33a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 09:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec976a41-f84c-4ec0-0a96-08d8f035a1b6
X-MS-TrafficTypeDiagnostic: DM6PR11MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR11MB351458AAAED836F6D00FEA6CFF619@DM6PR11MB3514.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1twHarV45HVShWRZwKWzqyxBQYACbBkWpr3P7IssPikK5qYQjBHdbV8pLk4laKIHdcveeF/Lm/Lh+A1SpqZyOJIFTrze9UfFabm7ZQR/3+wTuwDPDgtlCCOElzSH0IBRIHQYQByo+aXCY+hcezlzfJDQC2cEBcW4C0nsgEhvPAONGbT0q+3PyZZJny7i+2MTbXr6cUiPaU2Xc18VmVS8RYeaF71cbbEGH+FA/FonlqpOAKll+R7390n0pvMsnOhnpoHAnGIIvw0B5YAS35eg4eDJlXwRPeNY85WEFBxJW2y7hAb6C28XBz77JyuYwNWCkwFmrJcYJYe58F/9845pMOeenHMnDxsNXI6dMLJOy9EFeWaFs+PtoeAgRpLGWYerbBbr4ZyTsZSYa0Wxo0qeVi0L1LmTvfBiCTJYG87dKfPuPaHfDjuhMvN4cWO1ubYaIcdX5ilOfE+LhBHvJJbXW9mYOOUC0DKFsFAwk5BPcwiUqj/saCTHFf9whl7oX2BAA1XptccUIRipSAAYX49t/srLxCi4wXVTVcEnN26LprH9CB6fBzOg2zX+3RNFqJyUmvZcXEut7aNbKemK5XSOgxyOTgHaZP9Mfmq7yrgtgdj7QfvC0CwJ6JJmpk6dI5Kgrtt9IPkUwHBZH54zq+kj6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(86362001)(38100700001)(478600001)(8676002)(66556008)(66946007)(83380400001)(6486002)(1076003)(2906002)(66476007)(8936002)(6512007)(316002)(186003)(52116002)(16526019)(36756003)(6506007)(5660300002)(6666004)(2616005)(9686003)(956004)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pa+h4HwHHURzX7Qm2893tC9Q7nw8/x2miNwKxKketrCVI+Q9vtVlGyZwujd6?=
 =?us-ascii?Q?CzL7iVXe4e56ZKNuu03F1nT6GZJUDUUEF2BbkNB6zLrqRxMFUXKFhDSD7lh8?=
 =?us-ascii?Q?+korxUVJLBpKC3Fm3rRg+BO0DKU9XsqXX4Ru7eTCnzkxnggMMbu/NHuzO8uy?=
 =?us-ascii?Q?dRIQJqMKoEls6vl3wrmvNhdDh0llkhW8EgttNq1qS19vNMs42vx32rxeRgrb?=
 =?us-ascii?Q?tWud4xdLq4shIdkc1raz3R+wKp3JCyxYrqV8u7r9KJCquzWuw7CQ+VTetioU?=
 =?us-ascii?Q?OKfscCjnVDVh/Egv3VOnC24Rc+OPuKREBgd46XbmU1MiIyugjDf4QznLdFLb?=
 =?us-ascii?Q?JEN6RGNFzDwSMPQ8XIJJXsELOYfsXPCKg2B0hjaMVd5wNA82UCnB+to5259f?=
 =?us-ascii?Q?cOhSI0BBkGpcOOpXAxL6leFkVcr2osyFoDl+sClOGWd516rNj8CayWZXSDTO?=
 =?us-ascii?Q?0lqj65uakWCsGKeprxaSyDyqBNMyWeNm/dOOvMXbScADlusjtAlS9ultiB3h?=
 =?us-ascii?Q?FaUUNglFYgQqD3899HgQk/h0PUl36a8WO6Jz6K8oKnztr+g/RCfwAQe67+4X?=
 =?us-ascii?Q?/OmqE/fOEDCs3yghAKQK7J7mWTRXOFaNO7nMZw1w1YvjZ5vB6Fh1MLNpdDZn?=
 =?us-ascii?Q?L7CmR+aqmCYR0DuLkmSjSBWatn0WT0Zc3CVPn2aohRj/fgszp3KrtKicZYY/?=
 =?us-ascii?Q?G6RJ8aaAs+l/oF9CBtAQRqirI51fFSzTe4tq/kzhheB2ct3RO+CP/DIiRFlN?=
 =?us-ascii?Q?3jMoiIKXymS7T5HRcj/s6Coal7ubCPdTec8V292B7wifFm2rwqHGQmsS6f3b?=
 =?us-ascii?Q?Yp40ISWFhpD3bCdPSdowgYU7rBp8XoxVlMZJ4fByR+rMqVm2yJRaK8omM+uj?=
 =?us-ascii?Q?EneC6aYXRyie28jbV3+DVIGWLPnU9qQzleDaHuWeg23RdYfl7dp9BUneMzqu?=
 =?us-ascii?Q?Ji5+d5b+eoJYOmGs+mpiU3xTLG4xPsItg5Tb5v8Fr0rXjWvRy3WMF+kUACzc?=
 =?us-ascii?Q?0uFazWxYzYaj181azM/IQs81SjSUl9dbnsvy43wMRPfkEVGkTBfLQp2GbPzH?=
 =?us-ascii?Q?nHkhs0DAEcCSbUeyo68B6r/G8uqjCKz7AP+t6JrzuEoKm5nqxiXquU+Pj9tR?=
 =?us-ascii?Q?1pluUcUEYF496jBv7ZSVkWmKbWQEeGFb+FDiFwUnQx9JqOVpybn86yVHygC6?=
 =?us-ascii?Q?zqyYIZzNkEoBgUq18ifO1YsK7zOv4jv+5SKnrSTHrP/wGgu1PHCrsP6WBYjt?=
 =?us-ascii?Q?uMjqECQhHNqLHHulSImttaOel4FVi8duacxIQbcL3EFCfcOdEIgzUXG7fWgO?=
 =?us-ascii?Q?SS7GUizkIaoPT72D0fn0e19D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec976a41-f84c-4ec0-0a96-08d8f035a1b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 09:00:41.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ3OvXmH2tU6HTXUoQkVm1ahjemI+DTQ5ewvEvNEb66VGK8IPLDWSq9NVvWyytMje5P9xie/Z8Mw6odcYgl1a9qe1i12Rx6AulUzKta6WSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3514
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
       data race

When different tasks on two CPUs perform the above operations on the same
lo device, data race may be occur, Do not drop lo->lo_mutex before calling
 __loop_clr_fd(), so refcnt and LO_FLAGS_AUTOCLEAR check in lo_release
stay in sync.

Fixes: 6cc8e7430801 ("loop: scale loop device by introducing per device lock")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify the title and commit message. 

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

