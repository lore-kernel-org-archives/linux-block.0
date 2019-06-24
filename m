Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D49C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4571420652
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fe8rLTSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfFXQLb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:11:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42903 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFXQLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 12:11:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so14516955wrl.9
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yv7g9F3JbTO6nm8BoK1sLWwWIrm0oykMKq0EW314Tag=;
        b=Fe8rLTSzr1sb5lUncJi7FEZ/eNkjQbgWsoQps4Gs4FIwHO5Tt7pGpW+q2micqCVJUO
         7ShvXQlvIT5mfTtppoDs94fCcCWtBGW81ycvZk03Hcylcgs1RFedpBJyoIfvH8euiPHl
         DpunVvYe9vBLeDXQKO0eZF0HZML4rrcQDtddoMdNhL/qIVaBuoZkMSLjdFFJY2Li6I/t
         1B+M3/3bu3B8S6dC+j5aqpVd7WNjFVglZTPr4bHaDaWfLQIHmcBhKRN36IrTl38jZ5wP
         JBRbz+xpqgU14cZKD0sFLhtB3ZDRlq5G2ySdfQLZ/8Vwv6QL/ZpQ+owzlRbHxs4+fnFL
         b6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yv7g9F3JbTO6nm8BoK1sLWwWIrm0oykMKq0EW314Tag=;
        b=V+Mq+y9DIA9aiLNvCuqopHNCwnIEYz0hjWZ2aDML9n+a1JFIXTgUHR3JqecBz9ytAj
         1Qyv2/nz8D6wX0YR/dh/4O0NjJky8mK0IkyCN6XkhgZ9xg1pNSwzFmCIfPkkdjI4nzoN
         6p/2hazE6iHv1kg4+qwQmyVsCwKcJNrjP0I9bEfg0wyE9MfHFz8e4t3gl2zK5cdzGQe9
         8cKbyyVTzB/qCokT9sKqXb/temEC/je3hDdgFw4kvxtX+hnxUMSaq+g9Pgd65r3241D2
         n11wiAVX6YqsbqbMdx+ikPSsFEaDLifLdDTaXqA8oNvcjc9iEYv6er0zCNRHpra+xT/I
         U7mQ==
X-Gm-Message-State: APjAAAX5deWQw3NXXzQg9uotIYPz4UYZ6F+F4csrXLYr8y+R2y8dp7MI
        0UZjHiY1aL/sqFBnqV7fPWj8xUeAMQBpvYbm
X-Google-Smtp-Source: APXvYqx5dDIsMuJy3B70LLvSX82c79NQkaeseqdEewRs2ybI3ghntIz2mUkg4dD2R6KWySro3Xo6QQ==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr8778904wrw.46.1561392688805;
        Mon, 24 Jun 2019 09:11:28 -0700 (PDT)
Received: from [172.20.10.174] ([85.184.65.84])
        by smtp.gmail.com with ESMTPSA id n14sm25505400wra.75.2019.06.24.09.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:11:27 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20190624061241.GA31634@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00f87f06-99f3-b28d-eef8-d6bb8afe2f72@kernel.dk>
Date:   Mon, 24 Jun 2019 10:11:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624061241.GA31634@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 12:12 AM, Christoph Hellwig wrote:
> A large chunk of NVMe updates for 5.3.  Highlights:
> 
>   - improved PCIe suspent support (Keith Busch)
>   - error injection support for the admin queue (Akinobu Mita)
>   - Fibre Channel discovery improvements (James Smart)
>   - tracing improvements including nvmetc tracing support (Minwoo Im)
>   - misc fixes and cleanups (Anton Eidelman, Minwoo Im, Chaitanya Kulkarni)
> 
> 
> The following changes since commit 474a280036e8d319ef852f1dec59bedf4eda0107:
> 
>    cgroup: export css_next_descendant_pre for bfq (2019-06-21 02:48:34 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.3

Pulled, thanks.

-- 
Jens Axboe

