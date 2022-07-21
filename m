Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD69EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 14:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGUO3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiGUO3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 10:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 877BA81B2D
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658413759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zy9lKE8txHgJYLTuXNKukK+g9DBxs+n9rJQAs9jcMNo=;
        b=HXCNXnNGqT6WopB1Xonf2eWtZViIgwKgFHs+rYrboKABVTCd1ZkbhQRrs5lTinCjve5ufr
        /W1I0z553LNwkmXahNDF36BDebfuvsfMvd7r6k4YoKE3cBCE4Lc7OWSD9CJh59+wuo7IqJ
        tnuxIJfeNeH3/gYOmHY4NPSavjWACQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-uwiC03z4O9-ZprhIqhuVwg-1; Thu, 21 Jul 2022 10:29:15 -0400
X-MC-Unique: uwiC03z4O9-ZprhIqhuVwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E382805B9A;
        Thu, 21 Jul 2022 14:29:15 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9DAD40CF916;
        Thu, 21 Jul 2022 14:29:11 +0000 (UTC)
Date:   Thu, 21 Jul 2022 22:29:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] ublk: defer disk allocation
Message-ID: <YtlisvNeO5XvyPK7@T590>
References: <20220721130916.1869719-1-hch@lst.de>
 <20220721130916.1869719-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130916.1869719-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 03:09:16PM +0200, Christoph Hellwig wrote:
> Defer allocating the gendisk and request_queue until UBLK_CMD_START_DEV
> is called.  This avoids funky life times where a disk is allocated
> and then can be added and removed multiple times, which has never been
> supported by the block layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

