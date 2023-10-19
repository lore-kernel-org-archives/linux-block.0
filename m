Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50728CDB482
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 11:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjJSL1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjJSL1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 07:27:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBB136
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 04:27:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso1094555b3a.0
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697714851; x=1698319651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLhirv0t6Gdj7rg3Zj76XjVTeaxSqmv9ustTaBTht3E=;
        b=Rr5penU/KlD0QQqW6FH7EQGwyUAHhPR8tO4eftmdJftyWdrTZ4OqTTq7CxYs2Zibup
         1IJd5LDRaPPZ4uuufuLVzAzWrbLguysuWj8M/V3Z1GPwLHoS83drCIudvJMrksPvEqBX
         dK2+k2MDUT80IcYIpFeEgCIDy/p1pbl8XLtVJkq7VGAxUWnDjEL2/l/O2zB8xNLchgOn
         4dALSOHWUtAsUH9mWHPmfdbryPPJnz4oKdxWacVRxuyvXK0Mi+bJN3GKhSXfEXB6z7LW
         Q+d/Ky27sVhT2WhVLJuFlHP/JvAi5iFoZQlS9ofxOSPbM0wd4L3dlgCjTtqTBVrTOXAe
         /LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714851; x=1698319651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLhirv0t6Gdj7rg3Zj76XjVTeaxSqmv9ustTaBTht3E=;
        b=H6tM2lddHIURfm49Qlb9Uyf0vvv1JczIPqTQGdcFOeu6hSOsTHMGXMawI6zPsiwv+Y
         1i/Nfj18ixyWKzk49KI1jWqO1S3QGUimtbW4wgni/xJ14X/s+UxIaoSKeU/HOAdO6Na9
         e+cs2Zn1xMNrFoNtQFQu1XRO25//1IzRxeyWfrR/qk1W9KruovjTX2hFixHqQsLrzGtE
         jCPf7MfbQzuLizbvrmtOJYRlrnTsEcidQwKh3kecp6YwWeGHne1OLQ+HSyzeIPqAfTv1
         l5JXRMmsxnGg26jGN/QIgh76pBcK70SFqWBWR57c/Z7joytKwCA3+wiO2ytbinmflt/1
         fa6w==
X-Gm-Message-State: AOJu0Yw/y4m5TVzw9YGJL+ANBWyw7zc805K03TAQ+89zgTWjBGoX/MzX
        /denj9hdufZU3l4PmOdBl//8+g==
X-Google-Smtp-Source: AGHT+IHmj1OwSRNAW2Wg7BjQshnDU0lVMCjcabQ+fd7WSqpY9b2/q3in6H8np4ns+Vm1d9GhLTNpbA==
X-Received: by 2002:a05:6a00:2d1e:b0:692:ad93:e852 with SMTP id fa30-20020a056a002d1e00b00692ad93e852mr1692002pfb.2.1697714850705;
        Thu, 19 Oct 2023 04:27:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b00690fe1c928csm5238960pfb.147.2023.10.19.04.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:27:29 -0700 (PDT)
Message-ID: <d6957524-5364-4b05-a5a7-bad8dccd67f5@kernel.dk>
Date:   Thu, 19 Oct 2023 05:27:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't take s_umount under open_mutex
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231019-gebangt-inhalieren-b0466ff3e1c2@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019-gebangt-inhalieren-b0466ff3e1c2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/23 3:35 AM, Christian Brauner wrote:
> On Tue, 17 Oct 2023 20:48:18 +0200, Christoph Hellwig wrote:
>> Christian has been pestering Jan and me a bit about finally fixing
>> all the pre-existing mostly theoretical cases of s_umount taken under
>> open_mutex.  This series, which is mostly from him with some help from
>> me should get us to that goal by replacing bdev_mark_dead calls that
>> can't ever reach a file system holder to call into with simple bdev
>> page invalidation.
>>
>> [...]
> 
> I've applied this so it ends up in -next now.
> @Jens, let me know if you have objections.

Looks fine to me, please add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

for the series.

-- 
Jens Axboe


