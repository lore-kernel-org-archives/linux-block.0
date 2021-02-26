Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31358C433E6
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF6564EE3
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 09:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBZJxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Feb 2021 04:53:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhBZJw5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Feb 2021 04:52:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B74D4ACF6;
        Fri, 26 Feb 2021 09:52:15 +0000 (UTC)
Message-ID: <3f5f3d34220d882ca20696da0df1b9feeeaba879.camel@suse.de>
Subject: Stray reference to RQF_SORTED
From:   Jean Delvare <jdelvare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Date:   Fri, 26 Feb 2021 10:52:14 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

In commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
elevator code") you removed all users of RQF_SORTED. However there is
still one reference left to it:

block/blk-mq-sched.c:412:               rq->rq_flags |= RQF_SORTED;

This in effect is dead code now. Should this statement have been
removed as part of the aforementioned commit? And then maybe also the
definition of RQF_SORTED, to prevent further confusion?

Thanks,
-- 
Jean Delvare
SUSE L3 Support

