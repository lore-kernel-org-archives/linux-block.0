Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD817C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 01:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjBOBbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjBOBb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 20:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503DC34017
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 17:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676424638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKU0neX7HspOKwgho4RN5DZrsBuffeJ73oSMJgy2eMo=;
        b=dwgvTI6C3f2kmWYG+NowlT9pfI3DhgL55jadWC08wf1y1iZccFJ3iJMBuVDdHkRF55UYvF
        liu29mJKfa/uFHrjZXBtaCgDLHEQNqigIH1B1Bq2exdc271VNOqFLGeQkYx27eF8Tv1m1y
        Ajw1wYn3oywTZMtIfYQbarWaJIgcdVk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-xW-TbRo9MsWTgZcPn0rg8w-1; Tue, 14 Feb 2023 20:30:33 -0500
X-MC-Unique: xW-TbRo9MsWTgZcPn0rg8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAF5C3815F6D;
        Wed, 15 Feb 2023 01:30:32 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D4ED492B15;
        Wed, 15 Feb 2023 01:30:21 +0000 (UTC)
Date:   Wed, 15 Feb 2023 09:30:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: revert blk-cgroup changs
Message-ID: <Y+w1qFgMNh6mz/GH@T590>
References: <20230214183308.1658775-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214183308.1658775-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 14, 2023 at 07:33:03PM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series reverts a bunch of blk-cgroup patches as one of them
> caused a problem for which the time is running out to fix for this
> merge window

Thanks for fixing these issues!

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

