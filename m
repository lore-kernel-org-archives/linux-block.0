Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58854 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdFQACD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 20:02:03 -0400
Date: Sat, 17 Jun 2017 01:01:57 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use filp_close() rather than fput()
Message-ID: <20170617000157.GQ31671@ZenIV.linux.org.uk>
References: <149758925866.10006.12779875832895865043.stgit@noble>
 <149758932908.10006.10765671892098302463.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149758932908.10006.10765671892098302463.stgit@noble>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 16, 2017 at 03:02:09PM +1000, NeilBrown wrote:
> When a loop device is being shutdown the backing file is
> closed with fput().  This is different from how close(2)
> closes files - it uses filp_close().
> 
> The difference is important for filesystems which provide a ->flush
> file operation such as NFS.  NFS assumes a flush will always
> be called on last close, and gets confused otherwise.

Huh?  You do realize that mmap() + close() + modify + msync() + munmap()
will have IO done *after* the last flush, right?
