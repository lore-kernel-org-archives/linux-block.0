Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DCFC433E1
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 18:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B994206F5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 18:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbgEMSdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 14:33:11 -0400
Received: from verein.lst.de ([213.95.11.211]:48076 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390090AbgEMSdL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 14:33:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F27368C65; Wed, 13 May 2020 20:33:05 +0200 (CEST)
Date:   Wed, 13 May 2020 20:33:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 12/15] md: stop using ->queuedata
Message-ID: <20200513183304.GA29895@lst.de>
References: <20200508161517.252308-1-hch@lst.de> <20200508161517.252308-13-hch@lst.de> <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 11:29:17AM -0700, Song Liu wrote:
> On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for the cleanup. IIUC, you want this go through md tree?

Yes, please pick it up though the md tree.
