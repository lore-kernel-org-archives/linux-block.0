Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456BC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4721C64FEC
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhCKPAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233696AbhCKPA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 10:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615474826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7dGb8aQpMhoqKwBw4i+yc0H4oau0lAYady+6ZggTSw=;
        b=bkRkWPa+L0HWvitl/OFB7pVSUGimHz3UEUSY+TzQlLNGDBcGlb4ouQeVVzKxV9hP0WiiU2
        qfEl+V7a54zWyydmZfZgnTvFTmzZsydn3qk6w2TaSP7FNTC9v2SqUJpPwZqNdzQ91r5E2U
        f0izbE513WlKD9Ji8Pj4nzXoOkZcOc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Ryi0ezYOMvujvC9EaPIhzg-1; Thu, 11 Mar 2021 10:00:24 -0500
X-MC-Unique: Ryi0ezYOMvujvC9EaPIhzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5B79100C618;
        Thu, 11 Mar 2021 15:00:22 +0000 (UTC)
Received: from T590 (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B0A10023BE;
        Thu, 11 Mar 2021 15:00:10 +0000 (UTC)
Date:   Thu, 11 Mar 2021 23:00:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: rename BIO_MAX_PAGES to BIO_MAX_VECS
Message-ID: <YEowdj5x93RoUqhN@T590>
References: <20210311110137.1132391-1-hch@lst.de>
 <20210311110137.1132391-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311110137.1132391-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 12:01:37PM +0100, Christoph Hellwig wrote:
> Ever since the addition of multipage bio_vecs BIO_MAX_PAGES has been
> horribly confusingly misnamed.  Rename it to BIO_MAX_VECS to stop
> confusing users of the bio API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

