Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48802C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39FB20866
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DDsl2cIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfAPCwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:52:14 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:40952 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfAPCwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 21:52:14 -0500
Received: by mail-pl1-f176.google.com with SMTP id u18so2247173plq.7
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 18:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRtSCSRSjRqHxGmG1ueNvjK0x8AAftbAdLRxqaOPi+k=;
        b=DDsl2cIydoW3/LV4LrAwOgr/zO+eFQw9kQcXUNGO+MZSBwoGSybtp2fci8DYYRiwHP
         UcJLsjGz3Oxx6fkwkPqRVLGP6TykjGnuJpdgx7/Bv1vjZBUcfwHmm7w82OQnr/4CnDZS
         dzO1pEm5mqXJsoflUDPuOne7RSXshdxezQDljhLVF1/r6Mrd1Ku4AnGnB/OgiI5BNC1U
         wGzHQA4orevvBGe5c7bdYXV8kwf7CYDr07mP8TNX35+0YurbqbfyzG+nPADQw24Ro16j
         h4PM8Wryod1NMY6+EeIMbWIzX1Z+58FHVeyg3p2SF2PVq4ePz23uXS3b99M0srmQsQ5P
         Ng2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRtSCSRSjRqHxGmG1ueNvjK0x8AAftbAdLRxqaOPi+k=;
        b=dNNfxD/l522E8JOVK0tI9m9Zi8qgeSPea/oGyruMg7/y9CllUiBT9HVGeDMOr5o2kY
         v2jQBa9cimNphKL6SoSIrZypjigWSUSwA9KwKE+cDxjUDzTGwgPmsmU2CMCHiq1tnOD1
         RNNYYxmgJOLSqnuibR2UDNtawpuruH0fb1XQSZ5Li2w727tfODSYD+70YxLH6l/U4iFg
         C8P3fyYMdVO/VOjtgehI3JRNeSzhR8aR1bBK3UQtelPoQCwc7GLb6qt8Qt4whRNUCPI9
         ZPdIQ3mghcWXG4I5yGx3Kvk6KSp1caA2hVA45KpIOA7BgmfFadp+le4DaWNdNA2Mg38g
         Czzw==
X-Gm-Message-State: AJcUukeAJ0aXFf88JCnMB9bo9QwqB9vXfal+1OcbH8A0d1W6jCscgQWU
        JO50m5h82v6FS4xtrfKvIfQu/A==
X-Google-Smtp-Source: ALg8bN7SdCmwgsCurikj1RdBc1h2tE6umCqapVe1Rwp74KI0F1MZf5le14mnzUkM5QMiPFd9sCjk3A==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr7210752pla.47.1547607133315;
        Tue, 15 Jan 2019 18:52:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l19sm8116191pfi.71.2019.01.15.18.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 18:52:11 -0800 (PST)
Subject: Re: [PATCH] fs: gfs2: fix build failure
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190116021602.27130-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95332016-e712-2e7f-896a-0f8f10d7c824@kernel.dk>
Date:   Tue, 15 Jan 2019 19:52:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116021602.27130-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/19 7:16 PM, Ming Lei wrote:
> There is one bio_for_each_segment_all() not converted, so fix it.

Just pushed it out yesterday, I'll just fold this in.

-- 
Jens Axboe

