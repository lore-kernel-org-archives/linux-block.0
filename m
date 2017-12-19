Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:45447 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdLSTmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 14:42:32 -0500
Received: by mail-pf0-f175.google.com with SMTP id u19so11540677pfa.12
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2017 11:42:31 -0800 (PST)
Date: Tue, 19 Dec 2017 11:42:28 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: xiao yang <yangx.jy@cn.fujitsu.com>, eguan@redhat.com,
        fstests@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/013: Add test for BLKRRPART ioctl
Message-ID: <20171219194228.GB22017@vader.DHCP.thefacebook.com>
References: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
 <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <mqd8tdzataq.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mqd8tdzataq.fsf@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 19, 2017 at 11:47:09AM +0100, Johannes Thumshirn wrote:
> xiao yang <yangx.jy@cn.fujitsu.com> writes:
> 
> > +requires() {
> > +	_have_program mkfs.ext3
> > +}
> [...]
> > +	# Format
> > +	mkfs.ext3 -F "$TEST_DEV" >> "$FULL" 2>&1
> 
> What's the reason to limit the test case to ext3 only? Can you switch it
> to the generic 'mkfs' command? IIRC we require 'util-linux' to be
> present for blktests but mkfs.ext3 is (at least in SUSE based distros)
> in the e2fsprogs package.

I'm fine with only testing one specific filesystem, since we're really
testing generic functionality and not any filesystem code. And according
to the manpage, bare mkfs is deprecated. I'm fine with requiring
e2fsprogs for this test, and xiao yang added the _have_program there for
it.

> apart from that:
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
