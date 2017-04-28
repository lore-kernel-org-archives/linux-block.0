Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965470AbdD1Qy5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 12:54:57 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH v4 0/6] Fixup mtip32xx for scheduling
Date: Fri, 28 Apr 2017 10:54:27 -0600
Message-ID: <1493398473-29872-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

OK, I think we're getting there now. I dropped the RQF_RESERVED
and the tag helper, since mtip32xx can just call
blk_rq_is_passthrough() and know it's an internal request.

We can do another cleanup series of mtip32xx making the
internal requests use the normal blk end_io infrastructure,
and use the provider helpers for mapping data. I think
that should be done separately as a cleanup, keeping this series
as a straight forward conversion.

I've tested this on the following card:

[   56.394162] mtip32xx 0000:81:00.0: Model: P320h-MTFDGAR350SAH

and it works fine for me.

-- 
Jens Axboe
