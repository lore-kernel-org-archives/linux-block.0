Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C7C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1513D2085B
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKXD3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:29:38 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38256 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgKXD3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:29:38 -0500
Received: by mail-pg1-f176.google.com with SMTP id j19so16200296pgg.5
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 19:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tk7+VHs3A54MHBNnCv10uKUdSrI/jE3yN5ABibRDiUY=;
        b=ik9tdeTWbjQDcrzI6nW1AATooKxzRfvrtB8u4MIb9G/q9qalPLaroj8AOtKKKMidFp
         ldG6asCi03Q7PXsW1ETZs7qBYNVB2eO71qjxDfMzcjPpgFV91DrxEbHcA2pjeiAsCqit
         u1+8NVS/EQtkevZZDrfZ/tE3DlbXojHw3qSBpumy3GZeJX9Fh52amQrugJnyzQcfYfsc
         RvJGtEGJnQT565z9err1ZWVrk3U7KLynKCcmF06EVSlWqhOKOeNQzTs/0XuArOb0Kfi7
         v/+rNdbM5+79EPQqoQn6b1Fsu/h4W3JjXmZBuhKC5DUK4sRl0mraL0tEGqL52xBKP9Oa
         Bv6A==
X-Gm-Message-State: AOAM531pbLAn/ygN9AFnQM6N2l2tZGiXJR6MWyWb1cM3WR40TIrerLn+
        3VklUESi1WCwJf12OimFEIQdgcHRAmQ=
X-Google-Smtp-Source: ABdhPJyKNuXF8srsElWxl86G5Fv8L7MJYCVGyM5K556Aqe/33OS8zCTCadCOeAMy+wSk8rwc6jhmFA==
X-Received: by 2002:a63:161a:: with SMTP id w26mr2058225pgl.17.1606188577594;
        Mon, 23 Nov 2020 19:29:37 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 3sm13007624pfv.92.2020.11.23.19.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:29:36 -0800 (PST)
Subject: Re: [PATCH blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-5-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
Date:   Mon, 23 Nov 2020 19:29:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-5-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> With bellow commit, the version will be updated base on the tag
       ^^^^^^
       below?
> fbef6555 replace SNAPSHOT with auto-generated version string

Thanks,

Bart.
