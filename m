Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A228BC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4032133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeLQLMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:12:16 -0500
Received: from verein.lst.de ([213.95.11.211]:33666 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeLQLLr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:11:47 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7052B68DD3; Mon, 17 Dec 2018 12:11:46 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:11:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     yupeng <yupeng0921@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v3 2/2] trace nvme submit queue status
Message-ID: <20181217111146.GA6126@lst.de>
References: <20181217080605.16867-1-yupeng0921@gmail.com> <20181217080605.16867-2-yupeng0921@gmail.com> <11554384-e0a9-0bde-97e9-228b29e6b641@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11554384-e0a9-0bde-97e9-228b29e6b641@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 09:33:24AM +0100, Johannes Thumshirn wrote:
> Is the addition of a trace_pci.h really needed? Why can't you just put
> it in trace.h?

Agreed.  Especially as the concepts actually are generic, so we could
actually add the trace point to the rdma and fc transports as well
(not that they would be all that useful, so we probably shouldn't).
