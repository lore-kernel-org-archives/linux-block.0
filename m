Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C8C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A720675
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iRDZiMIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbeLQRcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:32:12 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:40675 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQRcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 12:32:12 -0500
Received: by mail-it1-f175.google.com with SMTP id h193so56626ita.5
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 09:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDQuQ5NfMmJG7M7XfUWKPMZ8ksZUnZzp+yrE0PDomBU=;
        b=iRDZiMIxWKAKIR9rT8TPM7y3MCjO3AqG8SHx9S9YXcw+Eyl9VAf5KyK+KIGspzgP0k
         ubzREWSQIFP9/Joy4Oh7xZl/XlDc2+N9nn+tBITKGrTwLdMuPTPEdm8WPKLuWTXD8B7y
         vEio6QaLdv7HJ+v2FyC/hvbKc+iAuu34pSQ3a3TgloPpLbsli/53g2Dle9HbqVznEj6V
         0pmOquoX36YRFyDdNo6ftfjrDZ2F/7OGSycfbLSQcaOBUm70fQojxK8WVaCPmDizPuvI
         lB/uPpQTlsAgkY3N3ICqOGpSfMBngcaeld0PrucC9g9g9fOFqj8pl9+yDmlRu9YI1jnO
         qPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDQuQ5NfMmJG7M7XfUWKPMZ8ksZUnZzp+yrE0PDomBU=;
        b=AE1r8PkZtv+pkmgim1hUp1BojjUDjvHxF/xA886Oq91gyH51S+NYnVYtm5kOaBaJyQ
         5+wZ7glR6xsyP7XSmu8kgzxFNhRQHxXif7VJnJpCayDUXg9Z2TYiITCJwg/W3bisLIbY
         jfFNSR4PHu/bV8MXwKLLaIoDIlTn1I6gMnkyigtBwPhmaX/TZUwRmte0zdsR65yroTeH
         uXV7ZJhev+lQ3BQmaSdOzuwpg1dWEXxPqNg/UTPFSgB66Tu+ojsqOU5cFWTz9WZ7Zl0W
         EQ21BlI5YzSolIzkz3vDW4IXqkuMx8i7Cijh0nisfqngBoFyzcAz+RnmmtodAyfIcH7d
         +seg==
X-Gm-Message-State: AA+aEWb8haD80fgJOAMmMt73HSS6o298p3EdoYXYY0PCAUEV7HixIVNg
        rbRvKLdfB7nR8oLXwoSoQWmNwA==
X-Google-Smtp-Source: AFSGD/WX/rZnHbNRF8Arf2BKqlO4NtleANIXZr8LX5qs9j4JmCix1FqezxJJLDo1XjAxKnoCPIHr8w==
X-Received: by 2002:a02:8ca8:: with SMTP id f37mr13347446jak.80.1545067931126;
        Mon, 17 Dec 2018 09:32:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64sm8895987itb.5.2018.12.17.09.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:32:10 -0800 (PST)
Subject: Re: [PATCH] blk-mq: skip zero-queue maps in blk_mq_map_swqueue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181217172856.14743-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <745cbe77-efb1-c21d-2f8c-d0afec341b37@kernel.dk>
Date:   Mon, 17 Dec 2018 10:32:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217172856.14743-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 10:28 AM, Ming Lei wrote:
> From 7e849dd9cf37 ("nvme-pci: don't share queue maps"), the mapping
> table won't be initialized actually if map->nr_queues is zero, so
> we can't use blk_mq_map_queue_type() to retrieve hctx any more.
> 
> This way still may cause broken mapping, fix it by skipping zero-queues
> maps in blk_mq_map_swqueue().

Applied, thanks.

-- 
Jens Axboe

