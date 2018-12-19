Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF159C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 07:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA632084A
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 07:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeLSHg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:36:29 -0500
Received: from verein.lst.de ([213.95.11.211]:45489 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeLSHg2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 02:36:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DCE0567358; Wed, 19 Dec 2018 08:36:26 +0100 (CET)
Date:   Wed, 19 Dec 2018 08:36:26 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     peng yu <yupeng0921@gmail.com>
Cc:     "hch@lst.de" <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
Message-ID: <20181219073626.GA28023@lst.de>
References: <20181218045138.4282-1-yupeng0921@gmail.com> <20181218045138.4282-2-yupeng0921@gmail.com> <20181218172645.GB13768@localhost.localdomain> <20181218174750.GA14416@lst.de> <CAG3TDc3QarHcz_ez=GYYzqDp8VwMHL=nUTvur+5XN+m5-T57sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3TDc3QarHcz_ez=GYYzqDp8VwMHL=nUTvur+5XN+m5-T57sA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 05:19:00PM -0800, peng yu wrote:
> I think this change is nice. Will you submit this change or are you
> suggesting me to do it?

I've folded the changes in.
