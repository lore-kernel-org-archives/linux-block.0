Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C818CC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AA7206E9
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDVHSO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:18:14 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34930 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVHSO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:18:14 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03M7HuOx016837;
        Wed, 22 Apr 2020 09:17:56 +0200
Date:   Wed, 22 Apr 2020 09:17:56 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Message-ID: <20200422071756.GA16814@1wt.eu>
References: <20200421125722.58959-1-efremov@linux.com>
 <20200421125722.58959-4-efremov@linux.com>
 <20200422070921.GA19116@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422070921.GA19116@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 12:09:21AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 21, 2020 at 03:57:22PM +0300, Denis Efremov wrote:
> > UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
> > index 16 is out of range for type 'unsigned char [16]'
> > Call Trace:
> > ...
> >  setup_rw_floppy+0x5c3/0x7f0
> >  floppy_ready+0x2be/0x13b0
> >  process_one_work+0x2c1/0x5d0
> >  worker_thread+0x56/0x5e0
> >  kthread+0x122/0x170
> >  ret_from_fork+0x35/0x40
> > 
> > >From include/uapi/linux/fd.h:
> > struct floppy_raw_cmd {
> > 	...
> > 	unsigned char cmd_count;
> > 	unsigned char cmd[16];
> > 	unsigned char reply_count;
> > 	unsigned char reply[16];
> > 	...
> > }
> > 
> > This out-of-bounds access is intentional. The command in struct
> > floppy_raw_cmd may take up the space initially intended for the reply
> > and the reply count. It is needed for long 82078 commands such as
> > RESTORE, which takes 17 command bytes. Initial cmd size is not enough
> > and since struct setup_rw_floppy is a part of uapi we check that
> > cmd_count is in [0:16+1+16] in raw_cmd_copyin().
> > 
> > The patch replaces array subscript with pointer arithetic to suppress
> > UBSAN warning.
> 
> Urghh.  I think the better way would be to use a union that creates
> a larger cmd field, or something like:
> 
> struct floppy_raw_cmd {
> 	...
> 	u8 buf[34];
> 
> #define BUF_CMD_COUNT	0
> #define BUF_CMD		1
> #define BUF_REPLY_COUNT	17
> #define BUF_REPLY	18
> 
> and use addressing based on that.

But isn't it a problem if struct floppy_raw_cmd is exposed to uapi ?
That said I remember a discussion with Linus who said that most if not
all of the floppy parts leaking to uapi were more of a side effect of
the include files reordering than a deliberate decision to expose it.
So maybe that could remain the best solution indeed.

I must say I don't feel very comfortable either with replacing p[i]
with *(p+i) given that they are all supposed to be interchangeable and
equivalent (as well as i[p] as strange as it can look). So we're not
really protected against a later mechanical change or cleanup that
reintroduces it :-/

Willy
