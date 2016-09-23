Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33986 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbcIWQxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 12:53:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id t67so6160941ywg.1
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2016 09:53:40 -0700 (PDT)
Date: Fri, 23 Sep 2016 12:53:39 -0400
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blkcg: Annotate blkg_hint correctly
Message-ID: <20160923165339.GC31387@htj.duckdns.org>
References: <a22244c9-c8fa-2538-688e-58b7284dc387@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a22244c9-c8fa-2538-688e-58b7284dc387@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 23, 2016 at 09:07:56AM -0700, Bart Van Assche wrote:
> Avoid that sparse complains about blkg_hint manipulations.
> 
> Fixes: a637120e4902 ("blkcg: use radix tree to index blkgs from blkcg")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
