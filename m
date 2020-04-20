Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD72C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6521473
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587382779;
	bh=ayEwL0nLQ4QNklqralna2ArCsYIcKq41Dq3so3Ua300=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GhC25JElrpNRBAqCvFx+Qp3WIDmorf/ykC0hOo4lRcP3YYdHpmX+Q6kNKJVTivkQC
	 vL7ltMmUFHkoFWHqDI8ZXFwWnvJ0x6Qux7UDLqqnf+Nb+n2isxJHS0sF4Vj9tBDeU8
	 AOnuaEBSfscBDYUpTUQ4U5FOfN7/Yms/0uAYgu4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDTLji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDTLji (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 07:39:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645AC206D4;
        Mon, 20 Apr 2020 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382777;
        bh=ayEwL0nLQ4QNklqralna2ArCsYIcKq41Dq3so3Ua300=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKyAxxq7yd26pECXoTlbjKqMWFkRdNhgDxZ9xKhdL1f8UpX7ouB4svzDyfpIC47Il
         N3uYBGimgkrH/iU2TCsj8b8bg1iDycwlQWtGMUpTeM9iwNLGvtsOqDFWeatnd54TY1
         fZstqWPRni2bIUoWgNa2Fn3AklEIsfQd4XlGZFXk=
Date:   Mon, 20 Apr 2020 13:39:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
Message-ID: <20200420113935.GD3906674@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-9-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 07:45:27PM +0000, Luis Chamberlain wrote:
> Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
> select DEBUG_FS, and blktrace exposes an API which userspace uses
> relying on certain files created in debugfs. If files are not created
> blktrace will not work correctly, so we do want to ensure that a
> blktrace setup creates these files properly, and otherwise inform
> userspace.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/trace/blktrace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 9cc0153849c3..fc32a8665ce8 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
>  					  struct dentry *dir,
>  					  struct blk_trace *bt)
>  {
> -	int ret = -EIO;
> -
>  	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
>  					       &blk_dropped_fops);
> +	if (!bt->dropped_file)
> +		return -ENOMEM;

No, this is wrong, please do not ever check the return value of a
debugfs call.  See the zillions of patches I've been doing to the kernel
for this type of thing over the past year for examples of why.

the code is fine as-is.

greg k-h
