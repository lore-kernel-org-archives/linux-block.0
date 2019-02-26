Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B8C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A92146F
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/1urR1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfBZLNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:13:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55974 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBZLNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 06:13:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so1967403wme.5;
        Tue, 26 Feb 2019 03:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHqS9FYiG1zBoxmbf0V7JRLtAFvidK6oH6Is4fIvoJ4=;
        b=S/1urR1/rCTfMI1kbuJXJVXFlPl3G6THigx/0Jl7udoDmkpi0LLp4elqtSaij71S0w
         DM/045jwfOAxNjQJFtqBG8+M6eo45azAxkNwkFpJtBETXpO160FfKt0FIZJrVUQln3fm
         NcCR/KpQHaP+QM9rZHjN5akaMlmm7nBhlvEwwY/8SExGZsAtR7BCpUuRfyWPUYMTcyUC
         bUf20RQw5vhu2QBReLIhpMWz6gnfCgOIIYuYP6R8IYIGEYrT8NKX69I5JndO4l6RZuLi
         FVgwenrihVyYPnNSodd0OBe7qFYgZJefpalW3heqhStIGDL04vhYyH8Cek4NrTuMlTwH
         +h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHqS9FYiG1zBoxmbf0V7JRLtAFvidK6oH6Is4fIvoJ4=;
        b=DNx0gdbH1uJ2hcNBWegBLCEBfpC5Gd7qK0DH1aM/3eQjkWuY1GvtojPfSfF2HPyLsT
         sP8B8nAFYJP5bgoD44iv9ljLhXq+iAwIouH5E+tNBFpe4d24/SOWzRvGuNYURNnDciXD
         fwzhFST91ztzRAEsRn3K9Txs/W16wznxNOA+7i6bpN5LWpNrjmh8+8ppyVccGV5O5nUc
         9bBe8pyZB16rPpOLhkVg7KbGQJD2h193YgzRzErg3K3bG+2SvU4kI/qwerY1LicV1Hip
         npP2J8Vkz3x9x4MRaZb9A5zsTloEcwOm92fOC/G0Z0vGa7zNdFUAFd/SE/6J3WuqoBUF
         iwtg==
X-Gm-Message-State: AHQUAuZx6Z7Izy+7bD+GtTn6XsPhzsqM6mnfW6KUGTtsEmSeedIA61lA
        Y8fe8M7tcE3S+rnBBjnErYsbYh0HcGBfyboTkMk=
X-Google-Smtp-Source: AHgI3IbJHz73B55lSuZB2tgChvWyG+f3SNNJuU9R8d5KDwOBP8Iye0XxT6ZxlngQszFhVsJ56xW2KpcEMqMJWS1vYZk=
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr2173623wmh.43.1551179581180;
 Tue, 26 Feb 2019 03:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20190225040904.5557-1-ming.lei@redhat.com> <20190225043648.GE23020@dastard>
 <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz> <20190225202630.GG23020@dastard>
 <20190226022249.GA17747@ming.t460p> <20190226030214.GI23020@dastard>
 <20190226032737.GA11592@bombadil.infradead.org> <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p> <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
In-Reply-To: <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Feb 2019 19:12:49 +0800
Message-ID: <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 6:07 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/26/19 10:33 AM, Ming Lei wrote:
> > On Tue, Feb 26, 2019 at 03:58:26PM +1100, Dave Chinner wrote:
> >> On Mon, Feb 25, 2019 at 07:27:37PM -0800, Matthew Wilcox wrote:
> >>> On Tue, Feb 26, 2019 at 02:02:14PM +1100, Dave Chinner wrote:
> >>>>> Or what is the exact size of sub-page IO in xfs most of time? For
> >>>>
> >>>> Determined by mkfs parameters. Any power of 2 between 512 bytes and
> >>>> 64kB needs to be supported. e.g:
> >>>>
> >>>> # mkfs.xfs -s size=512 -b size=1k -i size=2k -n size=8k ....
> >>>>
> >>>> will have metadata that is sector sized (512 bytes), filesystem
> >>>> block sized (1k), directory block sized (8k) and inode cluster sized
> >>>> (32k), and will use all of them in large quantities.
> >>>
> >>> If XFS is going to use each of these in large quantities, then it doesn't
> >>> seem unreasonable for XFS to create a slab for each type of metadata?
> >>
> >>
> >> Well, that is the question, isn't it? How many other filesystems
> >> will want to make similar "don't use entire pages just for 4k of
> >> metadata" optimisations as 64k page size machines become more
> >> common? There are others that have the same "use slab for sector
> >> aligned IO" which will fall foul of the same problem that has been
> >> reported for XFS....
> >>
> >> If nobody else cares/wants it, then it can be XFS only. But it's
> >> only fair we address the "will it be useful to others" question
> >> first.....
> >
> > This kind of slab cache should have been global, just like interface of
> > kmalloc(size).
> >
> > However, the alignment requirement depends on block device's block size,
> > then it becomes hard to implement as genera interface, for example:
> >
> >       block size: 512, 1024, 2048, 4096
> >       slab size: 512*N, 0 < N < PAGE_SIZE/512
> >
> > For 4k page size, 28(7*4) slabs need to be created, and 64k page size
> > needs to create 127*4 slabs.
> >
>
> Where does the '*4' multiplier come from?

The buffer needs to be device block size aligned for dio, and now the block
size can be 512, 1024, 2048 and 4096.

Thanks,
Ming Lei
