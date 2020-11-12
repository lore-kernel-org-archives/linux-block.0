Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2639C55ABD
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC0C20B80
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLTbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:31:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgKLTbD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 14:31:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 628ABAB95;
        Thu, 12 Nov 2020 19:31:02 +0000 (UTC)
Date:   Thu, 12 Nov 2020 20:31:00 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
Subject: Re: loop uevent fix
Message-ID: <20201112193100.GC14767@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201112165005.4022502-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112165005.4022502-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Christoph,

> Hi Peter and Jens,

> this is how I'd slightly respin the patch from Petr on top of the
> set_capacity_revalidate_and_notify I need for 5.11.  Let me know what
> you think.

+1, thanks.

From your discussion on my original patch I understand that these 2 fixes will
make it to v5.10-rc4. Will they go also to v5.9 stable tree? (it affects also
v5.8, but that version is EOL).

Kind regards,
Petr
