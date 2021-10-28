Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A2F610E8
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJ1RP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 13:15:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93767C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 10:13:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z14so11446820wrg.6
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2fMEsgtKVWBhqxXGHFDxjFeTChf8uE0bg9spoHkMsuA=;
        b=g9uvR19OV+sKKYZFMKoj8YAJtBsmspZ/4i8AaZ/Wasm3B7tQ3cKDSyA1sf13CFjG/m
         4yW/FhwFDnoR4QitGCa96uFThbGT/Ah0oNVU9N+4ChWlTx6ji7H29ShOQHt9rep4CmQJ
         rACvLb7hePZ0cmBb0LNaE+NKia8ixkKzNyghRSLK8RK0NycbKocHzm4iyK2jclExGSXQ
         9xVvfyO9hNJBY/iQYk+SBwo3ANR132cNZB3C1IXXyNmKz7LENMvkQlvwzmbdK8l98lGl
         c31lQ5q+CmKxICObt75L3LJAOhya7hVEJzNRtiMD6Um/RaD12ARheJ04WstJmHkTcuvo
         kb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2fMEsgtKVWBhqxXGHFDxjFeTChf8uE0bg9spoHkMsuA=;
        b=1hCtNKz3V3C48us75NQ6ezXkZga4P5rM5ZlhNY2cuMgQhEH9CrRRDkGFBVlwC8lo8M
         0/tvN9yLvNG8363XGHOBFhgLDIUmoWGu9/zdAcGBg9Eil89u3zdajVjXckXrM8ZkDDyw
         SnuDgzIX9HES7B/ABRRU3KIVScwKj7cyzJCwJwwUTJm5uKrj7FBYJ/kC3loEApVn/Bj+
         I/7Q3eW23QyBHuuLTH/03dOJIZTILSQEV/2hqqZyN3Zu0ro/L7JhfsW/xpoAgv1ucogV
         qL+ae2UFQVkrGkklXEUxrxOKGrtDXJXyybJzMyHqsFUlzVGtGar5nAv2Uym8YYwX53G6
         y3Pw==
X-Gm-Message-State: AOAM532jBAeBBVLHb9my5DUyPvpbsGjTSyj7Mu3Gon2/QiubfXie2HaQ
        YUwIt7ArB2BzTmj6F1lvyeU=
X-Google-Smtp-Source: ABdhPJwv4irYqovI5zq+W1LKpTz3VqatKOBiCyNdCSVJL2P7pBxQVb1+cJkLOCVvnIxamh4o30bDcA==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr7603110wrf.258.1635441207219;
        Thu, 28 Oct 2021 10:13:27 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.129.16])
        by smtp.gmail.com with ESMTPSA id s3sm6589150wmh.30.2021.10.28.10.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:13:26 -0700 (PDT)
Message-ID: <e44e0928-bc01-06df-4bd7-cb120efeed50@gmail.com>
Date:   Thu, 28 Oct 2021 18:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/3] implement direct IO with integrity
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
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
 <bc0dc601-8e5a-800a-e3c4-d2dfdabb96fb@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <bc0dc601-8e5a-800a-e3c4-d2dfdabb96fb@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 17:22, Jens Axboe wrote:
> On 10/28/21 9:56 AM, Pavel Begunkov wrote:
>> On 10/28/21 16:50, Jens Axboe wrote:
>>> On 10/28/21 9:44 AM, Mikhail Malygin wrote:
>>>> Thanks for the feedback, we’ll submit and updated version of the series.
>>>>
>>>> The only question is regarding uapi: should we add a separate opcodes
>>>> for read/write or use existing opcodes with the flag in the
>>>> io_uring_sqe.rw_flags field?
>>>>
>>>> The flag was discussed in the another submission, where it was
>>>> considered to be a better approach over opcodes:
>>>> https://patchwork.kernel.org/project/linux-block/patch/20200226083719.4389-2-bob.liu@oracle.com/
>>>
>>> Separate opcodes is, at least to me, definitely the way to go. Just
>>> looking at the code needing to tap into weird spots for PI is enough to
>>> make that call. On top of that, it also allows you to cleanly define
>>> this command and (hopefully?) avoid that weirdness with implied PI in
>>> the last iovec.
>>
>> Reminds me struggles with writing encoded data to btrfs. I believe
>> Omar did go for RWF_ENCODED flag, right?
> 
> Exactly the same problem, yes. It ends up being pretty miserable, and
> there's no reason to go through that misery when we're not bound by only
> passing in an iovec.

I agree that a new opcode is better, at least we can keep the overhead
out of the common path, but RWF_ENCODED was having similar problems
(e.g. passing metadata in iov), so that's interesting why RWF was chosen
in the end. Is it only to support readv/writev(2) or something else?

-- 
Pavel Begunkov
