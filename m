Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:49265 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdKJKTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 05:19:17 -0500
Received: by mail-io0-f196.google.com with SMTP id x63so872350ioe.6
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2017 02:19:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-4-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbLRc8PMguqHOokhyZVUua2TGLL11BCxTawQoWdD2ZaGg@mail.gmail.com>
 <416a00a8-3ea0-b600-aa60-b0d176c967a3@intel.com> <CACRpkdakoJ+Ktyz-NyR=Ut7Qff+9yMdZQa9hqL7jAXdWwtLxjQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Nov 2017 11:19:15 +0100
Message-ID: <CACRpkdbsF2FAwT+d6qQ7S+GvPPr38KERBhjxEbjxuE6yaOXNNQ@mail.gmail.com>
Subject: Re: [PATCH V13 03/10] mmc: block: Add blk-mq support
To: Adrian Hunter <adrian.hunter@intel.com>,
        Neil Brown <neilb@suse.com>, Ming Lei <ming.lei@canonical.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Following up on this:

On Thu, Nov 9, 2017 at 4:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> No one has ever suggested that the legacy API will remain.  Once blk-mq is
>> ready the old code gets deleted.
>
> The block layer maintainers most definately think MQ is ready
> but you seem to disagree. Why?
>
> In the recent LWN article from kernel recepies:
> https://lwn.net/Articles/735275/
> the only obstacle I can see is a mention that SCSI was not
> switched over by default because of some problems with
> slow rotating media. "This change had to be backed out
> because of some performance and scalability issues that
> arose for rotating storage."
>
> Christoph mentions that he's gonna try again for v4.14.
> But it's true, I do not see that happening in linux-next yet.

Neil Brown's article on LWN points to Ming Lei's patch
set:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1513023.html

As addressing the issue that held back blk-MQ from
being default for SCSI, and it is reportedly to be
queued for v4.15. Since this MMC/SD rework is
also targeted for v4.15 I think we can assume it is
pretty much ready for everything, and delete the
non-MQ block path.

I just haven't seen any of this problem in my tests
with MMC/SD so I do not think it would be affected,
but it anyways seem to be fixed.

OK maybe I am especially optimistic. But it's not just
based on that.

Yours,
Linus Walleij
