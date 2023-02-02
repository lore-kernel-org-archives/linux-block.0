Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9AC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBBSXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBBSXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 13:23:35 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832225DC23
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 10:23:34 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id w20so1829399pfn.4
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 10:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZpjHFgp6gIFjvMCRZDUoskDYXR8BMiuFx7PRJDiqsM=;
        b=vgVR4CZjTpKH4TNwvv1QNp5N+prYMDPtf1Lwxk3VqK5GY6MVuuGAh69Io7Bsqy/tD5
         bachWVBtrqlN1v7o4bb0n1X7uPobil+WVKNY/BfTEjEg5QpsU5jtJGuWTeVJOR87F53h
         mAtCZBVeKCpaSHe9sLrSP96+k6eurU9yz8ejLjKl7T3RIacxt9PS+M0QcEpxAS99MW2l
         TUHXyDHAETHywmHmccQ9K4AYi1PTyHPbg/qGglMX5Pb/EWANGX3Waf/oQ/uoJH3HqOmv
         sdUY3CT3u7OTqI5+AUUjUxOOIfueE1xOXM+4lPsbo0BpmQMk38ToshPU7JVFkO9lKRKH
         dknQ==
X-Gm-Message-State: AO0yUKUH4kQjoXdXu/XYcSDzPosh5wsA20xl+pb036o0sso5s4nmL0xi
        aBag65zBcIWWSpludLYsnjYmiPfPLck=
X-Google-Smtp-Source: AK7set8rvrAHn5yqXqNDqcQ+GkCtTy/P8bE3LSSAsjj6AjKGEQVomd8MeNy5ZUntwlpWt7l6LkfAJg==
X-Received: by 2002:a05:6a00:1489:b0:593:e5fc:9dba with SMTP id v9-20020a056a00148900b00593e5fc9dbamr8471461pfu.26.1675362213939;
        Thu, 02 Feb 2023 10:23:33 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:bf7f:37aa:6a01:bf09? ([2620:15c:211:201:bf7f:37aa:6a01:bf09])
        by smtp.gmail.com with ESMTPSA id w5-20020a627b05000000b00575b6d7c458sm13904529pfc.21.2023.02.02.10.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:23:33 -0800 (PST)
Message-ID: <5fc60de1-be59-3630-242b-fb6ea3a17da6@acm.org>
Date:   Thu, 2 Feb 2023 10:23:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug report]blktests: g++ discontiguous-io.cpp failed
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8WN_OyT0ZZAG81UP-cW49cL6=ve5dzVFqLd_-zkfp6aA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs8WN_OyT0ZZAG81UP-cW49cL6=ve5dzVFqLd_-zkfp6aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/23 21:07, Yi Zhang wrote:
> discontiguous-io.cpp:15:1: note: ‘uintptr_t’ is defined in header
> ‘<cstdint>’; did you forget to ‘#include <cstdint>’?

A pull request that implements this suggestion is available here:
https://github.com/osandov/blktests/pull/110

Bart.

