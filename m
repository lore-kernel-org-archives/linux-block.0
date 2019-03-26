Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3AC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150CE20848
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfCZBdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbfCZBdW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 21:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04238C04BE09;
        Tue, 26 Mar 2019 01:33:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC7B90A04;
        Tue, 26 Mar 2019 01:33:14 +0000 (UTC)
Date:   Tue, 26 Mar 2019 09:33:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Yi Zhang <yi.zhang@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3] sbitmap: order READ/WRITE freed instance and setting
 clear bit
Message-ID: <20190326013309.GB30669@ming.t460p>
References: <20190322011351.4082-1-ming.lei@redhat.com>
 <20190325185217.GE5826@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325185217.GE5826@vader>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 26 Mar 2019 01:33:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 11:52:17AM -0700, Omar Sandoval wrote:
> On Fri, Mar 22, 2019 at 09:13:51AM +0800, Ming Lei wrote:
> > Inside sbitmap_queue_clear(), once the clear bit is set, it will be
> > visiable to allocation path immediately. Meantime READ/WRITE on old
> > associated instance(such as request in case of blk-mq) may be
> > out-of-order with the setting clear bit, so race with re-allocation
> > may be triggered.
> > 
> > Adds one memory barrier for ordering READ/WRITE of the freed associated
> > instance with setting clear bit for avoiding race with re-allocation.
> 
> Just to make sure I understand, the race is something like this?
> 
> Thread 1			Thread 2
> sbitmap_queue_get()
> ...
> write to request _____
> sbitmap_queue_clear() \
> 		       \	sbitmap_queue_get()
> 		        \______ observes write
> 
> If so, you can add
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Yeah, it is one normal race between freeing and allocating.

Thanks,
Ming
