Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5018C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 21:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCAA2077D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 21:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCVc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:32:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37896 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCVc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 17:32:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so1277832plt.5
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 14:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VWd149gQHGAxsdrW+OPOlQzJKW8AB/B4FCCE/4vPSZYJZ5taFwsWT4OuTKJuxu+qhA
         QYgn9+DwjKz+cV0wnCu3sXihZlxtYTv3SsgSQ6Xil4QPCAgmvEPmNHEQx6IL67XozYtW
         qg0QRD6tJqN6hplkcJpEo9VI43gCWIjblbLS8bhbJOY7GpG8MrARNHzu+Rr6WN1jnCyw
         r8HlBgceu0/t2MuqHXW9YTM0fuffYwBr/BRHFQUGsjF8j42F1dVH1uDqpoRGe2Op1MDS
         HiRzLYRIblIJXRsbPr0M1FT9JrK0NraWlKGvxQ30sEb07va7vtFcoG/LjwkA2d66bLaj
         697Q==
X-Gm-Message-State: AOAM5303FSGDAyntzxxHWxd/Z5a8ZEuvp08m131v45Qduy3lSNIKPBqQ
        Y1I+nHIQAU2ZBb8NVcABOe4=
X-Google-Smtp-Source: ABdhPJwhW+uLI2cBK17pJ8rxtIn1WDpscu7FB5VWYfr5eEJwjpzwhKz920dbxZlwaLwIsgIOuubwZQ==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr2149642pjb.160.1591219946281;
        Wed, 03 Jun 2020 14:32:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff? ([2601:647:4802:9070:5409:1488:6d95:bdff])
        by smtp.gmail.com with ESMTPSA id f6sm2773150pfe.174.2020.06.03.14.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 14:32:25 -0700 (PDT)
Subject: Re: [PATCH] block: remove the error argument to the
 block_bio_complete tracepoint
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hare@suse.com,
        linux-nvme@lists.infradead.org
References: <20200603051443.579748-1-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a46c6fb4-1b0f-154c-4158-a05bb5891edd@grimberg.me>
Date:   Wed, 3 Jun 2020 14:32:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603051443.579748-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
