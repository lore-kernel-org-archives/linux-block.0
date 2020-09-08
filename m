Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D38C2D0A7
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1F42074B
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 16:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BKP+vtYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgIHQ1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgIHQ1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 12:27:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB91C0068F8
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 08:01:44 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r25so6426659ioj.0
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbB2u55s7t4EoMbvP4SHgNKmLWDLhuF+vG7yZ6O7oE0=;
        b=BKP+vtYcLBHYfC6cidJedf2ftxoftPlara6y141ZEqy9HFwnVrE1a0XOdXjLQ0toCD
         RM2nzfrB80PdYwMLtXawh2KiRSHvcy6y322v3HKqBJ9Homa7kLIH8sKCOG40j4WRhxPt
         KXoHgmHotHxmpRzOLSsGBXTLss2bsK2FysnV/upy6pd1nSqWYHHpIVNahCdXw0eJCxa9
         sGT66k/Iz8pQwS33u7mZ4wus/vX63ouIZTJHEltcn3tzb1z1WfFrTWPXdwAZ2sZR3p91
         DwIz7mXBggnv0hNcTTIm84wV+1F3dkOh9nfyxSZZo6WDgcLxHDz66nEQIl+c7zKNzS+o
         SNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbB2u55s7t4EoMbvP4SHgNKmLWDLhuF+vG7yZ6O7oE0=;
        b=m6vTBwDc9zXyKxyxW6KsA9HftCa2YHjbpqbNDxChK49vV+4wlukO0RpElZmWrQwyix
         yC8eIBD2jZLxia16JKujBg452eYYq599i6ccEoj0hINZG0XjP6Cb3WXgtlhYogx5C0o0
         VzqZUHWg/5Tb773OWw6jpNzUq8yuP9f+EVkeS8UkF4AeDj0gJJjxl5KkCCRwLX/rkLl3
         FQwso7PzRDQsvlo30GHC4DPp32SyUXOHHKgqmJMo8cUmRdgC3PKlNOium3rwVBjdEGD5
         C30Reg79u7XGEOuTzyZe9JYgPxftwMK5p/LX6Awp3Np6VzTRyp8zRePKwkIXvVN93BFK
         bQpA==
X-Gm-Message-State: AOAM532P8Wi4uNuMlEi7XMDLeJizZ66eNaXTEGliE9oI/xkMz4lN/FTC
        eet00c4ixzm1cU74sfwT118PrMOUeeibgC/g
X-Google-Smtp-Source: ABdhPJz52I5AHFNRxvv4ql1D72pfbb8WqVln7AQsAxDPHcz+oPUNpdKBNniPOt6ZFQWIEXqCpkMEJw==
X-Received: by 2002:a02:85e1:: with SMTP id d88mr24607632jai.8.1599577303367;
        Tue, 08 Sep 2020 08:01:43 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z72sm8790874iof.29.2020.09.08.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 08:01:42 -0700 (PDT)
Subject: Re: improve the block queue sysfs helper macros
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200903060701.229481-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f701fba-05ba-f6d0-0a78-5974bfae0923@kernel.dk>
Date:   Tue, 8 Sep 2020 09:01:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903060701.229481-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 12:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series improves the macros to generate the queue sysfs boilerplate.

Applied, thanks.

-- 
Jens Axboe

