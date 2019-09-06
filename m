Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA81C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 05:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6520842
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 05:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfIFFXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:23:38 -0400
Received: from verein.lst.de ([213.95.11.211]:54218 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389949AbfIFFXi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Sep 2019 01:23:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7479268B05; Fri,  6 Sep 2019 07:23:34 +0200 (CEST)
Date:   Fri, 6 Sep 2019 07:23:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe
 subsystem
Message-ID: <20190906052334.GA1382@lst.de>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com> <1567701836-29725-3-git-send-email-maxg@mellanox.com> <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 05, 2019 at 01:52:39PM -0700, Sagi Grimberg wrote:
>
>> Use block layer definition instead of re-defining it with the same
>> values.
>
> The nvme_setup_rw is fine, but nvme_init_integrity gets values from
> the controller id structure so I think it will be better to stick with
> the enums that are referenced in the spec (even if they happen to match
> the block layer values).

These values aren't really block layer values, but from the SCSI spec,
which NVMe references.  So I think this is fine, but if it is a little
confusion we'll have to add a comment.
