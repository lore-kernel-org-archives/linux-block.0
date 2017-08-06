Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37988 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdHFB4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Aug 2017 21:56:33 -0400
MIME-Version: 1.0
In-Reply-To: <76006963eb89552e91e3d6acf72199a75d45659a.1501945859.git.shli@fb.com>
References: <cover.1501945859.git.shli@fb.com> <76006963eb89552e91e3d6acf72199a75d45659a.1501945859.git.shli@fb.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 5 Aug 2017 18:56:31 -0700
Message-ID: <CAA9_cmdcYq8yr9cO=Tm4bQ25OhFbhy=e2mNWtknFMPc5BqGEDA@mail.gmail.com>
Subject: Re: [PATCH 5/5] testb: badblock support
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kyungchan Koh <kyungchan.koh@gmail.com>,
        Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Aug 5, 2017 at 8:51 AM, Shaohua Li <shli@kernel.org> wrote:
> From: Shaohua Li <shli@fb.com>
>
> Sometime disk could have tracks broken and data there is inaccessable,
> but data in other parts can be accessed in normal way. MD RAID supports
> such disks. But we don't have a good way to test it, because we can't
> control which part of a physical disk is bad. For a virtual disk, this
> can be easily controlled.
>
> This patch adds a new 'badblock' attribute. Configure it in this way:
> echo "+1-100" > xxx/badblock, this will make sector [1-100] as bad
> blocks.
> echo "-20-30" > xxx/badblock, this will make sector [20-30] good

Did you happen to overlook block/badblocks.c, or did you find it unsuitable?
