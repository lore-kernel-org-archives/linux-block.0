Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56137 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdFSMfW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:35:22 -0400
Date: Mon, 19 Jun 2017 14:35:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 02/30] nvme-rdma: Don't alloc/free the tagset on
        reset
Message-ID: <20170619123520.GC29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-3-git-send-email-sagi@grimberg.me> <20170619071851.GB13168@lst.de> <4b612cf9-f8ba-f2fa-8f93-c2c46468daf4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b612cf9-f8ba-f2fa-8f93-c2c46468daf4@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> We can do that, but this tries to eliminate duplicate code as
> much as possible. It's not like the convention is unprecedented...

It's fairly nasty to follow.  OTOH I like your overall cleanup,
so I guess I shouldn't complain about the initial patches to much
but just possibly do another pass after you are done..
