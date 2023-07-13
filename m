Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F012C001B0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 18:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGMSOC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGMSOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 14:14:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7526AF
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 11:14:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760dff4b701so10133639f.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689272040; x=1691864040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkiImLuc6QEi7DoBhIgOGbdYDHWQTk/Om9WfXsB50ig=;
        b=KaIUF3/tRJ0qDXoscRUarwjybkgc4Jl0hFgymnA5hkbLIT6OhuW1iF9nl1oH13udf4
         97bricT600iR8f65mmBjFucMWZ7YlJ2fCAcOWyURLBdNY/YPb7JoUzHnH98VO3CRTFtS
         3f/5JQ25nW4HGGYdQr8lCQN7Qb7c4/IJ75T6SwpTYfuR630PFbwfeCL+p2NvQuVAx7gU
         5R2y3kDTcXCVEV+1rIpDAWT9b9rbESHkitf2Au9L3MNevkNeNMIInmXIrROZXaVv4EDz
         B9Px4ySMG98RfplGco5fju1aEy0Z7CWYfsjD/shNzKWxKhFlsyU9U4o/AmrayUUXL60u
         TJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689272040; x=1691864040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkiImLuc6QEi7DoBhIgOGbdYDHWQTk/Om9WfXsB50ig=;
        b=U3JuwD9BzU2G3PrEmuAC6CjYBvA4k+HDcOJAtuOvNsN6IMT08DKiMLNDsEUKhQkVUO
         fUTvBJj3OfgkoNeTD9IwAs7QE2j7U1pzin5z8sio9fujwoLdVpggBn13j8rsoDT7ruJ/
         hRRAsBC7W+toAcHKdtwW9l0gFbC35MpPJJpIS8zag4zLvCj+LiJNeOzwBeB15S95D0WS
         2LuaNErYyJ4yfyYRirkuyo1uJdZCq6YNobiu3TdEIET+Linc2KcCfgICxviD1i1Ne4iI
         D9WN2+vYSzyt+WzjEGmAwDzBf1QfAZQ+jnqdV6wpue7+Kr02KQklVjf+TdkhKJoHCSLz
         ooEg==
X-Gm-Message-State: ABy/qLahOOsp749mc79Bgz8tZWTfrD099/BY/CkII9PazBIgNSVmMAyG
        Pa+jaVmiQeDUzymDrDcThCvlUA==
X-Google-Smtp-Source: APBJJlGEQFZ6OBYxtZC+K33OLZUgxOrSGSIHYOctFRQOOsUPFQIWpxqwEEyazh9ZENT8OYhqg9jwkA==
X-Received: by 2002:a05:6602:360e:b0:783:63e8:3bfc with SMTP id bc14-20020a056602360e00b0078363e83bfcmr2410666iob.0.1689272040248;
        Thu, 13 Jul 2023 11:14:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d81c7000000b00777b7fdbbffsm2134594iol.8.2023.07.13.11.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:13:59 -0700 (PDT)
Message-ID: <6e73aaab-fd2e-f9c4-0826-16643717694e@kernel.dk>
Date:   Thu, 13 Jul 2023 12:13:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Chengming Zhou <chengming.zhou@linux.dev>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
 <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
 <ZLA7QAfSojxu_FMW@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZLA7QAfSojxu_FMW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/23 11:58?AM, Tejun Heo wrote:
> It's a bit out of scope for this patchset but I think it might make
> sense to build a timestamp caching infrastructure. The cached
> timestamp can be invalidated on context switches (block layer already
> hooks into them) and issue and other path boundaries (e.g. at the end
> of plug flush).

This is a great idea! Have the plug init start with the timestamp
invalid, and use some blk_get_time() helpers that return the time for no
plug, and set it in the plug if not set. Flushing the plug would mark it
invalid again.

This obviously won't help the no plugging cases, but those are not that
interesting in comparison.

-- 
Jens Axboe

