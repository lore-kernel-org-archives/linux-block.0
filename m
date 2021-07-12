Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43FC07E99
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 23:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D53A61006
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 23:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGLXUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:20:08 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33490 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhGLXUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 19:20:08 -0400
Received: by mail-pg1-f175.google.com with SMTP id 37so19919832pgq.0;
        Mon, 12 Jul 2021 16:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJYXu78Otmo9gjq965zqEhcSFFXNrjOldt93lGmVRWY=;
        b=M8SLFTK1HYQrMiaAozXZDNMl/0kNdu9FNFVptwqgAuqTSwDhayYFyHiHecfbylDVF5
         Pgd391cMU46wexHtf999zc5V54AtzP073jfdvhMajq/ouk/avdsuhDeyjACTkPgs484q
         jAubDF/bgS/r6D6mXhFzxejqgAt9v62dI4aSqhXHdtXnxOVfnyz2uH6am43CB4/n4Sgw
         i03HOjaWTfW1P6a7OFjCsZhxbLM/Hjk1RUDQsh30WxGt3uSxld6CvWAj/vY1l0F+D8lM
         jdbfzasj/mn4xnrAHw4jzJi7pQMl+QYFhYwrd54asKYqwopVqEmfpghRnwtZZNKAsn96
         caXg==
X-Gm-Message-State: AOAM530y3DPviJSAdin99OH0WSFYnh2/TMyi7hhuE+52BRE54I3JZJd2
        64xEREt78YTHQ+NI0lWY1XM=
X-Google-Smtp-Source: ABdhPJyvhvuyptKDvvybAUfQSniprveC0Rop1ecCKORddZFqU4wZnKSX02PIPxefhnvmESqN2uB7Wg==
X-Received: by 2002:a65:50ca:: with SMTP id s10mr1503440pgp.68.1626131839259;
        Mon, 12 Jul 2021 16:17:19 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id b18sm482706pji.39.2021.07.12.16.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:17:17 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:17:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] zram: fix deadlock with sysfs attribute usage and
 module removal
Message-ID: <20210712231644.eeaql22odowieomb@garbanzo>
References: <20210703001958.620899-1-mcgrof@kernel.org>
 <20210703001958.620899-3-mcgrof@kernel.org>
 <20210710122851.aae9783ae9b1a703d565cbec@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710122851.aae9783ae9b1a703d565cbec@linux-foundation.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 10, 2021 at 12:28:51PM -0700, Andrew Morton wrote:
> On Fri,  2 Jul 2021 17:19:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > +#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
> > +static ssize_t module_ ## _name ## _store(struct device *dev, \
> > +				   struct device_attribute *attr, \
> > +				   const char *buf, size_t len) \
> > +{ \
> > +	ssize_t __ret; \
> > +	if (!try_module_get(THIS_MODULE)) \
> > +		return -ENODEV; \
> > +	__ret = _name ## _store(dev, attr, buf, len); \
> > +	module_put(THIS_MODULE); \
> > +	return __ret; \
> > +}
> 
> I assume that Greg's comments on try_module_get() are applicable here
> also.

While we wait for Greg for an alternative, patch #1 is still fine.

  Luis
