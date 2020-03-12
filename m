Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07497C1975A
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC90E2071B
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zssgGwlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCLOGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:06:15 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42647 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgCLOGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 10:06:14 -0400
Received: by mail-il1-f193.google.com with SMTP id x2so5543969ila.9
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
        b=zssgGwlH8/VmLMRtLhaCwqZbq9RREsK0T5bf6PIvtt1VGFFLfPPnQnZejqOTYcE66h
         YC0y2su0NF5zACw1HZZsr7rjtUkogTsWqTu6Vm6/ie+LuGi85xrZGApcNLASkl90rCNH
         N3iKNDAKYS9oq8i9IEow8BJeJKPxUsJrlebRdwIF5eJPTF0cAwRj9ggXLmAxIDhdEZuG
         PvnpPrEInwbqPNIjvL3PzflYawxDa3mZi2TgaKLvf7ECZzHSxJx3KAoa2ry7Pf7aKJ1S
         y7gpjNa2PHKgoNp0XyIc9HwCBIQjRNDXD+/sV+kacNjm7ivwd82D7IAXuee/0UJ8BEOm
         eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
        b=q2r8XyRPdN9cGFxbisPkEFkCqkpDweXaP9ZLMj7bHybZfibWLT0hfDyhwE+8IwZTi/
         odSPycfdMrtLKHo/7hvPSNcO00qxH6Id6etMt/cr+4L/rh5+DQNcRVryYxirPmJsVu9j
         muFDWPHh+OJ2KJoQwU61W9z76q4OKtu/LeSHfFsgyuTDu2ydNiA5V73SX2j+OlOh2YOs
         LiOxJKfvccB7xFrKFAdfSLYdBLbikGklesNE3P2qu+gHVOuhWlxyMyUgpXtW5pUhlJue
         ehINWa228xEPglHl5SbWPOjpC3vh06gWwHx+MwDD2wJpX4Bh4kbImWIZwJQTVa77yWrI
         q/ZQ==
X-Gm-Message-State: ANhLgQ2VXjgOVjkfJruFQhrC2SxwpNrQtz5V23/FMShfGOfE1iRLlNdF
        u8MBC8zLru0mP6W+IHyJealyug==
X-Google-Smtp-Source: ADFU+vu/XM+0n/FArOrrpYRuqpoofr0nhTgegl8nM9GcEZ0Y35AWlXD9wYups+i8jASk7u1s54i1cw==
X-Received: by 2002:a92:c904:: with SMTP id t4mr959353ilp.209.1584021973514;
        Thu, 12 Mar 2020 07:06:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm6126275ilq.9.2020.03.12.07.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:06:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
To:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "hch@lst.de" <hch@lst.de>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
 <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05bb1606-4cf1-dba3-22a0-5f8624b43767@kernel.dk>
Date:   Thu, 12 Mar 2020 08:06:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/20 9:03 PM, Singh, Balbir wrote:
> On Tue, 2020-02-25 at 20:01 +0000, Balbir Singh wrote:
>> Allow block/genhd to notify user space about disk size changes using a
>> new helper set_capacity_revalidate_and_notify(), which is a wrapper
>> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
>> notify
>> iff the current capacity or the target capacity is not zero and the
>> capacity really changes.
>>
>> Background:
>>
>> As a part of a patch to allow sending the RESIZE event on disk capacity
>> change, Christoph (hch@lst.de) requested that the patch be made generic
>> and the hacks for virtio block and xen block devices be removed and
>> merged via a generic helper.
>>
>> This series consists of 5 changes. The first one adds the basic
>> support for changing the size and notifying. The follow up patches
>> are per block subsystem changes. Other block drivers can add their
>> changes as necessary on top of this series. Since not all devices
>> are resizable, the default was to add a new API and let users
>> slowly convert over as needed.
>>
>> Testing:
>> 1. I did some basic testing with an NVME device, by resizing it in
>> the backend and ensured that udevd received the event.
>>
>>
>> Changelog v2:
>> - Rename disk_set_capacity to set_capacity_revalidate_and_notify
>> - set_capacity_revalidate_and_notify can call revalidate disk
>>   if needed, a new bool parameter is passed (suggested by Bob Liu)
>>
> 
> Ping? It's not an urgent patchset, I am happy to wait if nothing else is
> needed.

It doesn't apply to the 5.7 branches, can you resend against for-5.7/block?

-- 
Jens Axboe

