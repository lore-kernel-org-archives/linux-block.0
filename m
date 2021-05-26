Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A63C2B9F7
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0606D6143E
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEZI1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 04:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhEZI1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMgndj0zBkXWndvoMPdHnzhaYtOQq07fjFQGw13rugA=;
        b=c/q+O5C3Kqr9AIa3CBYjL7o5nleHaSZPx86dRWtHFHrbf8viczD0MFPSrCwpcMk9L2ENKw
        79AcfPE3LvBxtKFSNKR2KV3u5wpl2gqstFFuOJfplWN38tZ4XdvNH5CuTrzpxB3/l8BU/H
        eD6t+m3VBC9FhQoN9fLC7woJwy6kKqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-bbw9ipCiP3eA6sdffDQo9Q-1; Wed, 26 May 2021 04:26:20 -0400
X-MC-Unique: bbw9ipCiP3eA6sdffDQo9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239826D24A;
        Wed, 26 May 2021 08:26:19 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5344660875;
        Wed, 26 May 2021 08:26:10 +0000 (UTC)
Date:   Wed, 26 May 2021 16:26:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Message-ID: <YK4GHgL7h4B+QhNl@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-4-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:44PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the blk_status_t
> result of the request.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
> 
>   Return blk_status_t instead of errno.
> 
>   Removed "extern" header declaration, and named the parameters.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

