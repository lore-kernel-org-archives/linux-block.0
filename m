Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF4C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 01:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCBB6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 20:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCBB6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 20:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA74608E
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 17:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677722247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvHi1cbgymUMBTcnwc0YF8t++HMwGmUSrWlZRGvDFiY=;
        b=QxbuLIGeKUMRTSv5GismDiMV6RclGMKuI0LU9A8JX6a3KkeqbxBP9ARv3iTNeB9f92ghOI
        qYXMkJLHXGYiXz21xHBUwSE9T2QryQ6Glpsgt0/6VWQEhepOnsrMYRBJhDhEOgNPcVvuHK
        RWy73b7pnCCzPhKmShddiPVVMnDzRwM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-QnnBZibbOvaANRpIm0Of3Q-1; Wed, 01 Mar 2023 20:57:24 -0500
X-MC-Unique: QnnBZibbOvaANRpIm0Of3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D37800050;
        Thu,  2 Mar 2023 01:57:24 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FAF2492C3E;
        Thu,  2 Mar 2023 01:57:18 +0000 (UTC)
Date:   Thu, 2 Mar 2023 09:57:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <ZAACeb0/Pfw8XN3a@T590>
References: <20230301000655.48112-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301000655.48112-1-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 28, 2023 at 05:06:55PM -0700, Uday Shankar wrote:
> The block layer might merge together discard requests up until the
> max_discard_segments limit is hit, but blk_insert_cloned_request checks
> the segment count against max_segments regardless of the req op. This
> can result in errors like the following when discards are issued through
> a DM device and max_discard_segments exceeds max_segments for the queue
> of the chosen underlying device.
> 
> blk_insert_cloned_request: over max segments limit. (256 > 129)
> 
> Fix this by looking at the req_op and enforcing the appropriate segment
> limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
> everything else.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

