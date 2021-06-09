Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7DC48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E1461375
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhFIPpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:50 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38736 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFIPpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:45:49 -0400
Received: by mail-pl1-f175.google.com with SMTP id 69so12727637plc.5
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EgqbQ0qmYQiVi4+TxQzK8DLdRT/rfMIV+/j8tJzJJLQ=;
        b=PdxkE/DegMBbE8NSV6suY1PS86UjQ6B/A/6RTild4+qzDVJ/2Gg8KGe0oxjl0yJJyy
         uQC2wMbHLtMb5v7DlnyvDljZlncdk+m6hA4UFoBqeH/lnauYSu3x1MXA0Dhrq+2SfbX1
         AFSHEMu9M+fAZaZtm+OnafEAz3oprpyhDFXqSv5TebNzyu0q7wdG9dlIHme3S+5ULPLc
         UcpxpMt+2wzeVIgQTFsQXTMPrhhs55UM2xw1tNARSA2X9EXSijaYNyFD/aO+j9LbB5MP
         EyWwzWLoJQ+a0aMCsSujir72GMpgqsTdlGZQiJgiZ231GCkDXxN+M4l4kOEFN2ro0oy6
         yUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EgqbQ0qmYQiVi4+TxQzK8DLdRT/rfMIV+/j8tJzJJLQ=;
        b=BBRbPcp50XpJT+XHZa93UjocyIYn7EYM/fjIBWfKv8fXwdHye93Se78ZJcWa2R0xNB
         g1xGdndflJsMbpdy0YH7eoJqHtq8OLDCjvVo/dzpRerx0vxZjNQLcmqipy0u42B0LIJR
         LJo6r6WQjt88jseu+Ox8Om86XsE07RN+id5v1gaJKWY2kXC8JHbDBU2uMcVsRN9t7VjY
         h4+608zoN2jORKt2xohEQ1WTFngsiblc2AISrhISH5aPpCDsunZj2fM0G2dWaUEXl6L7
         79ENUZKiERQW8JhByuoRhkOEn+T++lnR8VXdd+/HhM+7qguMuaAH+qth/eAzxMKSiPCx
         K9+Q==
X-Gm-Message-State: AOAM530ug98t9z8uHQpD/bs3mF6fkKlMwLwx0NM5+/z8Tg3NgICdlG0t
        XEs5NwvvhumAUFQTT4PV3qLJZQIk6fTqlw==
X-Google-Smtp-Source: ABdhPJxq96U3sFP6m54ib8ZB/ZrMhmE74Vbb4j9G9LucJSQN0yCOKWYQMhed9lStvqUpQgnpjn5SPg==
X-Received: by 2002:a17:902:dac3:b029:105:66fc:8ed7 with SMTP id q3-20020a170902dac3b029010566fc8ed7mr233534plx.6.1623253374688;
        Wed, 09 Jun 2021 08:42:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 20sm35482pfi.170.2021.06.09.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:42:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] sunvdc: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609122327.14045-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6166507-d709-6982-1627-cb878a347112@kernel.dk>
Date:   Wed, 9 Jun 2021 09:42:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609122327.14045-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:23 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

