Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50024C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFCC2074C
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 11:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMLJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:09:15 -0400
Received: from verein.lst.de ([213.95.11.211]:41995 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMLJP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 07:09:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D18968C4E; Fri, 13 Mar 2020 12:09:13 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:09:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de,
        Someswarudu Sangaraju <ssomesh@amazon.com>
Subject: Re: [PATCH v3 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200313110913.GA8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-2-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-2-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:05AM +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper set_capacity_revalidate_and_notify(), which is a wrapper
> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
> notify via udev if the current capacity or the target capacity is not zero
> and iff the capacity changes.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
