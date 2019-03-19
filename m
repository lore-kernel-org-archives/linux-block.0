Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C9C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95920850
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jDFT+ZeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfCSPGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:06:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42665 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfCSPGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 11:06:04 -0400
Received: by mail-io1-f67.google.com with SMTP id c4so18088114ioh.9
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2019 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q5xowtc7ZnZnKjlRO7p8KAAicrTh4qNFot0Ilpis0OU=;
        b=jDFT+ZeF3vvyPX0uqV3LGHQbIK0Lii+gI3tcqxb5rPdHlpvwfuVj5PR6QfygtzXnjQ
         mUaz4HUvxeARuIcz1whhiKXMBQyd5pk6bQ9/TE8p3YCDOAv5r6AbDT+dXZZgaLCNYK8J
         n3zQyK+59KUJB1GcsHfUFtn42CNPs75O7ln2LWsCiB9dZS/AHNmYYvcLEwsuXZJJ/OVM
         rTyEiUha5L2sVql/enTsdx2/N5a9BzpVaWJ56X93k1Q0iZjnesTGRgq5FhwWzOYodjnq
         jlDqLK+8yCz1noDzu+7zUCmrRkJpTf4tB+h6Bkw4uzgBXErJPzg8sJ3Y1gFVkWA3hm5z
         mP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q5xowtc7ZnZnKjlRO7p8KAAicrTh4qNFot0Ilpis0OU=;
        b=guSWiZOsAxZOPuxLoutlk3b8OtYMMZsRkWYIF2hAWtn0iZ6vYFVhiH3YnDsYkuZa8a
         eEg5fv+zciYsSGENNuDsooatGxaxhOuJHw/uAue67EYbqD8Wzr2yguLJLt6R/xRNyyi2
         evYqLdNqb9DkMXYH3W4YtwZEga7UBD5zZx4N5s1p7PZkmDv89yx75EkTbjVB1pcdBTlc
         jhfPuAI6og9MKr/awTe10pUITDRUtu6ylxYkyE7OiguEgRRzYHtB25Oi+hNvlFV+0hA6
         ImIWCCS+CdevporDWfo92xFJ42OZoAYEcgJIPyRkbiATk9Xs0/Qh05/AnYheZyPRB83w
         erXA==
X-Gm-Message-State: APjAAAWEP+D05Q9RfPXmyVUVtq2DGMdKEJ1fRxClgVFT3YQjswJuy7p2
        AkkCuimAqOtbcA1EbobdaM3PJg==
X-Google-Smtp-Source: APXvYqyrgbZfWt6TCVUBUKNOXCf4JZzt7P0S/Zoyq/f0xCYWBtgbotb8EOBXzwSHjSvtu5zrrVhpfg==
X-Received: by 2002:a5d:8712:: with SMTP id u18mr1881942iom.36.1553007963959;
        Tue, 19 Mar 2019 08:06:03 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 136sm1566522itu.35.2019.03.19.08.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 08:06:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: remove unused 'nr_expired' from blk_mq_hw_ctx
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keith.busch@intel.com
References: <1553007918-5026-1-git-send-email-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <385c2413-e2b5-9e72-ac81-aec44de9ea63@kernel.dk>
Date:   Tue, 19 Mar 2019 09:06:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553007918-5026-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/19 9:05 AM, Dongli Zhang wrote:
> There is no usage of 'nr_expired'.
> 
> The 'nr_expired' was introduced by commit 1d9bd5161ba3 ("blk-mq: replace
> timeout synchronization with a RCU and generation based scheme"). Its usage
> was removed since commit 12f5b9314545 ("blk-mq: Remove generation
> seqeunce").

Thanks, applied.

-- 
Jens Axboe

