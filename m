Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F0C10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F8F217D7
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 14:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbfDROeo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388343AbfDROen (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 10:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEBB2300414C;
        Thu, 18 Apr 2019 14:34:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C12A05D9C5;
        Thu, 18 Apr 2019 14:34:35 +0000 (UTC)
Date:   Thu, 18 Apr 2019 22:34:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        neilb@suse.com
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
Message-ID: <20190418143429.GA19175@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418140632.60606-1-hare@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Apr 2019 14:34:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes,

On Thu, Apr 18, 2019 at 04:06:32PM +0200, Hannes Reinecke wrote:
> When calling blk_queue_split() it will be using the per-queue
> bioset to allocate the split bio from. However, blk_steal_bios()
> might move the bio to another queue, _and_ the original queue
> might be removed completely (nvme is especially prone to do so).

Could you explain a bit how the original queue is removed in case
that blk_steal_bios() is involved?

> That leaves the bvecs of the split bio with a missing / destroyed
> mempool, and a really fun crash in bio_endio().

per-queue bioset is used originally for avoiding deadlock, are you
sure the static bioset is safe?


Thanks,
Ming
