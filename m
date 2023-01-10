Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C7C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAJAou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjAJAos (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:44:48 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261EE035
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:44:48 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id w3so11490622ply.3
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHz9dsv4zV0IG9UJxiuazCME4VuHv9QKHvfpRhKelv0=;
        b=LPd9zUPsl1eY9msDkUQTV4KAxM985AD3EJLmQysXHr5MpZPJpOSF2h5oMiCY0UFeQt
         pFYEOhLvBaHKy7+UqgeIORn3BzRbINKQQRZ1hdbCnHxHSlQPkJYUoYK6EaIahiug6XNS
         y5WRdB704P3nFjaoyBgZTJfyHX18joZMz29Vme3C2dku+Ucy6bhZO9H7TfDtkxNOnbL/
         Pbq3dZnX+AWsDk0NCdcxLB89a4gTTvpELlldydKW7FF3ZitRol+FOQnW5s9kmPsEo5cY
         /Ae5E4cDr+Hd+HshfBUJUISBCGS9J3q49BHjD8Au0IzvA+Wmku2ME+AIl8lM5j5VPnYf
         olvg==
X-Gm-Message-State: AFqh2kqcZzpEwEzahXW7xk+lkKTUESZlFLaR18fC1N/5fuOcWK6xdzQK
        hxiLG7Hrd1Dy94HRP0QUp2NVWgBYyME=
X-Google-Smtp-Source: AMrXdXuU4rya4g7qkmm78+rXzWv/5YZBvG7isTAjGtvcRRWIoVIBwXKDIxs2Qh7I25b+w2MkchLJZQ==
X-Received: by 2002:a17:90a:d982:b0:226:f05f:7e4 with SMTP id d2-20020a17090ad98200b00226f05f07e4mr10324745pjv.27.1673311487492;
        Mon, 09 Jan 2023 16:44:47 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090ad78700b002270155254csm3629496pju.24.2023.01.09.16.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:44:46 -0800 (PST)
Message-ID: <07084f70-00a7-d142-479c-52c75af28246@acm.org>
Date:   Mon, 9 Jan 2023 16:44:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 16:41, Jens Axboe wrote:
> Or, probably better, a stacked scheduler where the bottom one can be zone
> away. Then we can get rid of littering the entire stack and IO schedulers
> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.

Hi Jens,

Isn't one of Damien's viewpoints that an I/O scheduler should not do the 
reordering of write requests since reordering of write requests may 
involve waiting for write requests, write request that will never be 
received if all tags have been allocated?

Thanks,

Bart.
