Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36442 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940407AbdAIVBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 16:01:41 -0500
Date: Mon, 9 Jan 2017 16:01:33 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 13/17] blk-throttle: ignore idle cgroup limit
Message-ID: <20170109210133.GR12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <c577fd0ec47f2e301bba98eacfd0de66f13ed7e2.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c577fd0ec47f2e301bba98eacfd0de66f13ed7e2.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 15, 2016 at 12:33:04PM -0800, Shaohua Li wrote:
> Last patch introduces a way to detect idle cgroup. We use it to make
> upgrade/downgrade decision. And the new algorithm can detect completely
> idle cgroup too, so we can delete the corresponding code.

Ah, okay, the slice based idle detection gets completely removed here.
Might be better to not add it in the first place but no biggie either
way.

Thanks.

-- 
tejun
