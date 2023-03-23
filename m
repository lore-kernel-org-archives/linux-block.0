Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C52C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCWITI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCWITG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 04:19:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443722FCDA
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 01:19:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95D2868AA6; Thu, 23 Mar 2023 09:19:01 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:19:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/3] block: Preserve LBA order when requeuing
Message-ID: <20230323081901.GA21977@lst.de>
References: <20230320234905.3832131-1-bvanassche@acm.org> <20230320234905.3832131-4-bvanassche@acm.org> <20230321055802.GA18078@lst.de> <6325fba6-3dac-9391-28ef-177fcae9ad0a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6325fba6-3dac-9391-28ef-177fcae9ad0a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 07:46:51AM -0700, Bart Van Assche wrote:
> On 3/20/23 22:58, Christoph Hellwig wrote:
>> On Mon, Mar 20, 2023 at 04:49:05PM -0700, Bart Van Assche wrote:
>>> When requeuing a request to a zoned block device, preserve the LBA order
>>> per zone.
>>
>> What causes this requeue?
>
> Hi Christoph,
>
> Two examples of why the SCSI core can decide to requeue a command are a 
> retryable unit attention or ufshcd_queuecommand() returning 
> SCSI_MLQUEUE_HOST_BUSY. For example, ufshcd_queuecommand() returns 
> SCSI_MLQUEUE_HOST_BUSY while clock scaling is in progress (changing the 
> frequency of the link between host controller and UFS device).

None of these should happen as the upper layers enforce a per-zone
queue depth of 1.
