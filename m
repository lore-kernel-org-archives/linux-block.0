Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BFDC6FA92
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIVNkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIVNkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:40:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61393F6F
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:40:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23B8D1F8EA;
        Thu, 22 Sep 2022 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663854031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTnTe9ao9zHjAzLNt3DZiwBsoTSDa8ih8vr4D6K0yrg=;
        b=eSMLoiMnYDxj2bLJNgmU96gWgQoycevZ20SZ+1OOeKf2oF9tKJEkTEZw0H/JnMCQqsVy3+
        QfLNHwedYUGSZ3B4yTEsCMXx4z+ueAEhujv48LjR9Et+zZQ+E6QuOR3S+21c42q7i+qloT
        pgoIWRbrSsOa0xclVUQjDXN5KR90nUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663854031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTnTe9ao9zHjAzLNt3DZiwBsoTSDa8ih8vr4D6K0yrg=;
        b=5fPYaHtjv1wp6b9JttmL/76wUq9HeY7oJUHr8tn3T3dPillWa+aYB7J8HdyKNVmKdRGV+/
        lDYF5zgGj99g7cAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E90E413AA5;
        Thu, 22 Sep 2022 13:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id raq0N85lLGPJfAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:40:30 +0000
Date:   Thu, 22 Sep 2022 15:40:29 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 08/17] blk-iolatency: pass a gendisk to blk_iolatency_init
Message-ID: <YyxlzXnatdkuPwaC@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:52PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_iolatency_init as part of moving the blk-cgroup
> infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c    | 2 +-
>  block/blk-iolatency.c | 3 ++-
>  block/blk.h           | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 89974fd0db3da..82a117ff54de5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1265,7 +1265,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  	if (ret)
>  		goto err_ioprio_exit;
>  
> -	ret = blk_iolatency_init(q);
> +	ret = blk_iolatency_init(disk);
>  	if (ret)
>  		goto err_throtl_exit;
>  
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index e285152345a20..c6f61fe88b875 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -756,8 +756,9 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
>  	}
>  }
>  
> -int blk_iolatency_init(struct request_queue *q)
> +int blk_iolatency_init(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blk_iolatency *blkiolat;
>  	struct rq_qos *rqos;
>  	int ret;
> diff --git a/block/blk.h b/block/blk.h
> index d7142c4d2fefb..361db83147c6f 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -389,9 +389,9 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
>  }
>  
>  #ifdef CONFIG_BLK_CGROUP_IOLATENCY
> -extern int blk_iolatency_init(struct request_queue *q);
> +int blk_iolatency_init(struct gendisk *disk);
>  #else
> -static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
> +static int blk_iolatency_init(struct gendisk *disk) { return 0 };
>  #endif
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> -- 
> 2.30.2
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
