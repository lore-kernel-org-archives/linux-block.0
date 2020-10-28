Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08327C4363A
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940D8246CD
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tirtnbfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgJ1WEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgJ1WEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:04:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB630C0613D1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 15:04:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so588176pfr.8
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J50aqCoEMBtyZNJKdiytI/3RRo9lqaFR/Dl/dXrtNcE=;
        b=tirtnbfWciU4QLqL6XlcPtwLdyJ2VM4KPzJ7huIKun4yjFXB/hjXolkqeWUwxmFp2P
         FyfaEl//nYyHj2aei/Ojc+wGoxLz3U6lCRMToacGWASIvujWGc+cBujSXZ+lap415t0V
         FKZJ48OMld27kCC34fCVYKd83cUx5HRY32X6Z5gq0DXygY4YKGCpCoMmb874piBp5nq6
         eZisPgb6OfyRdPp1ydnvfAPi/angYx51p4ykKI+VTPhgOLXIq7jhBcjVYaSFuXXoM2FM
         HAsRta/LxpAR/isC7RdO6pSO56srz6n4kbFKDfRxhN1DUXZldwWla2s8u5WgCoV0PO+G
         S+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J50aqCoEMBtyZNJKdiytI/3RRo9lqaFR/Dl/dXrtNcE=;
        b=o0yoJdPQdoFstM9T48gB6BmGMrLWlbEATH4wCUmNFmWabDobsDlKsK3ahO8uNTVOWM
         UjjBy5wRyGQ6xDmzV9vrmN126HqWwBWbhGgV0huOZENi1N28lep457VXL6CTqJa9GiDQ
         FME4KsstncdYbEOMoEMECApcfPUSzouLFV+S2kmm+g+u3nieOpZPCH/4PY5Va593fypt
         VURylQfB3gWqapzO60Hu21KBrfjW6YaQ9+KwU/Ti9XCSb6cUn+BpSxTDWXr8Gfea7gao
         Fm1w6bXPrzfm2u85RHZZ1Q6aNRHxIx88GITEfn+9HVg3AGpCCMkVFMvdxMNLUYbfUfMM
         +xhg==
X-Gm-Message-State: AOAM532R7ZPBQMEs0PDIlbThZUOYpfOHG861MMPalR0uYxkdxuBXRuXD
        x7CilqXFuijWDrVAW2RYXFIeJrUM7qeClQ==
X-Google-Smtp-Source: ABdhPJxDjFRZcRCJtqKUtYQ7ucNs8mt1Ic5OcHNVD8ftrJOhnBFViOoktkHSmb5uvU11l5TSDARcBQ==
X-Received: by 2002:a6b:f909:: with SMTP id j9mr6391447iog.184.1603896160666;
        Wed, 28 Oct 2020 07:42:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f12sm2534129iop.45.2020.10.28.07.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:42:40 -0700 (PDT)
Subject: Re: [RFC] blk-mq: don't plug for HIPRI IO
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-block@vger.kernel.org
Cc:     hch@infradead.org, joseph.qi@linux.alibaba.com
References: <20201027132951.121812-1-xiaoguang.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80adbefe-2660-34a4-1242-c3db9cd689a6@kernel.dk>
Date:   Wed, 28 Oct 2020 08:42:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027132951.121812-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/20 7:29 AM, Xiaoguang Wang wrote:
> Commit cb700eb3faa4 ("block: don't plug for aio/O_DIRECT HIPRI IO")
> only does not call blk_start_plug() or blk_finish_plug for HIPRI IO
> in __blkdev_direct_IO(), but if upper layer subsystem, such as io_uring,
> still initializes valid plug, block layer may still plug HIPRI IO.
> To disable plug for HIPRI IO completely, do it in blk_mq_plug().

There's something funky going on with plugging and polled IO. I tried
to improve the io_uring plugging, so we don't plug for polled IO (or for
non-bdev IO in general), and it tanked performance here from ~2.5M IOPS
to ~1.4M IOPS. Thinking I had made some sort of mistake, I just tried
your patch alone, and I see the same performance drop.

This doesn't make a lot of sense, so some investigation is needed.

-- 
Jens Axboe

