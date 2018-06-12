Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:56758 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeFLKEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 06:04:43 -0400
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: Regarding the recent new blk-mq timeout handling
Message-ID: <88c22c6d-8482-8854-6e9b-88605eab3735@oracle.com>
Date: Tue, 12 Jun 2018 18:04:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens and Christoph

In the recent commit of new blk-mq timeout handling, we don't have any protection
on timed out request against the completion path. We just hold a request->ref count,
it just could avoid the request tag to be released and life-recycle, but not completion.

For the scsi mid-layer, what if a request is in error handler and normal completion come
at the moment ?

Or do I miss anything about this commit ?


Thanks
Jianchao
