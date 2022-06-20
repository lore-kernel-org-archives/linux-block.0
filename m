Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 00:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiFTAju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFTAjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 20:39:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868064E0
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 17:39:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a15so1649763pfv.13
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CXlFNhm5d5w44PULV8ieTtcznkhjNB6ps45VrxEErMs=;
        b=5F1UCGB8yp0R6S0JcSCPDIotiloCm/U+be33oVWId9878kvkoFjSAexhnx1k+0S+YO
         LxBLQPkCVwgR1AVWasZ+YlQUu+bR2W4EU0/7P8b7860KykRjKOnbKTPcJ4cYANtOUATm
         BhiCmnFr87R/Ug588LW9vhBMNqHxsCXsyB0vfEZAe2H1tEB0Y4kNIqINjjlSDxAUEXtB
         hGMRR9p2t3obA/sPgz08rEisulMKvfhStfXSUmzPBUPp4uf6TXBIY87FXJyUyF6v/xD7
         vOYdHYew26L5mqwHcrc+/nTYlc8tPpqmHIlo5RnYE5vgYcF5nuh20RqPT4q+3BYIfqYY
         X7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CXlFNhm5d5w44PULV8ieTtcznkhjNB6ps45VrxEErMs=;
        b=jE10OkdCWDCxDle/Q0HDgx1/IAp6Y/+Zo49LeGnmUuw4ANqHmPZRXhifwXW6TWJLDM
         /VN6RVwjgQXK/1Ni7Sx9B9pasTTNwIZw4MisxWCgaA6k0P9P6mZWjqoploAeHuIX3WqS
         PaQLU29Ka9zqzBWIl5pvYTX9kshDFiu6NylUNo3DmyWGXU99VSFUrhW5zBTCTUHnq3sN
         8P4+BpWC7ujfh/7+PYbnLCIrHcJRD/c4Ll2wTcGVhk1HYbDoG9fqlk+U9GygRnt/L2wv
         cT91auWGRKCPlyYhE1OhHh8aLyqWeyEvAjJTiYiRhIBIssnaqv1fFPKNuPTCFst5BuWR
         tpfQ==
X-Gm-Message-State: AJIora+m1jpMyx0r/05YbSzR81VM1RuiHSyneHQA0LTSFvGL7wuYm+9e
        pqq+S8eAhniteT6r+ukMBOpxG5WsHGV5QA==
X-Google-Smtp-Source: AGRyM1uk9oVjWhwOIe1IaTjlAEYhlsWYkLp7+va07T+dw371zarG/DeNM23KBiJMj3WL3W7U0wc1/w==
X-Received: by 2002:a05:6a00:2393:b0:524:eeb2:5547 with SMTP id f19-20020a056a00239300b00524eeb25547mr10601783pfc.8.1655685585363;
        Sun, 19 Jun 2022 17:39:45 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x6-20020a637c06000000b003fbfd5e4ddcsm2809323pgc.75.2022.06.19.17.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 17:39:44 -0700 (PDT)
Message-ID: <6fc62d78-a1f2-f585-bad2-b2ae8f4edab5@kernel.dk>
Date:   Sun, 19 Jun 2022 18:39:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: remove queue from struct
 blk_independent_access_range
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
References: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
 <3680d9fd-7543-7eba-6da4-04b92e49a45d@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3680d9fd-7543-7eba-6da4-04b92e49a45d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 5:29 PM, Damien Le Moal wrote:
> On 6/3/22 14:35, Damien Le Moal wrote:
>> The request queue pointer in struct blk_independent_access_range is
>> unused. Remove it.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Jens,
> 
> Ping ?
> 
> This now can have also:
> 
> Fixes: 41e46b3c2aa2 ("block: Fix potential deadlock in
> blk_ia_range_sysfs_show()")

I'll queue it up, was OOO that week (and week after).

-- 
Jens Axboe

