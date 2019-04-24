Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40992C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167E620835
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfDXWOh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40213 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfDXWOg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 18:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73DD7E9506;
        Wed, 24 Apr 2019 22:14:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9D919729;
        Wed, 24 Apr 2019 22:14:28 +0000 (UTC)
Date:   Thu, 25 Apr 2019 06:14:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
Message-ID: <20190424221422.GA21351@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 24 Apr 2019 22:14:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 10:20:46AM -0700, Sagi Grimberg wrote:
> 
> > per-queue bioset is used originally for avoiding deadlock, are you
> > sure the static bioset is safe?
> 
> Can you explain this? I didn't find any indication of that in the change
> log history...
> 
> Originally introduced by Kent:

bio split can be run from stacking drivers, for example, MD over NVMe,
if the global reserved mempool is consumed by MD bio splitting, then
no any progress can be made when splitting on bio submitted to NVMe.

Kent may have more details...

Thanks,
Ming
