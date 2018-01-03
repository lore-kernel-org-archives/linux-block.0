Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42502 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeACRHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 12:07:30 -0500
Received: by mail-pg0-f44.google.com with SMTP id q67so904487pga.9
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2018 09:07:30 -0800 (PST)
Subject: Re: [PATCH v1 00/10] cache device failure handling improvement
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
References: <20180103140325.63175-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <e53e363e-740d-5974-d989-6bf2c3a37dac@lyle.org>
Date: Wed, 3 Jan 2018 09:07:27 -0800
MIME-Version: 1.0
In-Reply-To: <20180103140325.63175-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Coly,

On 01/03/2018 06:03 AM, Coly Li wrote:
[snip]
> The first 8 patches of this patch set is to fix existing bugs in bcache,
> the last 2 patches do the real improvement. Order of applying these patches
> is important, if the last 2 patches are applied firstly, kernel panic or
> process hang will be observed. Therefore I suggest to apply the first 8
> fixes, then apply the last 2 patches.

Wow, this is a lot of changes.  :D  Thanks for the fixes.  I've skimmed
through these (no real review yet) and overall what you're doing looks
good.  I think I'm going to concentrate on the first several patches in
the set for now as a strategy to get at least some of this in for the
first pass of 4.16 and we can figure out what to do from there.

We're up to RC6, so it's getting to be time to get things into next, and
pretty soon I need to focus on testing for awhile.

[off-topic, I wasn't able to find the time to go through the lock model
for 4.16 as I had hoped-- hopefully these changes make it to 4.17].

Mike
