Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93407C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhKWQaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhKWQaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:30:22 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575DC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:27:14 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z18so28676489iof.5
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mFFmD9tFu4vNl/AN5enQrVPybOlrHNlciINGldzt9Nk=;
        b=u+g7S+MwycrGJlsCum8fLvJQ7AVjwRSoIgS0bh03MMC/DcO2+7YOXS3Oles+9wsJC7
         +F0NYh40PmNkKYEg4jwqpsgq5331GeOLmOrsU3qty1Ea5/4nkAYc3+DUpOlVEEr7vvdy
         SAQXavunoMKdfY6Gfb2umHlAKBiGj5uIE4NdOtqbNSOWMYAtsBXAQ7Mb1SO2E1Rp5LoK
         3BDquoroGV3ZN5AlWPf9Da72WgW5iCCjzkNpP8f6batP2cFU9foVcfKNzYFYj2qxSihT
         3ZupI/F5TBtSUuNTRl7/OKXf2I+X4PsQoi73Di/hhMkqPRqzuAGHKMWCxKBEhJuaLGjL
         8FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFFmD9tFu4vNl/AN5enQrVPybOlrHNlciINGldzt9Nk=;
        b=FGXwvB77IcN/2wmwuN5/MOCKt3UXqgZ9g8SG4NbESnA0nXjuereMCcaR91O9lxB4Pt
         BYDC19ifdeRL2poehrBDJJgb2OEFgL/lWp3BKd98+o4VR56PUQZqgcyqIKPck8R/6VUp
         H+125pxDttynIjdgDXiCUv4SD3ppKp7E1ohWf1nO/1/0cg6y0Gw0fuDlS1yyERH+0Qje
         WuiTXQyHrDSJ3XzS4utqF4zIUvoeq/uvow1ssA4cEz0hDG6I5FqejnLuxPfdG1Lzr48R
         TrdBrqkalt5QQBVd0jRV1OKa2D4SMPUXdNvpeTTrvlckZ+YL2TDn3stc3yGmezjWt9m/
         iW7g==
X-Gm-Message-State: AOAM532/QY4bc4TpHli2U6QyXECkiKcywC0gyj7xETsHwrd6z2Xb6liy
        5sWSOmg8QstJUej3ucP74pkAOagU3Q9ErWyZ
X-Google-Smtp-Source: ABdhPJzZ46/Kp8lRKe4/sgMqubaEVt0SHOGqiW+jKaTkwTGz+9L+6b27c6P2Ja2ArEU59X168KgWbw==
X-Received: by 2002:a6b:b886:: with SMTP id i128mr7601629iof.151.1637684833366;
        Tue, 23 Nov 2021 08:27:13 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s18sm6167721ilq.25.2021.11.23.08.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:27:13 -0800 (PST)
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk>
 <PH0PR04MB741653C525BD926BA38793729B609@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <47eb6b8a-4897-5132-088f-030df2f0bab2@kernel.dk>
Date:   Tue, 23 Nov 2021 09:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB741653C525BD926BA38793729B609@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:21 AM, Johannes Thumshirn wrote:
> On 23/11/2021 17:18, Jens Axboe wrote:
>> +	poll_stat = kzalloc(BLK_MQ_POLL_STATS_BKTS * sizeof(*poll_stat),
>> +				GFP_ATOMIC);
> 
> Why not kcalloc()?

Sure, can do.

-- 
Jens Axboe

