Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C81C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27996137D
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJSSav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhJSSav (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 14:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 176A661260;
        Tue, 19 Oct 2021 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634668118;
        bh=Fhtf7VlSWsJXLka1T9VBb/ONbZ90TTb8FR0sVs3L9EQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfAJNtcOST2+jtOjorP6OvbHK/4a4VzLKddo9DGEu/6D/C4Pig8UIFZ/LXhpeQ/gg
         vke0Bmqay8ArobdugFVgr6gMl+oZG4mJsvgJuW/ZS66vKqMz++llXaBNoiqHPPtVXy
         7ixt7ZSQAGBh5ONON38LP0ilRkLpWXuiWvoKYb4dRm1oWz2rvPQGSFcCi/2zFuJZzP
         f9C4TKTeodx1ZiIXe/Az/aD/wQ9/bqL6sULWKoLrEcyEkaqaaz3tdObbhLyFBRcqJh
         +SWrZNKYQiVlUvR8GH1JznCRIs8/BzWpiVhAirHB0Q6YAtY98zXcNH0IGzbo8k6FAS
         cmO1FqpEZytUw==
Date:   Tue, 19 Oct 2021 11:28:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v2 1/2] nvme: move command clear into the various setup
 helpers
Message-ID: <20211019182835.GB2083665@dhcp-10-100-145-180.wdc.com>
References: <20211018124934.235658-1-axboe@kernel.dk>
 <20211018124934.235658-2-axboe@kernel.dk>
 <f90f4e83-52d2-4d92-126a-9f65f384f8a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f90f4e83-52d2-4d92-126a-9f65f384f8a4@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 06:53:02AM -0600, Jens Axboe wrote:
> commit fb4e29f648e320c94f210c54692c754ad69fb6f6
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Oct 18 06:45:06 2021 -0600
> 
>     nvme: move command clear into the various setup helpers
>     
>     We don't have to worry about doing extra memsets by moving it outside
>     the protection of RQF_DONTPREP, as nvme doesn't do partial completions.
>     
>     This is in preparation for making the read/write fast path not do a full
>     memset of the command.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
