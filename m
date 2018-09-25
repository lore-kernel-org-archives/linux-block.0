Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeIYGre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Sep 2018 02:47:34 -0400
Date: Tue, 25 Sep 2018 08:42:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: clean up physical merging helpers V2
Message-ID: <20180925004232.GC14386@ming.t460p>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 24, 2018 at 09:43:45AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, cleans up the code a bit
> and removes not nessecary includes from the block headers.
> 
> Change since V1:
>  - dropped the Xen related changed which are moved into a new series
>    to be sent after this one

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
