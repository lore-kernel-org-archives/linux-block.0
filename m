Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36BAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiDYJWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiDYJVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 05:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6484B237E4
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650878318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ig/+0EmVB9vwQi6vn0R3x6vvKSqzKUefU9W9v3HstWs=;
        b=JYwlVY3NgpUltPU2fOw+t3ieRmAxxBk2wu8rOobU78ktR/s2AL8yJo3E6m0I+2sr5C3wJG
        U+u6ub1uPcg0OTAA2b720y5m1om5wOr0TdLrejz8tFoLaAsGdfB++RL8Oj03AknaoL5r4b
        dmt9tT2cL5LZlQJKwwpO7gmxrWiAC5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-Bh7ip-TwMZa_cGGVxW4AVg-1; Mon, 25 Apr 2022 05:18:33 -0400
X-MC-Unique: Bh7ip-TwMZa_cGGVxW4AVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6B5218812C6;
        Mon, 25 Apr 2022 09:18:32 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC95F1468942;
        Mon, 25 Apr 2022 09:18:27 +0000 (UTC)
Date:   Mon, 25 Apr 2022 17:18:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmZnXeZlip5z0QLm@T590>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <20220423162937.GA28340@lst.de>
 <YmUXPA4EE5jOo1yz@T590>
 <20220425074918.GA10320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425074918.GA10320@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 25, 2022 at 09:49:18AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 24, 2022 at 05:24:12PM +0800, Ming Lei wrote:
> > > As the debugfs directory use the name of the gendisk, the lifetime rules
> > > should simply match those of the gendisk.  If anyone wants to trace
> > > SCSI commands sent before probing the gendisk or after removing it
> > > they can use blktrace on the /dev/sg node.
> > 
> > Not sure blktrace can trace on /dev/sg since blktrace works on
> > block_device.
> 
> Unless someone broke it recently it does.  Take a look at all the mess
> it causes in the blktrace code.

But /dev/sg and /dev/sdX can't be opened by blktrace at the same
time.

Thank,
Ming

