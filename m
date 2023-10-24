Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9591C07545
	for <linux-block@archiver.kernel.org>; Tue, 24 Oct 2023 08:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJXIoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Oct 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjJXIoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2023 04:44:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F23B0
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2023 01:44:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C348CC433C7;
        Tue, 24 Oct 2023 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698137075;
        bh=spgpNFU470w+i5R/iihyxIaQCbIvjCGM+TkdU8WIWZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8Q0g6B8gPBrQsp/Kz5f2T5y/IvMbOR+U8IFZlw4TvnyQ+GBk4Rui6ds9bI6VwL0c
         /iXIP8mNxCEF6xRHEvKoj5+L1azcILd+fhdEcRJ0rca7s9byBNpT9afe2AhGSjHQUt
         2nk13BtFQChn5OM9F/YLctPsOWAsA1EqiPEsPwFolm10u42g3gNQx0hu7U6SDaQ+Zt
         Kgp4++mnJ7TUzmCzFjNufRALX8zX0jmxDTI4LOk314pmzi5mIjX3suLpfM8LOY1NFi
         3AU9/Ts2guqh0O/uJa+6RnOcAjVQRpVINTasvpSBpbpuLFsEifHlJSscWTUQqAovxF
         sFXGzBohuixgg==
Date:   Tue, 24 Oct 2023 10:44:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: loop change deprecation
Message-ID: <20231024-entfuhr-sachbezogen-aab33dec4087@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-ausgraben-berichten-d747aa50d876@brauner>
 <20231023-fungieren-erbschaft-0486c1eab011@brauner>
 <ZTdsPUgCA5TK1hfj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTdsPUgCA5TK1hfj@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Sorry for the broken "Subject:" btw in the first mail.)

On Tue, Oct 24, 2023 at 12:03:25AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 23, 2023 at 05:35:25PM +0200, Christian Brauner wrote:
> > I just realized that if we're able to deprecate LOOP_CHANGE_FD we remove
> > one of the most problematic/weird cases for partitions and filesystems.
> 
> > change fd event on the first partition:
> > 
> > sudo ./loop_change_fd /dev/loop0p1 img2
> > 
> > we call disk_force_media_change() but that only works on disk->part0
> > which means that we don't even cleanly shutdown the filesystem on the
> > partition we're trying to mess around with.
> 
> Yes, disk_force_media_change has that general problem back from the
> early Linux days (it had a different name back then, though).  I think
> it is because traditionally removable media in Linux never had
> partitions, e.g. the CDROM drivers typically only allocated a single
> minor number so they could not be scanned.  But that has changed because
> the interfaces got used for different use cases, and we also had
> dynamic majors for a long time that now allow partitions.  And there
> are real use cases even for traditional removable media, e.g. MacOS
> CDROMs traditionally did have partitions.
> 
> > For now, we should give up any pretense that disk_force_media_change()
> > does anything useful for loop change fd and simply remove it completely.
> > It's either useless, or it breaks the original semantics of loop change
> > fd although I don't think anyone's ever used it the way I described
> > above.
> 
> Maybe we can just drop the CHANGE_FD ioctl and see if anyone screams?

Yes, I suggested that in the prior mail. I think we should do that.
We'd need changes to LTP and blktests but there are no active users in
either codesearch.debian, cs.github, or cs.android.
