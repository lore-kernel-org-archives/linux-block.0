Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C861CC12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89DB6108B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 11:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhGUKwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237738AbhGUKs7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 06:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72A5D60FD7;
        Wed, 21 Jul 2021 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626866971;
        bh=KuqXd9c0oqHy7TdswVIRrqpFLTWdndmpxVDUpS8AoeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZeIaHEKdRo96dzgmo07yomricrlx6+KG9BaiBnyaXBlrGPBbeWvTXCL1WX3fLxfb
         6LZBP86wH4eIp/EjLHez/KCaittkmCRT/W/ZZ5HrYMkoB3mlLfB4vGeUuuTGcpMBnO
         QRgslRJYN9seO9ahClGZW9IY+p/2nXsep/Xrj2Zk=
Date:   Wed, 21 Jul 2021 13:29:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <YPgFGd+FZQZWODY7@kroah.com>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210703001958.620899-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 02, 2021 at 05:19:57PM -0700, Luis Chamberlain wrote:
> +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> +static ssize_t module_ ## _name ## _store(struct device *dev, \
> +				   struct device_attribute *attr, \
> +				   const char *buf, size_t len) \
> +{ \
> +	ssize_t __ret; \
> +	if (!try_module_get(THIS_MODULE)) \
> +		return -ENODEV; \

I feel like this needs to be written down somewhere as I see it come up
all the time.

Again, this is racy and broken code.  You can NEVER try to increment
your own module reference count unless it has already been incremented
by someone external first.

As "proof", what happens if this module is unloaded right _before_ this
call happens?  The module will be unloaded, memory zeroed out (or
overridden), and then the processor will resume here and try to call (or
return into) this code path.

Boom.

Just say no to "try_module_get(THIS_MODULE)" as it is totally wrong.

thanks,

greg k-h
