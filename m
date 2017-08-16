Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39468 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdHPJ5I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 05:57:08 -0400
Date: Wed, 16 Aug 2017 11:57:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
        reconnects
Message-ID: <20170816095707.GA26561@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me> <20170816081605.GA29784@infradead.org> <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me> <20170816093559.GA24709@lst.de> <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 16, 2017 at 12:46:25PM +0300, Sagi Grimberg wrote:
>>> Sure, should I have it on top of the affinity patches or not?
>>
>> For now get any tree you have out to take a look.  In the longer
>> run we'll need to decide how we want to deal with the merge
>> of the two trees.  In general having to depend on the RDMA
>> tree is a major risk because it's maintainance is so unreliable.
>
> Its really a small conflict, easy enough to get it without. The problem
> that no matter what I do, one tree would conflict...

Let's keep the refactoring self contained in nvme now and sort out
the small conflict when the rdma tree is merge (which is alsmost
certainly going to be after the block tree)
