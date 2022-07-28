Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFFFC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 07:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiG1H5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 03:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiG1H5B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 03:57:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6AF50738
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 00:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA0E637E85;
        Thu, 28 Jul 2022 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658995019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0ZK2qfKFCo/kY4lw60YYT+sBQRMP+h/KpwD3g4eQSM=;
        b=lx12v62B1uBDQ+OeQ5JUCDeIKrkxkMGpHnO6wjOe1TZAR4OURoSJ94d7Su0HIFSKAWf+60
        q3aLlR5bU+BMr70DZhP9gcn6na8STH8NfWpFBv8qNVC+5U+TmIB9knnqiEg9wEgtTeqODM
        YyZVpOgEJ0fmz9fyxPnliSAKcpivZxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658995019;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0ZK2qfKFCo/kY4lw60YYT+sBQRMP+h/KpwD3g4eQSM=;
        b=8N0WZ4ijZ5acS2iuYt7de6bbc4FyObYZfxvtb5nVWhRECOE7b/thA8N1tLY4CUBaBLqOMc
        FW2L04Z0OMEiK3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1E3413A7E;
        Thu, 28 Jul 2022 07:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QApgKktB4mI0IQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 28 Jul 2022 07:56:59 +0000
Message-ID: <7cb33e54-4c21-4839-f270-2ee0b4d79ba1@suse.de>
Date:   Thu, 28 Jul 2022 09:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220727162300.3089193-1-hch@lst.de>
 <20220727162300.3089193-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220727162300.3089193-3-hch@lst.de>
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-mq.c |  2 +-
>   block/blk.h    | 10 ++++++----
>   block/bounce.c | 26 +++++++++++++-------------
>   3 files changed, 20 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
