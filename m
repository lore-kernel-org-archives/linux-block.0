Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80801EEB56F
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjIHTeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbjIHTdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 15:33:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9562F1FE7
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 12:33:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-273b1ea30beso598211a91.1
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2023 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694201565; x=1694806365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q77K6K9aetpUJ+m2swHb4WFutErkMKiXOvu8vLXzv6o=;
        b=StaqAb895JvirYrM90QDqw3si2QNurWg9xqd3bKaTbAzN7xVFEafc8Jmtx+j252e4J
         PhTV5qifegRuBcA97ZQv49pfRjdMBveQTNrD+bx2+ht+z6bitpIsdW+tJeh5SJg10+mZ
         OSMSv4gQXVgunODUUCntC+mPvxH6usivIiSv6xaEzBHoo7KRgkQrJYE4MVXkwppJTgG9
         jKx95J2fNhh0PsWbInAhfDal6KPd0eiCgLL09y3BtTzFaFheJmMZN885Spdk4TbGrgqa
         awKrcAhzAqE3F+aTZEiZ9T3HpVi29zfnSU/G5rNJucsXrCiMQIC/0YiuffFzdgSpbPdx
         fRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694201565; x=1694806365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q77K6K9aetpUJ+m2swHb4WFutErkMKiXOvu8vLXzv6o=;
        b=Oq8sl4lSg48H9a/aIuDrRaWiHOvp+P3QdpNuaqlVtUTPO9fLsGxnPGmFpcs/Lg4vdI
         TsU15ogz/VDcqDLSxtEtUNNjVXlLMd9Sjph/aQk+jX0QNWUKiyl8zY7gRvCdVjlaVptf
         STIXv0bGdLRXJxOilVJ2uNcE/WXFmXBkcDkkuvPQIHUE2qS9waxY0cXn/CxyWLmSan29
         SrHl3nYmCXcNCY32YL1O/BXnxRY+mjqLiHxYoEoKEo8Kh5N6DS/J0++NrnoflWShjyX9
         lp/xLIp2I6VZMYun9DP0Y1BUuLyaju0puwIiE29dWu6xCDLCYNpLnGWFh1Hfek0c4on7
         x6fg==
X-Gm-Message-State: AOJu0YzTGVy+0TIjLz8D0uD4JhOropvt2HIoS4vvxK3i9vBAYxbi93Ux
        1blTR81Ntj0FRZmuHoGRiWr+Uw==
X-Google-Smtp-Source: AGHT+IGHLvavStavXlYDVS2UvBAcUd/wa4WruHdVF/uXy7Bs2gkR5oWddVf4pPXi4u1EgSURMVojhg==
X-Received: by 2002:a17:90a:7025:b0:263:730b:f568 with SMTP id f34-20020a17090a702500b00263730bf568mr3401958pjk.3.1694201565361;
        Fri, 08 Sep 2023 12:32:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a030900b002635db431a0sm1766410pje.45.2023.09.08.12.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 12:32:44 -0700 (PDT)
Message-ID: <cd341326-cfaf-4796-8894-2241e7b630d9@kernel.dk>
Date:   Fri, 8 Sep 2023 13:32:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.5 31/36] block: Allow bio_iov_iter_get_pages()
 with bio->bi_bdev unset
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-31-sashal@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230908192848.3462476-31-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/23 1:28 PM, Sasha Levin wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]
> 
> bio_iov_iter_get_pages() trims the IO based on the block size of the
> block device the IO will be issued to.
> 
> However, bcachefs is a multi device filesystem; when we're creating the
> bio we don't yet know which block device the bio will be submitted to -
> we have to handle the alignment checks elsewhere.
> 
> Thus this is needed to avoid a null ptr deref.

Please drop this one from -stable, there's no need.

-- 
Jens Axboe

