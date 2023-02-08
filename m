Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD89CC636D3
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 23:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBHXsf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBHXse (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 18:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D11BDE
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675900070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ExfQDE7KVxDLO1+U8yNlS/arOOh7tfNvhIJCfgg/6E=;
        b=YyFT0YDCe7ZSNvQ4wTdD0abRxi7EBllsFx5oZ2LofSnRVgnR8Wm9X+px8HKx3JNKbAAcj7
        kRkTX9uBBtgA+n0oON5xsNb9bEZ+XPTOWucQZ4Yt3/kKux9mw1CTMqEdW9IskxO3VPjjLd
        9qi1EeD2yXodn/svj8AMc66e7by5eKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-SC1IHkYiPFuKnfGsKjkDSw-1; Wed, 08 Feb 2023 18:47:47 -0500
X-MC-Unique: SC1IHkYiPFuKnfGsKjkDSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B293811E9C;
        Wed,  8 Feb 2023 23:47:47 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7254E18EC2;
        Wed,  8 Feb 2023 23:47:43 +0000 (UTC)
Date:   Thu, 9 Feb 2023 07:47:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <Y+Q0mp1cV3Ca6bAf@T590>
References: <20230208063514.171485-1-hch@lst.de>
 <Y+NRgI+99Gz33BvQ@T590>
 <20230208151231.GA16018@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208151231.GA16018@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:31PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 08, 2023 at 03:38:40PM +0800, Ming Lei wrote:
> > > This now can cause a case where disk_release is called on a disk
> > > that hasn't been added.  That's mostly harmless, except for a case
> > > in blk_throttl_exit that now needs to check for a NULL ->td pointer.
> > 
> > With this way, blkcg_init_disk() could be called before q->root_blkg
> > is released in disk unbind & rebind use case, then memory leak?
> 
> q->root_blkg is now disk->root_blkg.  So in an unind and rebind case
> a different disk will be involved.

OK.

Another thing is that blkcg_init_disk() and blkcg_exit_disk() becomes
asymmetrical with this patch. So alloc_disk() & add_disk(), del_disk() & put_disk()
have to be done together. If it may be documented, this patch looks
fine.


Thanks, 
Ming

