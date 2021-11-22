Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03172C433F5
	for <linux-block@archiver.kernel.org>; Mon, 22 Nov 2021 05:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhKVFdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Nov 2021 00:33:02 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:47614 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKVFdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Nov 2021 00:33:02 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id BEC6E14CD00;
        Mon, 22 Nov 2021 14:29:55 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1AM5TssG008381
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 14:29:55 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 1AM5Tsf9042442
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 14:29:54 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 1AM5TrUi042441;
        Mon, 22 Nov 2021 14:29:53 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     "NeilBrown" <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
        <87ee79yiik.fsf@mail.parknet.co.jp>
        <163754226639.13692.10449616189734943162@noble.neil.brown.name>
Date:   Mon, 22 Nov 2021 14:29:53 +0900
In-Reply-To: <163754226639.13692.10449616189734943162@noble.neil.brown.name>
        (NeilBrown's message of "Mon, 22 Nov 2021 11:51:06 +1100")
Message-ID: <874k84hi5q.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"NeilBrown" <neilb@suse.de> writes:

> On Sun, 21 Nov 2021, OGAWA Hirofumi wrote:
>> "NeilBrown" <neilb@suse.de> writes:
>> 
>> > congestion_wait() in this context is just a sleep - block devices do not
>> > in general support congestion signalling any more.
>> >
>> > The goal here is to wait for any recently written data to get to
>> > storage.  This can be achieved using blkdev_issue_flush().
>> 
>> Purpose of flush option should be for making umount faster, not data
>> integrity. (but current flush implement is strange at several places, IMO)
>
> I don't think that is true.  I believe the purpose of the flush option
> is to write out data as soon as a file is closed, so that if the media
> is removed without first unmounting, the data is more likely to be safe.
> That is why the commit which introduce it:
>  Commit ae78bf9c4f5f ("[PATCH] add -o flush for fat")
> particularly mentions "removable media".

Right. This was to make the removable device usage better (but sync
option is too slow).

e.g.
    # cp -a /foo/source /mnt/fatfs

    # umount <don't too slow>
    or
    <do other thing, and forget umount>

>> So, I don't think the issue_flush is not proper for it (flush is very
>> slow on some usb thumb), and rather I think it is better off to just
>> remove the congestion_wait().
>
> We already call blkdev_issue_flush() on fsync.  With my patch, a simple
> close() effective becomes an fsync() and a close().  I think that is
> completely consistent with the purpose of "-o flush".

It makes much slower above "cp -a" part. So I think it is overkill.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
