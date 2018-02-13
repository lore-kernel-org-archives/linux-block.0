Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33648 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935243AbeBMOnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Feb 2018 09:43:17 -0500
Date: Tue, 13 Feb 2018 06:43:14 -0800
From: Tejun Heo <tj@kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: axboe@fb.com, shli@fb.com, vgoyal@redhat.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: avoid multiple counting for same bio
Message-ID: <20180213144314.GP695913@devbig577.frc2.facebook.com>
References: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 13, 2018 at 02:45:50PM +0800, Chengguang Xu wrote:
> In current throttling/upper limit policy of blkio cgroup
> blkio.throttle.io_service_bytes does not exactly represent
> the number of bytes issued to the disk by the group, sometimes
> this number could be counted multiple times of real bytes.
> This fix introduces BIO_COUNTED flag to avoid multiple counting
> for same bio.
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>

We had a series of fixes / changes for this problem during the last
cycle.  Can you please see whether the current linus master has the
same problem.

Thanks.

-- 
tejun
