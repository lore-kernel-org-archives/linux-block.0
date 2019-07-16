Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F10C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE396205ED
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gY4EE0lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGPQQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:16:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42509 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGPQQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 12:16:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so10355835plb.9
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oTqmvGl8ydIB0gYyA2WGHXrgHJboD1D2kKfJPTOLljw=;
        b=gY4EE0lWvjI8k5EnpMxk5fZOG/5kDkGLC2m7HwOKJcu1aET7HqbJNi+g0TcZPD3OIy
         pCdrZUxQy9hYzYlgXCoQokqb4Ul+dpngrkHesTkkJAzKIYl73Sy7qJsl2gMqF1SC/0mE
         HptIU9YIPOOHAgtW1ouCkgz23A/FICdg48lUOG02u5dlEI50Py4U5bMO7w/CIJOQWkke
         s2K3gr4KTS0Em+In0Zt0NfSKMf1JIOkympUtouOBM/zxJDUi/6jpXSZiIwh1th84JOnW
         7+TUkeh0Jkfi6nqyP3cNiqn0EKTp0tkTRTuLSc1z1yJXpRBREzauItG7jrwou7EPCyKW
         r17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTqmvGl8ydIB0gYyA2WGHXrgHJboD1D2kKfJPTOLljw=;
        b=tsMfZF2y0dwAtn23Tou7I74c9uYyQ04JzWjNtJAuZJ5hhv479XKrA0ETJLfaXH9m3X
         /ilZqyiB1qJ5HT7iBJUVfVg35Ae397uayyj+YZi6ZnyGVa04Ss48iHRsMuCf8nVx4C/4
         CG00+42sm2N4GVjyUsGqHGuJ1RZcHtrdTUD7l9jfABgrTg+wZt5fslZRNOCXy9k0Eeji
         zRL80JfNR+5lUWsTvX9FqsnSQ9e8cSi0TZ1NFkTnHZcGXYAeSrL2BiIIBWoBtfBglpWw
         WWyI6js86JXwU3psu4BVuoYa1ukZGUEwYWKatOgLxjJjioM7QPm2274kZUfbAfpk+mul
         5FtQ==
X-Gm-Message-State: APjAAAVIAFWbeYguAYyx3Ttsy1x+tbEgE5gMJOX5V1Nqan5wYz09qbKO
        k7YP649Z9NGGGFDkjIx8Sygor9OYAmE=
X-Google-Smtp-Source: APXvYqyY8ZSnOEB8AqfpRYhH2KGeuVce9HLHo7E2ezD3Xe3f6TSc+uhozP+g1p6lkGjw6WezBnB2rw==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr36419439pla.182.1563293810678;
        Tue, 16 Jul 2019 09:16:50 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id s22sm22047929pfh.107.2019.07.16.09.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 09:16:49 -0700 (PDT)
Subject: Re: [PATCH] block: fix sysfs module parameters directory path in
 comment
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-block@vger.kernel.org
References: <1563281975-6353-1-git-send-email-akinobu.mita@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <076edd6f-70ef-1e6b-d93f-ea6540cd5f04@kernel.dk>
Date:   Tue, 16 Jul 2019 10:16:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563281975-6353-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/19 6:59 AM, Akinobu Mita wrote:
> The runtime configurable module parameter files are located under
> /sys/module/MODULENAME/parameters, not /sys/module/MODULENAME.

Applied, thanks.

-- 
Jens Axboe

