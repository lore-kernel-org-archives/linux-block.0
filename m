Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40BC54EE9
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 14:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIGOF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIGOFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 10:05:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30D48C9A;
        Wed,  7 Sep 2022 07:05:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D24D67373; Wed,  7 Sep 2022 16:05:50 +0200 (CEST)
Date:   Wed, 7 Sep 2022 16:05:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel: export task_work_add
Message-ID: <20220907140550.GA21414@lst.de>
References: <20220829040013.549212-1-ming.lei@redhat.com> <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org> <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 07, 2022 at 07:44:05AM -0600, Jens Axboe wrote:
> On the patch itself, it definitely makes sense in the context of ublk.
> My hesitation is mostly around not really wanting to export this to
> generic modular users. It's OK for core interfaces, of which ublk is
> on the way to becoming, but I really don't like the idea of random
> modules using it. But that's not really something we can manage with
> the export, it's either exported or it's not...

Yes, I'm really worried about folks doing stupid things with it.
Thinking of the whole loop saga..
