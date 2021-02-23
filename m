Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889DC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C99464E31
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBWHMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:12:36 -0500
Received: from verein.lst.de ([213.95.11.211]:32956 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhBWHMb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:12:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E369A68D0D; Tue, 23 Feb 2021 08:11:48 +0100 (CET)
Date:   Tue, 23 Feb 2021 08:11:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Anderson <dvander@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Message-ID: <20210223071148.GC16980@lst.de>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com> <BYAPR04MB496566A72BC5641BAC7D279F86809@BYAPR04MB4965.namprd04.prod.outlook.com> <CALAqxLXWs0GUZv=zWFK8hvnnkEgfMXvr_tZPyPaPBra=k9yf-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXWs0GUZv=zWFK8hvnnkEgfMXvr_tZPyPaPBra=k9yf-A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 22, 2021 at 08:22:09PM -0800, John Stultz wrote:
> I'm wondering if given there are multiple call sites, that in
> bio_alloc_bioset() would something like the following make more sense?
> (apologies, copy pasted so this is whitespace corrupted)
> thanks

No.  The fallback from the mempool backing to plain kmalloc is highly
dangerous, which is one of the reasons it was removed.  The other being
that we don't want to disturb the fast path with this slow path.
