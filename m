Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C1C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 07:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiG1Hzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiG1Hzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 03:55:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1350738
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 00:55:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 313DD1FB1A;
        Thu, 28 Jul 2022 07:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658994953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irILcUqztOy9FLI31Hfz4RVE1KgxWVLjW8cWMZO4p3I=;
        b=O2VU2F5KPZ5jOrqf7o1LI6poiQaqP5W3fvzp5WYy4NBMyDgRSgE7aidu4hUo0XxLIAFLce
        TIteBOU1k5cVwTsUzPl4ABu2r/j5kvd8Zv0+KstIUniRzMwSNi2eiHzFHOsMCBeGOnkrDr
        Kt9PAA4PBXd5OTpYYsHJKPbfkL94nZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658994953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irILcUqztOy9FLI31Hfz4RVE1KgxWVLjW8cWMZO4p3I=;
        b=MXz7bMDI6klyEJblVT6jZVrJ1/aq4PX9jhPXYvQFQuPZMYV/ay4i0Eq67NzCjJELHAo9j2
        VL1jBFOnvMTQkfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B9DD13A7E;
        Thu, 28 Jul 2022 07:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TIRuBglB4mK8IAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 28 Jul 2022 07:55:53 +0000
Message-ID: <c55c272c-0bb2-d651-5bb1-5e9b5b052788@suse.de>
Date:   Thu, 28 Jul 2022 09:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/6] block: change the blk_queue_split calling convention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220727162300.3089193-1-hch@lst.de>
 <20220727162300.3089193-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220727162300.3089193-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 18:22, Christoph Hellwig wrote:
> The double indirect bio leads to somewhat suboptimal code generation.
> Instead return the (original or split) bio, and make sure the
> request_queue arguments to the lower level helpers is passed after the
> bio to avoid constant reshuffling of the argument passing registers.
> 
> Also give it and the helpers used to implement it more descriptive names.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c             | 98 +++++++++++++++++------------------
>   block/blk-mq.c                |  4 +-
>   block/blk.h                   |  6 +--
>   drivers/block/drbd/drbd_req.c |  2 +-
>   drivers/block/pktcdvd.c       |  2 +-
>   drivers/block/ps3vram.c       |  2 +-
>   drivers/md/dm.c               |  6 +--
>   drivers/md/md.c               |  2 +-
>   drivers/nvme/host/multipath.c |  2 +-
>   drivers/s390/block/dcssblk.c  |  2 +-
>   include/linux/blkdev.h        |  2 +-
>   11 files changed, 63 insertions(+), 65 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
