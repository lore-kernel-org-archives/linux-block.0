Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE2C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A8661220
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhHXQO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhHXQO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 12:14:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB4C061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:13:44 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r6so21012887ilt.13
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fL6M5M+ZQf9tkzwQfSg/E8Nzzkt+d6QKhAddz9kDrLw=;
        b=QcKBXjqgCdKIog3MSnLBEtFgC7Wtxz1vqnDq+Kg/nmaPgFNTeKoHg/Rw36MZwZxDsO
         bgnvECrfd7y0aueCtNDQORvsMR6E7ZNWgrNC4Ak1/96SZapOFioWMy+GjU+TOvMpjzW8
         oXSfbc2wyUOXtmqinq+5F0hI2Y5MaHIDTXI8+u9tKF/nXyTjO3dvnN2FsGbAMzXNG618
         ACEvUwvW/09lqao3vQAs/FmpA0esnExWHoRi4cplCWqNdZ8toZuQTVaZc8fNE8sHg2ur
         pvdL+XTo70hfw2gl/Vy2ZKo0prnI0cdU4umbwKUkWeHFM6uGBhYjDpn+NBQ3M7RyXmwv
         1CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fL6M5M+ZQf9tkzwQfSg/E8Nzzkt+d6QKhAddz9kDrLw=;
        b=pnZScH8AFJutG2dBznbLxbhfyaaMzHCu9pR5LTuOPDiAmzFBnZRI0s0K5YhJA/gBJ4
         WMuTfJoGeC/N21felITKbKIcOqULfwR0EiqfQlxdEr8wzVo6flmofmIDPkKALhK7Sy3l
         1qMIwD/BR5PmIorRYd/mv6hkpkqV/kDZXfnRWJ+dQ/ihJvMbbsCKOzQoX/sfifwXY1pP
         i+b3o0eD3m9KKFyytzy69KR3WSlsMn4wRjdnRXfDe6l8Zs2624PuZMjrvpEvNdmavvn1
         ukfzMlXVywyHcDM+eoJSKdnR0pu8T6qO2vfd5Pl68TZtE0BTFLAUuRSSsPf45w3dN5SX
         0E+g==
X-Gm-Message-State: AOAM5339VI3ATpRp9nfBIz9XRfdldLz2JQi7V4JAw3k5kVJTlDzWJ/hO
        hdrhQN89l/e8CnRRfApZO2AWjQ==
X-Google-Smtp-Source: ABdhPJziirSX8gjQLqc3AQRcQQHS7PUSqIE4ljRCP8jio00Kp8Ixuj1HbGq2QsL38XhoQ4k5UcHqZw==
X-Received: by 2002:a05:6e02:1044:: with SMTP id p4mr26857255ilj.227.1629821623851;
        Tue, 24 Aug 2021 09:13:43 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e1sm10224562ils.76.2021.08.24.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:13:43 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210811110505.29649-1-Niklas.Cassel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15e827b8-5bf9-eed4-7358-80f9e2a7766a@kernel.dk>
Date:   Tue, 24 Aug 2021 10:13:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811110505.29649-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 5:05 AM, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
> BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
> CAP_SYS_ADMIN.
> 
> Neither read() nor write() requires CAP_SYS_ADMIN, and considering
> the close relationship between read()/write() and these ioctls, there
> is no reason to require CAP_SYS_ADMIN for these ioctls either.

Applied, thanks.

-- 
Jens Axboe

