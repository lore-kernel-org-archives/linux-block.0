Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A8EC04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958320989
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEMG0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:26:36 -0400
Received: from verein.lst.de ([213.95.11.211]:37174 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfEMG0g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:26:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7D8CE68AA6; Mon, 13 May 2019 08:26:15 +0200 (CEST)
Date:   Mon, 13 May 2019 08:26:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
        sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190513062615.GA18152@lst.de>
References: <20190509110409.19647-1-hch@lst.de> <20190509112410.GA20711@ming.t460p> <20190509123406.GB21483@lst.de> <20190509133120.GA22059@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509133120.GA22059@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So actually, after running out ways to make any of my complex block
layer fix ideas work I have a simple fix for the block layer now.

Lets see if is acceptable..
