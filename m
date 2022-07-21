Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC50C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 12:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiGUMoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGUMob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 08:44:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741C7F501
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 05:44:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D744068AFE; Thu, 21 Jul 2022 14:44:26 +0200 (CEST)
Date:   Thu, 21 Jul 2022 14:44:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Israel Rukshin <israelr@nvidia.com>
Cc:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 0/1 RFC] block: Add ioctl for setting default inline
 crypto key
Message-ID: <20220721124426.GA20555@lst.de>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 02:26:30PM +0300, Israel Rukshin wrote:
> Hi Jens/Christoph/Eric
> 
> I am working to add support for inline encryption/decryption
> at storage protocols like nvmf over RDMA.

What would that be? nvmf over RDMA suggest on-the-wire transport
encryption, which really is a different think that what fscrypt
and blk-crypto deal with.  NVMe has a Key per I/O TP, which is
still waiting for the messy TCG counter part, but as far as I
can tell it is in many ways designed to more or less intentionally
not fit the fscrypt model.
