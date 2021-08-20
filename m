Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202BFC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E9060FDC
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhHTGKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:10:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 02:10:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3B4E1FD3C;
        Fri, 20 Aug 2021 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629439785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C61MpgPhrwCj7zijiqku7a5djb8fgJRY/G0UP06gNCs=;
        b=mMI3Q3GNJzuHD9EY8hxNqXxQz6cWcXZCi9H8nKS9qjuOaEUwtj4NrN7D82AoTD8E/fY8uw
        qecSQpd/t7wrLHbBt0ASKHRN12IpcAqveOtcYpGfOu4z++GecukU49QUVEFwQ+g/I1lXui
        0ADjZRUdBlrTNePN1Ocs2YGHXk65uGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629439785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C61MpgPhrwCj7zijiqku7a5djb8fgJRY/G0UP06gNCs=;
        b=P6gIMOQb7Q0ICPHnWbQYc4PbnhfT1xEBnC/76WODUMqPJGSBmeM4WMP5iuD2zRybFfRoaz
        xonQvSoZF4h29PDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5BD4D13883;
        Fri, 20 Aug 2021 06:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UHm0FShHH2FsLgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 06:09:44 +0000
Subject: Re: [PATCH 06/11] block: call blk_register_queue earlier in
 device_add_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <91be9421-0455-bf91-c58d-f21b998e6b82@suse.de>
Date:   Fri, 20 Aug 2021 08:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> Ensure that all the sysfs bits are set up before bdev_add is called,
> as that will make the upcomding error handling much easier.  However
> this means the call to disk_update_readahead has to be split as that
> requires a bdi.  Also remove various sanity checks that don't make
> sense now that blk_register_queue only has a single caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-sysfs.c | 9 ---------
>   block/genhd.c     | 5 +++--
>   2 files changed, 3 insertions(+), 11 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
