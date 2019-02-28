Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F6C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672322084F
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ArWnY9/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfB1Utv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:49:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37181 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfB1Utv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 15:49:51 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so17935101itc.2
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KJk8ztiFf+hMP/NeGi9Lx2ghpuNSZWEO7aJq6IlQNvE=;
        b=ArWnY9/N80xJKKL5b7TVoE0SpRVenserDn2Ws2z7BJmuehLg7ySmOC44bJErpnCnpO
         ptT7B78nddM2RiOyrwAiVbeA5eswBU9NJNzPGo2HmyS0Uqr7JiF1NX35CoivD5V8NoVp
         2Ehjg7xXiFchSe/ZbpmBm6Cf81PbjeU2sxWH8WCP+eqq8ZBo0IpRNSUuxqTZIlrTWoV4
         ACs18DjmluqLrnWAoUoiOSAIVGeHy55hBqz7hWvJdW6STUHQXFcDwNnMMJ/1/u1+KfA1
         oHS/V0FaLVoUjg23wu276nF8vwd5ar92DPUa05IkLO/xprGeJh9EVbkM4m9u5WaYtcoP
         t88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KJk8ztiFf+hMP/NeGi9Lx2ghpuNSZWEO7aJq6IlQNvE=;
        b=EGOipQ/WcDlsbzEsZAj7YFgXJQBNVI3gBtRAdzIC33qZbsfvBec8D860r5lz+oxo8B
         RjGnvu336rTxY2BUqc1MndbekR3QOPmEaao9Q0MbIauxj2uK5NnkAwzR6z5npClnJUK8
         0FNIHHcYiF0Gy99aNQ1HCoZ6ZYN6NE4jW9DzUIMbPnS5AMgKgGdK6bYAgzqu3zpOeLRU
         HU2eUFOEVvsrTYPUBWWMpNKqpDrHL9KRosHfJQNaVSPLhOcKxhUMDKnEzE4QqT1Ajdl5
         cj/uhP+bB1fbuDlyDrn6Wr0yCSahBQfngenUnGWR9KgZLLY5Q+kzwuuohc1nE3Q4wiEU
         xkZQ==
X-Gm-Message-State: AHQUAuZwa4kkNw/KJa2qChBIPD9jLdJH8cyDilx74E+yWLX93XkcspfK
        wcIhEnKeDb/ubhPPa0FLHzse9zYxcU69hQ==
X-Google-Smtp-Source: APXvYqypJ2LQmLnLuGUNMv11oKksQiUs19OIfmfcKYMwSBanrGE0pTHaCUwuS4OvwNXKs4/gc2/VQA==
X-Received: by 2002:a24:ba1a:: with SMTP id p26mr1179643itf.150.1551386990535;
        Thu, 28 Feb 2019 12:49:50 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r19sm7560294ioa.35.2019.02.28.12.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:49:49 -0800 (PST)
Subject: Re: [PATCH] block: optimize bvec iteration in bvec_iter_advance
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190228160018.3652-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc4c1eaa-0b6d-82b0-c2e9-9b668b535902@kernel.dk>
Date:   Thu, 28 Feb 2019 13:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228160018.3652-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/19 9:00 AM, Christoph Hellwig wrote:
> There is no need to only iterate in chunks of PAGE_SIZE or less in
> bvec_iter_advance, given that the callers pass in the chunk length that
> they are operating on - either that already is less than PAGE_SIZE
> because they do classic page-based iteration, or it is larger because
> the caller operates on multi-page bvecs.
> 
> This should help optimizing shaving off a few cycles of the I/O hot
> path.

Applied, thanks.

-- 
Jens Axboe

