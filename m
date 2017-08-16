Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40898 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbdHPPRY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 11:17:24 -0400
Date: Wed, 16 Aug 2017 17:17:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
        reconnects
Message-ID: <20170816151723.GA18932@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me> <20170816104935.GA30525@lst.de> <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 16, 2017 at 04:51:31PM +0300, Sagi Grimberg wrote:
> I think its a very desirable goal to have PCIe consolidate with fabrics
> here, so I'd like to shoot for that and backoff later (and change again
> where makes sense).
>
> Having said that, I'm very much open to suggestions if you have anything
> better in mind...

Not too many suggestions - you want to see it done before we go on
merging the code..
