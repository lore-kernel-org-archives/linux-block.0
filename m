Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF578C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C754E610E5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJ1QZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhJ1QZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 12:25:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C26C061745
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 09:22:46 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y14so7482233ilv.10
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8e0IsOhbU7ovpKWfhWREwNaFxqW1k//feRyrdLC0qw=;
        b=pKHaUh4qjzsvVcEeqAcrXIbleMg7WHTkW9uZ2eVKWbosHHgzHsFB1SpCUwRI/6Dyrk
         uL3sWiQ2AYScBvcEjnvR6CzmR+Vd2BwMDQC2qS54WAZFJbEll7+IHwIn4Ky6f0xhStFX
         ludBEmW7df7oQF9JqyTD2lBp/ccxoD4dp2AE2G0ad/H6GcX2zKNZitVV3+G6hbm6BZxC
         7nPNOfjcrhazHMJbQOpbbCgvngRjSFyDkeVbkzdLMx5j8ldEOZYem8KpJZSrD0CQY1rq
         8IvJdbONG7eD0eNMCop/pR/8XNcHn0KHesRceVgkaxy4YFsJwNVNRF6+r7FnCE1Qpwk4
         03JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8e0IsOhbU7ovpKWfhWREwNaFxqW1k//feRyrdLC0qw=;
        b=hwT1wDQKiX1RxrP2qZQATgG8eiEUPYc6N0Y/ywPk+jrBPXqGlmbnwVBNyNNr88CTJ8
         578XjuWZ5EjJn18CD6MY7I8Hbn+xsLxjb6VEZu37IzVPLOXBk5y0/gHE6UxnytCjKTmv
         or/v6Lju0wty4wOsAiURl6qoI5kNC3f0Y6+pDA0dGbOFfpsni9m8UqRV4ad2WyxU+GV1
         gDA3fw/p9LiKcVM13mxHdQZz2HG3v4qiH+I3hjuO5aDQ3tWsVy5fdrvCvLIGDboXYZYO
         LfLqowX3nMMePRmf+mDy8f7BmFLIETYKgC6a9OCfgQIxOE/YjmHMGMbrH2KYXuJGCB4V
         iLmw==
X-Gm-Message-State: AOAM533eJ47U38VLvED3aAPIGucCc56gh2BAwcNxF30IXv0q9I6jXsAQ
        dQrmKBqwwMBj2J93vBFG6AUhjw==
X-Google-Smtp-Source: ABdhPJzOUWTVvLGtgqCwksROjSJoL0eaHPxiVTG8tSw5DRhQ5gKvKvHrIE+VHNdqmVdPfRlLeE4Lrw==
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr3913229ilg.79.1635438165643;
        Thu, 28 Oct 2021 09:22:45 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j22sm1991018ila.6.2021.10.28.09.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 09:22:45 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Mikhail Malygin <m.malygin@yadro.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Buev <a.buev@yadro.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux@yadro.com" <linux@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
 <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
 <20211028151851.GC9468@lst.de>
 <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
 <AAD8717C-E050-47C0-B8C9-119C8F51B47D@yadro.com>
 <14dcfef2-ac21-35a2-a97b-9cee39b079a1@kernel.dk>
 <64016c86-188e-916e-662d-b33431dec946@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc0dc601-8e5a-800a-e3c4-d2dfdabb96fb@kernel.dk>
Date:   Thu, 28 Oct 2021 10:22:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <64016c86-188e-916e-662d-b33431dec946@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 9:56 AM, Pavel Begunkov wrote:
> On 10/28/21 16:50, Jens Axboe wrote:
>> On 10/28/21 9:44 AM, Mikhail Malygin wrote:
>>> Thanks for the feedback, we’ll submit and updated version of the series.
>>>
>>> The only question is regarding uapi: should we add a separate opcodes
>>> for read/write or use existing opcodes with the flag in the
>>> io_uring_sqe.rw_flags field?
>>>
>>> The flag was discussed in the another submission, where it was
>>> considered to be a better approach over opcodes:
>>> https://patchwork.kernel.org/project/linux-block/patch/20200226083719.4389-2-bob.liu@oracle.com/
>>
>> Separate opcodes is, at least to me, definitely the way to go. Just
>> looking at the code needing to tap into weird spots for PI is enough to
>> make that call. On top of that, it also allows you to cleanly define
>> this command and (hopefully?) avoid that weirdness with implied PI in
>> the last iovec.
> 
> Reminds me struggles with writing encoded data to btrfs. I believe
> Omar did go for RWF_ENCODED flag, right?

Exactly the same problem, yes. It ends up being pretty miserable, and
there's no reason to go through that misery when we're not bound by only
passing in an iovec.

-- 
Jens Axboe

