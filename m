Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD5C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbiC3NBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbiC3NBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 09:01:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95272E9F3;
        Wed, 30 Mar 2022 05:59:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CE4A68AA6; Wed, 30 Mar 2022 14:59:47 +0200 (CEST)
Date:   Wed, 30 Mar 2022 14:59:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Message-ID: <20220330125947.GA1938@lst.de>
References: <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de> <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com> <20220310141945.GA890@lst.de> <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com> <20220311062710.GA17232@lst.de> <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com> <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns> <CA+1E3rJW-NyOtnn2B5CbSusEs46X4O3Qzb_RGtoR1x_aXZfXsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJW-NyOtnn2B5CbSusEs46X4O3Qzb_RGtoR1x_aXZfXsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 28, 2022 at 10:14:13AM +0530, Kanchan Joshi wrote:
> Thinking a bit more on "(b) big-sqe + big-cqe". Will that also require
> a new ioctl (other than NVME_IOCTL_IO64_CMD) in nvme? Because
> semantics will be slightly different (i.e. not updating the result
> inside the passthrough command but sending it out-of-band to
> io_uring). Or am I just overthinking it.

Again, there should be absolutely no coupling between ioctls and
io_uring async cmds.  The only thing trying to reuse structures or
constants does is to create a lot of confusion.
