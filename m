Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44394 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbdHQHgW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 03:36:22 -0400
Date: Thu, 17 Aug 2017 09:36:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
        reconnects
Message-ID: <20170817073620.GA24372@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me> <20170816104935.GA30525@lst.de> <de413980-1382-7567-b0d4-3207a4476719@grimberg.me> <20170816151723.GA18932@lst.de> <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 17, 2017 at 10:21:08AM +0300, Sagi Grimberg wrote:
>
>>> Having said that, I'm very much open to suggestions if you have anything
>>> better in mind...
>>
>> Not too many suggestions - you want to see it done before we go on
>> merging the code..
>
> Something is not adding up in your reply :)
>
> You want to see it done before we merge? Or are you asking if I
> want to see it done? I designed it to be incremental and not
> break existing transports.
>
> Personally I think that pci conversion will have to be incremental
> and gradual as we need some preparations in place first. So if you are
> reluctant to get it in without full conversion its ok, just note it will
> take me some time to get both pci and fc converted.

I'd really like to see at least a demo PCI conversion.  Guess I need
to take care of it then.  I'd also like to see FC, but I'm not that
concerned about it as it better fits into the Fabrics scheme.
