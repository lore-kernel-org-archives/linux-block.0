Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A0C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270C5206BA
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P1MywJ0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfBGT5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:57:36 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:50967 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfBGT5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:57:36 -0500
Received: by mail-it1-f179.google.com with SMTP id z7so3023340iti.0
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cUomU2y7zwsgPVwkydJM4T4AU3kFO9l5yhtc85gy+eI=;
        b=P1MywJ0KtFaTvXIFHCEaGnezTF2pXAHIMMOc0JlHPUCA7Z+SrY8AxbPIwnRgI769ay
         BrSiERHtUfuiT4gxDyO2bn4IvQBTOEMPX/IlTbnpMVtVNPD27pEMHb0GL3kjUgBj5OSn
         Ql89UhBscs2WzOZbJYnRWR/PpBVm3hr+a9c8dXXKrao9gS4CDUkWPjwsoo+NXIX+QYi0
         yA+dVmBT9/upZoGJIg+hvO2UTWQHUP4tdjsPRMcnVrBMo0kLKL01C4Mu6LazI6HOBqnV
         rkVPPZVsKhKeY+7jVYUXkfFW9ecTSn8q8HX6tsZNpv0/7/OQCaNEU03b/6spCNAxQ+K0
         EagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUomU2y7zwsgPVwkydJM4T4AU3kFO9l5yhtc85gy+eI=;
        b=DL0t7ulaaR3SOsd8pDIGif4SO6xNOrKKh0ayX2WOO+IjZvcbG0EhrYvlx/76P6FKMU
         VghlMRpJBNzOM2Zjvp4+a6AYhXJFYDYqnIQEUPVUZPLjUBpsXKsD8ChZXXbmEdoMCzWj
         OFRrKZte00hGUH7c6TwI29qGOhpN71QOqh3KNQtkKQSmfNbHh/9TXvortnZm+Kxb/znY
         CxO6YK8D+joFnc7NHaXJWjmEyO4vrqYrfB8g7bEy9laKt06t8uO+e7sk1R04STBmtqDv
         CENq/YeQTOMvgM3JcPZlTXmnd7bHU7B9wSItE3xzRstbfCVqekDw7aiNjM3NCYRBu0EZ
         naLQ==
X-Gm-Message-State: AHQUAuan2BzQca4Uc0HcV9fIqqrjYDEhr9jrodS9gCB/obESTxrMzEcg
        cBatrIzBA/h1KM3hr63yHoKd13fi9Mv7Cw==
X-Google-Smtp-Source: AHgI3IbMy1yi8w7diQjJAz4t+38b+iqCmmSDph9VqRYVpR0YgM4SMDF5611XT5sDRft6UZW8CAz6sA==
X-Received: by 2002:a24:e44:: with SMTP id 65mr5474675ite.154.1549569455296;
        Thu, 07 Feb 2019 11:57:35 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z1sm4822924ioi.77.2019.02.07.11.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:57:34 -0800 (PST)
Subject: Re: [PATCH v2] blktrace: Show requests without sector
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20190207105539.8815-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96db0ea5-00ed-a3b7-0413-4762e5233f9b@kernel.dk>
Date:   Thu, 7 Feb 2019 12:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207105539.8815-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 3:55 AM, Jan Kara wrote:
> Currently, blktrace will not show requests that don't have any data as
> rq->__sector is initialized to -1 which is out of device range and thus
> discarded by act_log_check(). This is most notably the case for cache
> flush requests sent to the device. Fix the problem by making
> blk_rq_trace_sector() return 0 for requests without initialized sector.

Much better, thanks. Applied.

-- 
Jens Axboe

