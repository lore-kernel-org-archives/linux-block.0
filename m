Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A196C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356649AbhKYQwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKYQuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:50:08 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93AC06139E
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:36:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v23so8182521iom.12
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1ZDNgn834WbCkz4HbANyUMJbAE8lQOkVdODgu49duE=;
        b=lpBtjs5FChdGoxM3f15NbuZmNklhn03BhbUEubWPMNmwedM/+bTWqXmWthWmxZ4eFy
         cx3gsFVeZru24lHPWxX1gHP0780oaBUx1yhZPAk5q7N1difFx+8v9iz2SNd2KJ21rpmo
         aYCCefR9+DyIrZ6agFO1gpHnrTIJ00/cfdqRTexetffiJyTbXJ8hfTtU+fvKKrdwCvWG
         B+7N1NkMhsKLl2RqweSAhuJJWs0yzf7sZekHRycWvAMFX1fiAKehPmovrpNSfCCs7kf5
         6tHjd3QtJ5IVd2iSuzBCeqNon2M90x/7aARh+/SB5fnlV9K8SbjgkqL16cfrjo7PZh4D
         paCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1ZDNgn834WbCkz4HbANyUMJbAE8lQOkVdODgu49duE=;
        b=oB54XveOEgDjDkZA36lxZmFesWraZ3zB4b0dBzKYw8RIPZjpDyVk/Qk+SCOsdNbzoJ
         K6Qd3fb16o7aEhwk/A6eSkYkj8IKFGHI7fpLjs2bvbgSCcRYhkoksfCz0NKf3VIheZIk
         MOPmmTGaWUy9EHkJyw6mQEsJt//I3LjVKQtPR8xHxdwEWNPOXobhi50/PLuKrH02rJSV
         lVQTqeDDRw3VTC7rnBe4t9f8334bXZlqoPaztrqRSdzddHfSswbnKTEBvsjgjUL8itLz
         3wlDDEOCiGjQsoP1R+Iy3bs29/P8zan9uQ9JlfOqU9/rYQTq86VCfVFrz2MaIgDDEEvq
         LVcg==
X-Gm-Message-State: AOAM531qSn9ncRi2yeN3YVlFv27Q/ux74z0dA45PIlk2cGfX6698MHKU
        kjjPUrqbS/zMBFuyPFDv5DtfIA==
X-Google-Smtp-Source: ABdhPJywbE+wGzJAR6pUFsTE7EziAsQyLRWt+geVKbMSftt+6s5knBMhPsAdy474yBpSGE+51wfrOg==
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr26816851iow.203.1637858206013;
        Thu, 25 Nov 2021 08:36:46 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i1sm1871909ilm.5.2021.11.25.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:36:45 -0800 (PST)
Subject: Re: [PATCH v2] block: fix parameter not described warning
To:     davidcomponentone@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <acf6fdca867ff78a13099ea6615ac39d69bbfc9b.1637825871.git.yang.guang5@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b11ce2f-fdea-1cfa-10f1-44e5664d64ed@kernel.dk>
Date:   Thu, 25 Nov 2021 09:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <acf6fdca867ff78a13099ea6615ac39d69bbfc9b.1637825871.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/21 9:20 AM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The build warning:
> block/blk-core.c:968: warning: Function parameter or member 'iob'
> not described in 'bio_poll'.

Applied, thanks.

-- 
Jens Axboe

