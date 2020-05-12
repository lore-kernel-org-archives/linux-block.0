Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B06C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9C02071A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpYLi358"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgELCoU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 22:44:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727892AbgELCoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 22:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589251458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaK0IuNYU+fidUkhDc3DSrcKtfzteU2hEgoXtsiaY6c=;
        b=RpYLi358jHhbCs31S9kDYPyB6LZYerglG5kUohqENvM9zrjw6LQaELjhHORfcNKmLRntex
        Q/Du+/Y6xR+RKPJXPPmnndAAeikrU58KNB6C2GHvA1rxSDJDh8sX5lAm9hDeG/iKi0tokZ
        DldXpHEqPy+f8wyjW26hOUsxvdT5UOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-nMjEzZpvNAWv-OxB7pKrZA-1; Mon, 11 May 2020 22:44:14 -0400
X-MC-Unique: nMjEzZpvNAWv-OxB7pKrZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A2E18FE860;
        Tue, 12 May 2020 02:44:13 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAF94600EF;
        Tue, 12 May 2020 02:44:07 +0000 (UTC)
Date:   Tue, 12 May 2020 10:44:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH V3 0/4] block: fix partition use-after-free and
 optimization
Message-ID: <20200512024402.GE1531898@T590>
References: <20200508081758.1380673-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508081758.1380673-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 04:17:54PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st patch fixes one use-after-free on cached last_lookup partition.
> 
> The other 3 patches optimizes partition uses in IO path.
> 
> V3:
> 	- add reviewed-by tag
> 	- centralize partno check in the helper(4/4)
> 
> V2:
> 	- add comment, use part_to_disk() to retrieve disk instead of
> 	adding one field to hd_struct
> 	- don't put part in blk_account_io_merge
> 
> 
> Ming Lei (4):
>   block: fix use-after-free on cached last_lookup partition
>   block: only define 'nr_sects_seq' in hd_part for 32bit SMP
>   block: re-organize fields of 'struct hd_part'
>   block: don't hold part0's refcount in IO path
> 
>  block/blk-core.c        | 12 ------------
>  block/blk.h             | 13 ++++++-------
>  block/genhd.c           | 17 +++++++++++++----
>  block/partitions/core.c | 14 ++++++++++++--
>  include/linux/genhd.h   | 24 +++++++++++++++++-------
>  5 files changed, 48 insertions(+), 32 deletions(-)
> 
> Cc: Yufen Yu <yuyufen@huawei.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hou Tao <houtao1@huawei.com>

Hello Jens,

Ping...

thanks,
Ming

