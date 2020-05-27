Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC0C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE4A20888
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VgXBx/n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgE0Lmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgE0Lmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 07:42:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07DC061A0F
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:42:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x11so9054128plv.9
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZeKxoqsJfHmJKWaGZ+FoPVmzG1uJu0Aa8XuYZUp/Ew=;
        b=VgXBx/n9QvB+YvDn6NYJLz6oVH59pjcPxJRh65BhLU3L7ZuClmM3L2k6D/626PY954
         QQyeqbu8PgPXQCenizXc2i0fC76rQLs8Wigkf4p7SMgbycDSZCVefXPmN+8UV1pawScy
         A2EFa4ZQzatLH1XSkfSK5ym9JQ6jWznNerWZ2LgW+2s1KfuNPJGOAi6T/vXRasdxGG5O
         KuIlKlb5pj0K1QBhbpZ77dep0qpYB5q901mYzXB6eaxxX+5v0gV/Js8+y+LOrYVQC57G
         xNoyGX2CFF0yNvJxOJQSSqMfHZ+KtdVhLsAgGn6KSWyP6rnnd7SyNkWQQHHdVyiC4nC7
         N0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZeKxoqsJfHmJKWaGZ+FoPVmzG1uJu0Aa8XuYZUp/Ew=;
        b=alalZ/ISdXvm3pKYFTVzT+aX/zxc1g5VZ0DDUrI+Kju2VG6iv7S+RFLh8ItUAnLqJQ
         XXurPy2lD9zi8vDoaSy4HV9tfn9EPwhYkwJgnfFkJMPg6MFq71dB+iBCN8GZreqOqpKW
         3VHzcuXeqwhzqjQDGsqA1XjiZ37X7tI8GtkvVYsXRVzLOcFpZC3Dcm2z2agUVzqzqv0V
         TQniQkg1JTTQM5RIPr8xtibjGmhgdrUQiiYc5kab+xteiKPxJN5APq8Qnv6XYRjpv3e6
         l2HHEqTYDDu2zAxnzbMNaKu3keIjCrH8dqYfdcYo52GWzALWF2lFP8AZ++byQK5DPJ1T
         lqaw==
X-Gm-Message-State: AOAM533mSMuXLXayfsVLyJ+23fQre0pC5Y+uzLCi8+N4Fs3pnct5c87M
        18/0nmJiJJhifBgdn6oxluaSSg==
X-Google-Smtp-Source: ABdhPJxEIjzI7FCnmm+8XenXCkMLJM7xic+d04No6urE0jxruzEp+coK6xFyXzPHJohz4u+UUWTTdg==
X-Received: by 2002:a17:90a:26a7:: with SMTP id m36mr4607945pje.28.1590579756112;
        Wed, 27 May 2020 04:42:36 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2cc3:8599:f649:862c? ([2605:e000:100e:8c61:2cc3:8599:f649:862c])
        by smtp.gmail.com with ESMTPSA id v9sm1981838pgj.54.2020.05.27.04.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 04:42:35 -0700 (PDT)
Subject: Re: [PATCH][next] block: blk-crypto-fallback: remove redundant
 initialization of variable err
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200526224902.63975-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <feb4f798-ce3b-6a08-e462-ab23bd223b18@kernel.dk>
Date:   Wed, 27 May 2020 05:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526224902.63975-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/20 4:49 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

