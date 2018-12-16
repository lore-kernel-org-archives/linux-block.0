Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C41C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E33217FA
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 19:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="msiOdgdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeLPTNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:13:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43927 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbeLPTNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 14:13:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so5054362plb.10
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yRNztpCs6K99TohfqfBm4d8X1jISzVyEPcUOmUR4qiA=;
        b=msiOdgdITatxBQytnUKn6IvdPrg8w87aPX/7Cma3Rk7q7Pt/QiSNnvSPc2L3dQepBy
         T9luDA9K8/uU4/7RPU4wteUBGz/JZwkdCJR1+PMPociKf8D8EEIFErcCuwAZ7WvW1q5i
         8eBVu5wYVh6Kwc5M1Dt4S30xomVfiByLoCf4NZ6E9LN3hQmbvfxE9M14W9EPLAzYloGv
         fc53MnQi1RGoxYjMnbHvHFMv9plh8tsJP4K8TvXTHwmJ8dZBZTx5eZc73lTvNN+yuB7Y
         F5RyK5DjK+D7xKhA9pqGHeu6SLibsLFEJuNYhjCQMAaNBoElebTIB+oKkyi/OAI+oVtj
         zU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yRNztpCs6K99TohfqfBm4d8X1jISzVyEPcUOmUR4qiA=;
        b=MEUyK1jMUPJB0HBztBqs0veSrFCCJWOZUJ8gQY+++IZm8kYQuEvkHMn51egYYwNz9c
         KPLQkKihEKjTIfSvY9+4ni6BEsL7mf16na/nLYQPZPvece9T22lYPAFRvCTO+JBPjJ2R
         ZzRd9OznXj/Cz55BvCl0D8odjlqifXyiNUKHJatamQK+Hwo3e+cbG00lajWF+eXLwJKe
         uBYp/D9kUMDOuT6+1O2FhYgEbhQB9Q8On3C/vBinAVWiTKkvrJrQwiHpef5mErhUE3yv
         NZwm0ncVFCHeUsyQN0r/sS7jb/MlsH1MNVURoetJP8wt1X4TUuNFqjHLgNGNg6vXtgHn
         gymg==
X-Gm-Message-State: AA+aEWa+NfuNJAH308kONOmowUhw7BSu1yrgriUq43Fm4TzlnyWRx3/G
        vo8P/+eBzYSceyAFJ6cHKWCSMQ==
X-Google-Smtp-Source: AFSGD/VY+OCxYosI7CvMnHw9wtjGuOEVRSN9KIOUSWKhS8iBZ9Uy+HQereeYEQC2EBlV5Vnav8TpRQ==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr9805856plr.245.1544987579394;
        Sun, 16 Dec 2018 11:12:59 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h8sm11222593pgv.27.2018.12.16.11.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 11:12:58 -0800 (PST)
Subject: Re: [PATCH 4/4] blk-mq-debugfs: export hctx->type
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-5-ming.lei@redhat.com> <20181216161744.GE9957@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21e262bd-58e6-f6d8-3ff0-03153d11171b@kernel.dk>
Date:   Sun, 16 Dec 2018 12:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216161744.GE9957@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:17 AM, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 10:25:17AM +0800, Ming Lei wrote:
>> Now we only export hctx->type via sysfs, and there isn't such info
>> in hctx entry under debugfs. We often use debugfs only to diagnose
>> queue mapping issue, so add the support in debugfs.
>>
>> Queue mapping becomes a bit more complicated after multiple queue
>> mapping is supported, we may write blktest to verify if queue mapping
>> is valid based on blk-mq-debug.
> 
> I'll let Jens decide if we really want to double export information
> like this (or maybe even move it to debugfs only?)

Let's just move it to debugfs, we don't need it twice.

>> +static int hctx_type_show(void *data, struct seq_file *m)
>> +{
>> +	struct blk_mq_hw_ctx *hctx = data;
>> +
>> +	seq_printf(m, "%u\n", hctx->type);
>> +	return 0;
> 
> But if we export it we should probably export it as a text, just
> like we do for sysfs now.

Indeed

-- 
Jens Axboe

