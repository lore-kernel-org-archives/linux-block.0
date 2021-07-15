Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16968C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E896128D
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhGOOMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhGOOMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626358198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFJXZGV7aNAREnh89TW34RE/5AHLlwB5DBQieYCgIYY=;
        b=jNwLKNDGlFz+x0wmXpEUsPu5hUQgS/y4Swo+bix94j4vdXrIKu4u2x0LfAzNQI7Vyzmixn
        NxcMoOWdCeYj7vZ74ZBClhfLPBUls12eDqpx9v12Z6D/vzVREOtF7KMdJ9ESjZgkLxdsgN
        nC5fzyo5B3coRplKlKlQAEI9M0Dp+PY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190--gP4xdu1OBmGTC03xAAtaw-1; Thu, 15 Jul 2021 10:09:56 -0400
X-MC-Unique: -gP4xdu1OBmGTC03xAAtaw-1
Received: by mail-ed1-f71.google.com with SMTP id r23-20020aa7d5970000b02903ae404e7fb4so1212054edq.12
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 07:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tFJXZGV7aNAREnh89TW34RE/5AHLlwB5DBQieYCgIYY=;
        b=UDjn1r7sJHxmKs+MTPy3WaFfTHw0AFcZbgHjUPuDIk5drKVbcrXD9GOZ8gFvCn9i0d
         sV6VHHo1j2byON5CtwOsrmx/nqrnUKZciTtdY1tq4jkHK4i3zIPd+DlU3+NySZx/VVqA
         O4dTwujeXxOgTzbjFHYLd+Z2MDT0R6yQDJmdt/7+Y6mVXGdxxzk3jUnKXlwgmbwCNNh3
         W78cPpVdh7OsHibDoBmKdgcyhx59VgD4s3UfScUi6Pjk7A5zL87AfqjsPs+MSriiN46B
         fnz7vNxm08JnuFS6gAF27LwuHj8cQxFEUCYCW5j9CqHposg2cYndq19DzE8/st9U4KVs
         ZPaQ==
X-Gm-Message-State: AOAM532IOCO7rbe1/oxJ2AVeJOSlWlbY2r55UIoPN+Cj6cnMN/RI1hU2
        E4WZlU92GH3M2g/hRxHMAHTz6dBwnPHc6QAR1GucFwUDIbS1o6kNrQzVeSNVfAuJFSw4TNw/rrk
        B6hQRm+fEz5mbo18EgLpl/Ns=
X-Received: by 2002:aa7:d991:: with SMTP id u17mr7226996eds.240.1626358191953;
        Thu, 15 Jul 2021 07:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4KCo5yWB3CUiMiCx4bNhZEE9IvvOeUpFd2/S/H0MMsvN7gNqlBpEaA1BuPjpWA2rCZTWo6g==
X-Received: by 2002:aa7:d991:: with SMTP id u17mr7226968eds.240.1626358191806;
        Thu, 15 Jul 2021 07:09:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n11sm1941466ejg.43.2021.07.15.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:09:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: [BUG report] Deadlock in xen-blkfront upon device hot-unplug
In-Reply-To: <20210715134656.GA4167@lst.de>
References: <87pmvk0wep.fsf@vitty.brq.redhat.com>
 <20210715124622.GA32693@lst.de> <87k0lr1zta.fsf@vitty.brq.redhat.com>
 <20210715134656.GA4167@lst.de>
Date:   Thu, 15 Jul 2021 16:09:49 +0200
Message-ID: <87eebz1xea.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Jul 15, 2021 at 03:17:37PM +0200, Vitaly Kuznetsov wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > On Thu, Jul 15, 2021 at 11:16:30AM +0200, Vitaly Kuznetsov wrote:
>> >> I'm observing a deadlock every time I try to unplug a xen-blkfront
>> >> device. With 5.14-rc1+ the deadlock looks like:
>> >
>> > I did actually stumble over this a few days ago just from code
>> > inspection.  Below is what I come up with, can you give it a spin?
>> 
>> This eliminates the deadlock, thanks! Unfortunately, this reveals the
>> same issue I observed when I just dropped taking the mutex from
>> blkfront_closing():
>
> Yeah, this still left too much cruft in blkfront_closing.  Can you
> try this version instead?
>

This one seems to work fine for me! Feel free to throw

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

in. Thanks a lot!

-- 
Vitaly

