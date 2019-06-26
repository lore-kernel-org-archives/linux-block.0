Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B845C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 22:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434C221743
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 22:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wl4IVoax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfFZWZ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:25:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37133 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZWZ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 18:25:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so112567plb.4
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yXH77KA1A1IW9jOBzRWJZbCLzrA9uThM81uS89UYoSU=;
        b=Wl4IVoaxRwbRhirOgliE8eXCyv1QrjjOgbhe7ORjLu4fDmYPjY8/Nw2F3YNETiuhFW
         NLpzmM+qzD3PNW95ODlLblQp+YcLk4s2ZwwOTg1bhTHTUubVpSQm6FIqWAMDe/9DVGKg
         rn2eK8pZGhtEVuitZj8wPXm9FP0/6qKIGWCX+A07/FU+Pq7kQRe/NqeN3Kz42cyEVO3A
         uKZ8SPSD+vksqg+YDUoAAywVZD8g0YElGrWu2RTbLRKKT7s8IK2OTJOGsR7wW5J0EBJr
         vkPHnk79i9efYSuuJJfFDlJU9eFZb90NXLIF7AO0tq+M3ws5Hv5YjFWPvTpFmFaFNqkj
         Amuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yXH77KA1A1IW9jOBzRWJZbCLzrA9uThM81uS89UYoSU=;
        b=f+Ss/PpxEVp1SgIL56hnIAkBft4yw1JOZgmnEktjDUbesMWRzZ+SdIxLE7Sc0VuIMq
         b8OAvxLSy46Mz9PlD8frJPgarIlfRZ6XKK8nL/PUVgSlDKIZFdh80fQrZIGIYgn0Y/rr
         GIZ4Xu1mErfUM510chWZ7+WC3qAzWEq9HgCptcsPv+ZqmY3ZnDd3hNtSfEdQYx2lnfJH
         yZGSSwzVpyht0H0D44g8uI/ZUg14duAunHVe1No3LexG6kkH2gt4+KtKDz87hekEVMsI
         e4iIcP4J+2cPSk0xNJwJRVM59piIaan/6uyexfhTwmm6O87UI4QVljRRyCH5RQiqZdL9
         hrKg==
X-Gm-Message-State: APjAAAVkNGlAnDfrfDjp3WEU/NBb2sjHtwoWdn1xFu0LHwkfu00GIv0U
        3nuI1n7YeQpkO3Q18hY0rD3u+Q==
X-Google-Smtp-Source: APXvYqyFASo6/HuehlUHfhZusl2VH67NgnB7FpHMLSsvKvEp8xsjLhjEQg5Hu6ZMjSm/ZN4I7gMA/g==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr472750ply.11.1561587958017;
        Wed, 26 Jun 2019 15:25:58 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t2sm124731pgo.61.2019.06.26.15.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 15:25:56 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: Init saved_wr_start_at_switch_to_srt in
 unlikely case
To:     Douglas Anderson <dianders@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     groeck@chromium.org, drinkcat@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190626195919.107425-1-dianders@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a108498-77ec-1164-b5ed-80d791f60119@kernel.dk>
Date:   Wed, 26 Jun 2019 16:25:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626195919.107425-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/19 1:59 PM, Douglas Anderson wrote:
> Some debug code suggested by Paolo was tripping when I did reboot
> stress tests.  Specifically in bfq_bfqq_resume_state()
> "bic->saved_wr_start_at_switch_to_srt" was later than the current
> value of "jiffies".  A bit of debugging showed that
> "bic->saved_wr_start_at_switch_to_srt" was actually 0 and a bit more
> debugging showed that was because we had run through the "unlikely"
> case in the bfq_bfqq_save_state() function.
> 
> Let's init "saved_wr_start_at_switch_to_srt" in the unlikely case to
> something sane.
> 
> NOTE: this fixes no known real-world errors.

Applied, thanks.

-- 
Jens Axboe

