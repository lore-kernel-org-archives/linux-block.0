Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06ADC48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1487613C3
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhFNHJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:09:22 -0400
Received: from verein.lst.de ([213.95.11.211]:43019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhFNHJT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 03:09:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A4CA67373; Mon, 14 Jun 2021 09:07:13 +0200 (CEST)
Date:   Mon, 14 Jun 2021 09:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <20210614070712.GA29881@lst.de>
References: <20210608161327.1537919-1-hch@lst.de> <202106081033.F59D7A4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106081033.F59D7A4@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 10:34:29AM -0700, Kees Cook wrote:
> NAK, please answer my concerns about your patches instead:
> https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

No.  This code pokes into block layer internals with all kinds of issues
and without any signoff from the relevant parties.  We just can't keep it
around.
