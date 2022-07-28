Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D0C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 04:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiG1EiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiG1EiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 00:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E013149B55
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 21:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658983100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DtDWDoVfrxzOEcNfIZXcHuI2LgAUcYjmiM+joGvP8c=;
        b=AvHBrP9J+RGsGmbbBBuL90F56Y4sejgJ80ODR0FYC/hUSIh0H7UWUcRzYcGSr9YGVvwjJw
        7iD7P1lOjLhOJCFQPUb3sjY5MkbqmztCeDNII0e4gSqzSl31QyilKJxbEoUF7EIbAmqS0f
        BegZW8HVwz8UivdaWuCv8QImg4Btc7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-wsfL5aqRNz2GEdk1SYu6SA-1; Thu, 28 Jul 2022 00:38:17 -0400
X-MC-Unique: wsfL5aqRNz2GEdk1SYu6SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA53B1C05AB8;
        Thu, 28 Jul 2022 04:38:16 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2EB32166B26;
        Thu, 28 Jul 2022 04:38:09 +0000 (UTC)
Date:   Thu, 28 Jul 2022 12:38:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 3/5] ublk_drv: add SET_PARAM/GET_PARAM control command
Message-ID: <YuISqrJMQVky57/4@T590>
References: <20220727141628.985429-1-ming.lei@redhat.com>
 <20220727141628.985429-4-ming.lei@redhat.com>
 <20220727162234.GB18969@lst.de>
 <YuHsyusQZYTlUabu@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuHsyusQZYTlUabu@T590>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 09:56:26AM +0800, Ming Lei wrote:
> Hi Christoph,
> 
> On Wed, Jul 27, 2022 at 06:22:34PM +0200, Christoph Hellwig wrote:
> > As stated in the previous discussion I think this is a very bad idea
> > that leads to a lot of boiler plate code.  If you don't want to rely
> 
> But you never point out where the boiler plate code is, care to share
> what/where it is?
> 
> If you don't like xarray, we can replace it with one plain array
> from the beginning, this change is just in implementation level.
> 
> Given it is ABI interface, I'd suggest to consolidate it from the
> beginning.
> 
> > on zeroed fields we can add a mask of valid fields, similar to how
> > e.g. the statx API works.
> 
> With one mask for marking valid fields, we still need to group
> fields, and one bit in mask has to represent one single group, and
> it can't represent each single field.
> 
> Also one length field has to be added in the header for keeping
> compatibility with old app.
> 
> With the above two change, it becomes very similar with the approach
> in this patch.
> 
> IMO there are more advantages in grouping parameter explicitly:
> 
> 1) avoid big chunk of memory for storing lots of unnecessary parameter
> if the big params data structure is extended, and we just store whatever
> the userspace cares.
> 
> 2) easy to add new type by just implementing two callbacks(both optionally),
> and code is actually well organized, and each callback just focuses on the
> interested parameter type 
> 
> 3) parameter is easier to verify, since we know each parameter's length and type.
> With mask, we can only know if one parameter type exists in the big
> parameters data structure or not.

Another thing with putting everything into single structure is that the
params structure will become a mess sooner or later, since all kinds of
parameters will be added at the end, none of them are related.

For example, Ziyang is working on userspace recovery feature which may
need some data which can't be hold in single bit flag, meantime someone
may work on zoned target implementation[1] which needs to send zoned
parameter, and I am planning to add backing pages for handling running
out of pages, which needs userspace to pre-allocate/send buffer to driver
as backing page[s], ... Then all these unrelated parameters are added at
the end, and the single structure becomes fatter and fatter, then become
unreadable and hard to maintain.


[1] https://lore.kernel.org/qemu-devel/fa7de750-8def-c532-8c86-64c7505608e0@opensource.wdc.com/T/#u

Thanks,
Ming

