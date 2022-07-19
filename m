Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D889C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 16:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiGSQ4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiGSQ4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 12:56:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E64F1BB
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 09:56:11 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id f1so2173280ilu.3
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=poCk2apV+LMtrh3G4K7hLOMkOXCZ0THBzF1nOrkzCWo=;
        b=yCSlWK6U1YnSRZkOtdp6YyqCJDH4MsE8HBxrY8JvGdpdPaMtrz37Oqf/H1V0B7iGxs
         is98EmpmeqH+jtesAGr3TMA6YnmWpfiOfAAVxJaPgyNum25MdK4GELkT2jb84Lkhbg/K
         nZGhmS3edZueAXgeiXSEmbbMdWtuB+7l7EkmuTATvZTVLW0V2s4BbZ6mHlsAnayzvxO7
         qAprW1eUYDgLCGri4mpZnaMOaDooIpl2T7WIDqoLruD/vTFO/hvuvDTZkNo9jZJLOz56
         tdjrRBNaSKadnB4a8amgh8GS8GcHBcPhM/NZ+rBRSuT5MPNT+s6Un9Q6hQOS/YN5SLLy
         fQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=poCk2apV+LMtrh3G4K7hLOMkOXCZ0THBzF1nOrkzCWo=;
        b=VxLB4UKkjlxBlrYrzvV20lsyAbLLtyFE+pi9CqyWbqBvotL1UIbN3sRAblRRMgq1qI
         U7/4d436/W2chS7xgV7V2p8HjHhUbIJV0TiNbWAQy8TfP49SeBqETOVoGMtniuKCIsBm
         sgp8mdXiKU5TigY0kq6+bfzhejv6uZCddM8iU0WhjRfvlcthcPYcYb8Ts/g6HgEbvUiV
         tsdHqImfbCOKzx4ysy9wIgniKppodBoHnlsq7xbhHihEq+w4gEm0UNaPlYbULLKT/4Lj
         HBa0MTQ5bTmQ6+PQv0DhvFK+Y3Np9h4u5vgraWcIsDLsIWL7DP2wmyYecoN7j3tetDHJ
         YyPw==
X-Gm-Message-State: AJIora/rFpfSTQir9BH+CKIipgjSXPYzEStOKrtBxgNMBY9I51IEzaRN
        FAK5aX1iinGY5Fjkp7JzsMN25A==
X-Google-Smtp-Source: AGRyM1s6w8YfT5bcSXdin5eON8Jkbvf5Xo52wZiJqw1nR81AeCSCe2QktwnmO4z/hUPl8l3jQiPtLA==
X-Received: by 2002:a92:cdac:0:b0:2dc:919d:aea1 with SMTP id g12-20020a92cdac000000b002dc919daea1mr16351478ild.162.1658249771346;
        Tue, 19 Jul 2022 09:56:11 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y27-20020a056638229b00b0032b3a781754sm6896667jas.24.2022.07.19.09.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:56:10 -0700 (PDT)
Message-ID: <036e5ae0-4908-d4ab-c2e5-56e9ca85e26d@kernel.dk>
Date:   Tue, 19 Jul 2022 10:56:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] block: don't allow the same type rq_qos add more than
 once
Content-Language: en-US
To:     Jinke Han <hanjinke.666@bytedance.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        stable@vger.kernel.org
References: <20220719165313.51887-1-hanjinke.666@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220719165313.51887-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/22 10:53 AM, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encounttered some list add/del corrutions of
> inner_walk list in ioc_timer_fn.

This still fails for 5.20 and you didn't correct any of the spelling
mistakes I identified.

Please take your time to get this right rather than attempt to rush it
and needing to send new versions all of the time.

-- 
Jens Axboe

