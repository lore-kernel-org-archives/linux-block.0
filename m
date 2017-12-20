Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754303AbdLTXMc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 18:12:32 -0500
Date: Thu, 21 Dec 2017 07:12:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH V3] block: drain queue before waiting for q_usage_counter
 becoming zero
Message-ID: <20171220231213.GA15493@ming.t460p>
References: <20171129235635.20292-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129235635.20292-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 30, 2017 at 07:56:35AM +0800, Ming Lei wrote:
> Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
> ("block: Make q_usage_counter also track legacy requests"), but that
> commit never runs and drains legacy queue before waiting for this counter
> becoming zero, then IO hang is caused in the test of pulling disk during IO.
> 
> This patch fixes the issue by draining requests before waiting for
> q_usage_counter becoming zero, both Mauricio and chenxiang reported this
> issue, and observed that it can be fixed by this patch.
> 
> Link: https://marc.info/?l=linux-block&m=151192424731797&w=2
> Fixes: 055f6e18e08f("block: Make q_usage_counter also track legacy requests")
> Cc: Wen Xiong <wenxiong@us.ibm.com>
> Tested-by: "chenxiang (M)" <chenxiang66@hisilicon.com>
> Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- V2 can't cover chenxiang's issue, so we have to drain queue via
> 	blk_drain_queue(), and fallback to original post(V1)

Hi Jens,

This patch fixes regression caused by 055f6e18e08f merged to v4.15-rc,
could you consider it for v4.15?

Thanks,
Ming
