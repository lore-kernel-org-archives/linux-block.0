Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B7C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81113613CA
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDFPaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDFPaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:30:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BFC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:30:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ha17so8133863pjb.2
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQTCy5ijyyViRaAjyIy/PYwacbW1UlGpqylY/UiiSJQ=;
        b=m0L1YmnP/tNmFLfM1zrmNAWM0spVul4zMFWtOnEmzckpxHb6ptLBEKk9lm+KAJo7dd
         Vz/D9y2IokFu0F7FTEA8CCAecKhbRuW4joM5VaN55lpZvezBkZmBtdA05filU+4KBL13
         5RniQsfyiJMiUr4w/87OzEUV86tGMgX1lGIYBFPW4T2TiKYTDXIVbarQs1NZUgqZeSip
         bbYdceozz0wAgmoHbx6iNh8O361mqNwrvcadsVwrjMq/T4rNVjpnpByi8iDUW2lcnRN3
         J897lzSyjnkrm3IFSHHhw2ijXIjW0m7UktbuFAjDQi+vH7rKcc+7CvgLPSROjQkydPJ5
         1v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQTCy5ijyyViRaAjyIy/PYwacbW1UlGpqylY/UiiSJQ=;
        b=CliUIFfbPkOv4VDDvqMZuK8q8m2ZCvQXTsWrFtegJuzvLQQfCVdAVoWTTHb00r7Zdf
         VozW5AD6r41gGcags5AQJIpNIYqhiqVZnQazxCiCkRV6D/o+Sfnm386s+/92hBK15VRi
         GC/Izfo+IRwEE0yHiYjZV4zRoW6kA7hVsBlL3TF3lWFGiIYTa/agv009izQD3KM203yf
         mrYnoxCTl2SS+onGvOKPtJmCj2A6AreeYyNsS9g04BwJKXoNT9XhNTDyqYNMMmLg44z+
         1A57XEYb8vuoIs5xauXX34nlawLxTMb1jYiQDp0E9Z/urteyWvrRQkc7fRLY7JtRcYi7
         wixA==
X-Gm-Message-State: AOAM530CGs5+Qt9U7z6lHoK5qnvyIUMyddFtQiCG09IbOq43RnP6cR0n
        7B2XGzDEzJ7Y14ZyeYavbEXB5TRPMSas9g==
X-Google-Smtp-Source: ABdhPJyQ0rg0aNhRPfV4x1SaMuFIH6BUnqWcvkJ+tcA669yQ5CiLANcaYO/FNoDoehLeL0hA18LVEQ==
X-Received: by 2002:a17:90a:f3d0:: with SMTP id ha16mr4753222pjb.5.1617723026501;
        Tue, 06 Apr 2021 08:30:26 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y15sm22000339pgi.31.2021.04.06.08.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:30:26 -0700 (PDT)
Subject: Re: [PATCH] gdrom: support highmem
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210406061648.811275-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <728fc6f5-d9e1-ca17-2c24-8d4929449983@kernel.dk>
Date:   Tue, 6 Apr 2021 09:30:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406061648.811275-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 12:16 AM, Christoph Hellwig wrote:
> The gdrom driver only has a single reference to the virtual address of
> the bio data, and uses that only to get the physical address.  Switch
> to deriving the physical address from the page directly and thus avoid
> bounce buffering highmem data.

Applied, thanks.

-- 
Jens Axboe

