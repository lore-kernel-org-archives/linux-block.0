Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ABDC76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 19:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjC0T0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0T0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 15:26:42 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA591984
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 12:26:41 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u8so5187628ilb.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679945200; x=1682537200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m22IOmYO648upgKA8FIcZBXwHFb4PsyxR8+W0WlIGww=;
        b=RiknIdyiWcZWnkIIkiOglicslJMzjPhVeGaVim1BrZZ9d94WZXBVfsGXQz9TdsbEuq
         CxZ9Cy1ubRrPrJ9L/7y1gRC745EoV/0T9SFNum1USDjTb60fcq1bEV+4RGHHXPRImVYO
         qt5aElyt2L35i0rsTOKSDWMsKLH9jmTyrp6xMr03bzCTXIHfayggLIzCsphA06j3Qe47
         EteAjoDfpaiJUvCUV1WXOb04nsv4Rsmdmx9T77DQaxXJ71WBjqjejCkFlrYQwCG3xpcM
         6VKIBuO6HMstop/bVFTJw6q/qWTYgx1H6BD6m9DKHibR3nph0YJE0vijbGP1rvHNVIpr
         E+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945200; x=1682537200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m22IOmYO648upgKA8FIcZBXwHFb4PsyxR8+W0WlIGww=;
        b=Nr5x/71hR5EyIxDpCAKS9J7a9ffy1n26Usc3nSk6I1KXMpzGTofBuaJtCjlXLr/G5Z
         ILnfLNox7hhvztgBba7Sx5cRAVkWQWmnCtX6XJmvOApUY16k7zUvnUYu+tHQ349JxGVz
         feHdb+N8FFPEvegPKYFrvlF4LZ2n4S4Xs9++DAUBNYQy5jRt7MtYDWRR+nyzT1XNizYW
         qOpnAJLcY86hgftEdlnGbU08f6r8h3fDbr961RDgWw8wJhEcYL2NZ9KEsFFIS5MynrgD
         jseK0GsLN+ceKjL0Lfc+ZsWJnaH9HiOFNc94OVz7S9dXNL+Wl1A38iOd8hTB7QxDqUQd
         B5yw==
X-Gm-Message-State: AAQBX9cZ/cKjA3YxH1CVNdHowrNQ5FQcWk9HiaSR2+k0G07RQ9vlqMjO
        ULl8Bnwt7Yjn2svS8JtmH69e4g==
X-Google-Smtp-Source: AKy350bKFm46lxLr131DpMPhTEYIe8HyBOaDLSJqY/PpHTB+bEeW1OC5kYpFgf6NM+wBY+QyLHyKsQ==
X-Received: by 2002:a05:6e02:b43:b0:317:94ad:a724 with SMTP id f3-20020a056e020b4300b0031794ada724mr7897223ilu.2.1679945200604;
        Mon, 27 Mar 2023 12:26:40 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w4-20020a056e021c8400b003230864f757sm7846593ill.68.2023.03.27.12.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:26:40 -0700 (PDT)
Message-ID: <e5b78f91-122a-0b0d-8d3f-922d462ba44d@kernel.dk>
Date:   Mon, 27 Mar 2023 13:26:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/14] drbd: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/23 6:27 AM, Joel Fernandes wrote:
> On Wed, Mar 15, 2023 at 2:19 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
>>
>> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>>
>> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
>> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
>> avoid accidental use of the single-argument forms, which can introduce
>> functionality bugs in atomic contexts and latency bugs in non-atomic
>> contexts.
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Philipp Reisner <philipp.reisner@linbit.com>
>> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Jens/Others, any chance for an Ack here?

Begrudgingly-acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


