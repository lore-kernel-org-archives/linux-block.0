Return-Path: <linux-block-owner@vger.kernel.org>
Received: from server.coly.li ([162.144.45.48]:38780 "EHLO server.coly.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdI2EW5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2017 00:22:57 -0400
Subject: Re: [PATCH 4/5] bcache: writeback: collapse contiguous IO better
To: Michael Lyle <mlyle@lyle.org>
Cc: Junhui Tang <tang.junhui@zte.com.cn>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1506656271-22665-1-git-send-email-tang.junhui@zte.com.cn>
 <CAJ+L6qeyOHvNUZzWrukGWAGqkmUza0S49DYEm+H_VgpPYKjwZA@mail.gmail.com>
From: Coly Li <i@coly.li>
Message-ID: <e90f6574-89b5-34f8-c05c-f7e6199c1f92@coly.li>
Date: Fri, 29 Sep 2017 12:22:45 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+L6qeyOHvNUZzWrukGWAGqkmUza0S49DYEm+H_VgpPYKjwZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/9/29 下午12:15, Michael Lyle wrote:
[snip]
> Also, why do you keep copying linux-block for every bit of feedback on
> this code?  It seems like we probably don't want to clutter that list
> with this discussion.

Oh, it is because Christoph Hellwig suggested to Cc linux-block when
posting bcache patches to linux-bcache list, then patches may have more
eyes on them.

Thanks.

Coly Li
