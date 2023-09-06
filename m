Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85244EE14C3
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 21:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbjIFVXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjIFVXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 17:23:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B710E9
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 14:22:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68e2ff0b5c4so35724b3a.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2023 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694035377; x=1694640177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pTAHTXloHOhYCDxM4IPFeAD1uFGnMlVQwouiz8cCsY=;
        b=U7eARx3+hkrbw1Kxks/zuoB3+FwHzvU1sRzjo5ORywKsWYPpvKTHkPXMnpQnB5gCFM
         SwY53NtrsH4v5qBHBgv+86qsGvJJMZHLevgCRuXAI+K3oQfGv58V1xsIrHWa/vJogkTb
         XAoeA6ZgR01Qn12StqLgGGc24u1M1frcImhJnI4I7TOtT4vPJ93Mgc2McuOrEzo5ZKAU
         W2Xi2KxkBkx+LOqIGuGsNvWMyLmym0oMSPm3yjsO9y1L2eldMxmX31i0wgrbykkb+m7m
         1Npys5Ail7rVavY0Qr934S8kOqMb4TwQOAkEy4e3QAIMiCRyGUK1KcYi64z76YfMLQsw
         oIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694035377; x=1694640177;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pTAHTXloHOhYCDxM4IPFeAD1uFGnMlVQwouiz8cCsY=;
        b=EyQDu6pM3TH2Bf/Wu9C1+X5F4Pxs/cjesEV5Pqo3r2KXRiYFjUCp05BoYqZ1wdgi8D
         uI7391a3qKzRYUAB6b+BSYbN7YUWrVJSWKOBuebK1Wyx+agAfk5Vzi4u8Qj/SzGtIgdd
         Dg+nH1qP3CMNGgVuVuqZR3KYyibeWdCVsLR9JZp1DOdrA9FqR4HpotiZYwQG4v0JqjGg
         w8cKFLkr1VRR+CZ+tJpPCMRGeX0sk0PoC9HuIdrROMCRJyI9vFLHBuQQYrWWxUWkOg/i
         wZrmOTQLd1sU8L2djvLHWt7qzR3eaWDCTLyHtbTXgbvhFrikTHzZbxQBklXlNNZFJOvm
         DQJA==
X-Gm-Message-State: AOJu0YyienY540vIVRTZpJJyhbi8ZsGx43/rmLlLoy9rVCHlZjX7YKc5
        sl9NAwQkbHPszivQ2YkUoD9j+HPvb7pGYn9vzUQtgQ==
X-Google-Smtp-Source: AGHT+IFrYq9kZQPtcOdy9ZGpZFGg5udTEmzmIqlmTkZtP9nDqMVLSADjqIy1Xzkxg1/s8rww4pi19w==
X-Received: by 2002:a05:6a00:801a:b0:68e:3095:588e with SMTP id eg26-20020a056a00801a00b0068e3095588emr2853184pfb.1.1694035376921;
        Wed, 06 Sep 2023 14:22:56 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78c09000000b0068bff979c33sm11247498pfd.188.2023.09.06.14.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 14:22:56 -0700 (PDT)
Message-ID: <7794cbbe-c55c-47d2-b836-595083874273@kernel.dk>
Date:   Wed, 6 Sep 2023 15:22:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
 <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
 <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
 <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
 <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
 <29785264-a5f1-493a-df22-8fa291c3d28a@uls.co.za>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <29785264-a5f1-493a-df22-8fa291c3d28a@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/6/23 3:03 PM, Jaco Kroon wrote:
> With the only extra patch being the "sbitmap: fix batching wakeup"
> patch from David Jeffery.

Should we get that sent to stable, then? It applies cleanly.

-- 
Jens Axboe

