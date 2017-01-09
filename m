Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35003 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933680AbdAIW1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 17:27:48 -0500
Date: Mon, 9 Jan 2017 14:27:33 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V5 00/17] blk-throttle: add .low limit
Message-ID: <20170109222732.GA35078@shli-mbp.local>
References: <cover.1481833017.git.shli@fb.com>
 <20170109214635.GV12827@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170109214635.GV12827@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 09, 2017 at 04:46:35PM -0500, Tejun Heo wrote:
> Hello,
> 
> Sorry about the long delay.  Generally looks good to me.  Overall,
> there are only a few things that I think should be addressed.

Thanks for your time!
 
> * Low limit should default to zero.

I forgot to change it after changing the name from high to low

> * The default values and roles of idle timeout vs. latency target.
> 
> I don't think either would be difficult to address.  Oh and a bit more
> documentation overall would be nice.

Will fix these.

> Thanks a lot for the great work and happy new year!

Thanks and happy new year!

Best regards,
Shaohua
