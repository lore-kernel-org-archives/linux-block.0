Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E26C63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160EC206F9
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 06:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLCGpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:45:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgLCGpL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 01:45:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C73FEABE9;
        Thu,  3 Dec 2020 06:44:29 +0000 (UTC)
Subject: Re: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered
 by request queue flushing"
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20201203012638.543321-1-ming.lei@redhat.com>
 <20201203012638.543321-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <000de78f-a0b5-bec9-9b1c-7032dd930ac4@suse.de>
Date:   Thu, 3 Dec 2020 07:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203012638.543321-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 2:26 AM, Ming Lei wrote:
> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> 
> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive locking'
> by nvme-loop's lock class, no need to apply dynamically allocated lock class key,
> so revert commit b3c6a5997541("block: Fix a lockdep complaint triggered by request
> queue flushing").
> 
> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it is reported
> the whole probe may take more than half an hour.
> 
> Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reported-by: Qian Cai <cai@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-flush.c | 5 -----
>   block/blk.h       | 1 -
>   2 files changed, 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
