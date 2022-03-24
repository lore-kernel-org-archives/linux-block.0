Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 06:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiCXGcU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiCXGcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 02:32:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0468F90;
        Wed, 23 Mar 2022 23:30:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5129768B05; Thu, 24 Mar 2022 07:30:45 +0100 (CET)
Date:   Thu, 24 Mar 2022 07:30:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 14/17] io_uring: add polling support for uring-cmd
Message-ID: <20220324063045.GB12660@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com> <CGME20220308152723epcas5p34460b4af720e515317f88dbb78295f06@epcas5p3.samsung.com> <20220308152105.309618-15-joshi.k@samsung.com> <20220311065007.GC17728@lst.de> <CA+1E3rKKCE53TJ9mJesK3UrPPa=Vqx6fxA+TAhj9v5hT452AuQ@mail.gmail.com> <20220315085745.GE4132@lst.de> <20220316050905.GA28016@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316050905.GA28016@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 10:39:05AM +0530, Kanchan Joshi wrote:
> So how about adding ->async_cmd_poll in file_operations (since this
> corresponds to ->async_cmd)?
> It will take struct io_uring_cmd pointer as parameter.
> Both ->iopoll and ->async_cmd_poll will differ in what they accept (kiocb
> vs io_uring_cmd). The provider may use bio_poll, or whatever else is the
> implementation detail.

That does sound way better than the current version at least.
