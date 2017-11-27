Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751951AbdK0MPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 07:15:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vARCEB43064499
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 07:15:40 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2egj56shwg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 07:15:39 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Mon, 27 Nov 2017 05:15:38 -0700
Subject: Re: [PATCH V2 2/2] block: drain blkcg part of request_queue in
 blk_cleanup_queue()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171123044800.25251-3-ming.lei@redhat.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 10:15:31 -0200
MIME-Version: 1.0
In-Reply-To: <20171123044800.25251-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <21cce8c8-bf03-314a-6c73-234bcfee7fc4@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/23/2017 02:48 AM, Ming Lei wrote:
> Now once blk_freeze_queue() returns, all requests(in-queue and pending)
> can be drained, but we still need to drain blkcg part of request_queue
> for both blk-mq and legacy, so this patch calls blkcg_drain_queue()
> explicitely in blk_cleanup_queue() to do that.
> 
> Then the __blk_drain_queue() in blk_cleanup_queue() can be covered by both
> blk_freeze_queue() and blkcg_drain_queue(), and tasks blocked in get_request()
> are waken up in blk_set_queue_dying() too, so remove it from blk_cleanup_queue().
> 
> Cc: Wen Xiong<wenxiong@us.ibm.com>
> Cc: Mauricio Faria de Oliveira<mauricfo@linux.vnet.ibm.com>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

All disk pull tests completed successfully without I/O hangs (24 disks).


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
