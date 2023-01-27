Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AC38142
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjA0HFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 02:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0HFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 02:05:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3610DA;
        Thu, 26 Jan 2023 23:05:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 904861FEB2;
        Fri, 27 Jan 2023 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674803117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wd8xgRRUTIVdNOaI3TqxJ7HbVqeTrKQd21CSSsNgKKM=;
        b=QmLaQlaDO9eRneRVTIPn5P2pU9jHr2A27cy22etuTPuXdPERraoKajj6mEjftJfyISQNgb
        GZCIZJ8U0taBjD2Yd1UY2ir4qqBw8XVHEOPPR+IlylGT9PF7xb7/zqIguHqxQvOQGX2HUs
        ac1gnX4Nd9W7HQfzICXcsFzelvpk7hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674803117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wd8xgRRUTIVdNOaI3TqxJ7HbVqeTrKQd21CSSsNgKKM=;
        b=SlwZhIU10HwzyMQeZWpkPlhSURgBBrgYWNa078sqDiPDFdHqBJRuUeFEMXxlGB/ez3FpHz
        9EdrFl4l2IRvKXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CC3A1336F;
        Fri, 27 Jan 2023 07:05:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id evzNF61302ObUwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 27 Jan 2023 07:05:17 +0000
Message-ID: <6c05179a-62fc-f041-da08-8c95a61be742@suse.de>
Date:   Fri, 27 Jan 2023 08:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 07/15] blk-wbt: pass a gendisk to wbt_init
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230117081257.3089859-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 09:12, Christoph Hellwig wrote:
> Pass a gendisk to wbt_init to prepare for phasing out usage of the
> request_queue in the blk-cgroup code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-sysfs.c | 2 +-
>   block/blk-wbt.c   | 5 +++--
>   block/blk-wbt.h   | 4 ++--
>   3 files changed, 6 insertions(+), 5 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

