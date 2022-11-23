Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiKWS0I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 13:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbiKWS0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 13:26:07 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6E67122
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 10:26:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c15so11781424qtw.8
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wor3YG1VA6P7o8c/O7L7eJMI/pZ9HPWWwXQft3hmCP0=;
        b=cedo7ZWSmsuH0XJ4ubpV07F12j6QbWjVQ5/8pLuMpcToghtBSuk56S6MXMX6Qm7WjS
         1NChO+moKmrDNMneamIggSvWWzwr/T//kN/Kwcj6tkr42ZlPhD/UrODWK93fqzNGGGwJ
         iaes3XW9eYna/Bw5lL+n4z8tFP5LtgS2cmv98rZ7AlPx3XDSdaiaMvzcA8+djvnqI1Jm
         kByuaQkEy2IUN0jEoJWE9aJxjegXkz/nFnBqeS7bAW8o6PzzHwTSega1vNzAX6eGe++Z
         VrL1e2yxkd6Af/0OPW4nuezYyEJvxr1zGiOqJwebNXGUK6ij0o7CaXNXzEmp7wpIRmex
         6uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wor3YG1VA6P7o8c/O7L7eJMI/pZ9HPWWwXQft3hmCP0=;
        b=XqGO9QuA4y6oIOYjawCmAhiCndguoLf042xKftvA4NfU0AcMdXHGMrgxWBF82rDvcs
         fMQZbpK/jKSSvhROHyDzUsJfkgjYq8Yo94lvvOVJBXU/rb1bmhUO8GefHTXGlB78R4aQ
         +4jOP9pptZy8ggaJQSZYWryTDdy9xX1kxWVHZKLGv4IkRR2TqT+Q9oRyqMZUZLrUniyt
         I5OiBJFC0kjiGgGZy7tjzFXmaGjz7EVAAWSt6rDI1d141omPSgEebtUu1PNgk8kXjGKb
         3gNLD4BlBVcnv4T4cakh2Nqq74e38b4hNQpD8oWCZxJqHgo+A3sAB8oBAvQwxAhjHUhb
         KHtw==
X-Gm-Message-State: ANoB5pm+AHNirA3ANMxQAF8E9dvrm+4BEIz/EKIFCFRqjVYiRv6rYVvk
        inlCNL2N3Nb7+2gJ6sYuz1lR9A==
X-Google-Smtp-Source: AA0mqf7b8dECsNl10eMwxdSE/ntYRY0ZHq3jcx6smQ+WjEjXUXHAE2sWPKfXnqS1wuH6GWMgna/H+Q==
X-Received: by 2002:a05:622a:1f97:b0:3a6:39c4:dc6 with SMTP id cb23-20020a05622a1f9700b003a639c40dc6mr19492448qtb.515.1669227960618;
        Wed, 23 Nov 2022 10:26:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id e9-20020ac81309000000b003a56796a764sm10034417qtj.25.2022.11.23.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:25:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxuRb-00AgEQ-7R;
        Wed, 23 Nov 2022 14:25:59 -0400
Date:   Wed, 23 Nov 2022 14:25:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y35lt+0jXrOKynL5@ziepe.ca>
References: <711d5275-7e80-c00d-0cdc-0f3d52175361@gmail.com>
 <Y34hgIW8p1RlQTBB@smile.fi.intel.com>
 <97be39ed-3cea-d55a-caa6-c2652baef399@gmail.com>
 <Y34zyzdbRUdyOSkA@casper.infradead.org>
 <Y34+V2bCDdqujBDk@kroah.com>
 <Y35JfNJDppRp5bLX@ziepe.ca>
 <Y35R+/eQJYI7VaDS@kroah.com>
 <Y35YlI93UBuTfgYy@ziepe.ca>
 <Y35dMIaNYSE0Cykd@casper.infradead.org>
 <Y35iKfYf3ThdVvaR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35iKfYf3ThdVvaR@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 23, 2022 at 07:10:49PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2022 at 05:49:36PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 23, 2022 at 01:29:56PM -0400, Jason Gunthorpe wrote:
> > > #define generic_container_of(in_type, in, out_type, out_member) \
> > > 	_Generic(in,                                        \
> > >                   const in_type *: ((const out_type *)container_of(in, out_type, out_member)),   \
> > >                   in_type *: ((out_type *)container_of(in, out_type, out_member)) \
> > > 		  )
> > 
> > There's a neat trick I found in seqlock.h:
> > 
> > #define generic_container_of(in_t, in, out_t, m)			\
> > 	_Generic(*(in),							\
> > 		const in_t: ((const out_t *)container_of(in, out_t, m)), \
> > 		in_t: ((out_t *)container_of(in, out_type, m))	\
> > 	)
> > 
> > and now it fits in 80 columns ;-)
> 
> Nice trick!  Dropping the inline functions is a bit different, let me
> see if that still gives a sane error if we pass an incorrect type or
> mess with the const * the wrong way.  I'll run some tests tomorrow
> afternoon...

The errors in some cases are very verbose, but it is somewhat
understandable - the worst is when _Generic fails to match anything,
but also at least clang partially expanded container_of and it throws
other assertions too.

I also wonder if this could just be rolled into the normal
container_of.

in_type would have to be derived like:

  in_type = typeof((out_type *)NULL)->out_member)

But I don't know if you can use typeof in a generic type matching expression..

Jason
