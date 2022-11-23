Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A2C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 16:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiKWQZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiKWQZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 11:25:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84EE8FB0D
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 08:25:34 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id jr19so11540171qtb.7
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhJSJnLVsP1vBula4KCFSx5kBTht7CuZrspFHU0N884=;
        b=ebGDyq+q12UGY7Qk5Tupc9qhDLGyIcTZVkm5UZYo/563kMYJJqyAeOt5CzUtM4J8DZ
         3trFHny8FIDylUgXR9JjN8PS72NcWsvrDfr1Nd1Q7FDnTR43onbW+jw1+Ctw0cwtwrCd
         T18F6CTTWbwHWY6WrhS9prZWxtXaTjwzs7IQnIsjaZTmFdCmKdzeecD0BbnuyMQqVQVg
         z0s4POzfjTxMQ62r8mCHZM0rSmjmaRN4hzlYV7zdZbP1xMXxym5gxZ3SKz4kt6tgYYum
         EfCUt6/g2D4WDco0MNWeSPD0NJ6lencxZ7NqZJCJlD8ikZ4WiUl7N0yJnMd2Q4wIPSG2
         7pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhJSJnLVsP1vBula4KCFSx5kBTht7CuZrspFHU0N884=;
        b=NWl9pgLd5iDeN3q8QITVkp2smugVrtnOMy9eyzNS1+L7FA5fMme04rp/Qo+yxEPa4H
         t9wxXkHUTfaXgKxzIJsCxd2ceTsqyZFtOW4ZQy0l+DUIu7JbjG9meCabJyc34a0dX1z6
         JCqGO7VVvD2H1I4+utiuS8j6KrR2YxNk/yk+yqGrUiYCKrjOjorrjSvbOC2d3TGQqYcF
         d3wW8usEa0qZSjdZ0hvcI3i0Dlqk6SABVVyH9v5sQRRp030TtbNkXMXswtYJbng1X6Lh
         7kpC12fkpKP8wi0VldrpahDEOfIGIlIa8nQuIKCOesmLKzXT3vBtMnNBkoEBPluptLVO
         kgcA==
X-Gm-Message-State: ANoB5pluI1Ck82G0o9jnClkAYItBxWh9pPx1WWhNNSS7HijZ3YDSZQ9K
        Qoshn1itXUpjagRN3NtgXtNN8g==
X-Google-Smtp-Source: AA0mqf7URgWK3LZKBiCOJvrYX2BcRTBThzd2VlaYXoILbXTQHzjAWJMWnGzlcI0wVuCFvjEWzX6GjA==
X-Received: by 2002:ac8:60c:0:b0:3a6:37bd:ace5 with SMTP id d12-20020ac8060c000000b003a637bdace5mr14127789qth.426.1669220734011;
        Wed, 23 Nov 2022 08:25:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006f8665f483fsm12561497qkl.85.2022.11.23.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:25:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxsZ2-00AOLL-MZ;
        Wed, 23 Nov 2022 12:25:32 -0400
Date:   Wed, 23 Nov 2022 12:25:32 -0400
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
Message-ID: <Y35JfNJDppRp5bLX@ziepe.ca>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <20221123122523.1332370-3-gregkh@linuxfoundation.org>
 <711d5275-7e80-c00d-0cdc-0f3d52175361@gmail.com>
 <Y34hgIW8p1RlQTBB@smile.fi.intel.com>
 <97be39ed-3cea-d55a-caa6-c2652baef399@gmail.com>
 <Y34zyzdbRUdyOSkA@casper.infradead.org>
 <Y34+V2bCDdqujBDk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y34+V2bCDdqujBDk@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 23, 2022 at 04:37:59PM +0100, Greg Kroah-Hartman wrote:
> static inline struct device *__kobj_to_dev(struct kobject *kobj)
> {
>         return container_of(kobj, struct device, kobj);
> }
> 
> static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> {
>         return container_of(kobj, const struct device, kobj);
> }
> 
> /*
>  * container_of() will happily take a const * and spit back a non-const * as it
>  * is just doing pointer math.  But we want to be a bit more careful in the
>  * driver code, so manually force any const * of a kobject to also be a const *
>  * to a device.
>  */
> #define kobj_to_dev(kobj)                                       \
>         _Generic((kobj),                                        \
>                  const struct kobject *: __kobj_to_dev_const,   \
>                  struct kobject *: __kobj_to_dev)(kobj)
> 
> 
> Want me to do the same thing here as well?

It would be nice to have a shared macro code gen all of the above
instead of copy and pasting it. Then maybe other cases beyond struct
device could adopt const too..

Jason
