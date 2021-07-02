Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F430C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8CA613E2
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGBPb5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGBPb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 11:31:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570FFC061762
        for <linux-block@vger.kernel.org>; Fri,  2 Jul 2021 08:29:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so11669685oig.12
        for <linux-block@vger.kernel.org>; Fri, 02 Jul 2021 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CXV0DKVQRCtWdq52IHkgAA67d6YSGGf4XryK5qMVjOc=;
        b=cMXtNCDC/m1D4LqMqgw3DmvlLUezWUKFjWxUseST0tFVJysXQbpbpgKjfwrz0T7lVT
         /QQkMrzNaXl5cbTwS8NEA20OLz6zACltOsrR/NM0ujDQTUAAn0lzjeXL7Yfaqq3EtAVT
         SZtbskizu86rVDTna42VcL3h7UMlob4tz2oRLvSGPJmRMPwU+SMmAehHrYVHqNw+vCmD
         kiyJpQSblLZMkhSxHKjQjVyzhhfQWeF/wByziO49KxL5SEfhbzBqsBVSspPIJ9dxYm70
         YDCtuv4bmvZX3xykOXQ4j+H9Wk/1qg9ef8Wk7LSB6rJJeQOJ3mq0QqpTgCvksw5mad4b
         /ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CXV0DKVQRCtWdq52IHkgAA67d6YSGGf4XryK5qMVjOc=;
        b=e+QH7OwBMnGXcf4XcWRCcpco498bDLWwTJLIj7FM1NtDlJ6VS+B6BWIrclwFMQ6qkt
         QB5Pc3sqGkjr0LI+YDcxxSL+G1FqD1KRWa+cL097kKaR+q8TofuvfRQLnNDtvw9dlDF0
         cAVTGOJDmzIOQ/YzVsr0sTWRi4akmoIetpc0HDN0sVzuOhUg4TODjpngoh0NZ357EtxZ
         ey/t5xVo0uClZQFlykL0lplCc4YSpNYLT9s1gB/F+GPTxwytLSwxwnfD6nOOR89Go9EN
         jLHYTq8WjNeuftx1gz8FNYG4pqU9zSicgEZTL9NDhUshjDhk99rw/zyZOAVncLa5JPCM
         scMQ==
X-Gm-Message-State: AOAM530P3U7gYP41v2AF0J16ss+WfUlIxGkL0iPl3Ji4r5q26ysstt45
        9IGO7RB4n3uMnBaOw+pM4U626dY/YUU5UQ==
X-Google-Smtp-Source: ABdhPJw2yEv6lKFuf2UvVDOSfReZImIjtm5VuFmqDBxt+zcYn5EWz3vXUnueKuHxb4FWgS3cxEd+rA==
X-Received: by 2002:a05:6808:d51:: with SMTP id w17mr298783oik.104.1625239764452;
        Fri, 02 Jul 2021 08:29:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id q206sm768353oic.20.2021.07.02.08.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 08:29:23 -0700 (PDT)
Subject: Re: [PATCH] loop: remove unused variable in loop_set_status()
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20210702152714.7978-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb8c95b3-b062-131a-d963-5422a0e7933a@kernel.dk>
Date:   Fri, 2 Jul 2021 09:29:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210702152714.7978-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/21 9:27 AM, Tetsuo Handa wrote:
> Commit 0384264ea8a39bd9 ("block: pass a gendisk to bdev_disk_changed")
> changed to pass lo->lo_disk instead of lo->lo_device.

Applied, thanks.

-- 
Jens Axboe

