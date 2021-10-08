Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE63C433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816E960F90
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 13:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJHNbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241543AbhJHNbV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 09:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633699766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+20OtyOzoxeqzG//DN6kXf3yJzCYJkrDPENdiVWnik=;
        b=PmV8CnZVKLihbxlHY3O9kTZ4Z1N7Kdqtm3kW/e7yIm0ek97ZLunGk2Bpaa+s626tei2QCa
        jNWCSjeKmAn3lVI3nO9H3pHn7ixGo44JvOyMfKllLCdZr7W6rSAlWQiMfqMhWBTymAiCEA
        JxIQ15D9jbYHJxfGznL2f29SVFNAgoo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-FlmoXpyoN3qAjsja4yZ_rA-1; Fri, 08 Oct 2021 09:29:02 -0400
X-MC-Unique: FlmoXpyoN3qAjsja4yZ_rA-1
Received: by mail-wr1-f70.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso7316890wra.13
        for <linux-block@vger.kernel.org>; Fri, 08 Oct 2021 06:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=W+20OtyOzoxeqzG//DN6kXf3yJzCYJkrDPENdiVWnik=;
        b=Qu9SOwhBSpitovtBBppZETC30AKml/QrZLjW5FpP6QzgmYzr3hcFv+aKAiKaghCTfJ
         Gg+eY+eRg/PPzVDX/KowXTSL6UeEhQU8leXB4vGpjgB2YsnV/RNY0DeyBqLxl1YZGgIG
         t0tOsGXvT05Lns/i7WngAOSIJh4UiyjsmyHiJ6t7HVPwQVrcsVGWdF9bpsE0SNjU5N20
         ypgWXTxjxeRr9T1K+67vpS4/u7LACkevXlGNfAsRIstrViOU+aWfkUHPzeCKKR4HKGJR
         beW9vMDbpn1jZqFcmGorV2Atn6IXJzjjw5TzlgUBDpJHAPq/ufJvbQDoZADac0zEUUmT
         iWTw==
X-Gm-Message-State: AOAM530UvU1PhM91JdAp5DLuUIGfVv+1KFRYhdR/beHyawLUF2OMGLAw
        b6cJ384iqJr0m7WYcDUtEvudxHYw4WMn42zyDTEgtreCjhYpROd7ZaBrDs8kEoerRykRYdwWkEP
        Xp5Ffz6csKv7sn+PQhAbUVdw=
X-Received: by 2002:a7b:c341:: with SMTP id l1mr3467552wmj.142.1633699740958;
        Fri, 08 Oct 2021 06:29:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3LlFeRzehp5jW/HXHcTYHvdvbDvy0R7E26tnAaFh6ZsgXTWn2Mhn+npR6fWXOMyfVrJ15AA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr3467528wmj.142.1633699740777;
        Fri, 08 Oct 2021 06:29:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y4sm3451927wry.95.2021.10.08.06.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:29:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Long Li <longli@microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
In-Reply-To: <YWApWbYeGqutoDMG@kroah.com>
References: <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com> <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <YWApWbYeGqutoDMG@kroah.com>
Date:   Fri, 08 Oct 2021 15:28:58 +0200
Message-ID: <87a6jj3asl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, Oct 08, 2021 at 01:11:02PM +0200, Vitaly Kuznetsov wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> ...
>> >
>> > Not to mention the whole crazy idea of "let's implement our REST api
>> > that used to go over a network connection over an ioctl instead!"
>> > That's the main problem that you need to push back on here.
>> >
>> > What is forcing you to put all of this into the kernel in the first
>> > place?  What's wrong with the userspace network connection/protocol that
>> > you have today?
>> >
>> > Does this mean that we now have to implement all REST apis that people
>> > dream up as ioctl interfaces over a hyperv transport?  That would be
>> > insane.
>> 
>> As far as I understand, the purpose of the driver is to replace a "slow"
>> network connection to API endpoint with a "fast" transport over
>> Vmbus.
>
> Given that the network connection is already over vmbus, how is this
> "slow" today?  I have yet to see any benchmark numbers anywhere :(
>
>> So what if instead of implementing this new driver we just use
>> Hyper-V Vsock and move API endpoint to the host?
>
> What is running on the host in the hypervisor that is supposed to be
> handling these requests?  Isn't that really on some other guest?
>

Long,

would it be possible to draw a simple picture for us describing the
backend flow of the feature, both with network connection and with this
new driver? We're struggling to understand which particular bottleneck
the driver is trying to eliminate.

-- 
Vitaly

