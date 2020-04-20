Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C8C38A30
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D9120782
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EsTE0F5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgDTRfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTRfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 13:35:46 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43927C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n10so11935637iom.3
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWUS0gz1oE0nMQJEiPNjPzmZbhnBa9zc3bs1bmlvX2c=;
        b=EsTE0F5+UArSrmzWmdXS2OnYEz9PqYIoT8QxMFmD4Vqf3JsvVkJzP+GV8AAvH7v25V
         kSjhsw9GNmTuuY5H3uk7qVx89YQvW1Uh519IZe+t2UWrHboXZmpiBc6PC3nb33fSrS19
         DSjGfw6xlM503ABxZKM72TN0RqQzfkgbIoYAYr8Fobam5Mp+8I+LvWpPBP2K32IZuucJ
         qOQsD8FR5MVjDl46NfaPJR6xgqHip/ObH/gJcN5Y+DwbmAdRKJ2bbRoim2EQGYumDz0i
         cofswoTYBFQ/hpe1PFyF419NmX1w179+0ttK+GbxIpaRzxR5Y9DcjBs0B0+THrHuGcou
         fPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWUS0gz1oE0nMQJEiPNjPzmZbhnBa9zc3bs1bmlvX2c=;
        b=Hi2HmNAxn0/Dw7PF+3+EUp2glGfIBbKMl3erwQ5qYAw/IM11X7+2bfvPX7qytzLfIH
         9P4l20wPymMCkdyoB3aMWiidP47e9FC1CjkK4jM5N38q6gaLVjHQBpcOEyXJAvSEDFUJ
         /Iz9RMy889KC+vAi1XY12I3QNxtsfO+tWCFdBsynFPoAA20Bpd8qbfWxkoFRSvaZFu6A
         m637Uq3fTbokYaK+OWRkTgta9JsUGd/rz+ZxBgcliwd8VfJzx1UfoZ0Sv5D+i73APS3Y
         VwGqMKwRNixKob2rcWImQwPblenMv4nvP6xDUm1d0zrmqa2D9/TZKlKvLl9qHadToghG
         fycg==
X-Gm-Message-State: AGi0PuYHaWEyrY6OxngR81n5tYwLx9Ta8e9Z++IMaDCumjUxjUQjsKuF
        tBqEU2m7q5Gje8BMKTLKJfiq7g==
X-Google-Smtp-Source: APiQypIXxTDGRNvgFCLq2hn1/eBEIPBWTY0xjKTT8l+2ETFSS2JxOdovZyXYfhoNqW2Y4hbiD2VT5A==
X-Received: by 2002:a02:a806:: with SMTP id f6mr7169204jaj.22.1587404145557;
        Mon, 20 Apr 2020 10:35:45 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t86sm71688ili.82.2020.04.20.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:35:45 -0700 (PDT)
Subject: Re: more partition handling cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20200414072902.324936-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1c720cb-659c-44ca-1a64-16e08725accd@kernel.dk>
Date:   Mon, 20 Apr 2020 11:35:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/20 1:28 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up more lose ends in the partitioning code.  It also
> removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
> 
> Changes since v1:
>  - fix a brown paperbag typo in blkpg_do_ioctl
>  - fix a commit message typo

Applied for 5.8.

-- 
Jens Axboe

