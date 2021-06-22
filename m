Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038EDC48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCF5611CE
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhFVHnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhFVHnm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:43:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04E506113D;
        Tue, 22 Jun 2021 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624347685;
        bh=cXqANP3NFVa6yYTARGTcMaDW/gT6xyATnR047Rh4aE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7IXLenUWR3EkWDbA3UNQv9xpNKg8nG+wLfMwoIuNpXLfIhrSJV6UXegTZ0ZM2M01
         4HwUOkiDvQ+Uyh+GkgGGZjHiKrE+b7ok+gP3/UtnOwtRbGel4bqJFIKN+qIa0fgVbB
         WLtE/0XHF3XBm4Ofr5UefpCZ9DjUgKd/X/g5ZHyM=
Date:   Tue, 22 Jun 2021 09:41:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <YNGUIzh7aR3C/Hoz@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621233634.595649-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> +	ssize_t __ret; \
> +	if (!try_module_get(THIS_MODULE)) \

try_module_get(THIS_MODULE) is always racy and probably does not do what
you want it to do.  You always want to get/put module references from
code that is NOT the code calling these functions.

> +		return -ENODEV; \
> +	__ret = _name ## _store(dev, attr, buf, len); \
> +	module_put(THIS_MODULE); \

This too is going to be racy.

While fun to poke at, I still think this is pointless.

greg k-h
