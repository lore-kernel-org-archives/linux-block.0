Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59015 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdJCJQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 05:16:37 -0400
Date: Tue, 3 Oct 2017 02:16:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V5 4/8] block: move actual bio merge code into __elv_merge
Message-ID: <20171003091634.GB2771@infradead.org>
References: <20170930112655.31451-1-ming.lei@redhat.com>
 <20170930112655.31451-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930112655.31451-5-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 30, 2017 at 07:26:51PM +0800, Ming Lei wrote:
> So that we can reuse __elv_merge() to merge bio
> into requests from sw queue in the following patches.
> 
> No functional change.

There are very few callers of elv_merge, just update the function
with the new parameters instead of introducing __elv_merge.
