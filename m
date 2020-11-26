Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A5C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D79F21D7E
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbgKZQ35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:29:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40986 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391167AbgKZQ35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 11:29:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id t8so2046530pfg.8
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 08:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YpPNWLAEZvfDLmtn1UVmuL6TdVtdtW47XBHPkQR+4T0=;
        b=WYxit/hJ95u/BBuDJbNoWmFgv6ztl90D1wziBqOLg+V0zzNZWTh5Dhs2YN2eS9+GHK
         nDRID2EnIZrr8oXQinOxF3CXjatFRHrkIiSyP+DZKlo6RMZuSgRajgbCl/4V1I6k0dJo
         h7ohWOQyessUbGa3xJtYF/dWl5SrvhIblCwi/xw3sD1Ann7F0wBrnddifglbCbP5nVco
         /oC2AR4cKSAz5z2K5QRG2u22IvYyEQuuVjCohse06mU1FqpdGzxTL/veD40vHEEPJ8WO
         YWkjEavwZc7UQ8S3vmFtGBhLWAp2Zft2MIhwtplhksh8xVpmSeCWfzDssj+SYz6y39Zn
         i8ng==
X-Gm-Message-State: AOAM531fbxWUR5bugIKP1hptqWQzpYTVeIMz5gy5xI3o/iPx2jCbHAHs
        1pQ0aBqcvaDJKBLkGXT90A4=
X-Google-Smtp-Source: ABdhPJwcjvWooGLhPUWg+nuP5QqUyF064g2qmXXvKG8T7dlRDmAZv2RHTyExdgpeK28UpW0ddZaLRg==
X-Received: by 2002:a17:90a:6393:: with SMTP id f19mr4569899pjj.227.1606408196962;
        Thu, 26 Nov 2020 08:29:56 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z3sm446187pfn.38.2020.11.26.08.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 08:29:55 -0800 (PST)
Subject: Re: [PATCH V3 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-4-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <26365d1f-743a-4aac-57b8-3a542639c0f8@acm.org>
Date:   Thu, 26 Nov 2020 08:29:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-4-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 12:35 AM, Yi Zhang wrote:
> There is no cfq scheduler and new added kyber scheduler in lastest kernel,
> introduce get_scheduler_list and fix nvmeof-mp/012 srp/012

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

