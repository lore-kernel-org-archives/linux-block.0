Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A0C10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C6320855
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qp7Olwdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfDDKEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:04:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51944 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfDDKEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 06:04:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34A3mXF158589;
        Thu, 4 Apr 2019 10:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=7PcHI9HmkoOGUNLPVEDRBmxeIfCM+qtgtsTpdsPRKN0=;
 b=qp7OlwdvJ+C95CWG6NmlsUyaQB6BBneaEYdW1uJbxB6q2E00aJoPt7KZO1Hq90vSBDA2
 6dJ4ecCquYZGM4boqonr1R/QD5KxoDudr8zKjq+KPzo/bCIN308T57J3DpadsCv1yUBG
 WwvgHF7I7ppJphXQGJX01ur/fnr2zH4yYd0umk0u4+1caMB7O+rnsZzG9gBgkq2ytgxx
 eU9jTgpCdz3ulpnPkBKebgpfSuapK3LZZo2QRpQHHIY/k6LLwoc8xIxQeixT1qDVRQD6
 XTOMk3ymZwVvNz738lxiBlVsMblpxFbDX/1jpFXy1icfdzy4u+OcsUaDmKj+jQ64FYBf fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydea30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 10:04:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34A2SWX074919;
        Thu, 4 Apr 2019 10:02:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rm8f5tn9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 10:02:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x34A2UOl000999;
        Thu, 4 Apr 2019 10:02:31 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 03:02:29 -0700
Date:   Thu, 4 Apr 2019 13:02:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] cpumask: Introduce possible_cpu_safe()
Message-ID: <20190404100218.GA26946@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040071
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There have been two cases recently where we pass user a controlled "cpu"
to possible_cpus().  That's not allowed.  If it's invalid, it will
trigger a WARN_ONCE() and an out of bounds read which could result in an
Oops.

This patch introduces possible_cpu_safe() which first checks to see if
the cpu is valid, turns off speculation and then checks if the cpu is
possible.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 include/linux/cpumask.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..515179760c54 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -11,6 +11,7 @@
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/nospec.h>
 
 /* Don't assign or return these: may not be this big! */
 typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
@@ -102,6 +103,7 @@ extern struct cpumask __cpu_active_mask;
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 #define cpu_online(cpu)		cpumask_test_cpu((cpu), cpu_online_mask)
 #define cpu_possible(cpu)	cpumask_test_cpu((cpu), cpu_possible_mask)
+#define cpu_possible_safe(cpu)	cpumask_test_cpu_safe((cpu), cpu_possible_mask)
 #define cpu_present(cpu)	cpumask_test_cpu((cpu), cpu_present_mask)
 #define cpu_active(cpu)		cpumask_test_cpu((cpu), cpu_active_mask)
 #else
@@ -111,6 +113,7 @@ extern struct cpumask __cpu_active_mask;
 #define num_active_cpus()	1U
 #define cpu_online(cpu)		((cpu) == 0)
 #define cpu_possible(cpu)	((cpu) == 0)
+#define cpu_possible_safe(cpu)  ((cpu) == 0)
 #define cpu_present(cpu)	((cpu) == 0)
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
@@ -344,6 +347,21 @@ static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
 
+/**
+ * cpumask_test_cpu_safe - test for a cpu in a cpumask
+ * @cpu: cpu number
+ * @cpumask: the cpumask pointer
+ *
+ * Returns 1 if @cpu is valid and set in @cpumask, else returns 0
+ */
+static inline int cpumask_test_cpu_safe(int cpu, const struct cpumask *cpumask)
+{
+	if ((unsigned int)cpu >= nr_cpu_ids)
+		return 0;
+	cpu = array_index_nospec(cpu, NR_CPUS);
+	return test_bit(cpu, cpumask_bits(cpumask));
+}
+
 /**
  * cpumask_test_and_set_cpu - atomically test and set a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)
-- 
2.17.1

