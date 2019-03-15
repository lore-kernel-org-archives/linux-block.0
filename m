Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC6C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1412184C
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfCOJUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:20:30 -0400
Received: from verein.lst.de ([213.95.11.211]:33266 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfCOJUa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:20:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BC9AC68C4E; Fri, 15 Mar 2019 10:20:20 +0100 (CET)
Date:   Fri, 15 Mar 2019 10:20:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, hch@lst.de, jthumshirn@suse.de, hare@suse.de,
        josef@toxicpanda.com, bvanassche@acm.org, sagi@grimberg.me,
        keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
Message-ID: <20190315092020.GA2405@lst.de>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 04:57:36PM +0800, Jianchao Wang wrote:
> Hi Jens
> 
> As we know, there is a risk of accesing stale requests when iterate
> in-flight requests with tags->rqs[] and this has been talked in following
> thread,
> [1] https://marc.info/?l=linux-scsi&m=154511693912752&w=2
> [2] https://marc.info/?l=linux-block&m=154526189023236&w=2

I'd rather take one step back and figure out why we are iterating
the busy requests.  There really shouldn't be any reason why a driver
is even doings that (vs some error handling helpers in the core
block code that can properly synchronize).
