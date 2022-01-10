Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 00:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiAJAFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 19:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237534AbiAJAFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Jan 2022 19:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641773121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8SAvP6dAzHrjKhMg+5R+766TBWSrJAna+O4hSrTC58=;
        b=i3xW1a+ItJx9nL6JcmeSQ4PoEFuqCSOvSzADMlnzr1Voip3Eqx87tfYvEoM6jO8SHaZvoe
        VuPkd4TnDvUpYWtuzCn/rWyuVAp7iTArrvvMbvTG8M4BF9b2vsVGy+YG1BRVoLanvR9rEn
        WBthlAAo8qbgecGlzXPyj3pvb4p5wlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-EpnrowMdMyKBB6ZaQ9MdXQ-1; Sun, 09 Jan 2022 19:05:20 -0500
X-MC-Unique: EpnrowMdMyKBB6ZaQ9MdXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AEAA18C89C4;
        Mon, 10 Jan 2022 00:05:19 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F30656F9B;
        Mon, 10 Jan 2022 00:05:13 +0000 (UTC)
Date:   Mon, 10 Jan 2022 08:05:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't protect submit_bio_checks by q_usage_counter
Message-ID: <Ydt4NK82C3rx2EuW@T590>
References: <20220104134223.590803-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104134223.590803-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 09:42:23PM +0800, Ming Lei wrote:
> Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
> uses q_usage_counter to protect submit_bio_checks for avoiding IO after
> disk is deleted by del_gendisk().
> 
> Turns out the protection isn't necessary, because once
> blk_mq_freeze_queue_wait() in del_gendisk() returns:
> 
> 1) all in-flight IO has been done
> 
> 2) all new IO will be failed in __bio_queue_enter() because
>    q_usage_counter is dead, and GD_DEAD is set
> 
> 3) both disk and request queue instance are safe since caller of
> submit_bio() guarantees that the disk can't be closed.
> 
> Once submit_bio_checks() needn't the protection of q_usage_counter, we can
> move submit_bio_checks before calling blk_mq_submit_bio() and
> ->submit_bio(). With this change, we needn't to throttle queue with
> holding one allocated request, then precise driver tag or request won't be
> wasted in throttling. Meantime we can unify the bio check for both bio
> based and request based driver.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello,

Any comments on this fix?

-- 
Ming

