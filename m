Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30076C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 14:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbjELOe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjELOe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:34:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4A10C6
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:34:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3357ea1681fso1967665ab.1
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683902066; x=1686494066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l7M5qD0qh1ILTM02sp3n8gbFLZNlyZml6SWGnHetDI=;
        b=QcsRP46byFy+tULrJHYUbzjbPKBxJFbSV6gWkdbqiKZeONcrVs+ppc7YougOVZWo5E
         6rijDxOUH4oFmspicrX+RZXWoaYU0ArKSELDcVsYsM50fGM+YM0EHkASNSoBc7Tlp6FH
         5GED/3gELxXVzdFwJ3574SRnFvDMEcZilj/cYHgzwBtvPV52YQpHmywpfGP5uhnEZDoc
         wYQiin2CNYI4dXafz90TyvURbdKcRN3V1yWumS+alLoXHX4qp6LR040582hQ5SjOkGT7
         3MQ9cfjWJTsLvasRE61Lw1g3plBAZoQ3wupXBdSKWIrLAfvkJsRymResp3fgPd1x9G89
         3/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902066; x=1686494066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l7M5qD0qh1ILTM02sp3n8gbFLZNlyZml6SWGnHetDI=;
        b=imeDK9xJ0Rzmqhlh2B9si2r6+f/G3zbRmX7qFA2a5g+kQDqHVuMz+PFqDIz6SpBT0A
         w5k577ZEqv3Q/OYXHHiooBtbnOW+0ThuxUELEqjQIZj7gnjbB/dFW03BJPlaKbMv/ESg
         KR0XbanXrcwSlRwEma2foRf7bQCUQr7W/uAKWWiUEJ2TA/GjqBU7GBX+Rw8HK8kAqCkc
         jKVNNlgQJ6kX8XWwgGpKvg8pB7RKJvvjEJ8tWuXKJIBu2mWOEimOw33dwjGkQdSDTaJe
         3rluEFITmj15oAUVaKejuCp3wIvPgToKaASAgxMb0UD/jnSXRB00a+opu3db4XPPQOTo
         m1yg==
X-Gm-Message-State: AC+VfDx429AUfwblkcPMY8SLyLpzLFMwUsQ6XPfMIN5E5x5lOL16G0aK
        cgrY9jUGkV1cqndtfNaTgBHBng==
X-Google-Smtp-Source: ACHHUZ75zYODGwgsRmH72O/kFoyvffqG/+jQ2xADOSDf78tH9zO+9QU+656bJW9zO4+4XBi4crKiXA==
X-Received: by 2002:a05:6e02:178f:b0:325:f635:26c5 with SMTP id y15-20020a056e02178f00b00325f63526c5mr13737036ilu.3.1683902066649;
        Fri, 12 May 2023 07:34:26 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g47-20020a02272f000000b004165d7d6711sm4732434jaa.71.2023.05.12.07.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:34:25 -0700 (PDT)
Message-ID: <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
Date:   Fri, 12 May 2023 08:34:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com> <ZF5NssjIVNUU9oIA@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF5NssjIVNUU9oIA@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 8:31 AM, Christoph Hellwig wrote:
> On Fri, May 12, 2023 at 01:29:56AM -0700, Chaitanya Kulkarni wrote:
>> Allow user to set the QUEUE_FLAG_NOWAIT optionally using module
>> parameter to retain the default behaviour. Also, update respective
>> allocation flags in the write path. Following are the performance
>> numbers with io_uring fio engine for random read, note that device has
>> been populated fully with randwrite workload before taking these
>> numbers :-
> 
> Why would you add a module option, except to make everyones life hell?

Yeah that makes no sense. Either the driver is nowait compatible and
it should just set the flag, or it's not.

-- 
Jens Axboe


