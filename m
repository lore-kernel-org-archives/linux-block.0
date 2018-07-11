Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:42404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKJOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jul 2018 05:14:18 -0400
Date: Wed, 11 Jul 2018 12:10:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jbacik@fb.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] block: introduce blk-iolatency io controller
Message-ID: <20180711091036.v23v536aq45o23s2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Josef Bacik,

The patch d70675121546: "block: introduce blk-iolatency io
controller" from Jul 3, 2018, leads to the following static checker
warning:

	block/blk-iolatency.c:820 iolatency_pd_stat()
	warn: impossible condition '(iolat->rq_depth.max_depth == -1) => (0-u32max == u64max)'

block/blk-iolatency.c
   813  static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
   814                                  size_t size)
   815  {
   816          struct iolatency_grp *iolat = pd_to_lat(pd);
   817          unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
   818  
   819          if (iolat->rq_depth.max_depth == (u64)-1)
                                    ^^^^^^^^^
This is a u32.

   820                  return scnprintf(buf, size, " depth=max avg_lat=%llu",
   821                                   avg_lat);
   822  
   823          return scnprintf(buf, size, " depth=%u avg_lat=%llu",
   824                           iolat->rq_depth.max_depth, avg_lat);
   825  }


regards,
dan carpenter
