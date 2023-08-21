Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5CEE4996
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 02:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHUCgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHUCgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 22:36:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499EE0
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:36:03 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a85cc7304fso233613b6e.1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692585362; x=1693190162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hTwGHag5/BRbzBGzpXgGcaUnOGVdCVxbNkfxxYz9r4=;
        b=ExBjBbjqlttj3tmCSNc1Ep7ocgKs5d6HHCp+L1qj3GVaaNKJFL7HpTTZSDCRihnRjw
         pSW4jPCm+t+M/yXa6OWRSzSukofFRkFmv6Z12/uaiONlRk9lMSc++/b77cPOf+jMTVAi
         49hyAryBRSSXoAO7Po8S6qxctTJAEcNad1dKkbqRbQnMxlUb8BDdM/recPu1EYZBZ1kq
         F03hxKJLq/MHG2Xq4J02LOj3wqqiVaiYJDyUgzFRLm3fNC/w5Ia5BfOGjOjR28qXSIQE
         JzAC4oAn195LaK4l6E1tEv8EpivxcoNtvjSMgTQDeWqV67B2SpVLkNLsBiEYVBwqL18e
         jAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692585362; x=1693190162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hTwGHag5/BRbzBGzpXgGcaUnOGVdCVxbNkfxxYz9r4=;
        b=EHXpCjsjfU81eU7wcUgDDrkXqRjDT9eQ0gSWJi5uBVM9iSiMcj+b/Lu7ioilfzRL1O
         4sXliR3cSWr171m1kVOlQ6j6z/50SbSqJ7D0DrO2GvlJKR4kpW9ZvKfBe6qxT4qf83Sg
         j6hBQ+IbCroohFTp9Tlns68PSYrH/Cbrx6yD9ZbKTc/1Sw6N4Plr2nlnDYJIl9f9LhNX
         GsiiQFISMfFl/gCg4xh2Y6SD4ArQOrGQEDdWV+oH1f/zr6KzFbrZs9Zovxe1E0HTMpeD
         BecmWblNl47IANtMZM1Qt/2ZTeSqkRbNVyyl0AF0H1I9lS64z8115FJk52exGr1DDr1/
         7jkQ==
X-Gm-Message-State: AOJu0YweIdOwe9igCal2gjMshEGBhsX8SBHPbfGP77lePVyCnJWcBz1b
        c+rn8cQQcf7FrkYMXWlsMjN/DA==
X-Google-Smtp-Source: AGHT+IHrUa/J7IxM3FZfHbXQlO2+/+bKsIl90ob0YM4TPozDSL3dr0ujc4sy1ETEvWXG1F0Q+rwsaQ==
X-Received: by 2002:a05:6808:1448:b0:3a0:41d4:b144 with SMTP id x8-20020a056808144800b003a041d4b144mr7846072oiv.1.1692585362644;
        Sun, 20 Aug 2023 19:36:02 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c28:8d4:4968:8000:701d? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78d47000000b0068620bee456sm4961374pfe.209.2023.08.20.19.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 19:36:02 -0700 (PDT)
Message-ID: <f0c0937f-485c-d317-8bd9-b7d32ace4e1f@bytedance.com>
Date:   Mon, 21 Aug 2023 10:35:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at
 block/mq-deadline.c:679 dd_exit_sched+0xd5/0xe0
Content-Language: en-US
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
 <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk>
 <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/8/21 10:17, Changhui Zhong wrote:
> On Mon, Aug 21, 2023 at 9:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/20/23 7:43 PM, Changhui Zhong wrote:
>>> Hello,
>>>
>>> triggered below warning issue with branch 'block-6.5',
>>
>> What sha? Please always include that in bug reports, people don't know
>> when you pulled it.
>>
> 
> ok,I pulled the whole branch of block-6.5, I don't know which patch
> caused the issue，the HEAD is：

Hi, this problem should be fixed in the latest block-6.5 branch,
specifically including this commit:

commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

    blk-mq: release scheduler resource when request completes


Could you please help to check again?

Thanks!
