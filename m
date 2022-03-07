Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC38C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiCGHga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiCGHga (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:36:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D65F4F8
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:35:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9158621112;
        Mon,  7 Mar 2022 07:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646638535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcH9jiAecxMlzI0pOxrzwdOw/6hy652vcHnL49KKxFQ=;
        b=PB9Mh/lMuJUfPv7T3VTGKs0ADpAQl/yQWqD0+alpjkUHTnSw4CqoKbJmo+n3FSMa8WA8wg
        NxRePlaUkzGlYBcg0DHKNvg9lVotlUddc5AWtbJ9jumJUP+C7cprjPjeSuZWBJLGuzDVJe
        8WNN8knT0k0NkUDmaa3QqIXTKM6bgHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646638535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcH9jiAecxMlzI0pOxrzwdOw/6hy652vcHnL49KKxFQ=;
        b=DAZBvrCbpg8vNHaLHmUGzRZRxdk2De//VWGpAZSSYTfIIJLfMcYVEOYV/ktdpHMcsBVEOp
        T1xVQP+s4B//MjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728A313A04;
        Mon,  7 Mar 2022 07:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YxBnG8e1JWKtVQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Mar 2022 07:35:35 +0000
Message-ID: <f0bebba6-19b4-a698-a416-e3c174ad4ecf@suse.de>
Date:   Mon, 7 Mar 2022 08:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V3 2/6] blk-mq: simplify reallocation of hw ctxs a bit
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220307064401.30056-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 07:43, Ming Lei wrote:
> blk_mq_alloc_and_init_hctx() has already taken reuse into account, so
> no need to do it outside, then we can simplify blk_mq_realloc_hw_ctxs().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 33 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
