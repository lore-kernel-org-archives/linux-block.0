Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33016 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbdHTLaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2017 07:30:00 -0400
Received: by mail-oi0-f47.google.com with SMTP id f11so131996875oic.0
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2017 04:29:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502366898-23691-3-git-send-email-adrian.hunter@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-3-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Aug 2017 13:29:59 +0200
Message-ID: <CACRpkda=q=9UhKnvK5Z2PF+kqa1L4CSdTzcr=xuiOUgG7z6sww@mail.gmail.com>
Subject: Re: [PATCH V5 02/13] mmc: core: Add members to mmc_request and
 mmc_data for CQE's
To: Adrian Hunter <adrian.hunter@intel.com>,
        linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Most of the information needed to issue requests to a CQE is already in
> struct mmc_request and struct mmc_data. Add data block address, some flags,
> and the task id (tag), and allow for cmd being NULL which it is for CQE
> tasks.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> +       int                     tag;

Is this consistent with the block layer idea of "tag"?

I am asking because I get confused.

I thought the block layers idea of a "tag" was some metadata
associated with a request. Not that I am a block layer expert.
Why can't we just name this "task_id" if that is what it is in
Linux terms? Does the specification call it "tag"?

Yours,
Linus Walleij
