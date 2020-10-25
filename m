Return-Path: <SRS0=qssB=EA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED6C388F7
	for <linux-block@archiver.kernel.org>; Sun, 25 Oct 2020 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC26522226
	for <linux-block@archiver.kernel.org>; Sun, 25 Oct 2020 15:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415250AbgJYP5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Oct 2020 11:57:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44138 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732094AbgJYP5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Oct 2020 11:57:10 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09PFurBB000490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Oct 2020 11:56:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D81A1420107; Sun, 25 Oct 2020 11:56:52 -0400 (EDT)
Date:   Sun, 25 Oct 2020 11:56:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Removing b_end_io
Message-ID: <20201025155652.GB5691@mit.edu>
References: <20201025044438.GI20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025044438.GI20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 25, 2020 at 04:44:38AM +0000, Matthew Wilcox wrote:
> @@ -3068,6 +3069,12 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  	}
>  
>  	submit_bio(bio);
> +}
> +
> +static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> +			 enum rw_hint write_hint, struct writeback_control *wbc)
> +{
> +	__bh_submit(bh, op | op_flags, write_hint, wbc, end_bio_bh_io_sync);
>  	return 0;
>  }
>

I believe this will break use cases where the file system sets
bh->b_end_io and then calls submit_bh(), which then calls
submit_bh_wbc().  That's because with this change, calls to
submit_bh_wbc() --- include submit_bh() --- ignores bh->b_end_io and
results in end_bio_bh_io_sync getting used.

Filesystems that do this includes fs/ntfs, fs/resiserfs.

In this case, that can probably be fixed by changing submit_bh() to
pass in bh->b_end_io, or switching those users to use the new
bh_submit() function to prevent these breakages.

						- Ted
