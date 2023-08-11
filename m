Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22CC001DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 19:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHKTFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHKTFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 15:05:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762D30F7
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 12:05:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a751d2e6ecso2044313b6e.0
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691780709; x=1692385509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcEsTcn+SuNhkMLUeSCuQ8sXknpybV5WhOTYGeQ66kk=;
        b=GouqE1wtiSNd2VDPYzSXDYabK6ZZuVqnse+oyaREUTX1vEIHxzw3JXU8sy106O8h8r
         rnpMw8phgP/YClOZuJjpMco1VT10oqjwDIWzbnqPj70ZD3tbBDpwX+fq6XJEE5wEdOPx
         QjJuSZO1QAoh4BNFy8v7WmHglWi2fyVQgieSvCJQTYEBX8M94FcVupMdjmii7uzhb1+N
         PCnDrpK1CBjSjTQ0w8uVH9MNO5gfSijh5Dq6r7W7lb80R+INHNx9oAEhmCjAGmpudAmM
         G66IhXvfl+SCyy0DzoFwbWTMmlMKJ1K+X6g88co5Ihkmx34/67BiMkqoFGbe8vanNg4T
         sffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780709; x=1692385509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcEsTcn+SuNhkMLUeSCuQ8sXknpybV5WhOTYGeQ66kk=;
        b=Oe3sNA59ZCH9GYihWyTnIzYyFYNwKyGHc/wVbw1U30BGXVi0nDBPvAKiK4B4sW0gDy
         HNzXhFmocw/8rYkpr8Wbblkt/9Ow7tHvWwlwMhbS3URannS/T1BLSmlNyUYBESzflwYl
         FtD8WvuQzCIydPc8FIL1Dr+gT51IxdZdGuBQkn+KEkTklp+YsCt6+aSrCsDQEbqm3gsz
         9sLmzd+3/RTTUSkw/+tl0thtd8KRehds90aR0LzMMhE5fs2QMrQ2mD9C3Kv6WCElj1k6
         U5PDsCEMDbV8XatCfJE+QrJPC+9tf1q/g88N9s0q5pwflXtkc7TIFg32UhCTzXKy+i+r
         sQnw==
X-Gm-Message-State: AOJu0YwZjUdD1IINdREAeNvtTOA+WQWbRTKda6MncaXyBz0zODUNhlil
        qP5CKlARD4ULBayUsWM8YoJNAw==
X-Google-Smtp-Source: AGHT+IHELnDF7HiqdqfbjE1ESPLlwkNJVzceCMXsKsrRJaWJL+rwobZOAgSlRjw7wGzjYOhJLtQejA==
X-Received: by 2002:a05:6808:2099:b0:3a7:a379:63a with SMTP id s25-20020a056808209900b003a7a379063amr4042976oiw.41.1691780708768;
        Fri, 11 Aug 2023 12:05:08 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e23-20020a05620a12d700b00767ceac979asm1373441qkl.42.2023.08.11.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:05:08 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:05:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove get_super
Message-ID: <20230811190507.GA2791339@perftesting>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series against the VFS vfs.super branch finishes off the work to remove
> get_super and move (almost) all upcalls to use the holder ops.
> 
> The first part is the missing btrfs bits so that all file systems use the
> super_block as holder.
> 
> The second part is various block driver cleanups so that we use proper
> interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> 
> The last part than replaces __invalidate_device and fsync_bdev with upcalls
> to the file system through the holder ops, and finally removes get_super.
> 
> It leaves user_get_super and get_active_super around.  The former is not
> used for upcalls in the traditional sense, but for legacy UAPI that for
> some weird reason take a dev_t argument (ustat) or a block device path
> (quotactl).  get_active_super is only used for calling into the file system
> on freeze and should get a similar treatment, but given that Darrick has
> changes to that code queued up already this will be handled in the next
> merge window.
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/misc.git remove-get_super
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-get_super

The CI testing didn't show any regressions or lockdep errors related to moving
the device opening around (which is what I was worried about).  If you look at
the status you'll see the subpage compress timed out, that's not you, that's an
existing bug I haven't devoted time to figuring out yet.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
