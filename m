Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1261C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9095460F9E
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhJNPgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJNPgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:36:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E4C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:34:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k3so3973405ilu.2
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tmIUuuys3EqDDnLNInqbAFmzcI54reuyZo8XCnu/YDc=;
        b=2+hGZxqYDYUp7XyoPLbq5U+sEuzrjBfLAJsSR9OOz0kFGzVSgc7IMoQWxRNzIM0uNZ
         UTD0TQt8swp0ACDVNOeHUiGmr7DHRWmAwdtPHQD3UL0OCOv1m+QXYQy+hvclEolyGNTp
         kk71upji5RBUmFHFqMZF9sEGBo+TSl+UGsVZafBFR1Rf4pCRNxBtntOEIVhAhSkh86DQ
         tCngCFtcdwGZg9mAySCvcd6ifG8RZ4uT6bqvDvFE81tA8AF2fuoR7X0xDVG23uEgvQuq
         xwSqdOdCcmH/SsWsAVUzDiCopOgzEkjMMydUbwRlGRLOaaWcmbcKVX/NBuwRB8oMaPgn
         sbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tmIUuuys3EqDDnLNInqbAFmzcI54reuyZo8XCnu/YDc=;
        b=tDjckOfluD6ZfAR6qDDw/3o+vMRCQ5EctVVQK0/kdKH0Q0WaCV3gICRo9XphwBvNGi
         O93zbpSGi+durECuhH31FHEqQZcR+8ncnxeOhJq3nSrdEF3wKrr/RDGrFDs5uyUOaBnQ
         zZ4JeATLrYamGf3MIoGNS1iAnJBYiXCIjqrPrZuYV0j8Vy6ZkLujEXKuHNVaP12ZQTVT
         Rvu1ZVOj9buk0HgyaX+4wS22n/t8O+L9B4w3N4GK8grkLCeWgZReSG30ugQow50RYykS
         cINn7mSLNp8Nz7t2xpI6zJM9rE55rtH26ORLwQs9NpkP4XNdE2dNSrrt2qeexj8KLA3P
         cuJg==
X-Gm-Message-State: AOAM532FfX53feko+bGQu7bU7LB2ZmWfPSUlxFD7eTqgL3p1I3Aky8ph
        Cbx4CjUVkBi0k/TBUSSt4vN2JPw3DmcSgw==
X-Google-Smtp-Source: ABdhPJw1V7DdsRw4JuxkHgInqGa8SnmFdFiH4/Bskn13I3z0yeU+GGBlpKV+VXKjhXoLp27mFx0oCw==
X-Received: by 2002:a05:6e02:b2d:: with SMTP id e13mr3025053ilu.113.1634225674435;
        Thu, 14 Oct 2021 08:34:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r11sm1394978ilt.83.2021.10.14.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:34:34 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-7-axboe@kernel.dk> <YWffkZ2w/mhcJIAU@infradead.org>
 <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
Message-ID: <7a4b2e21-8bc7-df32-87c8-37e7055a8ad0@kernel.dk>
Date:   Thu, 14 Oct 2021 09:34:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 9:30 AM, Jens Axboe wrote:
> On 10/14/21 1:43 AM, Christoph Hellwig wrote:
>> On Wed, Oct 13, 2021 at 10:54:13AM -0600, Jens Axboe wrote:
>>> +void nvme_complete_batch_req(struct request *req)
>>> +{
>>> +	nvme_cleanup_cmd(req);
>>> +	nvme_end_req_zoned(req);
>>> +	req->status = BLK_STS_OK;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
>>> +
>>
>> I'd be tempted to just merge this helper into the only caller.
>> nvme_cleanup_cmd is exported anyway, so this would just add an export
>> for nvme_end_req_zoned.
> 
> Sure, I can do that.

That'll turn it into two calls from the batch completion though, so I
skipped this change.

-- 
Jens Axboe

