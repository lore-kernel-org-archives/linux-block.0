Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdLGTnf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Dec 2017 14:43:35 -0500
Date: Thu, 7 Dec 2017 14:43:34 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Shaohua Li <shli@kernel.org>
Cc: Khazhismel Kumykov <khazhy@google.com>, axobe@kernel.dk,
        shli@fb.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
Message-ID: <20171207194333.GB4067@redhat.com>
References: <20171114231022.42961-1-khazhy@google.com>
 <20171116165033.4noofd6gkaj6x3yl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171116165033.4noofd6gkaj6x3yl@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 16, 2017 at 08:50:33AM -0800, Shaohua Li wrote:

[..]
> Can you describe why we need this? It would be great if you can describe the
> usage model and an example. Does this work for io.low/io.max or both?

Hi Shaohua,

Is there any documentation for "io.low" somewhere now. Should we update
cgroup-v2.txt? Just reading through BLK_DEV_THROTTLING_LOW description
does not give me enough idea to know what it is.

Thanks
Vivek
