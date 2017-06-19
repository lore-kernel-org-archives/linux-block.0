Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35228 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdFSTJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 15:09:50 -0400
Date: Mon, 19 Jun 2017 15:09:43 -0400
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 09/12] block: always attach cgroup info into bio
Message-ID: <20170619190943.GL12062@htj.duckdns.org>
References: <cover.1497549993.git.shli@fb.com>
 <1f9bf3d57d5fe644f433844354c9af1aedb8442a.1497549993.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1f9bf3d57d5fe644f433844354c9af1aedb8442a.1497549993.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 15, 2017 at 11:17:17AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> blkcg_bio_issue_check() already gets blkcg for a BIO.
> bio_associate_blkcg() uses a percpu refcounter, so it's a very cheap
> operation. There is no point we don't attach the cgroup info into bio at
> blkcg_bio_issue_check. This also makes blktrace outputs correct cgroup
> info.
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
