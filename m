Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7892C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E861354
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 17:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJURmF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhJURmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 13:42:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED4C061570;
        Thu, 21 Oct 2021 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wbKnAVdwfP+5DNMopkjjBAYPB3ZdYZtPUIqeOJ1noD0=; b=epwZmF4d+MaIlCE6iEQH4XN0XG
        MRQek/8Z/mfw1Fi3PELO7/1kTIi+KfwWKlxNhB3FLf0t6f+bRQIfcSs/4aeqXIGKBgRXKdm3aA5d9
        W+CUKyYfueqf1PmmtuayWyOCwsNLpIkBtBei0La5i6rmelE9LmQCrKwHhyMT6svxrN5jo8xa6DZVK
        tVgvx282U91q1+hId9zcHjm1P3f/kUdYQLTe66H3ckPhTdjTizwSxyE59ijrh44zAHa+R2oGRZ9kc
        1Z4YBgbIbn9c6oLs0aXNcWc8+Kh7QkHu3VBEAlbjVeukh2rbs1tisdikGARb78LEN9ldrYsVo77OM
        QMa4efnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdc2c-008VfV-It; Thu, 21 Oct 2021 17:39:46 +0000
Date:   Thu, 21 Oct 2021 10:39:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] zram: fix two races and one zram leak
Message-ID: <YXGl4v1cMJtCLg2d@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <YXCMtRVXrGOec6OR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXCMtRVXrGOec6OR@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 02:40:05PM -0700, Minchan Kim wrote:
> On Wed, Oct 20, 2021 at 09:55:44AM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Fixes three issues reported by Luis Chamberlain with one simpler approach:
> > 
> > - race between between zram_reset_device() and disksize_store() (1/4)
> > 
> > - zram leak during unloading module, which is one race between resetting
> > and removing device (2/4)
> > 
> > - race between zram_remove and disksize_store (3/4)
> > 
> > Also replace replace fsync_bdev with sync_blockdev since no one opens
> > it.(4/4)
> > 
> > V2:
> > 	- take another approach to avoid failing of zram_remove()
> > 	- add patch to address race between zram_reset_device() and
> > 	  disksize_store()
> > 
> 
> Thanks for breaking the problems down, Ming.
> 
> To me, the whole patchset looks good to me since each patch solves
> the problem step by step and finally fix.
> 
> Luis, do you have any concern of this patchset to solve the cpuhp
> problem? (Sorry in advance if I miss some concerns if you raised
> in different thread. I'm totally lost).

Running tests against this now. Will report back!

 Luis
