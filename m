Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B1C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627C4217F9
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BJrr3mr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeLPQpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:45:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46005 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeLPQpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:45:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so5139775pfd.12
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F+zV8nk3HueJWvC00gE1u9VooYKgoOF10Q+5mz2cgHQ=;
        b=BJrr3mr24XpB9lNdM9kj1L014sa7jWq3YIh+K24ILcz0L/wqcLhDqyv35k1pVH8KCi
         M0Hu1KPcibYM2hM7pBkO+8wJSHxzd5wix01G1NTk9VMUzWEvagZ6eMlvMN2Qe58mZA7L
         +UcmcPIOte0NU3yniedWfSANfhVkEaejoStzYQxC1TmyZtZ1hd9+7bpkVWJMdoTHLkok
         tIc00evoVQMdBTfIlk9VWDLkkfLFwKp2upNizOx40wrf28Ajsdhc9DFzcBOQo5R8cGxQ
         D8eVVkkqRW2d83rGLCAL9L/UEs8XjbVyTD8b8Xx/vnKwhnku3H1TOjjESwddEdCPTDMI
         0siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+zV8nk3HueJWvC00gE1u9VooYKgoOF10Q+5mz2cgHQ=;
        b=lGLozPIX2z82yDRRCpcn1ENahIFJDXmLaYkHoo79g3wQFF6+JuHzSaFRgwu6PhurF6
         gmc8paP9dhmAXuMm5nfe46qUDq6SjxBEXZLKuDtb2JUSTe8CHQckwEcrYUXbamP7gyS+
         q/mOnjpiooamuHc/Wg2G7vcfEGKOQxsn9O91q79XsnFshHXYjeRJnr1kt4B6b7BQj/5C
         cQTiWWpglbE4LE4sMhtnlIQXn2If3UN4VZRqwMNDUApCbHA9BJFPbH72hep1czLgshOV
         gQKIOiW20/ud5nTpfVlF4I8kdIsyTpZmZ+ePzl2/xJTDn665CnqaI0f7i9h/cu2Jg+7b
         I79w==
X-Gm-Message-State: AA+aEWZLThn/ISW9VnGLhLSe3S/JHCV4CQG3ZXRWZiUw1mquLuKJ7GRz
        m4GF8wypnBw5l9nYVoGPvSDMtg==
X-Google-Smtp-Source: AFSGD/V06/P6FkyXM5lVpSSQO1q4UP2pyuK2qQx2r8Zsk7+zvu62cVVhmBquU1CtxnPa2F6GfC1dAw==
X-Received: by 2002:a62:2044:: with SMTP id g65mr9883792pfg.127.1544978732670;
        Sun, 16 Dec 2018 08:45:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s190sm13611816pfb.103.2018.12.16.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:45:31 -0800 (PST)
Subject: Re: [PATCH 24/26] fs: add support for mapping an ITER_BVEC for
 O_DIRECT
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181213175645.22181-25-axboe@kernel.dk> <20181216164130.GD13234@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08794cd6-c009-9804-804b-0d83ee07c480@kernel.dk>
Date:   Sun, 16 Dec 2018 09:45:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216164130.GD13234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:41 AM, Christoph Hellwig wrote:
>> +	if (iov_iter_is_bvec(iter))
>> +		ret = bio_iov_bvec_add_pages(&bio, iter);
>> +	else
>> +		ret = bio_iov_iter_get_pages(&bio, iter);
> 
> Shouldn't this actually be done inside bio_iov_iter_get_pages?

It probably should... Should be trivial, I'll move it there instead.

-- 
Jens Axboe

