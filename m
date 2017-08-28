Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdH1Pxi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 11:53:38 -0400
Date: Mon, 28 Aug 2017 08:53:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme update for Linux 4.14
Message-ID: <20170828155336.GA5302@infradead.org>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 28, 2017 at 09:51:38AM -0600, Jens Axboe wrote:
> What is this against, exactly? It doesn't merge cleanly with my 4.14 branch.
> >From a quick look, looks like it's conflicting with:

It was based on the nvme-3.13 tree from about two weeks ago,
which was based on your for-linus at about that time.
