Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385FC07E95
	for <linux-block@archiver.kernel.org>; Sat, 10 Jul 2021 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BF56128C
	for <linux-block@archiver.kernel.org>; Sat, 10 Jul 2021 19:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGJTbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Jul 2021 15:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhGJTbj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Jul 2021 15:31:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEE7E60FDA;
        Sat, 10 Jul 2021 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625945334;
        bh=cofA/x07+QPifmOZoVr2VFlfgkdydnPVIzFmRVlJr04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThZkvzbmUe4dUtE3AFBbBjKEFNN9bLPeQuuyed4R8V3vHSrs2GtuVTFeOuz7OWdx0
         QSPhopyxgXCyTaoSOXMrTDkT4tda+RP/Tx/P27nZyH5CW29JKAOHhmd+9OvMa7lIjO
         6Xw3rYIVqIdaiNFZbxWGrOR9HVXeADvfJqhsZe48=
Date:   Sat, 10 Jul 2021 12:28:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage
 and module removal
Message-Id: <20210710122851.aae9783ae9b1a703d565cbec@linux-foundation.org>
In-Reply-To: <20210703001958.620899-3-mcgrof@kernel.org>
References: <20210703001958.620899-1-mcgrof@kernel.org>
        <20210703001958.620899-3-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri,  2 Jul 2021 17:19:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> +static ssize_t module_ ## _name ## _store(struct device *dev, \
> +				   struct device_attribute *attr, \
> +				   const char *buf, size_t len) \
> +{ \
> +	ssize_t __ret; \
> +	if (!try_module_get(THIS_MODULE)) \
> +		return -ENODEV; \
> +	__ret = _name ## _store(dev, attr, buf, len); \
> +	module_put(THIS_MODULE); \
> +	return __ret; \
> +}

I assume that Greg's comments on try_module_get() are applicable here
also.

