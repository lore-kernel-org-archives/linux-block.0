Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE68C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 14:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CF2206C2
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xGE+918S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfIQONN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:13:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41107 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfIQONN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 10:13:13 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so7880985ioh.8
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dVDqz+rUD+OnR6W7YDSlajWZDua/pvLwmg4E+IqCu5M=;
        b=xGE+918S5B51H5CETuXGuR3m9kHErYYJES/11sO+RIqBzAqFpW3ntIsQDUBrrIrUmj
         LIh3iqAFmicykwNqdBMqV4Ic9/5rQWvYx72zj2xNSXKtwEYw8HcHTXBDxVuRd3ZQfnNk
         hZbR5QcT6EIiadTl7vBGaI6k6J5opDHGdTX0Pyd1wKcjoqN1IVWhl2eXWmNiZDN6g6kZ
         P2exEMy1uKH6sxtkfKvM9LJIYeQNkgwFioiciQcy7vfxjrQYJmx2p5swRQ5nr4elE4dN
         BP4KEn7cTNFJoXUSpd8ytJJhZuXlCvBcjgSXdDKQmUOwh+2R6mgGcSe9yTIPprp6NUpa
         M/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dVDqz+rUD+OnR6W7YDSlajWZDua/pvLwmg4E+IqCu5M=;
        b=Sglz6eItKoMNvuERybpOPkQsgXf9P0wJhOxs/akfaanD/uaKKdnGVHLzeGzaRhXB/r
         FA3CkOga3/RNFtTVMaYv1jZqUzdB7HTZzTFDmonzTyIwUbZpX/eMwYwIZEjlBQOiZRjW
         LsY4qPswPChBmthyqtXHYNGWfY6g/gCSLXDawaEzuLi+iodI6sEjylrLccy9NPsbuoZg
         MEoJB+VVYTgKB/0CxCYN/QQWoY4o24nKrQG9q1qnQv+wuIN+qjQInbauuz0Zl7HV8j2V
         +S2KENHkMvzpsAAnljR/lIJPZfpepyWRmlMyzGFLv8hqnMLA/7X12vUPP949kXCYG/1h
         QzUw==
X-Gm-Message-State: APjAAAWcP1suiq4uuuWvATMRyFkr9SYxa/pye9JVNZ3wzIyNkj1psGor
        pzoKwkk6tjFCNBENZdk7dC6YXK96M0Pg5Q==
X-Google-Smtp-Source: APXvYqxxSlQ69knggzSg3yDWlBZdxsp9hwUjDvPiCS8vC28lh96aTTWQ76a4012e3icfwqCBTsNQRQ==
X-Received: by 2002:a6b:8e57:: with SMTP id q84mr1161988iod.41.1568729591169;
        Tue, 17 Sep 2019 07:13:11 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t9sm1715477iop.86.2019.09.17.07.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 07:13:10 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] blk-mq: Avoid memory reclaim when allocating
To:     xiubli@redhat.com, josef@toxicpanda.com
Cc:     mchristi@redhat.com, hch@infradead.org, linux-block@vger.kernel.org
References: <20190917120910.24842-1-xiubli@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <426aa779-1011-5a75-bb73-ae573c229806@kernel.dk>
Date:   Tue, 17 Sep 2019 08:13:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917120910.24842-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 6:09 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Changed in V2:
> - Addressed the comment from Ming Lei, thanks.
> 
> Changed in V3:
> - Switch to memalloc_noio_save/restore from Christoph's comment, thanks.

This now seems to be a mix of both approaches, which I don't think makes
sense at all. I think we should just stick to the gfp_t being passed in,
and defining the standard mask for init time blk-mq memory allocations.

-- 
Jens Axboe

