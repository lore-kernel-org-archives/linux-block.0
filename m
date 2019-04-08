Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C059C282DD
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2673920870
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hP7L9iKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfDHIMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:12:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 04:12:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3888NqJ139100;
        Mon, 8 Apr 2019 08:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=HiUbrj12MPa2Z7DU5uSYa65BaW2pN4N2CCdbBgsulKI=;
 b=hP7L9iKH7tbatxNfhhBso3njNJkMEorOKASDKceJzbhbq4ZxTh2ZIyeRmWeN8vl2PQtr
 OfYpSf0AvnuGuDOA+Wap1iv8UW0JVUtKdG8YzoQKu8p5o7MslrUKNtq59vb9PS0mMLRC
 0oJsr4AbWEqdQuNX1jQ0epA8BGhSVRrLlKy5tXVGkujBIGtEX/4ukltDOsD22tLi2iOZ
 y1ANXFPjIFG+0Q6j1lvgjFUO5Jf1HesOqJT68//+oEfibl+rTAn2u/Ig9DuV65yBrFKP
 kl1vOp9b2WOJDZ7F50GBNUlzSLdZMAcji2L1SkK3uCYbQvk5cgKYQ/eamJrt0JFudND1 /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rpkhsmp5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 08:12:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x388A1c6096044;
        Mon, 8 Apr 2019 08:10:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rpkehjvra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 08:10:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x388A1MB026277;
        Mon, 8 Apr 2019 08:10:03 GMT
Received: from kadam (/41.202.241.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 01:10:01 -0700
Date:   Mon, 8 Apr 2019 11:09:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/2] cpumask: Introduce possible_cpu_safe()
Message-ID: <20190408080950.GA15239@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404104527.GX4038@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080076
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080076
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
v2: Use nr_cpumask_bits instead of NR_CPUS.
    Split cpumask_validate_cpu() into a separate function.

I still left cpumask_test_cpu_safe() return 0 for invalid cpus, instead
of returning -ERANGE I feel it's simpler to stay consistent with the
normal possible_cpu() function.

 include/linux/cpumask.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..f371e44cb5ff 100644
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
@@ -344,6 +347,28 @@ static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
 
+static inline unsigned int cpumask_validate_cpu(unsigned int cpu)
+{
+	if (cpu >= nr_cpumask_bits)
+		return nr_cpumask_bits;
+	return array_index_nospec(cpu, nr_cpumask_bits);
+}
+
+/**
+ * cpumask_test_cpu_safe - test for a cpu in a cpumask
+ * @cpu: cpu number
+ * @cpumask: the cpumask pointer
+ *
+ * Returns 1 if @cpu is valid and set in @cpumask, else returns 0
+ */
+static inline int cpumask_test_cpu_safe(int cpu, const struct cpumask *cpumask)
+{
+	cpu = cpumask_validate_cpu(cpu);
+	if (cpu >= nr_cpu_ids)
+		return 0;
+	return test_bit(cpu, cpumask_bits(cpumask));
+}
+
 /**
  * cpumask_test_and_set_cpu - atomically test and set a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)
-- 
2.17.1

