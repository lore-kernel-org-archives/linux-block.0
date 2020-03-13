Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62837C2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9120724
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCMLLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:11:16 -0400
Received: from verein.lst.de ([213.95.11.211]:42031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMLLQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 07:11:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0D5A68C4E; Fri, 13 Mar 2020 12:11:14 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:11:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de
Subject: Re: [PATCH v3 5/5] scsi: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200313111114.GE8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-6-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-6-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:09AM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
> notifications via uevents. This notification is newly added to scsi sd.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
