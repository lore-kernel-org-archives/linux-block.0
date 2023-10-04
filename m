Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C505AE7C4E9
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjJDSxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbjJDSws (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 14:52:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011BC0
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 11:52:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-351610727adso41245ab.0
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2023 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696445563; x=1697050363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+P1BMC6p7KesZ1QLneyQfNbStvb0j46CXO1yZ2rY9k=;
        b=OmCA0zH5hxz0KNLhV2y45fdtmnHIEkqhcpq3kvBfJllnNipxEubTY4JDcpv99ymcjX
         qT37VXm/Qxrq4/2OIizbFKbKGzNzqUJ92O1OCq8HGLeVVm3uFgOAH7bBP/yGTnsEZxEU
         O5admmZ7ICG3K6P5GlUTAVF8qeUqAQCEY3SSSk1424/jP/W+l8O1UXPpITKzIz7HoSEr
         u2jTeYwOGsDAIOD8AcmbwJtnUY2QdacMu8dGfi9S8ZzDaykZeGf93aogjjbtQrsymwE5
         CPkjsXWtn5cvVX3H3i8Yr++RQ33sbN1sbM00to5bh1vYpG4tpwL2Kh/G82KePZjBuUYM
         2HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445563; x=1697050363;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+P1BMC6p7KesZ1QLneyQfNbStvb0j46CXO1yZ2rY9k=;
        b=f5ot8Hw8XoVVUZFqrL7oHwlLRvUr65y23GpgXORiMhT2recsPiAPv+iCGAtX9GS9m5
         wFQX2WRzOvfACrhxIPUlMTSiehJTBVrj0cewM+hIkG30P3jEG6Ztjk0dy5bM3Lq1r0cL
         2hOO6RsVZVGsxHQF7WOKqHP1GSHpFTBD5E2OYfJpm/+7XyIMH4D16mWfkeGtzophXQvw
         HGiZDYBN4NihvB78SiqucqwC+3R1vdWQ0FUw7py7t8AS78dLxdJN5IGJu26RdgM3cmrx
         1sD6IYuJ998a218kLrqCwSi0N4Crx47URdUnRVp+J9BweRULnCqi3qkbrwN82+4QIuWX
         i3ZQ==
X-Gm-Message-State: AOJu0Yz2WJH9Fw2GFqmvvgCQK3Y9HXLM6FQEcSJPiEKoiyMCClueB7AQ
        eULKjzX7Ye7r3JOvfZZbmWypVbkxbFgvM+ecsjQ=
X-Google-Smtp-Source: AGHT+IETEG6pRPM9aDjlY3zLGtVT0VvyuqBH+JiMSjf/3mZu4Ua5GRk2AksYWgXqvA4Eu5+m/g9bzw==
X-Received: by 2002:a05:6602:2a44:b0:792:9b50:3c3d with SMTP id k4-20020a0566022a4400b007929b503c3dmr3746676iov.1.1696445563303;
        Wed, 04 Oct 2023 11:52:43 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gs10-20020a0566382d8a00b004290f6c15bfsm1138633jab.145.2023.10.04.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 11:52:42 -0700 (PDT)
Message-ID: <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
Date:   Wed, 4 Oct 2023 12:52:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in __floppy_read_block_0 (3)
Content-Language: en-US
To:     syzbot <syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com>,
        efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003b14000606e7f15b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000003b14000606e7f15b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'll keep saying this:

https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk/

but apparently nobody is listening.

-- 
Jens Axboe


