Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED9C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF0D2074D
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 01:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SRqgOiDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGABDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGABDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 21:03:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D44C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 18:03:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so9204796plq.6
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1SOchKZ/ulQnHhpPSyWO9xT/75BMeth9ktg5RGv4Y4=;
        b=SRqgOiDfo+bpResuzcf8kRlzdKislh9gJEKWyIyeIbhJ2hHpcPyq5galX8RPNblatx
         1oIap2OsheBZHwLXbh6XHHP6KGu1TMvSQ/kj03iTncRrd7brzs08FifIDGSOU6DmqUls
         rzUpjtM0HD9UQAqlZhmljy5Si/PiJoBoItMmZegeFGIkC4ZD76aE1J4VHg7rPHheJ+AB
         lBOjpgjJBGd9gvR12hVLSfCcpZOyAbFDP4o56WnzAGLjJ649NqtmaeAnfWvoggoNX2/w
         X2TQ593A/+V+oDAh1jeUJpHXHlK4KGSExxc2jleA5JfSuLwhw6z9QdaBL6VMi+sRhSc5
         NnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1SOchKZ/ulQnHhpPSyWO9xT/75BMeth9ktg5RGv4Y4=;
        b=HV8ORBIq3JeCfAwvRB/XJgib8R5zYQtNnCyH4OCcCq+RIHkLqxanzEVkDgJClDdkC6
         i0LK/WLatuvIdki8B9Fx9qP2v8QRqXFcmg0HStMt+dDcXPxyTDnyRRTN/9FtnuCdOvUf
         dteqmoz9EqT8ZSP+rZgCtQthcDhJsT0IE4CFrLEKsBXirTdj1Uh5zL+6QO9ZxAd649bY
         xr51qXN6soyNV06k+I/WG6YAFDsYs9pPv4m9e6tZFusseLTqiH62kIlGlsKg1lpMNp6X
         7bUNozLdi8p/FOnC7aA4S9HMUe323cRCi+iibJJhKfepxFpi4IwO2jkqT1VZNzFWFxHX
         IhcQ==
X-Gm-Message-State: AOAM533fW6Ihcu/QSgz6B7Vvs6Zp1KcVMYNhfezSNuFvZhwrWj0u1GeS
        /bGdf3teXOqv+MwsChMwfBua5Q==
X-Google-Smtp-Source: ABdhPJzXoVRhuyjhMLrMjLWtZrz422qjtMxAxEoKnokFEMriFw4m4fSOrPCyc/pZW0SA+xTbCDCdmw==
X-Received: by 2002:a17:902:6ac4:: with SMTP id i4mr18471013plt.252.1593565412020;
        Tue, 30 Jun 2020 18:03:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:5066:4556:8aed:6810? ([2605:e000:100e:8c61:5066:4556:8aed:6810])
        by smtp.gmail.com with ESMTPSA id 26sm3781308pfp.35.2020.06.30.18.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 18:03:31 -0700 (PDT)
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@canonical.com>
References: <20200615041459.22477-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <daba0f31-df05-0d1f-9422-15c6813f62af@kernel.dk>
Date:   Tue, 30 Jun 2020 19:03:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615041459.22477-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/20 10:14 PM, Hou Tao wrote:
> Else there will be memory leak if alloc_disk() fails.

Applied, thanks.

-- 
Jens Axboe

