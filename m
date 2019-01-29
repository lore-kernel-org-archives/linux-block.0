Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A517C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C752183F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JNWbKC1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA2AcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:32:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AcD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:32:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8780696pfd.12
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 16:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kka2Xjewfy19rlqTl2ME1+nqW06Svw7L2aqwjtMISwY=;
        b=JNWbKC1ZeB4rQpxI+G/ZjsK+eNIHsali93ga76Q6NNFS5Lx+whGCVpbo25JxCPtwao
         lozkBtITG+KnfKfpUUZfUSzE4bxygmkHYg6dNUbPPtA/nK5YQpEsfYX02TQ7SBoZK+71
         Syo9UqoKQEougp/h7OagoFl2ZnyrHj4g/On0OwbQwsDo0lTSdzoETdGChDZ0Mc2STTSs
         3YwFriLRmdqk3W+cQN8SZQxz0k9MPGK5U3bCfHDrL/Vt+5N1AJhkXomGxjmemll/R9MO
         VKjtLFgLgjUL4Ivv9sXkgOPotsoBXKDqf19jiONdxAeXmucXoGJj3P06CxNOsFOYpEuU
         LVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kka2Xjewfy19rlqTl2ME1+nqW06Svw7L2aqwjtMISwY=;
        b=qdfjVCfmWy1c1XieLdBqHp5+DfshfGkq8CSntWrIz5jVqCSyP4RmGpK8RAf5dIaYyv
         xPL/1j3ajjP+IPuqFw7Yj/XhK6cCtIzif0LCB8tl2JiEFxdfYsi5/nAQx2IwQarIRhuO
         MAfaMEwFwL39mJThh7/EdoEWpbu1QvmTS8c6ZN251cPRaALlMhvU4+Oxj+Ob+KB4Ucb4
         BJQ9zpqrxsATXcFtd/0mkZd73sQY9ofb3hD8W1FxRjCu27UhtFO8td5opHsomfB0sdqr
         MhrqbcldOBraVHaXj+zePYfKMujZUXnF6BRH6ib0sHSWDb2IZ0pZ9qYx+PKtF96VOQnr
         f+5Q==
X-Gm-Message-State: AJcUukc7JR67Mx09lTIv/kzOz2dEjAMzc9SWzCax5WyJcfPutdhTzw5k
        JvkKM/Hf3ox2v0a8oUOOltJWWw==
X-Google-Smtp-Source: ALg8bN4a/YvIAuVBgBGqo4ZsfJwZtLtSW6l4ZnA0ZIvwBJAjfYFSl8t+c8gC9UR67tCiOD8HupT8DA==
X-Received: by 2002:a63:6984:: with SMTP id e126mr22076905pgc.143.1548721922212;
        Mon, 28 Jan 2019 16:32:02 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d69sm54653576pfg.168.2019.01.28.16.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:32:01 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk>
 <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk>
Message-ID: <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
Date:   Mon, 28 Jan 2019 17:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 5:03 PM, Jens Axboe wrote:
>> But you only do that teardown on ->release, right? And ->release
>> doesn't have much to do with the process lifetime.
> 
> Yes, only on ->relase().

OK, so I reworked the files struct to just grab it, then we ensure that
doesn't go away. For mm, it's a bit more tricky. I think the best
solution here is to add a fops->flush() and check for the process
exiting its files. If it does, we quiesce the async contexts and prevent
further use of that mm. We can't just keep holding a reference to the mm
like we do with the files.

That should solve both cases.

-- 
Jens Axboe

