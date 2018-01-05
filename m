Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:44363 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeAERJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 12:09:02 -0500
Received: by mail-qk0-f175.google.com with SMTP id v188so6711671qkh.11
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 09:09:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1fcdcfe6-9fa0-a853-6b86-6049953815f6@suse.de>
References: <20180103140325.63175-1-colyli@suse.de> <20180103140325.63175-2-colyli@suse.de>
 <5cd9f028-366a-ba94-3bdf-0aefd5028c21@lyle.org> <1fcdcfe6-9fa0-a853-6b86-6049953815f6@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 5 Jan 2018 09:09:01 -0800
Message-ID: <CAJ+L6qf9Xizpmkd1hzTraPFToAUKSgjFHXSUjE6C4dKsP8cxoQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] bcache: exit bch_writeback_thread() with proper
 task state
To: Coly Li <colyli@suse.de>
Cc: linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org, Junhui Tang <tang.junhui@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Coly---

On Fri, Jan 5, 2018 at 9:05 AM, Coly Li <colyli@suse.de> wrote:
> It seems I need to call set_current_state(TASK_INTERRUPTIBLE) before
> up_write(&dc->writeback_lock), then dc->writeback_lock will protect and
> avoid the race. Or move set_current_state(TASK_INTERRUPTIBLE) to the
> location before the condition checks in line 469-471.

I think you're right.  Sorry I missed this in my review.  I will pull
this from my testing/for-416 set.

Mike
