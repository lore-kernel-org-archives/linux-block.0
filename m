Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF806CDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJTRJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJTRJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 13:09:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21BCA
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 10:09:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B487C433C7;
        Fri, 20 Oct 2023 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697821752;
        bh=eWD+Adzj/v2h0Z2nAsdfUjQtNIPGZlsELZD/XCkarcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayxwV5WPb0DpgRE7P9klWfunOOKJkgPKNs+gqYlWZTyOwCXGF0frMT6MITkM5UBNO
         ydS6ib980YAlmuJBCZYEywyrFUrjd+YUvogZzX4NbCbhmJWsqVvVcxTPXuDNQf4RCh
         gz+KPVLKpQn+TEZN6/7CxR6wbBRcRYxShcY2uq1W5EBb6Y8XgP72pBLV+AUZB4FwnM
         mqaxB3jmNT7OLmwhDXfZtWtqRV+q6usAg6kKPpoTrKx4khLn7d1uFNXooURZoMC0pb
         lgdBdMZ6KyaTCh+MBRvTCJt8QUbVFcXLEYM6j/hlEXGYEx9bpvg/hrLkIDrjN+unx4
         7fLZ6uG6Df0dw==
Date:   Fri, 20 Oct 2023 11:09:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
 <ZTKqAzSPNcBp4db0@kbusch-mbp>
 <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 20, 2023 at 09:45:53AM -0700, Bart Van Assche wrote:
> 
> On 10/20/23 09:25, Keith Busch wrote:
> > The legacy block request layer didn't have a tag resource shared among
> > multiple request queues. Each queue had their own mempool for allocating
> > requests. The mempool, I think, would always guarantee everyone could
> > get at least one request.
> 
> I think that the above is irrelevant in this context. As an example, SCSI
> devices have always shared a pool of tags across multiple logical
> units. This behavior has not been changed by the conversion of the
> SCSI core from the legacy block layer to blk-mq.
> 
> For other (hardware) block devices it didn't matter either that there
> was no upper limit to the number of requests the legacy block layer
> could allocate. All hardware block devices I know support fixed size
> queues for queuing requests to the block device.

I am not sure I understand your point. Those lower layers always were
able to get at least one request per request_queue. They can do whatever
they want with it after that. This change removes that guarantee for
blk-mq in some cases, right? I just don't think you can readily conclude
that is "safe" by appealing to the legacy behavior, that's all.
