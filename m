Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C4C83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF34208FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUPuFXyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgD2OFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:05:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29467 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgD2OFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 10:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588169134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15mWh+Q+04E+O3p3+W4qaQIE3K1ImLyGac8MlS9sbR0=;
        b=NUPuFXyvKAUnepUN08REGGfAM8eT824kF0soUTqbJGmnwFUQZTEKwfOn2L4KM4Kbp2hbjt
        Cvd/aKkVEbPdM22QmOooEaBpsAZwJbFrjMb7ypYlNujDF1sfyvSoMBL6FJn7Ge0wTmT/3k
        yPJviV5yGalgI/aMlDnI4PohvEHCa/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-4U-OHgS5MwmQkHZ3Cn2JOg-1; Wed, 29 Apr 2020 10:05:32 -0400
X-MC-Unique: 4U-OHgS5MwmQkHZ3Cn2JOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B07118FF661;
        Wed, 29 Apr 2020 14:05:30 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 193705D9C9;
        Wed, 29 Apr 2020 14:05:18 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:05:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200429140513.GD700644@T590>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-7-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:27AM +0000, Luis Chamberlain wrote:
> Be pedantic on removal as well and hold the mutex.
> This should prevent uses of addition while we exit.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e..6dccba22c9b5 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
>  
>  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
>  
> +	mutex_lock(&loop_ctl_mutex);
> +
>  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
>  	idr_destroy(&loop_index_idr);
>  
> @@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
>  	unregister_blkdev(LOOP_MAJOR, "loop");
>  
>  	misc_deregister(&loop_misc);
> +
> +	mutex_unlock(&loop_ctl_mutex);
>  }
>  
>  module_init(loop_init);
> -- 
> 2.25.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

