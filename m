Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4502BEB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 10:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGJKnc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGJKnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 06:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AFBD2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688985771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcqwH1JHB/zMyfnzLAkQxVrnbSRsy6dRa4E0txqsIQs=;
        b=Yao5EYyw67DwO4wlyqPOLgjfDoo4z/DN/Q3ZIZXsEsJRsopKba5XFM1j6y8fVnJx8YkPAJ
        jzVfltJhG6KEXYyHRSmZYrMLaEw/d9owpo0l8qdI9l4g0nPdr6ocXkmBCdJ6soE+6y7cr5
        a0wjIBcaDhrObzY19t93h1VJJsw/Jxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-NwoKJUS-OB6gnRBBDCzZ2Q-1; Mon, 10 Jul 2023 06:42:46 -0400
X-MC-Unique: NwoKJUS-OB6gnRBBDCzZ2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DEFC2999B20;
        Mon, 10 Jul 2023 10:42:45 +0000 (UTC)
Received: from ovpn-8-33.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6960FC09A09;
        Mon, 10 Jul 2023 10:42:41 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:42:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 07, 2023 at 11:46:13AM +0200, Christoph Hellwig wrote:
> max_discard_sectors is split into a hardware and a tunable value, but
> blk_queue_max_discard_sectors sets both unconditionally, thus dropping
> any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
> only set max_discard_sectors if it either wasn't set, or the new hardware
> limit is smaller than the previous user limit.
> 
> Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")

It is hard to say a fix, given discard_max_bytes can still be changed
by kernel. I'd suggest to document this behavior in Documentation/ABI/stable/sysfs-block.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f91..978d2e1fd67a51 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors)
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;
>  }

Userspace may write 0 to discard_max_bytes, and this patch still can
override user setting.

Thanks,
Ming

