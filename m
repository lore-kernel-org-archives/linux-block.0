Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEAC4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 17:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiKWRzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiKWRzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 12:55:46 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EFEC4C3F
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:55:44 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id cz18so6313199qvb.13
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZGGAbQVRBkDZyExP7ffjlyLb6N0sV9F4cgg4l8gSxE=;
        b=My/je7B5AkyQl5fsdxgrcU4MlCIO0r7BQ5Ticu0quoimRFyd1QFWg1CIRYo2hSlhCk
         gVjIJJSUMGBCSbu4UDXzbQPaiJloUApBWvaqFNa76nYHQxGNxzJWcDLEm0qltzXuuN/Z
         gO+uDnAR3m7NYXWzCuDuYM8LFnvN0Xu6vLCMlAClrlBYpN6lXcqxJLcrsGyjBmH/Sv12
         +4Tfy+Id6dykaHW4e8It4+0URa6BTBpgvGETfgKsz3tVQND5afP3nmgNdrdjI227ASXm
         vr1NQmNHtxvof8mhDMYhIaXb4hON7jWdw6w75cCEJBe1LxtxXk3bYjl3v+s4zDC4Zj8c
         gKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZGGAbQVRBkDZyExP7ffjlyLb6N0sV9F4cgg4l8gSxE=;
        b=kAkC4ib/GpqJ9TOEgO9mD3Q710PRfQ7Zc8DZ6eZ5JzhvAZaA8MzzBpy5/+nCZAIWFU
         /0Tnq7HAEYIyUnlbPg58qZ/BjL8jHZxrbWsYsy3iEjv9DLlDZtWHiZ+HUE0sVa3h6U0y
         MdL3ZhZ0PnmidSHSUIZriU5z967GaBTYASVdQK2Eoeczrp5EmhhSBAldZpERsNdO0ULy
         xDmRQJI5DHK6y2/u2tonORRAgM5FruyKLOMN82e/EH0DtzoGSNspdyjuB+W2yDtpAbw5
         aViaNvwRT1DV0VolCaQnD3z40sfn2rpURz7AjhKojc1MJCWqOA7OevA6TkX0pichTZwv
         2dbQ==
X-Gm-Message-State: ANoB5pmIqksVOM+nUW1keUVI1cmsPrBLJOmBmZN9numqQaddJOkpuW1+
        D3J1lHIxzC7/QrZnRN1VcZpQmQ==
X-Google-Smtp-Source: AA0mqf6wKiTjKYxvtjsF4TJ4YPeSr0mdEUQ+pw8A+HZdflt1p0dm9sIfWC/e+svu0siqN7xcA8Vb/g==
X-Received: by 2002:a05:6214:209:b0:4bb:6bbd:8c1b with SMTP id i9-20020a056214020900b004bb6bbd8c1bmr9012796qvt.111.1669226143925;
        Wed, 23 Nov 2022 09:55:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006faaf6dc55asm11988986qkk.22.2022.11.23.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:55:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxtyI-00Afdu-Dk;
        Wed, 23 Nov 2022 13:55:42 -0400
Date:   Wed, 23 Nov 2022 13:55:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Wolfram Sang <wsa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 3/5] driver core: make struct device_type.uevent() take a
 const *
Message-ID: <Y35enjI+dhhqiG3B@ziepe.ca>
References: <20221123122523.1332370-3-gregkh@linuxfoundation.org>
 <711d5275-7e80-c00d-0cdc-0f3d52175361@gmail.com>
 <Y34hgIW8p1RlQTBB@smile.fi.intel.com>
 <97be39ed-3cea-d55a-caa6-c2652baef399@gmail.com>
 <Y34zyzdbRUdyOSkA@casper.infradead.org>
 <Y34+V2bCDdqujBDk@kroah.com>
 <Y35JfNJDppRp5bLX@ziepe.ca>
 <Y35R+/eQJYI7VaDS@kroah.com>
 <Y35YlI93UBuTfgYy@ziepe.ca>
 <Y35dMIaNYSE0Cykd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35dMIaNYSE0Cykd@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 23, 2022 at 05:49:36PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 23, 2022 at 01:29:56PM -0400, Jason Gunthorpe wrote:
> > #define generic_container_of(in_type, in, out_type, out_member) \
> > 	_Generic(in,                                        \
> >                   const in_type *: ((const out_type *)container_of(in, out_type, out_member)),   \
> >                   in_type *: ((out_type *)container_of(in, out_type, out_member)) \
> > 		  )
> 
> There's a neat trick I found in seqlock.h:
> 
> #define generic_container_of(in_t, in, out_t, m)			\
> 	_Generic(*(in),							\
> 		const in_t: ((const out_t *)container_of(in, out_t, m)), \
> 		in_t: ((out_t *)container_of(in, out_type, m))	\
> 	)
>
> and now it fits in 80 columns ;-)

Aside from less letters, is their another benifit to using *(in) ?

Jason
