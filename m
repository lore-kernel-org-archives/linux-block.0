Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34137 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdFLShf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2017 14:37:35 -0400
Date: Mon, 12 Jun 2017 14:37:33 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 03/11] kernfs: add an API to get kernfs node from inode
 number
Message-ID: <20170612183733.GJ19206@htj.duckdns.org>
References: <cover.1496432591.git.shli@fb.com>
 <41d336f7006d63c6dd5bddf407c16de8064debc3.1496432591.git.shli@fb.com>
 <20170612182028.GH19206@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170612182028.GH19206@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ooh, one more thing.

On Mon, Jun 12, 2017 at 02:20:28PM -0400, Tejun Heo wrote:
> > +struct kernfs_node *kernfs_get_node_by_ino(struct kernfs_root *root,
> > +					   unsigned int ino)

Can we name this kernfs_find_and_get_by_ino() for consistency?  And
the RCU optimization does seem prominent compared to other find/get
functions which all just use kernfs_mutex (still not objecting).

Thanks.

-- 
tejun
