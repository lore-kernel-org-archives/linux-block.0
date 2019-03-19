Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB4C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E569D2133D
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553009081;
	bh=UcSGivjR4IoEW8F4+KWyh6OXtmk+nNpGljJV2aQJv64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MXEYJxXr3WXBOUyIa5eE/N4pxXh19FKbLbVwMoYhqfPrrun24s+bkbrKRhi9fq50Y
	 1Y/iN9pbqUdKN3MTOhWce2UjoI1P1vVg8M5Ces+iTQzx3RTNNF50YRrR+4RRDdCJTI
	 jzUwZH/+ATERJs1lUVpgVRvbAFn2jhWPZJ8QpTZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCSPYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:24:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:45109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSPYk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 11:24:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 08:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="135598379"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2019 08:24:38 -0700
Date:   Tue, 19 Mar 2019 09:25:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de, hch@lst.de
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
Message-ID: <20190319152533.GD24176@localhost.localdomain>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
 <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
 <1553008222.152266.43.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553008222.152266.43.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 19, 2019 at 08:10:22AM -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19 at 09:25 +0800, jianchao.wang wrote:
> > Do you mean this patch from Jens ?
> > https://marc.info/?l=linux-block&m=154534605914798&w=2
> > 
> > +	rcu_read_lock();
> >  	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
> > +	rcu_read_unlock();
> > 
> > The busy_iter_fn could sleep for nvme
> > blk_mq_check_expired
> >   -> blk_mq_rq_timed_out
> >     -> q->mq_ops->timeout
> >        nvme_timeout
> >          -> nvme_dev_disable
> >             -> mutex_lock dev->shutdown_lock
> 
> Hi Jianchao,
> 
> I think that's an additional reason to rewrite NVMe error handling ...

Nonesense. Block timeout handling runs in a work queue precicesly so
handlers can actually do useful work in line with the notification.
