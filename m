Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9DC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732F21873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 19:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aeMJvZgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRTEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:04:20 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:43397 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeLRTEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 14:04:20 -0500
Received: by mail-io1-f41.google.com with SMTP id g17so1797070ioc.10
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=hk4T3cobtaxwHNKm4terT+08lL9KwSGmqT11f/cAHgM=;
        b=aeMJvZgFcLkC4PRH3huEWI2tflOnrVgkw2R8lg/MQ1NTiiTQWB+YpelToFZhOBPdLh
         d8Z3d0ABULbzZjk13TiUxMEyB4e9c+eYNplJ9QIQPGtJ3jD5RbTfj6DGZxFi5Tw+MTMQ
         PpOQpZA5GaM/1Y0Qh3ymwvqd4BuXauZQH/l3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=hk4T3cobtaxwHNKm4terT+08lL9KwSGmqT11f/cAHgM=;
        b=XJXSdfTFyfXesm4Y7cPeWFYMgQj0x7b31dc9bjR5sZ2PvxB7pszgVEN+iyQuVfo9w7
         XakzhU3anp/8HWL77CZOuJNM1TRkds5acmOVx2YmEOKkyjSPsksgVC83eTB/Hbfwg/a9
         rGERvhntV5KPUgPGPztj/V8pephWQcBZ/K31c1Lp6ijMU61v60g2dGDCwTTgGpJyZ1Uc
         DkIwJPlfoSx3T5bhX/iD4dtEDs6FFkgLf5hz3e1q9rrPsLE7K43/HV4UUtQD20Vhknnq
         OEd5B1b+cTPaJALVspAMzQxbN3kGY04/x5QRwf9qtf4pqQ769rlouow7A66MRCnpD5p6
         Vx+g==
X-Gm-Message-State: AA+aEWbwiuwg8SO9u5G+IQQ4Ym8bQyxyYVm4tlad2G7hnA5Ki8Dmse0w
        z+sePHt7iQ9Kwnmk1u5BTNd4ysnu0gWQZRGEtYYFWncT
X-Google-Smtp-Source: AFSGD/WXzhuG1pHQ8F7+JzTzlWqC63lM9zyj1MTBPLO8HxdlLnOXsgY4h4rRyAKM1ln1l7sdHjPOlGCfOY3zPXyZTY8=
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr15904191ior.217.1545159858876;
 Tue, 18 Dec 2018 11:04:18 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org> <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
 <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com> <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
 <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com> <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
 <a9186c0c84f31623a544d73ce9a779d6@mail.gmail.com> <7a2b3fa5-652a-2d43-c93c-be5277b34060@kernel.dk>
 <26fb62ae415185db2df6af3bed159a68@mail.gmail.com> <cf524178-c497-373c-37f6-abee13eacf19@kernel.dk>
In-Reply-To: <cf524178-c497-373c-37f6-abee13eacf19@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTtuNko6E02tULaIEHowzteDaHmgFdiSnEAolTOMIBv4s1RgHH+RzfAtR0fm4CpRS/1gH7Dy4qAokcrFwC4hOPOwKPEsCDo0+tlqA=
Date:   Wed, 19 Dec 2018 00:34:16 +0530
Message-ID: <b6b95326e2b61100ac34fc89c86e54ae@mail.gmail.com>
Subject: RE: [PATCH V2] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> I actually took a look at scsi_host_find_tag() - what I think needs fixing
> here is
> that it should not return a tag that isn't allocated.
> You're just looking up random stuff, that is a recipe for disaster.
> But even with that, there's no guarantee that the tag isn't going away.

Got your point. Let us fix in <mpt3sas> driver.

>
> The mpt3sas use case is crap. It's iterating every tag, just in case it
> needs to do
> something to it.

Many drivers in scsi layer is having similar trouble.  May be they are less
exposed. That was a main reason, I thought to provide common fix in block
layer.

>
> My suggestion would be to scrap that bad implementation and have
> something available for iterating busy tags instead. That'd be more
> appropriate and a lot more efficient that a random loop from 0..depth.
> If you are flushing running commands, looking up tags that aren't even
> active
> is silly and counterproductive.

We will address this issue through <mpt3sas> driver changes in two steps.
1. I can use  driver's internal memory and will not rely on request/scsi
command. Tag 0...depth loop  is not in main IO path, so what we need is
contention free access of the list. Having driver's internal memory and
array will provide that control.
2. As you suggested best way is to use busy tag iteration.  (only for blk-mq
stack)


Thanks for your feedback.

Kashyap

>
> --
> Jens Axboe
