Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0FC6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCOBMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCOBMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 21:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453423C44
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678842720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RrLaAbaQQ8liS3JpotmCZivvj1yZqkGMm60GRC9/iZI=;
        b=Y5IP8uthSPt7lS3Gs7oxZ0m3jgiT3uBaiFyZKBnK8lqwvIWlcrjOxQp+sYy5hJaGV6CxdH
        nNksl/XjKYvguBJZIlX3v1lW3zqZS3D0aiCLelyh7J5KJhoqW5STroWsjriiiTPuDebPJw
        vJ6op+zHeHSOFV/P371PJLpq7gjf36E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-B7sg6ndEPLmTZYTOZXas8w-1; Tue, 14 Mar 2023 21:11:56 -0400
X-MC-Unique: B7sg6ndEPLmTZYTOZXas8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2760800B23;
        Wed, 15 Mar 2023 01:11:55 +0000 (UTC)
Received: from ovpn-8-22.pek2.redhat.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 266FB2166B26;
        Wed, 15 Mar 2023 01:11:49 +0000 (UTC)
Date:   Wed, 15 Mar 2023 09:11:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] loop: Fix use-after-free issues
Message-ID: <ZBEbUQ/mDIbunpeR@ovpn-8-22.pek2.redhat.com>
References: <20230314182155.80625-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314182155.80625-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 11:21:54AM -0700, Bart Van Assche wrote:
> do_req_filebacked() calls blk_mq_complete_request() synchronously or
> asynchronously when using asynchronous I/O unless memory allocation fails.
> Hence, modify loop_handle_cmd() such that it does not dereference 'cmd' nor
> 'rq' after do_req_filebacked() finished unless we are sure that the request
> has not yet been completed. This patch fixes the following kernel crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000054
> Call trace:
>  css_put.42938+0x1c/0x1ac
>  loop_process_work+0xc8c/0xfd4
>  loop_rootcg_workfn+0x24/0x34
>  process_one_work+0x244/0x558
>  worker_thread+0x400/0x8fc
>  kthread+0x16c/0x1e0
>  ret_from_fork+0x10/0x20
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Fixes: c74d40e8b5e2 ("loop: charge i/o to mem and blk cg")
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

