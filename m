Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35684 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdDEFNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 01:13:25 -0400
MIME-Version: 1.0
In-Reply-To: <8760ijiind.fsf@notabene.neil.brown.name>
References: <871staffus.fsf@notabene.neil.brown.name> <20170404071033.GA25855@infradead.org>
 <8760ijiind.fsf@notabene.neil.brown.name>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 5 Apr 2017 13:13:23 +0800
Message-ID: <CACVXFVN8tTYjidbdSJsEpnWcUccvyd-xsvCpJ9vDMtvs+ciCzQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Add PF_LESS_THROTTLE to block/loop device thread.
To: NeilBrown <neilb@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 5, 2017 at 12:27 PM, NeilBrown <neilb@suse.com> wrote:
> On Tue, Apr 04 2017, Christoph Hellwig wrote:
>
>> Looks fine,
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> But if you actually care about performance in any way I'd suggest
>> to use the loop device in direct I/O mode..
>
> The losetup on my test VM is too old to support that :-(
> I guess it might be time to upgraded.
>
> It seems that there is not "mount -o direct_loop" or similar, so you
> have to do the losetup and the mount separately.  Any thoughts on

I guess the 'direct_loop' can be added into 'mount' directly? but not familiar
with mount utility.

> whether that should be changed ?

There was sysfs interface for controling direct IO in the initial
submission, but
looks it was reviewed out, :-)


Thanks,
Ming Lei
