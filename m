Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A537FC07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609352082F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lGhgnWQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609352082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLKNYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:24:11 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41615 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKNYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:24:11 -0500
Received: by mail-pf1-f181.google.com with SMTP id b7so7125192pfi.8
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 05:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtus4MxpxRCdKgtZJQ5Dpllmq6xUUVW+M0axaqX4D5A=;
        b=lGhgnWQKTZGVQ0/+ZkmIrTAKKr/6/FuM0VdtJDjzj7rKGo8huLjy7QVQN7PBJpYPoD
         UqRS7/3JlyCeINzJ2dA65GF2/W8K23m0602RX8lLbZUt0agi71sa858omrxi+4eYtPzJ
         E1swPDXzRM7PDxhGQ9naIQZbQ8eHrm0vXv+CklLDQUZDBAnxctoU9i+nWgxXgxWHI1z4
         w7Ge8RwiNOW2lclp5SWe7UVxvxvy30lnMlb9VVgaF/kfPzczn5/7yO0sFi3nvbvT18Ah
         aesBCzgX3UB/FGIQsGtA2Hj8+/of7JGWRYSfS7n96MYn3mOW8lZMIWU7M71NPXLxSuNd
         Sxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtus4MxpxRCdKgtZJQ5Dpllmq6xUUVW+M0axaqX4D5A=;
        b=Fa7u5hDgFd4NtgG/DEW7ms01L73otDp1qSc1/dY+V/Ru9+4hU/gPe3YytG0VScmQmP
         8iBi/e+62gadqkaYUb8Lrl1qUxJCROGPP/Tb1hUS0Qu3gbYlsnds3XO+5h0Lq+qY6IeO
         WMGSqN3/4/1EMLCbtHFk7clVEx+yLV6vJnmcqetNM8a835pAlDsn0txDC7vHbTsETztQ
         1LybRW1Kok+CHevd5BpIXHPwP2IaILbhIpPez9qNJSToBPTCnlg75KTnHd3rzv5rv//7
         0jXqx4LRDJdEZDEq4b4q736mexD4yFoeD8jpUxqxZfSyUK/wa7OqqTuxDez8/cHmbyLE
         M6GA==
X-Gm-Message-State: AA+aEWZrg91GTYxKYacxQOhzfyb7v9nCUHL/6nI+ce+NppKyaYWKdZpJ
        Z2jtvPYSIxVho3iGegkJWEH0yA==
X-Google-Smtp-Source: AFSGD/XTwzICaHIqQ4Q8lz3zny+WQ3pVJiQJ5k9w9tIAYxbH92r5kVyZo95Eag9o4JR7ifJuoNcbLQ==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr16089218pfk.143.1544534650869;
        Tue, 11 Dec 2018 05:24:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z7sm15444191pga.6.2018.12.11.05.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:24:09 -0800 (PST)
Subject: Re: [PATCH] nvme: fix irq vs io_queue calculations
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
 <20181211070855.GA13999@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1545181f-d083-0935-93fe-0f4f83ee7567@kernel.dk>
Date:   Tue, 11 Dec 2018 06:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211070855.GA13999@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 12:08 AM, Christoph Hellwig wrote:
>> +		if (!(result < 0 || irq_queues == 1))
>> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;
> 
> Maybe its just me, but I hate this style of conditions, why not:
> 
> 		if (result >= 0 && irq_queues > 1)
> 			irq_queues = irq_sets[0] + irq_sets[1] + 1;

I'll change it, that is more readable (and logically identical).

-- 
Jens Axboe

