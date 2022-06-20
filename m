Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD1C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiFTIjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiFTIji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:39:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5B12A8F
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:39:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32BAB1F383;
        Mon, 20 Jun 2022 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+GafGs1RY2SrFmt0qOOyR0850MDa7/BR8UDawaidxY=;
        b=fNhHR2k+q43yvt0sigwYo5HwpqER/pbV1QSIJ75uOPUrzVonABY+wHA3KDAaMCneHjpjTq
        wtTWpSTIgNUgfwOmUtAXDQ89xQCcxTB+Wgy2ev6UFHRbJgCstQRzup+V9cPpG2tk3fF1k7
        ol9tLs/OvkLR8MnLAsLnFqn6sXHPBo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+GafGs1RY2SrFmt0qOOyR0850MDa7/BR8UDawaidxY=;
        b=l5g0WN2ou1rOaU35oO1RNoz8zct6p38dyi+XZcMB+Dty+XaUlUdwX85TMChncPz1bXjl3p
        i/J2XRCZBgJ2ZnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2464D13638;
        Mon, 20 Jun 2022 08:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGJ6CEgysGJQKgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:39:36 +0000
Message-ID: <f52b3d44-f899-22a0-9f6c-a90e681f10e0@suse.de>
Date:   Mon, 20 Jun 2022 10:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] block: remove QUEUE_FLAG_DEAD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220619060552.1850436-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> Disallow setting the blk-mq state on any queue that is already dying as
> setting the state even then is a bad idea, and remove the now unused
> QUEUE_FLAG_DEAD flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 3 ---
>   block/blk-mq-debugfs.c | 8 +++-----
>   include/linux/blkdev.h | 2 --
>   3 files changed, 3 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
