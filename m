Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:43151 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdKHJYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:24:54 -0500
Received: by mail-it0-f44.google.com with SMTP id a188so372645itc.0
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:24:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-7-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-7-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 10:24:53 +0100
Message-ID: <CACRpkdaf8nt1P32M+uYD3xSTTHMO8YMnP=Y56H179XiB9mvakQ@mail.gmail.com>
Subject: Re: [PATCH V13 06/10] mmc: sdhci-pci: Add CQHCI support for Intel GLK
To: Adrian Hunter <adrian.hunter@intel.com>
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

On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add CQHCI initialization and implement CQHCI operations for Intel GLK.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch seems OK in context, but it merely illustrates the
weirdness of .[runtime]_suspend/resume calling into CQE-specific
APIs rather than using generic host callbacks.

Yours,
Linus Walleij
