Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F230FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3E3207C4
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETNUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 09:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETNUl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 09:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B429AB7D;
        Wed, 20 May 2020 13:20:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 235A81E126B; Wed, 20 May 2020 15:20:39 +0200 (CEST)
Date:   Wed, 20 May 2020 15:20:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blkparse: Print PID information for TN_MESSAGE events
Message-ID: <20200520132039.GB30597@quack2.suse.cz>
References: <20200513160402.8050-1-jack@suse.cz>
 <d82a514e-390e-b268-dc19-45cb7be51ac7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82a514e-390e-b268-dc19-45cb7be51ac7@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 19-05-20 09:53:23, Jens Axboe wrote:
> On 5/13/20 10:04 AM, Jan Kara wrote:
> > The kernel now provides PID information for TN_MESSAGE events. Print it.
> > Old kernels fill 0 there so the behavior is unaffected for them.
> 
> Doesn't apply to the current repo, can you resend?

Likely because it is based on top of my blkparse fixes to deal with cgroup
information in blktrace events. Did you pick up those? Rebasing this
on-liner is simple enough but I'm just wondering...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
