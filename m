Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbdLTIDT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 03:03:19 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: xiao yang <yangx.jy@cn.fujitsu.com>, eguan@redhat.com,
        fstests@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/013: Add test for BLKRRPART ioctl
References: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
        <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
        <mqd8tdzataq.fsf@linux-x5ow.site>
        <20171219194228.GB22017@vader.DHCP.thefacebook.com>
Date: Wed, 20 Dec 2017 09:03:17 +0100
In-Reply-To: <20171219194228.GB22017@vader.DHCP.thefacebook.com> (Omar
        Sandoval's message of "Tue, 19 Dec 2017 11:42:28 -0800")
Message-ID: <mqdwp1homgq.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Omar Sandoval <osandov@osandov.com> writes:

> On Tue, Dec 19, 2017 at 11:47:09AM +0100, Johannes Thumshirn wrote:
>> xiao yang <yangx.jy@cn.fujitsu.com> writes:
>> 
>> > +requires() {
>> > +	_have_program mkfs.ext3
>> > +}
>> [...]
>> > +	# Format
>> > +	mkfs.ext3 -F "$TEST_DEV" >> "$FULL" 2>&1
>> 
>> What's the reason to limit the test case to ext3 only? Can you switch it
>> to the generic 'mkfs' command? IIRC we require 'util-linux' to be
>> present for blktests but mkfs.ext3 is (at least in SUSE based distros)
>> in the e2fsprogs package.
>
> I'm fine with only testing one specific filesystem, since we're really
> testing generic functionality and not any filesystem code. And according
> to the manpage, bare mkfs is deprecated. I'm fine with requiring
> e2fsprogs for this test, and xiao yang added the _have_program there for
> it.

what about something like (totally untested):

if _have_program mkfs.ext3; then
   mkfs_prog="mkfs.ext3"
   return 1
elif _have_program mkfs.xfs; then
   mkfs_prog="mkfs.xfs"
   return 1
elif _have_program mkfs.brtfs; then
   mkfs_prog="mkfs.brtfs"
   return 1
else
   retrun 0
fi


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
