Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZXpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 19:45:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so1990084pgp.11
        for <linux-block@vger.kernel.org>; Thu, 26 Jul 2018 15:26:45 -0700 (PDT)
Date: Thu, 26 Jul 2018 15:26:43 -0700
From: Omar Sandoval <osandov@osandov.com>
To: James Smart <james.smart@broadcom.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] blktests: test ANA base support
Message-ID: <20180726222643.GH16847@vader>
References: <20180717133118.39026-1-hare@suse.de>
 <BYAPR04MB4502201C7DCD5AC4514AC6BC86500@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20180725191712.GA16847@vader>
 <BYAPR04MB4502890F18B77778B8EF6E5686540@BYAPR04MB4502.namprd04.prod.outlook.com>
 <20180725210001.GB16847@vader>
 <BYAPR04MB4502FE260EA90730B4522657862B0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <9661913b-cb11-39ba-7c3f-7dbd7490736a@broadcom.com>
 <20180726213132.GG16847@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180726213132.GG16847@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 26, 2018 at 02:31:32PM -0700, Omar Sandoval wrote:
> On Thu, Jul 26, 2018 at 09:35:53AM -0700, James Smart wrote:
> > make sure this fix has been picked up in your kernel:
> > http://git.infradead.org/nvme.git/commit/6cdefc6e2ad52170f89a8d0e8b1a1339f91834dc
> > 
> > deletes were broken otherwise and have the exact trace below.
> > 
> > -- james
> 
> Thanks, James, that indeed fixes the problem. I'll go ahead and merge
> these tests since there's a fix in flight.

By "these tests", I mean Chaitanya's tests, Hannes still has some
comments to resolve :)
