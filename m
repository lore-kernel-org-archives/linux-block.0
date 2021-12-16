Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 17:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbhLPR5s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPR5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 12:57:47 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A1C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 09:57:47 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id k14so1037510ils.12
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OrjI5z3IkdAEJWz5PpqBf3hbH69U0UTIntyktbsjdFc=;
        b=OCs1DhRzFqvhWKKKVXUCWXlENPf6X+N1rw6mTERxitQYYbziHKClnSn+KjFbXfTV5k
         lkIzHWAy+8xEEFb70vSshpRRVW9lv+3W4v8UalcRuAtC2AcjPj95Mg01HU2Wtv/ZrEhU
         B4HGNmHZO1mHs02b8E4+RCQV7FwOJYvlteea4Y3lqoxktxO0tN5pYvws7wlse60VcYOe
         qTP/GeTaGQ8ZAq9afQlI9FN4cwB4TbZHDJrFAe6KeDG/VLZB0TRJcE1E5+3+SDZFn8tO
         JYArDVGGgtyWQmRqxLwp8c1qEBLQltK5uDUneWqZIMcGaybRmgwFxlZzZwNsmimKr9oS
         CW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrjI5z3IkdAEJWz5PpqBf3hbH69U0UTIntyktbsjdFc=;
        b=vjT74EuNVxUy1HAajmqMAtSRpfpN2eHN/oOfY4sg7UnbK0SleGxlnrgV050uq+Uou+
         o0YwUu3OYAK9qH6izgAiVkrnhc4n9Bz6B0EMRYZTrCbzr/C64t8L0+HA4xXkmmQQoBNl
         pBbBzWAQT1HrYeKOxoTp9QkmP8+FF3AAjYR7+n6f2S5SOpD51X9s0Ltj9NcVWealDRQo
         qNQLCsn0B3A+4XYPo0LH8YD25gDt+7HCmSmKpUnIWLzjcLfoigyBqEMAjTM9N36T5a3T
         +dZpKK6d0cuc8v/irAj5MftjLJkrMothQXVDDcaIic4gZYuoe067tWbAIdWoPf7Uh3uO
         tY/g==
X-Gm-Message-State: AOAM531ytxoRsfdGIa7d1qjG8eYHJxjeqA4w96hhttZmaAumwET4xtw1
        PhyaIEumeEzqE3aqdprKDwajqcGtQjKUbA==
X-Google-Smtp-Source: ABdhPJxHOE2poXQfoUCldE8NigPUnEvqF/Z7F+0wqYILZeB4Xrr+aXL+h+XvGUzK4cdxvywsuzXJrQ==
X-Received: by 2002:a05:6e02:1a65:: with SMTP id w5mr10083337ilv.57.1639677466676;
        Thu, 16 Dec 2021 09:57:46 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f21sm2993180iol.42.2021.12.16.09.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:57:46 -0800 (PST)
Subject: Re: [PATCH] block: remove the rsxx driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com,
        linux-block@vger.kernel.org
References: <20211216084244.579641-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae267aa1-1346-1244-a21d-50a6a60d21fc@kernel.dk>
Date:   Thu, 16 Dec 2021 10:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211216084244.579641-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/21 1:42 AM, Christoph Hellwig wrote:
> This driver was for rare and shortlived high end enterprise hardware
> and hasn't been maintained since 2014, which also means it never got
> converted to use blk-mq.

Applied, thanks.

-- 
Jens Axboe

