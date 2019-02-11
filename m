Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4632CC282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447521B1A
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0i3C6hsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbfBKPVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:21:53 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:53053 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391504AbfBKPVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:21:52 -0500
Received: by mail-it1-f172.google.com with SMTP id r11so21779651itc.2
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KfkAQZ+9G8+m0CU3a1j2o7j0gjCnDCH+NGOMm61ahcs=;
        b=0i3C6hsu12PTpkbAmuZsuX4soIc/E9Vh+ua9IAgZB2KI1uuIPIvjs8ab0093t2OEAm
         8+He9xslTM8G/BmEIgTBSyKhDeKb2VUl6tMaG8OEvU2Zdv7TXpmz5djmf0EPd5t+F6zw
         QthohYyQD8F0jnXuECZQFMEqSZihhpT4GsKVKDQVaW14JjIdtpga4i7xsyA0l8DsTWZb
         swz9pSoI3F7HJ/vMCY+7r6OekXRwg9U0AxBoCbJ+smFMneDyHPA/hDtoDjpCrAFR2LSo
         8tJGY6GOUtvPd+MFp/DQCx9pAMuxgCtpfKUcOxE+iYzMWZqOcmxCvq/ZlCIg3FeOdX/3
         Dupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfkAQZ+9G8+m0CU3a1j2o7j0gjCnDCH+NGOMm61ahcs=;
        b=BUNIaT8R7mYAv7N92+8fEvb4YjmUI9KyOz7hcYXmEsRd7L6TpUBagCS1YLAy+Ifedk
         8hZl68AlZLNkFLsuE+Ns0xZXNYnFApVOL0IOmr4FwVG1j6L9ZibNH4sjYjonf6w1emtU
         +/JblJJ2Jy78YCtlbgjlOa8n3XAwIyejtapOtVAsrFxmUGkE0KUawNMutEu4l/GKdCKu
         RzJ8g+H5j2DtnTkMUb8KIQHKqrUD4IPrs21bI6vVVxSrolH+FO9H6VJupuXWpkoUzIbR
         SYmvaDzNLjOu8iW4cVoaa3FbrSDmWmaoWyF+4Z7lYp8ZcbEXgJsLhmPU2xFPXY4qrHik
         d43A==
X-Gm-Message-State: AHQUAubZd8r3BovUT/Z772CdHevqIcmL6h6FDgttq5yT9IKfDLN0cjel
        EFGhXeyU8CpxkIy7oiHOkaTVoI5xr4tDRw==
X-Google-Smtp-Source: AHgI3IZaUn1FLGqWwt0GGjRyUvWPzKZpqk56EtFuELDCbrQ/4r9/QsSt6kDZ/cTKDl4cCOq+ASnOVA==
X-Received: by 2002:a02:40c9:: with SMTP id n192mr17222161jaa.78.1549898511325;
        Mon, 11 Feb 2019 07:21:51 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 196sm5442878itu.37.2019.02.11.07.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:21:50 -0800 (PST)
Subject: Re: [PATCH] block: avoid setting none scheduler if it's already none
To:     Aleksei Zakharov <zakharov.a.g@yandex.ru>
Cc:     linux-block@vger.kernel.org
References: <1549882237-28183-1-git-send-email-zakharov.a.g@yandex.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a6c264f-70ae-30d4-8c94-c9c3e5d5cb35@kernel.dk>
Date:   Mon, 11 Feb 2019 08:21:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549882237-28183-1-git-send-email-zakharov.a.g@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 3:50 AM, Aleksei Zakharov wrote:
> There's no reason to freeze queue and remove scheduler
> if there's no scheduler already.

Applied, thanks.

-- 
Jens Axboe

