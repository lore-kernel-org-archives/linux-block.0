Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DBEC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F627613EE
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELNlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhELNlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 09:41:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE8C061574
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 06:39:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id jc24so834808pjb.2
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HnfwX7m3Z+g9y+GxvV9dTr4oQgwcIKMOrB57DgGB/M=;
        b=RTwXYeJiCx5LbA/TppKdWG0bNmgqampo4zDXVYfA3AqbhFdlwCw6wfiKqLIhVRtIfb
         B21DPt8xHlw5rCM8LXxfjz4tQk2HAaxCGEQcTciSfS/n2YFZ+4Rhi8zibR8jxWcZwOFv
         lRKod4qWmA5J6HeVQKaKZ9sI7OCtqJMAwknWMBp5BYjMwP9EJwNo1v6Ozv4V+xiuq/eK
         RfYjLjgOhHeKoKhf+YfcXLDrRV2NDeY6XM8ttaNLryA9S8q4hZcFuhvqTexYvaKvKMZ/
         Xf5JNRv1IA6j20ir1aCmw+4BxFof+6PFo20aHoS0ToPpVZQw6F5pT8VZ8LTkePK/7xg6
         YSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HnfwX7m3Z+g9y+GxvV9dTr4oQgwcIKMOrB57DgGB/M=;
        b=XIZJntdPY8yoEEDwAeLy+JOWruCXwjz0Pkkn02TtsuLHhkNZiEMfArK63ThdWuFO3g
         KUTu23EpYwo7CYAtWTUJgnD1UpQdrFcsTynXEdfDBHT8+cH4al/Hx4XFwd9elCyW8LzY
         T5CmU9tecEjGipi1MUP11b+tMRqEdyfoLwfSioas5OLrdaIwC6+Vbk1P3wkyeZLvBfwv
         BOP/Yvs/kjQBQQQ8tdT6MbVerkYp3a6p7OCCVpigmbnZ/iHE7h8bx2orbMCQ3zoNh7Ch
         IY+BtdYuQH1g3dm7yqi/ny2H0GlD56IyTS4f6y4alscWMlpsvPgU3kQn1TIIkZ4NEtZ8
         sHqA==
X-Gm-Message-State: AOAM530GI+3FWHKFeYt0R7ysObDb1xslsnkKFZ2QhbYVVM3psn6zmb8u
        gERxdaNQfAio13xPPmBW0i4Oi+9M7pbD0A==
X-Google-Smtp-Source: ABdhPJxP6vRQYyKOUIGJG6xxYEUOrOMhrrtAzel+K3wr2JRaGqTBKmFUGojyyUTsAfc0BvuvA9M1Fg==
X-Received: by 2002:a17:90a:1382:: with SMTP id i2mr10981240pja.83.1620826794133;
        Wed, 12 May 2021 06:39:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 80sm49501pgc.23.2021.05.12.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:39:53 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/1] block, bfq: a bugfix for stable merge
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com
References: <20210512094352.85545-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d83a2097-3800-a222-4580-ae692bfac030@kernel.dk>
Date:   Wed, 12 May 2021 07:39:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512094352.85545-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 3:43 AM, Paolo Valente wrote:
> Hi,
> this patch fixes a bug I've found while debugging a failure reported
> by Yi Zhang [1].
> 
> This patch seems to make that failure disappear [1]. Yet it was tested
> only together with other debug patches (which add logs and invariant
> checks), so I don't know whether the other patches influenced the
> outcome as well. At any rate, this patch does fix a bug.

Applied, thanks.

-- 
Jens Axboe

