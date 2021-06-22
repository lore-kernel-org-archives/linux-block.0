Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B62C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D80A60FEB
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 15:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFVP3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:29:36 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39730 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFVP3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 11:29:33 -0400
Received: by mail-pl1-f181.google.com with SMTP id o21so10613365pll.6;
        Tue, 22 Jun 2021 08:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9Li0eWJU5Fw1KZkFQn1EnfS7gBuV+utSTj1IIdo1g4=;
        b=HDw1GredpVvHRYrX+Za3H+Xzc/CW5GBAuGlTxISPvRG0uqiE35psyPU6EeTpurL0up
         nLCtyCORl3qRv5QyEzpaqTbo+cT0FFnvAQ02leo5RaeBJe1bnIZ/XSbP4g+eNz2ef81m
         FVKdr8VUVI5uu04aAZwkgQxAXHNrxmkxQlSnz/3sI45yLUCn9qD4v9G6GA1ddZOfUYsz
         +8JejqVGNPefAwaxSfDa3wdYfm/LJjUsElxyrsP2q7kGFkjHpk7foRK9Rfm57oLtTK5q
         qZjDFCZDXUOh49n3mqwgQv7QLuFUp+3hpOtADrVrmmasYayMw6MQyk+iYbJvB+6uNDp8
         oi1g==
X-Gm-Message-State: AOAM532x7uGOYAytl0FLaXxznzdC2tbmC6TSHBWGi7tmfhqhOKbg6ZJ1
        dvfGpPT4q1EItW72Er17O3I=
X-Google-Smtp-Source: ABdhPJwIscItml4HZYFUA1Gk8IE9BudN7XAv0fogge2W/PCJNCPnyAfSF6akvDTOoVIxMWKW/gR2RA==
X-Received: by 2002:a17:90a:8547:: with SMTP id a7mr4634510pjw.197.1624375637038;
        Tue, 22 Jun 2021 08:27:17 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id a23sm857740pfn.117.2021.06.22.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:27:16 -0700 (PDT)
Date:   Tue, 22 Jun 2021 08:27:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <20210622152713.fqwyuqpamwgaxomc@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGUIzh7aR3C/Hoz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGUIzh7aR3C/Hoz@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:41:23AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > +	ssize_t __ret; \
> > +	if (!try_module_get(THIS_MODULE)) \
> 
> try_module_get(THIS_MODULE) is always racy and probably does not do what
> you want it to do.  You always want to get/put module references from
> code that is NOT the code calling these functions.

In this case, we want it to trump module removal if it succeeds. That's all.

> > +		return -ENODEV; \
> > +	__ret = _name ## _store(dev, attr, buf, len); \
> > +	module_put(THIS_MODULE); \
> 
> This too is going to be racy.
> 
> While fun to poke at, I still think this is pointless.

If you have a better idea, which does not "DOS" module removal, please
let me know!

  Luis
