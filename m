Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD441C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B2D20890
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfIPIDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:03:33 -0400
Received: from verein.lst.de ([213.95.11.211]:43011 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfIPIDc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 04:03:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 169BA68B05; Mon, 16 Sep 2019 10:03:29 +0200 (CEST)
Date:   Mon, 16 Sep 2019 10:03:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, axboe@kernel.dk,
        keith.busch@intel.com, sagi@grimberg.me, israelr@mellanox.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        shlomin@mellanox.com, hch@lst.de
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190916080328.GB25898@lst.de>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com> <yq1mufei4zk.fsf@oracle.com> <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com> <yq1d0g8hoj5.fsf@oracle.com> <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com> <yq1k1affx8v.fsf@oracle.com> <e59b2d78-4cf6-971a-1926-7969140d2a01@mellanox.com> <yq1lfurdejc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lfurdejc.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 13, 2019 at 06:20:23PM -0400, Martin K. Petersen wrote:
> 
> Max,
> 
> > what about broken type 3 in the NVMe spec ?
> >
> > I don't really know what is broken there but maybe we can avoid
> > supporting it for NVMe until it's fixed.
> 
> The intent in NVMe was for Type 3 to work exactly like it does in
> SCSI. But the way the spec is worded it does not. So it is unclear
> whether implementors (if any) went with the SCSI compatible route or
> with what the NVMe spec actually says.

Do we actually have Linux users of Type 3 at all?  I think for NVMe
we could just trivially disable Linux support, and I suspect for SCSI
as well, but I'll have to defer to you on that.
