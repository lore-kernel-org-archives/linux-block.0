Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B25C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A010961352
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVVhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhFVVhL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:37:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B523260FDA;
        Tue, 22 Jun 2021 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624397695;
        bh=4cSRvAqoTHr4OwTcbZ6u9/bzZawdJvtkgTtzw7brYrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7QxsBsX/81+AblHGmGihylV4H1XrwhGnCGfVW/S7hSzHRL6iM+gk6hWeUrDoskL9
         46Oxnt/2JXQ/H/sHBbrh/4xuOavYBeaGtKpj5ItYX7F0GPGroX+P56uwPYgoSnFCBI
         Zcr1lrQSmQqqi1zHfwK3eJaIgQalJ9V7l3xSAMfI=
Date:   Tue, 22 Jun 2021 23:34:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <YNJXfNfn4+CaKOyz@kroah.com>
References: <20210622210659.3708231-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622210659.3708231-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 02:06:59PM -0700, Luis Chamberlain wrote:
>  static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
>  			     char *buf)
>  {
> -	struct device_attribute *dev_attr = to_dev_attr(attr);
> -	struct device *dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr;
> +	struct device *dev;
> +	struct bus_type *bus = NULL;
>  	ssize_t ret = -EIO;
>  
> +	dev = get_device(kobj_to_dev(kobj));
> +	if (!dev)
> +		return ret;

That check is impossible to ever hit, please recognize what things like
kobj_to_dev() really are doing when calling it.

thanks,

greg k-h
