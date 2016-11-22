Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36489 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbcKVV1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 16:27:18 -0500
Date: Tue, 22 Nov 2016 16:27:15 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 07/15] blk-throttle: make throtl_slice tunable
Message-ID: <20161122212715.GD17534@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <24137f881a149d30b98ef040367f26378128d4d2.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24137f881a149d30b98ef040367f26378128d4d2.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Nov 14, 2016 at 02:22:14PM -0800, Shaohua Li wrote:
> throtl_slice is important for blk-throttling. A lot of stuffes depend on
> it, for example, throughput measurement. It has 100ms default value,
> which is not appropriate for all disks. For example, for SSD we might
> use a smaller value to make the throughput smoother. This patch makes it
> tunable.

It bothers me a bit because time slice doesn't mean anything inherent
to throttling.  It really is an implementation detail - throttling can
be implemented at per-operation level without time slice involved at
all.  It's okay to expose the knob if necessary but the meaning of the
knob is almost completely arbitrary to users (as it has no inherent
meaning).

Thanks.

-- 
tejun
