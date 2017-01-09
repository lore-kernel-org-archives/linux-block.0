Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32770 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933850AbdAIVqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 16:46:37 -0500
Date: Mon, 9 Jan 2017 16:46:35 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 00/17] blk-throttle: add .low limit
Message-ID: <20170109214635.GV12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

Sorry about the long delay.  Generally looks good to me.  Overall,
there are only a few things that I think should be addressed.

* Low limit should default to zero.

* The default values and roles of idle timeout vs. latency target.

I don't think either would be difficult to address.  Oh and a bit more
documentation overall would be nice.

Thanks a lot for the great work and happy new year!

-- 
tejun
