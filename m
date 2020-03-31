Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD087C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4920BED
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 16:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgCaQdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:33:41 -0400
Received: from verein.lst.de ([213.95.11.211]:39371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgCaQdl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 12:33:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1C3168BFE; Tue, 31 Mar 2020 18:33:37 +0200 (CEST)
Date:   Tue, 31 Mar 2020 18:33:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
Message-ID: <20200331163337.GA25020@lst.de>
References: <cover.1580786525.git.zhangweiping@didiglobal.com> <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com> <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com> <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com> <20200331143635.GS162390@mtj.duckdns.org> <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com> <20200331155139.GT162390@mtj.duckdns.org> <20200331155257.GA22994@lst.de> <CAA70yB6PYH-W8-RRd7nxXOvpg6n+_-h_BLm6JA3EbLmsYG-ZSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB6PYH-W8-RRd7nxXOvpg6n+_-h_BLm6JA3EbLmsYG-ZSw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 01, 2020 at 12:31:17AM +0800, Weiping Zhang wrote:
> Would you like to share more detail about why NVMe WRR is broken?

Because it only weights command fetching.  It says absolutely nothing
about command execution.
