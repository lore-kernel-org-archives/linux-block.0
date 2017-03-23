Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932592AbdCWU7E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2017 16:59:04 -0400
MIME-Version: 1.0
In-Reply-To: <8AA3DAC1-5E9C-438E-904B-D4C708A4F624@fb.com>
References: <1490050729-3578-1-git-send-email-mlin@kernel.org>
 <1490050729-3578-2-git-send-email-mlin@kernel.org> <8AA3DAC1-5E9C-438E-904B-D4C708A4F624@fb.com>
From: Ming Lin <mlin@kernel.org>
Date: Thu, 23 Mar 2017 13:58:58 -0700
Message-ID: <CAF1ivSbhnCET2V3iiAG57N_WJtKayJtp2UAX3miJvf+Zrpo3LA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] nbd: replace kill_bdev() with __invalidate_device()
To: Josef Bacik <jbacik@fb.com>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Ratna Manoj Bolla <manoj.br@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianshu.ljs@alibaba-inc.com" <jianshu.ljs@alibaba-inc.com>,
        "xiongwei.jiang@alibaba-inc.com" <xiongwei.jiang@alibaba-inc.com>,
        "james.liu@alibaba-inc.com" <james.liu@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 23, 2017 at 10:51 AM, Josef Bacik <jbacik@fb.com> wrote:
> Yeah I think this is ok, I’ll throw it on my queue for fixes for this cycle.  Thanks,

Great. Thanks.

>
> Josef
