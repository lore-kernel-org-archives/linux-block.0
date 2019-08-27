Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F65C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFE42186A
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fr6b8a9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfH0Puw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:50:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35385 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0Puv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 11:50:51 -0400
Received: by mail-io1-f65.google.com with SMTP id b10so38393754ioj.2
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J/zl30sApN55b1e/tvmUbX7uFNIjsgJONZu60b+r4Mg=;
        b=fr6b8a9qmXHHD1YOMA8Rit045HOzbgKfkTOSInm2y43VlCpq7BpsMLc5DilVzQWt4a
         cSMwBllVNT38KVWJYiGwJrwP2piXYCZpmdWvVhghse8f3izw+27fxKy45LvIBveNrYJd
         PH2ng8ckwfoxWUclcjbMYozhziEdocMuzBR4gUF6p38gm85XGnAhN/2JqJkk0mMGy3p4
         ysLw7Y2z+nF31S4KUDpuWARb9d1JDrbeLK1R9XJ5YYSCxsjsLU1TlmdTEvN+1xZuCf+1
         3clWCl3pOSMT7kogwKenQQpGvzK+jswBDxPA3NOC8IwWRXFv6ioXAY2d2haxu3o3tpuc
         qWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/zl30sApN55b1e/tvmUbX7uFNIjsgJONZu60b+r4Mg=;
        b=Z1SOgsAxTir7L3LXNLXIxKFQ2zTR3iw1KxyMtyqgF4Wa8DLfPPZ12zS/2x5v9C81Od
         zbesKOejXTMep7X7f6NCvlA/AoSnj7FB5qnpAQ/r0su4KS8MWzIAhNLXdz+JYdh/rGGz
         VXeJEEbJCtURy2ueeKBrp1fAjYMPI3Lj7YHdmtns/fEat4YsV6bT2kts+s8kJS3KT0cu
         wzsjdWjO18t/Ef296mVYUTZnsVz1xnXRjv92u8m7FkJ5ZomQ+xWS5KLem69/u6/ILSog
         RJVB52XsA9iserCRszLMaTbDigIK9tP9w0gMPobgq1OdjLB/u/pleJRZhXoSjOUz5g0N
         Oqvg==
X-Gm-Message-State: APjAAAVJEVVVrdXEzFQvYadvyhUhy1/dU4hwBpjTcbyGPoaY1NV2n8Wj
        jkJ9EungRxfF2lOpDm/PB53HcbTQTz013A==
X-Google-Smtp-Source: APXvYqwywX7eWlXpOR3JggrEL91GvfmCBYDyR0AcpkU9fafw3oReMBVgJtQl/CihypQNR+z+5yBVPA==
X-Received: by 2002:a05:6638:2aa:: with SMTP id d10mr19423358jaq.89.1566921050286;
        Tue, 27 Aug 2019 08:50:50 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e19sm12631619iom.57.2019.08.27.08.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:50:49 -0700 (PDT)
Subject: Re: [PATCH] io_uring: allocate the two rings together
To:     Hristo Venev <hristo@venev.name>
Cc:     linux-block@vger.kernel.org
References: <20190826172346.8341-1-hristo@venev.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80e0e408-f602-4446-d244-60f9d4ce9c71@kernel.dk>
Date:   Tue, 27 Aug 2019 09:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826172346.8341-1-hristo@venev.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/19 11:23 AM, Hristo Venev wrote:
> Both the sq and the cq rings have sizes just over a power of two, and
> the sq ring is significantly smaller. By bundling them in a single
> alllocation, we get the sq ring for free.
> 
> This also means that IORING_OFF_SQ_RING and IORING_OFF_CQ_RING now mean
> the same thing. If we indicate this to userspace, we can save a mmap
> call.

This looks pretty good to me. My only worry was ending up with sq and
cq cacheline sharing, but the alignment of the io_uring struct itself
should prevent that nicely.

Outside of going for a cleanup, have you observed any wins from this
change?

-- 
Jens Axboe

