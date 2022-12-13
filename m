Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE4C4332F
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiLMPnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiLMPnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 10:43:25 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62F220F6
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 07:43:12 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so5156703ilq.11
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXxSM72W9e0OIdQsYVPE+ecsCo1XbRnSTgnn3KVjBxI=;
        b=ZX8X4qbhEiBJwa+FdGVbMJXcoBVXhL6FGklx9k9TimapOA/2TnlWPndMCNGYjLIW9S
         aRFEUkNk65xlXuboUEwO6Ssc7p5iOY6aV6sMSIkvqOVv8i+M7Dv5SqIDhlmttR34eccX
         PFjOr44B+OVHwcucO888Y8hSffqxBi71SliaIefD0Nb/x5c3HKuOIZEVEYFXeXCZue90
         vN1gj1nGdPj6LheG5/RVaLVjAZ8Wo+/TUULe6mX6FJbgjSivxLzAyVGKtco7I8jC1tsP
         8CslTn0mGGQugLo4bVHpHyDudEfZzC77arDDcRK8IFeoL2Iv49iw979Hp06Cx/99vNWS
         rd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXxSM72W9e0OIdQsYVPE+ecsCo1XbRnSTgnn3KVjBxI=;
        b=TwQ3na7gB9WY/WUTpfa+HnwvBZPsbGiJyd+cX2wkNF98BAzlWItASQAz8kfvAsrgLj
         QAfWjAR7vxDEUO81xwFOTSVb5XGf3taZKXMXlbwJC//8rzZZVlvVtTUMAIphe5/mK/8a
         X0pwzuDacILmFWCNhHhQBaViGHT56pq+LOQOjyEzCIS3Em8wCEfjVbkNjO1fuvzRw+Yn
         emXd1jNy28MVZuVqXwJW2j197t+293Q84GsuFQq788rmYZ6Wai3vsi5MnaoqEpverOa0
         vlH/ysN5Ho4X20jpFDPPBIHwc5MhMr9tVialJt4LHcjYQ0Ztv0QPR1TUbhl5bSuF0Phi
         Gl5w==
X-Gm-Message-State: ANoB5pnWPRVKxmUhMu7eH6wBcriMUHoeNxW+x2rErJKuMJmDMMOJHKBs
        rWXqbSwnpgQxLffR/u1wkyhQ7A==
X-Google-Smtp-Source: AA0mqf4hGcU1nJUCJa6dT7p8tsWAnDGqubxaYBeNS4WL/6cEURFeJLLze2oOnxogApSN2QYPQARbnQ==
X-Received: by 2002:a92:cd8d:0:b0:302:d99a:bfd1 with SMTP id r13-20020a92cd8d000000b00302d99abfd1mr3100857ilb.0.1670946191959;
        Tue, 13 Dec 2022 07:43:11 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d32-20020a0285a3000000b00389d74d7e24sm944516jai.146.2022.12.13.07.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:43:11 -0800 (PST)
Message-ID: <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
Date:   Tue, 13 Dec 2022 08:43:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/22 8:40?AM, Paolo Valente wrote:
> Hi Jens, Damien,
> can we consider this for 6.2?

No, it's too late to queue up for 6.2, even when it was posted on
Friday. Bigger changes like that should be in my tree at least a week
before the merge window opens, preferably two (or somewhere in between).

I already tagged the main 6.2 block changes on Friday, and the pull
request has been sent out.

-- 
Jens Axboe

