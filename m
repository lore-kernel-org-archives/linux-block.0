Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25669 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbcKJNeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 08:34:37 -0500
Date: Thu, 10 Nov 2016 16:34:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: tj@kernel.org
Cc: linux-block@vger.kernel.org
Subject: [bug report] blkcg: replace blkcg_policy->cpd_size with
 ->cpd_alloc/free_fn() methods
Message-ID: <20161110133426.GA30610@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[ No idea why it's suddenly complaining about year old code - dan ]

Hello Tejun Heo,

The patch e4a9bde9589f: "blkcg: replace blkcg_policy->cpd_size with
->cpd_alloc/free_fn() methods" from Aug 18, 2015, leads to the
following static checker warning:

	block/cfq-iosched.c:1589 cfq_cpd_alloc()
	warn: use 'gfp' here instead of GFP_XXX?

block/cfq-iosched.c
  1585  static struct blkcg_policy_data *cfq_cpd_alloc(gfp_t gfp)
  1586  {
  1587          struct cfq_group_data *cgd;
  1588  
  1589          cgd = kzalloc(sizeof(*cgd), GFP_KERNEL);

It does feels weird to pass "gfp" and never use it.

  1590          if (!cgd)
  1591                  return NULL;
  1592          return &cgd->cpd;
  1593  }


regards,
dan carpenter
