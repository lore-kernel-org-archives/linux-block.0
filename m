Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429EC433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiCGHhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiCGHhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:37:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B05F8C1
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:36:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08063210E1;
        Mon,  7 Mar 2022 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646638612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLV6uHnGzF8N48ynGgmHD2TjfAEB83wkmDbfStCIWcI=;
        b=LJxkdzYMSZQqUWC5A7M7VKlH+WRvhJblUoqZhI/aaLYRI4/X3wCtXZZCS0iHzADdY46KVZ
        kl1AxVPNwVGxKMihcm6ljHdW/qgnlX05RPbIabiKspXYDaJhqS8JuFIOOV6Yu1m32ycmWc
        NurBw7sz/US27rSGDuaHL18GQZlrpOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646638612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLV6uHnGzF8N48ynGgmHD2TjfAEB83wkmDbfStCIWcI=;
        b=aWB7re+pMzGxdqPG0snUTJkEhaarL7GajvWWjMR7Tm///2wc/lSGzUwZuF/UfcKG9+Pk7x
        lx0uh4OiXftZG0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E817113A04;
        Mon,  7 Mar 2022 07:36:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nanzNRO2JWIiVgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Mar 2022 07:36:51 +0000
Message-ID: <bf5c7f13-62d6-23cb-9ce0-2856c86d4b30@suse.de>
Date:   Mon, 7 Mar 2022 08:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V3 4/6] block: mtip32xx: don't touch q->queue_hw_ctx
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220307064401.30056-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 07:43, Ming Lei wrote:
> q->queue_hw_ctx is really one blk-mq internal structure for retrieving
> hctx via its index, not supposed to be used by drivers. Meantime drivers
> can get the tags structure easily from tagset.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/block/mtip32xx/mtip32xx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
