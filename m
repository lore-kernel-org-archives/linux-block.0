Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A734C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 08:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBII51 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 03:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBII5Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 03:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA155295
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 00:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675932991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEhNc7UlMIZjrolnLzoJH4JHn7TfQ3/f2PGK0ibhGO8=;
        b=EDgVtmbpNjoq6Bn03UVAEaYowhuY/kvVdBF9f+LLYFP0M3Jo4orEUnFoW4sdW8lTwhVxsh
        Ye07bGpxWkfQdzdm8EN5FQCMv8v6HNp+hLwcmvXmYT7KCZSFyqQbj7nf6tVZsql47Z44Yu
        RiPCk2Eq6h6p9JuZilrarBsEIz0W/+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-IufnZA1DN-C-o0HmmcbLKw-1; Thu, 09 Feb 2023 03:56:28 -0500
X-MC-Unique: IufnZA1DN-C-o0HmmcbLKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9E085A588;
        Thu,  9 Feb 2023 08:56:27 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D67418EC1;
        Thu,  9 Feb 2023 08:56:23 +0000 (UTC)
Date:   Thu, 9 Feb 2023 16:56:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <Y+S1Mhzd3fPLqute@T590>
References: <20230208063514.171485-1-hch@lst.de>
 <Y+NRgI+99Gz33BvQ@T590>
 <20230208151231.GA16018@lst.de>
 <Y+Q0mp1cV3Ca6bAf@T590>
 <20230209050401.GA8235@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209050401.GA8235@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 09, 2023 at 06:04:01AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 09, 2023 at 07:47:38AM +0800, Ming Lei wrote:
> > Another thing is that blkcg_init_disk() and blkcg_exit_disk() becomes
> > asymmetrical with this patch. So alloc_disk() & add_disk(), del_disk() & put_disk()
> > have to be done together. If it may be documented, this patch looks
> > fine.
> 
> As in no add_disk is allowed after del_gendisk on the same disk?
> It's been like that since basically forever.  I agree that documenting
> it probably doesn't hurt though - but that's separate from this fix.

OK, fair enough,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

