Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA252C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBAB206DC
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxXj1+8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgENIMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 04:12:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgENIMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 04:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589443956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSkVOQXZYOveXGm088cjD1cR/Qf2tSHwZmBbq0N6f34=;
        b=YxXj1+8lY42Qx9dWhkKUivyUOVkjvTbC16baPOm7r/cr6i6EyweiqkIHwNtuNFTEG+Z1mA
        TgABnFvpABmRrrSezqs5k1BNNBYHXMtS9vD5qx4JWDxXwI26/fvywSBi3MmIe6HzN1yGKO
        vC5w4tP5gPtNh15deFi5yKTOP8fzxrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-i14-FcYJN22AJLx2-D0WWw-1; Thu, 14 May 2020 04:12:32 -0400
X-MC-Unique: i14-FcYJN22AJLx2-D0WWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B00835BB9;
        Thu, 14 May 2020 08:12:28 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D2FD5D9C5;
        Thu, 14 May 2020 08:12:25 +0000 (UTC)
Date:   Thu, 14 May 2020 16:12:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH] block: fix build failure in case of !CONFIG_BLOCK
Message-ID: <20200514081221.GK2073570@T590>
References: <20200514014302.2078182-1-ming.lei@redhat.com>
 <20200514064133.GA5058@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514064133.GA5058@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 11:41:33PM -0700, Christoph Hellwig wrote:
> Can you please just move the function out of line?  If we context
> switch it is by definition to performance critical enough to be an
> inline function bloating the callers..
> 

Looks blk_io_schedule() is only called from CONFG_BLOCK code, so it is
better to export it as one symbol.

Thanks,
Ming

