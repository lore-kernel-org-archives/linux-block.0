Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF4C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5879561042
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhHMTdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 15:33:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17223C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:32:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso22137256pjb.2
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WpzS/24q3pqxhkhlYWjPCwEJTnQ1gDnycgi6qLljlS8=;
        b=CQShZo6d6mQu6tpYzkUF6OL9B1//C/IxbepKm6d/YT5gjLvaWNnNHOTIPpVvk0EOk2
         28/V/yYlmVuyVKVOCUNWF3f0jQQ3+u6ZvRGFeKvHjVVK9PjzxRoobUkfCeMY1Gwjw6BV
         xBX0WwMpJ37i1DalnazOQsCfTdRuzg6J1av53VGEhW/UN4UZS4d/ELLEfRHRpWaEu5XF
         6PSLdPuj/z+sgCzeb2jG1MR5gE54Ho0DfSoeKezq/VqwD11dZQ8fRgEDZNi2tbGLntSN
         LYpdBW0D03O6RhKVwKBjuCu3aN2IUO6EfD52EByrytsI7SUQ2/3n7RI95E4rOnkrUauJ
         ZXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpzS/24q3pqxhkhlYWjPCwEJTnQ1gDnycgi6qLljlS8=;
        b=td2HIDVUfIBDl7rAcNpg34MKYEg0yUknMkJdjBVgXKvRnt4OnwG0ARFZVX5a2B8sdF
         SIyxI2BlsS3K2mfz2yEtMlCd7fcYJOMORCvEDc97QrIDbk8aIsd1HhbTENgkAVBZmKOJ
         97qw/I7yfhXEi9vJvMol/wwyG5xwsC33qGg8SHbefHHzfYTPUHAYpF4J4TXASaZI6K4G
         bCOMynl77lTxM8NncTe9cov1gaiUtzU3uvOUZvp75MmO7P18Pa1KuakizazsqaLvGXSw
         ivGRf4qgBU/NMWdwITpnYl6MI1V1Vvp5EPUoZWfcyXy5/KXWft2apvHhk4CZhbXEnKPs
         4YuQ==
X-Gm-Message-State: AOAM533IqgBjC2n1KFseJOxqJJFznWhTT+9ZnRzxtGnTeijjUa8L+0DA
        cIbz7bIZi2a4PFtmtjlTjTUjrA==
X-Google-Smtp-Source: ABdhPJx4PZtuMxU2JerWqM/YaRO4AatYhh3Ifqwo11TmsGyG+c+bZD07qnxVTNIgGzuF7orMgJhfXA==
X-Received: by 2002:a17:902:9a8b:b029:12d:7179:2f6d with SMTP id w11-20020a1709029a8bb029012d71792f6dmr3304238plp.54.1628883172579;
        Fri, 13 Aug 2021 12:32:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a17sm2988800pff.30.2021.08.13.12.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:32:52 -0700 (PDT)
Subject: Re: nbd locking fixups
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
References: <20210811124428.2368491-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eeb57c27-b6be-67d7-09db-efe60e516581@kernel.dk>
Date:   Fri, 13 Aug 2021 13:32:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 6:44 AM, Christoph Hellwig wrote:
> Hi Josef and Jens,
> 
> this series fixed the lock order reversal that is showing up with
> nbd lately.  The first patch contains the asynchronous deletion
> from Hou which is needed as a baseline.

Applied, thanks.

-- 
Jens Axboe

