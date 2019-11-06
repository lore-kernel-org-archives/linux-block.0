Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58684C5DF65
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D39D21848
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ad/Jn4kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKFSTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:19:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37246 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFSTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 13:19:13 -0500
Received: by mail-io1-f65.google.com with SMTP id 1so28039854iou.4
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVCvvj/Bzpo7G/F8NANL89VeLcgohXoVWpiNdF7oDcM=;
        b=Ad/Jn4kb8jBTYszgLQm5ysp9ROSapTbqb8P9O3Gdb460cmWSAsOXEof+h5bV4A/p3u
         GZElFKu0RK8Mr3F1HH8Qt7DFcz+T2nTs5fCtqJb8eEXaZRi774Ed5cWdPbruRBDP9/gS
         dRRC9prmSGRzYLjAUdS/gBNrevvtTORN2BdyjiOb+H9JJQgm+ZPfiugVnpvv3D3/6WQg
         wwFCy6siwk8Jd5lmY8aeV6QGScw/xeBp5GTZk3uFE2FoO9ACoCjpZhFzJXOkPJ62vqhg
         t2Na+dDqYR72c4anOCikillcWLJjjHB7h/xd1fEN6/aDLye2sb8oCKjHeINbmswffty4
         fR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVCvvj/Bzpo7G/F8NANL89VeLcgohXoVWpiNdF7oDcM=;
        b=Gx6kqMta4mJL8w15JOpfCf7SqqfTIg/gvX5N8sSbRZca5U20OYz6FKqRyCs887whpn
         MRAIX3Pb+/u75LbZfFoVcsLZQmMqkS/HFWQUpG96qsqqd0yeBzslQjupe+5j0gunX2Tb
         L2XEUTT865yIRO1HntFpJOX28kaemgj1KIGV6Ol/bPnAJfqcmeRsgwmf9gUkAdzZbd2U
         TVrZFiSF1M8wPjoI0XcRM2CEml74quf4ntGfTa2kcZkbMiNjYONpROLtRKPdsDKbDVYb
         ZvUBmy6RhWeqmFHrtCCAl/fwgBHyZh7jyWJVO94U68BRyZaS4Hxl4taVq8V/1siOzhrh
         rbqQ==
X-Gm-Message-State: APjAAAUDJpjR17Kbt19JLoSss5vXFa6cciyNST3/NghQcEQNCDFsqw0e
        dtOqtFKrnTE4KRlvpADd0cxWxg==
X-Google-Smtp-Source: APXvYqw6N1opvLyh945XNas+K8vW4Cn4j/sli71jMvBdLd8yjTe+PiMAVS0yHGDcB3G9izd4vLMfFA==
X-Received: by 2002:a02:a157:: with SMTP id m23mr8459257jah.135.1573064350967;
        Wed, 06 Nov 2019 10:19:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm3608788ila.41.2019.11.06.10.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:19:09 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: Remove extra io_commit_sqring()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Bob Liu <bob.liu@oracle.com>
References: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b16c107d-890c-6e15-ed24-0375a7cdb49a@kernel.dk>
Date:   Wed, 6 Nov 2019 11:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ca020164c33381c602d3188d95e0d650a5c625ac.1573058949.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 11:12 AM, Pavel Begunkov wrote:
> io_submit_sqes() calls io_commit_sqring() at the end, so there is no
> need for sq_thread to repeat it.
> 
> Fixes: 09c0eb1f1b93b9cf ("io_uring: Merge io_submit_sqes and
> io_ring_submit").

Thanks, I'm going to fold this one in with the offending commit.

-- 
Jens Axboe

