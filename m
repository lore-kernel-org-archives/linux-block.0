Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7586 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdJLSsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2017 14:48:41 -0400
Subject: Re: [PATCH V7 5/6] blk-mq-sched: improve dispatching from sw queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        John Garry <john.garry@huawei.com>
References: <20171012183704.22326-1-ming.lei@redhat.com>
 <20171012183704.22326-6-ming.lei@redhat.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <2852603f-ce98-9f8e-8d86-1d601445a1ff@wdc.com>
Date: Thu, 12 Oct 2017 11:48:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171012183704.22326-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/12/17 11:37, Ming Lei wrote:
> [ ... ]
> 
> This patch improves dispatching from sw queue by using the callback of
> .get_budget and .put_budget
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> 
> Jens/Omar, once .get_budget is introduced, it can be unusual to
> return busy from .queue_rq, so we can't use the approach discussed
> to decide to take one by one or flush all. Then this patch
> simply checks if .get_budget is implemented, looks it is reasonable,
> and in future it is even possible to take more requests by getting
> enough budget first.
> [ ... ]

Version 7 of this patch differs significantly from the version I 
reviewed so I think you should remove my Reviewed-by tag.

Bart.
