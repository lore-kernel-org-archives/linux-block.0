Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EAC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DA020832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J9QQcbRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA020832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeK2AJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:09:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42502 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK2AJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:09:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so10136551pfr.9
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o9bp1aFRegZKWbY5WpOWjAZ5wst59ZHQDllniLMDGpw=;
        b=J9QQcbRo1cExH5qB4+wju5aRpi8iy4jIatYctYIZpZOmzBtN6NdCaYJr7xFG9nUrDF
         N6Z3H6HwQcSdmSAybyP7UE1QRIfwzke8SCi+8QG/fwekVmi3cLk8GNZjaA0pP+OtorSG
         nia0Zl1YgKC5gXbNvp5kdpGfS/DsD40sj3X1o6EMnbbbU0QQTer2igwvLLmqEGJBUO8A
         zbxSXmVQp5JCwVTypjFn5RSv82BlPF9sJdlezeqmH9rqx6e6GOADXW7NyUG+h+QlibUk
         wklD4FlbyA5MNmG5v985Hcko3ZKARRB+s5vTdn19qmevjJWh7iBY9Ov6CtAOloQweadS
         MwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9bp1aFRegZKWbY5WpOWjAZ5wst59ZHQDllniLMDGpw=;
        b=o0onwjxQH2FNL6ETuwynmCc995wYG6NDyQ/6Xp2pfXpmmvoOMT6KUuB6hTvhw9+CHq
         qvvnlOcmbXQbCTjyl8e7tFA+YaUVzZ9MfOGRLXfb7M3DtTL/Y+pC21qB7QX3Agc07JaO
         79l64/NUTfQ3oQH29z0R/gI8XPj0L63wB84SgLP47wFHlJUq51ZiUwtAvTa/uvCeaKAF
         TB0m0NcdFgA3izvKwNHyCNuLMqpbShjTlLlZin5nWM7hWiO4V91F4xF32OW/seTezHzS
         YHnOzAri57JW099dwW+J+mCaC5iZKR3CrsmYSEXWHdmJTmU/IgOxiMgVzbViVpXzIun6
         oIHg==
X-Gm-Message-State: AGRZ1gJRyecJT6N5LR1lwABCZDIG80R6pSHtjK/O5ipLDeTf66wp/mkI
        7YFscF/X5/1BPAgAjY6OgtVBUw==
X-Google-Smtp-Source: AJdET5eFOCTNeD14BG8NuhZxc+POh71QaXJ2st3zRjFktwOnr5Aw+eHL2PX/DxRnZJD/nSuCA5LS2g==
X-Received: by 2002:a62:2bd4:: with SMTP id r203-v6mr37510467pfr.105.1543410452671;
        Wed, 28 Nov 2018 05:07:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y5sm11257939pge.49.2018.11.28.05.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:07:31 -0800 (PST)
Subject: Re: [PATCH 4/8] nvme: implement mq_ops->commit_rqs() hook
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-5-axboe@kernel.dk>
 <20181128072037.GB11774@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9f2f7b6a-0b6b-30af-94b1-b30259a1ecbb@kernel.dk>
Date:   Wed, 28 Nov 2018 06:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128072037.GB11774@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 12:20 AM, Christoph Hellwig wrote:
>> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
>> +{
>> +	if (++index == nvmeq->q_depth)
>> +		return 0;
>> +
>> +	return index;
> 
> Can you please just drop this helper?  It makes the code not only
> less readable but also longer.
> 
> Otherwise the change looks fine to me.

Alright, dropped the helper.

-- 
Jens Axboe

