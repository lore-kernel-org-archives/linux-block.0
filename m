Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF892C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhKWRIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhKWRIC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:08:02 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D9C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:04:54 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id t8so12504103ilu.8
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gU05w3kSx4wBre7Zt+elBuWUOUh56yjF2waDvQGUzCY=;
        b=N/D4lOFZODOLUDIzmr1FmTzRXEs3zi/5zfkvjy1vNe12f04k0Ouqo7FtSz6LUO//y4
         XHqyAjkhVracOFrRz19zsbSoA/qSMG3aBybaoHGUHqitxftFwQs8EAQHw0ZcWGW/emq8
         GAlZ2AbRvZi4bGtLo2I7UyNfoMPddT4s/JuhfN5U000DHzwDix5/xCzCD6Chz876t2QJ
         UaR7QcF7ik0Bf24nmcmXgEfX4/Yfye+vQ2VWmukZxWq6ZL9BGBY44+UR0Jv9BDLfsdG3
         CxBmuLnXVJ4RZxcbclx5qGOJFYQwxSXSa8FtSnOkbRmLouCxtSgzSCoS+n3kny/vvxax
         CTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gU05w3kSx4wBre7Zt+elBuWUOUh56yjF2waDvQGUzCY=;
        b=0gMPZuNu2iyoANim3DbGogH/WfXKENvu8MhY7X/HJtqrqYSTnZRF2MRXXj/wi0DLjV
         EgsvwQJYm9uLNnjPamKNmoCwtfF4tV/+h/0HoP70lr3OyPMDzcbtI5bm9lnkJAP8JAGI
         0NCoWSwF24GS05z/Z32kd/uhGpnKioz5+ZUlcbBVkCS4cOGuFC93XJ7WrdIJErfy21z3
         fGMCORDOGnJdBbO+lmcJom90ebbcl6NbWiwfEN/qlg+fDqdTbN9gfhMqi8dvU4t81V1/
         V3pXts6Q4K0Jwf3ocW69fCMh/c5RYkMq/+X+BjuOG7C6LEXvui3PjZHpJSjXTE2SaCVm
         XvAA==
X-Gm-Message-State: AOAM532w0qRowr+UqORw+/Mg/fXwjo1/0mrCKHXY2UA93DOEavlfSzGj
        kGWtrO9ge0C7Rt1S5eG/G8Fibhu2ySzOohFa
X-Google-Smtp-Source: ABdhPJyK6kXmk5OesYm9ePx8XfOwC+7/xob9YPTtQREXm9FV6L5jCkEcs5mVFUTJuwFy81AOOgyyEg==
X-Received: by 2002:a05:6e02:106c:: with SMTP id q12mr6120255ilj.125.1637687092970;
        Tue, 23 Nov 2021 09:04:52 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z6sm9829009ioq.35.2021.11.23.09.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:04:52 -0800 (PST)
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-2-axboe@kernel.dk> <YZ0ZUJGilOzhF2k5@infradead.org>
 <56538fd1-ca28-386b-36ba-493399af1803@kernel.dk>
 <a2b73453-c38c-c951-58cf-b8b3ee3fefb7@kernel.dk>
 <YZ0dLq2pSZNUEMZR@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5eef9ae6-98cc-e373-1d09-465745f3ccd6@kernel.dk>
Date:   Tue, 23 Nov 2021 10:04:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ0dLq2pSZNUEMZR@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:56 AM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 09:53:58AM -0700, Jens Axboe wrote:
>> Actually may not be that trivial - if a thread is cloned with CLONE_IO,
>> then it shares the io_context, and hence also the io priority. That will
>> auto-propagate if one linked task changes it, and putting it in the
>> task_struct would break that.
>>
>> So I don't think we can do that - which is a shame, as it would be a
>> nice cleanup.
> 
> Indeed.  We should still be able to move the call to
> create_task_io_context into blk_mq_sched_assign_ioc

Definitely, I'll make that change.

-- 
Jens Axboe

