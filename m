Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A25FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 05:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351419AbhLXF4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 00:56:48 -0500
Received: from verein.lst.de ([213.95.11.211]:55673 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351410AbhLXF4s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 00:56:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AFCA68AA6; Fri, 24 Dec 2021 06:56:45 +0100 (CET)
Date:   Fri, 24 Dec 2021 06:56:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org
Subject: Re: [RFC] remove the paride driver
Message-ID: <20211224055644.GA12208@lst.de>
References: <20211223113504.1117836-1-hch@lst.de> <202112231829.25658.linux@zary.sk> <4f88a1e4-1bbb-1c32-79dd-389f18cb3fa4@kernel.dk> <202112232334.46631.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112232334.46631.linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 23, 2021 at 11:34:46PM +0100, Ondrej Zary wrote:
> > That would indeed be great! As mentioned in my reply, I don't want to
> > remove drivers that are actively being used. Is the libata conversion
> > something you are going to do, or is it more of a dream at this point?
> > Ideally we get that done first, and then remove paride.
> 
> Haven't started yet. But I'm increasing its priority in my todo list.

Ok.  We'll keep the paride code in the current from for now then.
