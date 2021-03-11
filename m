Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9416AC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D6A64FE0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 18:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCKStW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCKSsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 13:48:50 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F4C061760
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e7so254673ile.7
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mc3m6KTJHLsCOwY+P4RkckClV3Dd+46obNbceKBuou8=;
        b=DBkzDJoj9Cc3MSJ1VZYsxObLtFcMaxmjSOk6+p63w5dET7yVHsDJFS09dtBv6Q0OXa
         gU/q/B4VETCpDwcrPEz6cBl3KPXdMmxPPlDAIsASmS/c0NAZS2aO0INS0hDc2Jlqt8H3
         gXg7Qb8P/HK6nPHFOIYWFOgi6y06csFbGAEOm5n4Hf0yI2HLMBmDyIngoBNUQFJqzF+N
         YcRjNQ9yRGjWJGAYT+q/4MPduyKGBV86w4kuMdhmJowyDDggOeDTznJKi3zct3rAwiQs
         ExIekUdFtOXH3G/Bl/pDai9Ulv6Citw/EkJiW5WyL6W76t15CsThHf8tP2e2Ug4FZxF9
         Zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mc3m6KTJHLsCOwY+P4RkckClV3Dd+46obNbceKBuou8=;
        b=YRXk/VIl9C2G1kjXxFjDzhcqBcUUlqzrQDCBeF+rDqggSX8ZEYrkOclVGmqvj680Y6
         lZ5VWznCZEibO68tFlPeo7cV23pbrC0F2yDXU9vu8aWyTdFzHzz2IfUTxvSJpbsSmrc3
         PnYsIFJK8qRYhWiKTaPvChfeTbFzecfM0O5Sd3qW3vFqcvktYSxVWdB1UftJ6jxAREJv
         NzPY5lqvMrXW9OA6+J2eq2At1Gnu44EPKu32oYsDr/an5qIE2oK6FmP3ObZg37Qije7I
         RPIrzcWfX7pOvIkMMjC/OuA89fHkue2i1g34NZp+sf+Lau0Q1dbMq1qcPLKRwmujPEEz
         vBBQ==
X-Gm-Message-State: AOAM533TR8T1EGXbr7TWPM+lrPR5AtBnLtEY3cu4HBRFeeEfVKe3OBj0
        dNk/24UE4/f9rEkGe6wCh6NIXaTcxYLBJg==
X-Google-Smtp-Source: ABdhPJyoW9KnOG0NsO7f6Z/sQxXYXqzw2vQtcO0xf6/CtOQsV6F0npUkTXAyPLtD0RlFNS0+c/praA==
X-Received: by 2002:a05:6e02:bc4:: with SMTP id c4mr7886434ilu.169.1615488529365;
        Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k10sm1734105iop.42.2021.03.11.10.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when removed
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
References: <20210311151917.136091-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2117129c-368f-41e9-5f2d-ad7430c40ec0@kernel.dk>
Date:   Thu, 11 Mar 2021 11:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/21 8:19 AM, Daniel Wagner wrote:
> register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
> but enables uevents at the end again in order to announce disk after
> possible partitions are created.
> 
> When the device is removed the uevents are still on and user land sees
> 'remove' messages for devices which were never 'add'ed to the system.
> 
>   KERNEL[95481.571887] remove   /devices/virtual/nvme-fabrics/ctl/nvme5/nvme0c5n1 (block)
> 
> Let's suppress the uevents for GENHD_FL_HIDDEN by not enabling the
> uevents at all.

Applied, thanks.

-- 
Jens Axboe

