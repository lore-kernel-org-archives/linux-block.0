Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51603 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750791AbdA1Bx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 20:53:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0RNT9B7075280
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 18:32:22 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2888w16nvg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 18:32:22 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Fri, 27 Jan 2017 16:32:21 -0700
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
Subject: [PATCH V2 0/1] percpu-refcount: fix reference leak during percpu-atomic transition
Date: Fri, 27 Jan 2017 17:32:15 -0600
Message-Id: <1485559936-14133-1-git-send-email-dougmill@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Removed extraneous parentheses. Did not switch to "bool" as that would necessitate
more testing and raises the question whether other platforms might have a different
definition for "bool" that would not fix this problem.

