Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91FC001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjHIPvW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHIPvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 11:51:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360751729
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 08:51:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68781a69befso971951b3a.0
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2023 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691596280; x=1692201080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQ5Nw0Hl1GKJjtHT4HExUQ4CvnZL5dICt7SndpkzNN0=;
        b=vd++RzGYgFboS/ruCwz2g+H7/uQsthTLY9m8k/gDS+m+XOVJf69tNLkBPZ3jwJDiCT
         Cj8YJQWbf4q75lh9hfq9ARwbKOAIsdLe5uzIWMdw7jcc7HsnQ9yQOC5ZySMK4qMxO/+W
         2f4HvMmW5fuunxZlG152iHZFwIAdBOXQLcByqwEMpO9us3WbVUj5EXWE4Pc95xhxUnkV
         xwtuFQTBBB8rHgoMaBzjPlwP6Nu2CzVck02uUHo91a5Q06dRDNGD/IjMaenKHuW6a2Lz
         +eHVLbPqfVG9IiwazBGCoR+tDeEt6jQKgKqR/TtYXpJ6mqOjtjXV0sQcLKma7HLrksLY
         MMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596280; x=1692201080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ5Nw0Hl1GKJjtHT4HExUQ4CvnZL5dICt7SndpkzNN0=;
        b=J3j830869u5/4EwYqQ95dqnTueEx3pPiXSgjICv5Iv8Q+sVJJPrweYBNJSXeA3i/Sq
         Icl/O20XhZRYvW+BFNozMa9DwMQlV3ebcWJfWkiHF2RFFy8RAnb7tcMA6YEOOvnA2iyk
         1AGy66B8sBN1rAqmWxBbW/XJtuy04Q76ZA7Fr89Ds90wCEXo804PeQ95IqhUydMXJ4cs
         psZ+PhKB2zDu1eEH7XQnloODbiu+6zfA9E/Ep9UOCScG3NjoKJVue9uT3tBt2Mf8/ffY
         jX89XvI+R3fHQSKhWekKRnNPvda5occVzkijPoYuEN5Qo/tlKVDmU/6UEynsZ6IvrH5f
         DffQ==
X-Gm-Message-State: AOJu0YzBd+BKY+dHF+1Cqb+yvme1KxThZ32qAJeIm5YtIzQBXNzZ/NoM
        t1Y9vwxZfMPPvBoNgIn1HE4Esg==
X-Google-Smtp-Source: AGHT+IFgkVIVEjfXan/BJLy51EUKgCBMKNWWPQElIWcYBHqMVPCAlDfry7DCleEO27u0aqes3BjDVA==
X-Received: by 2002:a05:6a20:394c:b0:111:a0e5:d2b7 with SMTP id r12-20020a056a20394c00b00111a0e5d2b7mr3385902pzg.4.1691596280645;
        Wed, 09 Aug 2023 08:51:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78547000000b006661562429fsm10442621pfn.97.2023.08.09.08.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:51:19 -0700 (PDT)
Message-ID: <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
Date:   Wed, 9 Aug 2023 09:51:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-block@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/23 7:08 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Even after commit 9f87fc4d72f5 ("block: queue data commands from the
> flush state machine at the head"), I'm still seeing hangs on NFS
> exports that reside on SATA devices.
> 
> Bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests"). I've tested reverting
> that commit on several kernels from 0aa69d53ac7c ("Merge tag
> 'for-6.5/io_uring-2023-06-23' of git://git.kernel.dk/linux") to
> v6.5-rc5, and it seems to address the problem.
> 
> I also confirmed that commit 9f87fc4d72f5 ("block: queue data
> commands from the flush state machine at the head") is still
> necessary.

Adding the author - Christoph?

-- 
Jens Axboe

