Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:39917 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeB0SHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 13:07:08 -0500
Received: by mail-pf0-f171.google.com with SMTP id u5so1522709pfh.6
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 10:07:08 -0800 (PST)
Subject: Re: [PATCH v7 4/9] bcache: add CACHE_SET_IO_DISABLE to struct
 cache_set flags
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Junhui Tang <tang.junhui@zte.com.cn>,
        Pavel Vazharov <freakpv@gmail.com>
References: <20180227165557.20442-1-colyli@suse.de>
 <20180227165557.20442-5-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <aefa3d5a-f168-9105-385a-4bb6bf6fa136@lyle.org>
Date: Tue, 27 Feb 2018 10:07:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180227165557.20442-5-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly Li--

On 02/27/2018 08:55 AM, Coly Li wrote:
> When too many I/Os failed on cache device, bch_cache_set_error() is called
> in the error handling code path to retire whole problematic cache set. If
> new I/O requests continue to come and take refcount dc->count, the cache
> set won't be retired immediately, this is a problem.
> 
> Further more, there are several kernel thread and self-armed kernel work
> may still running after bch_cache_set_error() is called. It needs to wait
> quite a while for them to stop, or they won't stop at all. They also
> prevent the cache set from being retired.

It's too bad this is necessary-- I wish the IO layer could latch error
for us in some kind of meaningful way instead of us having to do it
ourselves (and for filesystems, etc, having to each do similar things to
prevent just continuously hitting IO timeouts).  That said, the code
looks good.

Reviewed-by: Michael Lyle <mlyle@lyle.org>
