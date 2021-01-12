Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B7BC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF162311D
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbhALSdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:33:46 -0500
Received: from verein.lst.de ([213.95.11.211]:56840 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALSdq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 13:33:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B153D67373; Tue, 12 Jan 2021 19:33:03 +0100 (CET)
Date:   Tue, 12 Jan 2021 19:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112183303.GA5050@lst.de>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com> <20201216181828.21040-1-javier.gonz@samsung.com> <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain> <20210112092207.GA4888@localhost.localdomain> <20210112183055.u3y34tfxh4d5aeue@unifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112183055.u3y34tfxh4d5aeue@unifi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 12, 2021 at 07:30:55PM +0100, Javier González wrote:
> I have not implemented multipath support, but it should definitely not
> crash like this. I'll rebase to 5.11 and test.
>
> Christoph: Is it OK to send this without multipath or should I just send
> all together?

We're not in a rush at the moment, so I'd prefer working multipath
support if you can spare a few cycles.
