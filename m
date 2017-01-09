Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35431 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbdAIVRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 16:17:35 -0500
Date: Mon, 9 Jan 2017 16:17:28 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 15/17] block: track request size in blk_issue_stat
Message-ID: <20170109211728.GT12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <76954496f30da4902288fc027a0ed74a232535e5.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <76954496f30da4902288fc027a0ed74a232535e5.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 15, 2016 at 12:33:06PM -0800, Shaohua Li wrote:
> Currently there is no way to know the request size when the request is
> finished. Next patch will need this info, so add to blk_issue_stat. With
> this, we will have 49bits to track time, which still is very long time.

Not necessarily an objection but do we really need to overload the
size field?  Would a normal extra field hurt too much?

Thanks.

-- 
tejun
