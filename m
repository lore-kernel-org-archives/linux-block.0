Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A96C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD761058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhI0WbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhI0WbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:31:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475CC061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y197so24758078iof.11
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mqOH7D1ukF9Zx8b0uf7vcP62TIlQ9RE291MOEYFvaPI=;
        b=5v8EI4K57W2nZC6Fz5gZTCvYGpzpLmIVxBdnAzUCwcOELQ+Z50Fvi0F2ewrLtFDHRt
         vtQkQZUUT9draUGadJ6ZaetWUBTobhsNeKmmxnly90D3cPXzYH+dCrqn7mpikqrckWDt
         WHi7wR55Ek303Gg+2dugwLfcDXsRNH1MLrzdZ6XsBnqq5oBHq+hSOTcA57myq7M9AOAa
         aCJaO2UWkm+hsZKGxK0d0D/TNWYEqb0UDgv+4L/taDU3hH3nbprrs7bGRma0s183dv+l
         EPbxyWPCeAI7d/kBAGPUllWTqDWK0UR5PhnZh81ZPhBozZwXA1lGrbmMOWvdwHaSVxRe
         8BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqOH7D1ukF9Zx8b0uf7vcP62TIlQ9RE291MOEYFvaPI=;
        b=JCoWxpl5V/2T4BdVQ4HNr14D29lwPHCx3H3HiiKnrJRe10oMwdEWWyLOHjbS/BFK1B
         QyhSqe54IEPDXzksDLN7o3G35/X+zTEMBuTAQkuOitPovv5BWkEYSVYsZFf+61fjsnDO
         OAZceFUfq1ed8q8GQ5QZo816fOTVpkQyJo74FUHG1urile53Yw5tC+VjKkWQw92vxkF2
         uUN9O3HGN8YJytCmkxxjHX59Cd22SwCc+uvUEVHO6NgCTeiM8eim83GmvgFY9jdKslhU
         SDpmziOjq8JDM9Ku1E7BQQ8UyvkMm8+EBjML2icmJ6Dekh+QtoVRUV6YerUrAVPscSvW
         Nh4Q==
X-Gm-Message-State: AOAM531ldMdvMeosUqc8XpUrskoi/ungDRRMGlDHdn3n0sFerjyo53eB
        35rHXaw2oMm5072eS3us3a5iXA==
X-Google-Smtp-Source: ABdhPJx4BepmT9sgpk1hyVciVWTm6ec+ZxPGy9AhD/MitW3pGK1ERf8eVfBwoyEV70Tjv8vb1T8inA==
X-Received: by 2002:a05:6638:164c:: with SMTP id a12mr1841987jat.62.1632781775194;
        Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b12sm9902455ilv.46.2021.09.27.15.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:29:34 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] block: third batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, justin@coraid.com,
        geert@linux-m68k.org, ulf.hansson@linaro.org, hare@suse.de,
        tj@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
        chris.obbard@collabora.com, krisman@collabora.com,
        zhuyifei1999@gmail.com, thehajime@gmail.com, chris@zankel.net,
        jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220110.1066271-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee2c245d-7190-b708-4c48-cbee28f56f9a@kernel.dk>
Date:   Mon, 27 Sep 2021 16:29:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 4:00 PM, Luis Chamberlain wrote:
> This is the 2nd version of the third batch of driver conversions for the
> add_disk() error handling. This and the entire 7th series of driver
> conversions can be found on my 20210927-for-axboe-add-disk-error-handling
> branch [0].

Applied 2, 4, 7, 8-15.

-- 
Jens Axboe

