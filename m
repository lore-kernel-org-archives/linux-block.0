Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B5C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF8F21872
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmstC0ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfCNUiJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:38:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41764 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfCNUiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:38:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id n14so5787109edv.8
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2Al2soIhgZIYM0c+nsA3HRmEqADz3AbtxgDnr+ydzs=;
        b=HmstC0ijX8TZZQHSZ3M13+DhfP8K/O+4cmR22PkMy1LalXGtpcRmdy6lkTGlZ4cwlV
         7bSEjHJTfWNHMS5bTVvlmTpPdgsSr0FuutUYTEiaWKlczfO8tDR8SW8VuzxbISQG8SGN
         7gdkmFn+LsxHS+lAPxPsRgZDxSkeAlM3rW8OoZRePD8ddGoTXDWx1Tk5fD/n/4izN/rv
         0ADGCXXlMWCSEOxppJ7sUtGL0cOjA5xC+JzzshE7zC65jjZ5uV6YeFYSP+sPXMZd0HXN
         YPC8Ko6Zr85iIpVzJedCzalYS4gcZZp1qczjK5VXn9/2NKjubcfbWWjwhVyki9+BG/Vk
         Y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2Al2soIhgZIYM0c+nsA3HRmEqADz3AbtxgDnr+ydzs=;
        b=XRgeby81BweAOC6HeyD+tRSub+KKL2J7o1uIKNRQP5PCMwW+kUQyqSgBFkgAfLBAWN
         cle0ljZalR3/WvX45xYRwbWlLJiwyrylhWbpola0u1+41FOd5GgZaxTKJ0UXSQhGDN1+
         Y9HXOqifAHboZLeAzFT+zJoV9EVgxo2VkYoItUIpC4aSCFzcuPDsoXXLb8+iXGKjoZM2
         Dejp2Wa8V8ktmXRzdmJ4W4bU5aOC/37HjBaCYbR12DHGg7dMyg/XVUpV6Qthxa9ykMK+
         m0skcg4GLH1IZNAf6tiSpl5YJWgSIfTcgEP8+OuK7bTYUlk2+h65Bax6TjU/WYFPeWV4
         XBDA==
X-Gm-Message-State: APjAAAXHy0mM7zYGDde8BNIBH2GM5QY5iGwdH+B1SCuPbEY7eLx9zRDd
        HlaW3doryMAcTWCbfDfqTYjJau2bEjpHKlRj1jnOzQ==
X-Google-Smtp-Source: APXvYqxuSV5kEOWVG8KMd19JLV5wpgTHRvcJ6sEubnpauvX5YIax4VaTk/TBboDPeNR4v8ITzlCOTckx8YCzldxcdCM=
X-Received: by 2002:a50:c9c7:: with SMTP id c7mr236986edi.72.1552595886727;
 Thu, 14 Mar 2019 13:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRrVHxhK9Bsk42m5D2LEiVzoWxbK7Z5=FGynLcbqsX-5iWT0g@mail.gmail.com>
 <20190314201851.GH23020@dastard>
In-Reply-To: <20190314201851.GH23020@dastard>
From:   Ross Zwisler <zwisler@google.com>
Date:   Thu, 14 Mar 2019 14:37:55 -0600
Message-ID: <CAGRrVHxhBbMX9W9OmftUPDq5R4koJNjJDDy2xPDF073GTVo6jw@mail.gmail.com>
Subject: Re: question about writeback
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 2:18 PM Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Mar 14, 2019 at 02:03:08PM -0600, Ross Zwisler wrote:
> > Hi,
> >
> > I'm trying to understand a failure I'm seeing with both v4.14 and
> > v4.19 based kernels, and I was hoping you could point me in the right
> > direction.
> >
> > What seems to be happening is that under heavy I/O we get into a
> > situation where for a given inode/mapping we eventually reach a steady
> > state where one task is continuously dirtying pages and marking them
> > for writeback via ext4_writepages(), and another task is continuously
> > completing I/Os via ext4_end_bio() and clearing the
> > PAGECACHE_TAG_WRITEBACK flags.  So, we are making forward progress as
> > far as I/O is concerned.
> >
> > The problem is that another task calls filemap_fdatwait_range(), and
> > that call never returns because it always finds pages that are tagged
> > for writeback.  I've added some prints to __filemap_fdatawait_range(),
> > and the total number of pages tagged for writeback seems pretty
> > constant.  It goes up and down a bit, but does not seem to move
> > towards 0.  If we halt I/O the system eventually recovers, but if we
> > keep I/O going we can block the task waiting in
> > __filemap_fdatawait_range() long enough for the system to reboot due
> > to what it perceives as hung task.
> >
> > My question is: Is there some mechanism that is supposed to prevent
> > this sort of situation?  Or is it expected that with slow enough
> > storage and a high enough I/O load, we could block inside of
> > filemap_fdatawait_range() indefinitely since we never run out of dirty
> > pages that are marked for writeback?
>
> SO your problem is that you are doing an extending write, and then
> doing __filemap_fdatawait_range(end = LLONG_MAX), and while it
> blocks on the pages under IO, the file is further extended and so
> the next radix tree lookup finds more pages past that page under
> writeback?
>
> i.e. because it is waiting for pages to complete, it never gets
> ahead of the extending write or writeback and always ends up with
> more pages to wait on and so never reached the end of the file as
> directed?
>
> So perhaps the caller should be waiting on a specific range to bound
> the wait (e.g.  isize as the end of the wait) rather than using the
> default "keep going until the end of file is reached" semantics?

The call to __filemap_fdatawait_range() is happening via the jdb2 code:

jbd2_journal_commit_transaction()
  journal_finish_inode_data_buffers()
    filemap_fdatawait_keep_errors()
      __filemap_fdatawait_range(end = LLONG_MAX)

Would it have to be an extending write?  Or could it work the same if
you have one thread just moving forward through a very large file,
dirtying pages, and the __filemap_fdatawait_range() call will just
keep finding new pages as it moves forward through the big file?

In either case, I think your description of the problem is correct.
Is this just a "well, don't do that" type situation, or is this
supposed to have a different result?

- Ross
