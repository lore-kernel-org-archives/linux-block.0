Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1777C4345C
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B33820717
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0mXUKBAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGTVkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgGTVkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 17:40:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62DC061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 14:40:04 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r12so14644626ilh.4
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKJKS5v+fEVOz68RmsMB7ze/F2+4VEIuZSBHXiKWNHY=;
        b=0mXUKBAvldd2n8SJTjx6Rke4RrW+LxAgo5GrQZbNnyIuuUmRe1eiFwAofs5incpJnw
         O3zvQBZy8V93cgMupIEMk+//WHvsMTttYFXXUUPJdOJzKMGaxj1TDKa4zEPtGpr0vZvL
         Ka+PEexdyFtM3+O3aXEo6QxrQjwKWyF6PQZQseDEAPXoT3xseYVxtwd2RIepBK1hOgny
         24rrSkrpOwa6jp6B7N1+K/tDkpnM4vLo9pzJYlPSJjhjbDC/GcA3b0UTxco6zxUh8dvj
         RaQ/FY5g6tpuYWFDjByDvwnRRMlMwP34oqxHTEJniFKuZOC2MKOX3BX5ecCOghcB6w+m
         qWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKJKS5v+fEVOz68RmsMB7ze/F2+4VEIuZSBHXiKWNHY=;
        b=fn6cKIQ3S4lKR7t/Y8FnLYqZsV9ZRkYNqhe/9WgJkiDm+OYcttzxZ9HBHGxTg/hZyn
         I4SeY7nEv+YYRlHa7YasoY8JyZk90/Lw0xIhnJpZYshx3pI8f3MmpvStOG1amw0i8kLM
         gXbu53zUwcOWFj0apMSzZ+C8ZRj16AaWlCdITclegOq3kSLnW2tA62NVqF/Kx9KQEn3b
         dMEHDdlm8XTsvCju0l7zO4EObFFJ1Ax7/743n7pVtmOF7t6C1vraH6WzxnebUxvaOfri
         UrWvYTxp9dVugH3UdM4G4lR1IzSjFZe1JOCZafXFiuY+3YNnOqcTbssem2RSNgR5ieNU
         TOOA==
X-Gm-Message-State: AOAM530BcZZcBKdRyYHlj4rfqcGPhg1sqZMj7pAxsMKQ6iMZzWEZiH08
        WCMKM740h4j691G9eZO7mJO+MA==
X-Google-Smtp-Source: ABdhPJzVzXbuG6fyqFYOSjRTCIYq495m3j59E/eBmMqBtakGIZIx6kkteMs9Brg5KbQkraDI2LYDKA==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr25931439ilj.9.1595281203701;
        Mon, 20 Jul 2020 14:40:03 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i6sm9361776ilj.61.2020.07.20.14.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 14:40:03 -0700 (PDT)
Subject: Re: a fix and two cleanups around blk_stack_limits
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20200720061251.652457-1-hch@lst.de>
 <dfe56cf2-db3d-3461-9834-be314f4080ef@kernel.dk>
 <20200720173530.GA21442@lst.de>
 <ab942c19-68c3-2a76-b3b2-136a2bf3ca54@kernel.dk>
Message-ID: <b569fba9-bf1d-b9c8-1bd4-00d0b6111a7e@kernel.dk>
Date:   Mon, 20 Jul 2020 15:40:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ab942c19-68c3-2a76-b3b2-136a2bf3ca54@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/20 3:35 PM, Jens Axboe wrote:
> On 7/20/20 11:35 AM, Christoph Hellwig wrote:
>> On Mon, Jul 20, 2020 at 10:56:23AM -0600, Jens Axboe wrote:
>>> On 7/20/20 12:12 AM, Christoph Hellwig wrote:
>>>> Hi Jens,
>>>>
>>>> this series ensures that the zoned device limitations are properly
>>>> inherited in blk_stack_limits, and then cleanups up two rather
>>>> pointless wrappers around it.
>>>
>>> We should probably make this against for-5.9/drivers instead, to avoid
>>> an unnecessary conflict when merging.
>>
>> Then we'd also need a merge as my next series depends on this, and it
>> clearly is core material.  Not sure which one is more important.
> 
> Hmm, might make more sense to kick off a branch topic for this and just
> merge it after the other ones.

Created a for-5.9/block-merge which is based on 5.8-rc6, with the 5.9
block and drivers branches merged in. Applied the series on top.

-- 
Jens Axboe

