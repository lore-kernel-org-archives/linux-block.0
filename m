Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88FC433DF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080212065C
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgEMWtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 18:49:36 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40306 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbgEMWtf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 18:49:35 -0400
Received: by mail-wm1-f52.google.com with SMTP id u16so30325484wmc.5
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CGWNczDzWASYqHeai2C3XuuNyNm4LXIFq4GBZebb2sHcFOlCkmxUgarHoZA7ov5Bpz
         xeqrjKnCt2ceuKqgfl9fPUJBANBPQarhsxSZwW+q/01PAcLbSOCldVQwGveBmiI1bJTo
         z56ObNoqn/wYGyOvOsIPTLPM2mm6Hhk1hrH0IDWV4R5OebtFpy0z2aKykMOOB3raz+rU
         FxsPUM3G/qLEjPy+e7OHKImjfl7VZlRSCuJTru8d5d4aoANNz69MB53RYFH1oUB/oHma
         AGeCS+0+w8qQHQTy1gQ6VUsvvB2HkBV0GTmaLK2KvM9VHDbboUguvgGgj2nNPIQ04gxd
         +isQ==
X-Gm-Message-State: AOAM5306Z61Kw8zHkZqaOGrYlXzAd5UzAW9JJYM86O7MZ/XbdMmGX4V1
        Hk4wCdu7tFlnaolSVU7g6Hc=
X-Google-Smtp-Source: ABdhPJx/5URexesizIhH1C1w0AI7Ij7sdXgSG9A/JwPqVYI85U/Zsi9nAza0sPv5rKoOyIwYqgfXvw==
X-Received: by 2002:a1c:a947:: with SMTP id s68mr10541102wme.25.1589410172614;
        Wed, 13 May 2020 15:49:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59e0:deac:a73c:5d11? ([2601:647:4802:9070:59e0:deac:a73c:5d11])
        by smtp.gmail.com with ESMTPSA id p4sm1447312wrq.31.2020.05.13.15.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 15:49:32 -0700 (PDT)
Subject: Re: [PATCH 2/9] blk-mq: pass hctx to blk_mq_dispatch_rq_list
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-3-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c941fd73-5a9d-fcce-f636-d4c71cdabd97@grimberg.me>
Date:   Wed, 13 May 2020 15:49:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513095443.2038859-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
