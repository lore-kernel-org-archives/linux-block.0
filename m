Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31444C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 08:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJSIUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJSIUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 04:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB47B783
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666167641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXZBvfNAfi6luas85qTQSWuS6SyKZHjVv+hOV8o6mUU=;
        b=TcgHbawd5bzvzdVmJm45s1yxcPSVLdVIwosn9hZjpNoWknx0m3fKnnfHD6mrjdxb6RsM9h
        vNYEKpRdoQMubJUkoTysDEpTeKhvqpJ5DbQty4f5gU1AHpqvTa+di9WJUFb78ZKQ1eieqd
        iG9yS4NR4FYXITNbHYwOyHdm9CmqCy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-sYYUZg2lMLCIv-hW0rz_jA-1; Wed, 19 Oct 2022 04:20:39 -0400
X-MC-Unique: sYYUZg2lMLCIv-hW0rz_jA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83E0F8027F5;
        Wed, 19 Oct 2022 08:20:33 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91F85414A81C;
        Wed, 19 Oct 2022 08:20:27 +0000 (UTC)
Date:   Wed, 19 Oct 2022 16:20:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: blk_mq_quiesce_queue in del_gendisk
Message-ID: <Y0+zR+hhuVkV2rrc@T590>
References: <20221019073035.GB11606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019073035.GB11606@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 09:30:35AM +0200, Christoph Hellwig wrote:
> Based on the per-tagset srcu for quiesce discusion I've been wondering
> why we need the queue quiesce around elevator_exit and rq_qos_exit in
> del_gendisk.  At the point where we call it, we've stopped new fs
> I/O submissions, and the queue is frozen.  What does the quiesce still
> protect against, and if anything can we come up with a cheaper way to
> do that?

There might be in-progress run queue not finished yet, only rcu can
guarantee that.


Thanks, 
Ming

