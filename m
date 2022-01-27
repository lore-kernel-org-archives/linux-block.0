Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97077C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiA0J3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:29:24 -0500
Received: from verein.lst.de ([213.95.11.211]:43376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238542AbiA0J3Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:29:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D790868AA6; Thu, 27 Jan 2022 10:29:21 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:29:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshiiitr@gmail.com
Subject: Re: [PATCH 2/2] nvme: add vectored-io support for user passthru
Message-ID: <20220127092921.GB14431@lst.de>
References: <20220127082536.7243-1-joshi.k@samsung.com> <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com> <20220127082536.7243-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127082536.7243-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 01:55:36PM +0530, Kanchan Joshi wrote:
> wire up support for passthru that takes an array of buffers (using
> iovec). Enable it for NVME_IOCTL_IO64_CMD; same ioctl code to be used
> with following differences -

Flags overloading for a completely different ABI is a bad idea.
Please add a separate ioctl instead.
