Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751872AbdK0MPX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 07:15:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vARCEI9n128327
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 07:15:23 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eghec3jbm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2017 07:15:22 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Mon, 27 Nov 2017 05:15:19 -0700
Subject: Re: [PATCH V2 1/2] block: run queue before waiting for
 q_usage_counter becoming zero
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171123044800.25251-2-ming.lei@redhat.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 10:15:12 -0200
MIME-Version: 1.0
In-Reply-To: <20171123044800.25251-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b55cb58d-12ef-3f6e-7a2b-66b6b4b349f4@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/23/2017 02:47 AM, Ming Lei wrote:
> Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
> ("block: Make q_usage_counter also track legacy requests"), but that
> commit never runs legacy queue before waiting for this counter becoming zero,
> then IO hang is caused in the test of pulling disk during IO.
> 
> This patch fixes the issue by running queue in blk_freeze_queue_start() like
> blk-mq before waiting for q_usage_counter becoming zero.
> 
> Fixes: 055f6e18e08f("block: Make q_usage_counter also track legacy requests")
> Cc: Wen Xiong<wenxiong@us.ibm.com>
> Cc: Mauricio Faria de Oliveira<mauricfo@linux.vnet.ibm.com>
> Suggested-by: Bart Van Assche<bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

All disk pull tests completed successfully without I/O hangs (24 disks).


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
