Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB36C433F5
	for <linux-block@archiver.kernel.org>; Sat, 14 May 2022 21:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiENVY1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 May 2022 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiENVY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 May 2022 17:24:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BA9393F1
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 14:24:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so10156344pjb.1
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=FywJs009RBpZAOcBqaxGsEO9YqhF6uX15Kces+pxfJc=;
        b=pdhzZSMTCrydErUhyMAmfGNvCwzWz5N2Ja5LaQQMvnN/reusvgmq/vpkFh8OEsG2RO
         iU+t3d64NuA/dFntTdXLgMTGt/W95vsAj/k0rRtzwth6q6j8WfPPWQXbZJevFyUsJYXy
         HZKJM+jwqfPoAMgiMq/xs+EpCdmEb8CxXX7J83P5NfS9s/M7DQrBXL5dIFxaJ/L5lsfT
         bp1MUNUgN3RorcNtwekCZp3DUa7Wvr90sEDR2+NriHqj6u1XXZczhpaF+Duc+Wxgd5Gf
         LzAJJgN0S1ZH2WxYeJH7wqs8yKDsj8NgC/hdVuuFthk9izs9lH4r5XrJ86kVGenlXTR8
         YUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=FywJs009RBpZAOcBqaxGsEO9YqhF6uX15Kces+pxfJc=;
        b=Iso1jFIhmxILSrLjf8YrbJC8lCHFGicWQhEyCFcG0DFYB61WnUJEWiMSjqFhYNKL4B
         6tn/KLQOsf0zHfcy1fWV3gLO5F5yoJA6UPURIXoJ8sJ3g28DPBQSxc0uUq3y/llql+Xw
         w7PR/P9RUi5dZCsx6sQLcBLzWg1t/fhxlJDjsEhCkM6wYddmLnkJ7DHMNu0ZCzLki3SA
         Zn3U+xht3RQzob4A8wenbUQImMz+EIC/cfejzobWhk+f0Io7iVfOpK9Kg/fGnomQH/h9
         3E7tbEsH9jD6SA3ewySbcIYqIDSd/AH/uR64KPFQILE/Jtv9nunW+lVcOcO2blW4uMDD
         ElHg==
X-Gm-Message-State: AOAM533mDlhZRa1bYC8Lniy5E+j0Lzg+GZn90NeZopPl6zYXpT+woH7+
        Wtiq/ujiN9tMIzcFxh5Duvkdpw==
X-Google-Smtp-Source: ABdhPJwwbCHz8o4isK0umBmxTpb2X5DrYiard5QIMGvXJ9VtQVcPJ3Nnm4Z/ZSy7n9UI2BGiBA39zA==
X-Received: by 2002:a17:902:7890:b0:161:572a:2494 with SMTP id q16-20020a170902789000b00161572a2494mr3130432pll.123.1652563461826;
        Sat, 14 May 2022 14:24:21 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n26-20020a056a00213a00b0050dc7628167sm4014756pfj.65.2022.05.14.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:24:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Vasily Averin <vasily.averin@linux.dev>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
In-Reply-To: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
References: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
Subject: Re: [PATCH] blk-mq: use force attribute for blk_status_t casts
Message-Id: <165256346055.208046.4012136969482600787.b4-ty@kernel.dk>
Date:   Sat, 14 May 2022 15:24:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 14 May 2022 13:03:54 +0300, Vasily Averin wrote:
> Fixes sparse warnings:
> block/blk-mq.c:1163:36: sparse:
>  warning: cast from restricted blk_status_t
> block/blk-mq.c:1251:17: sparse:
>  warning: cast to restricted blk_status_t
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use force attribute for blk_status_t casts
      commit: cb9e061e974f8a3a8f2b8c89d93f34ffa7cacafb

Best regards,
-- 
Jens Axboe


