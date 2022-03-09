Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE5C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiCIBQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiCIBQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 858B2D21E0
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 17:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646787984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8m85lnJLq03SGtqd1pZEbZANvTc5wOe33M+qWpdorc=;
        b=FSZf4rNiYNTgouDb+j3D4jCAO53giYz9ZlJQ/ZbWRlZfxUuCi+mBLNomfEY2Kx7fwWl4Fe
        lyTghlQnjUj5+wb+h3H2AQyLEBdBUzXwXKv2LJH4+3Pvy40f8pS+6ZKcIPCVffHTJ+ZFJN
        r3uiS7UyFunwCxOFeV3S0fe0H4v5Aoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-hnCHeVVkOqmGqNkgxz2nRA-1; Tue, 08 Mar 2022 20:06:21 -0500
X-MC-Unique: hnCHeVVkOqmGqNkgxz2nRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B3A1006AA7;
        Wed,  9 Mar 2022 01:06:20 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BFFF60C66;
        Wed,  9 Mar 2022 01:06:05 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:06:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] blk-mq: kill warning when building
 block/blk-mq-debugfs-zoned.c
Message-ID: <Yif9efz0Gv1YNwpW@T590>
References: <20220302003431.1253287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302003431.1253287-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 08:34:31AM +0800, Ming Lei wrote:
> Fix the following warning when building block/blk-mq-debugfs-zoned.c:
> 
> In file included from block/blk-mq-debugfs-zoned.c:7:
> block/blk-mq-debugfs.h:24:14: warning: ‘struct blk_mq_hw_ctx’ declared inside parameter list will not be visible outside of this definition or declaration
>    24 |       struct blk_mq_hw_ctx *hctx);
>       |              ^~~~~~~~~~~~~
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- forward declaration of struct blk_mq_hw_ctx instead of including
> 	  header, as suggested by Christoph

Hello Jens,

This patch looks missed, can you take a look?

Thanks,
Ming

