Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 00:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiCWAel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 20:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8D301EAF6
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647995589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2M0LiFyVNVzuALo6Yr1XgbsnYE0HiRYpBPRPrdOU24Q=;
        b=D3tERQc5Sb+10sr+rjKK8utI1Lmd1rwB9ZNQyJJfW8xbibta9OQPtoXgDTK4zjtM5z0uYM
        HZgBLvJuJwYCbVPcnt/E56Wjo2JdhYrLoFjsICIjQmVqMDzhg4e4NuaH5W+qIbR1YqD8x/
        fjoJyqC49FXz/dPEZhdjfA7X3XVYb+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-mAX6EYdjOTiBEuJDhMetxQ-1; Tue, 22 Mar 2022 20:33:07 -0400
X-MC-Unique: mAX6EYdjOTiBEuJDhMetxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C26E8038E3;
        Wed, 23 Mar 2022 00:33:07 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C10EC26E9A;
        Wed, 23 Mar 2022 00:33:01 +0000 (UTC)
Date:   Wed, 23 Mar 2022 08:32:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Message-ID: <YjpquAY3l9qdOzmE@T590>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
 <20220318130144.1066064-3-ming.lei@redhat.com>
 <20220322093322.GA27283@lst.de>
 <YjmjplwpQpkOlimQ@T590>
 <Yjn9JBT02ZbSdRbb@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjn9JBT02ZbSdRbb@slm.duckdns.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 06:45:24AM -1000, Tejun Heo wrote:
> On Tue, Mar 22, 2022 at 06:23:34PM +0800, Ming Lei wrote:
> > One solution is to delay 'blk_put_queue(blkg->q)' and 'kfree(blkg)'
> > into one work function by reusing blkg->async_bio_work as release_work.
> > 
> > I will prepare one patch for addressing the issue.
> 
> Ah, so, this is the report. Can you please include the backtrace and
> reference to the patch you posted?

OK.

Also I guess it has answered your question in another thread.

Thanks,
Ming

