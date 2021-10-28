Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC7CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C72E610CA
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJ1Pwp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJ1Pwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:52:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D713C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:50:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i14so8654705ioa.13
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gv206wq10izBicMmNVNWEu1r6cOt3xOF+MaWt93swOE=;
        b=Uks9kBp8qFyK43vHtVDS1vFYP8PJbRI+GxWJWrD7AGPYzMnvsohGVWdl+7RntAArQ7
         7syreJzT7fUrH9asi6zMNJVHfJdAXBCPn0mZp/TYaan+bKr3b1unxYorI6f7ns/fNZER
         /hEkSzDrTv+BsrIf8SNzLICrN0uMH0eWgNrZTPmUcwtErpFQYmU0GJIKaPI0Bmztm9Lp
         SxxMZgop+JrPUtbOrmOVerWB9qkawVnLqtkVd8yFumzZRJDrVFz/rJG7AJigQOj5hs4/
         +kD0ANnGmGPilNybmhwet6CgFHqwUiZhFhDHLiRRTbYWFZTfUsQETCvjopK1Xieytiqe
         5RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gv206wq10izBicMmNVNWEu1r6cOt3xOF+MaWt93swOE=;
        b=bbsCSpH3VX7Fh77STumhkf5vKLfjOKAHWXyztLMA2hfaDEEdO8eafgjcB3y/2JqquA
         35p7am/2NmAsEbjkZlrbpfyJMoFoPTs2PzFDDnkraSx9icmTZBU2Q7Tj9NGo0wVZFjm9
         hPszycW5lMeaK+WVddzGnAli8WQ4K9RIi606SnhI8ZBUm+Mn/1nMq2BNwh0jTvFPR+zk
         qLOKkavsrw2r7ac8cCVGOS9QW8OBI28DEkTkf3iCeNmOib1ObQN3ukmVuAFS2QXvqvqD
         0TQ+pMrpdlH2c7+zMhqQ1n538FikD9KeZxRUDtVXG37E97w6kid/FbHsgR7VdQUKBoit
         o0KQ==
X-Gm-Message-State: AOAM530dKHKs+DklK0arS47F1cup1n7hbZIi7IRDjF+LY8RoDruLZkKY
        rtqf0FM+AVHFVYYbp/ft6VVBNQ==
X-Google-Smtp-Source: ABdhPJxwfkFBAugfhvM7VXlPL2ZF6HWgBA+VBdoibrE//HyN5dPVm+kPbyNA+OhekLijj7ReOkmFQg==
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr3937078jat.106.1635436216443;
        Thu, 28 Oct 2021 08:50:16 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f20sm1177874iow.15.2021.10.28.08.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:50:16 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
To:     Mikhail Malygin <m.malygin@yadro.com>,
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <14dcfef2-ac21-35a2-a97b-9cee39b079a1@kernel.dk>
Date:   Thu, 28 Oct 2021 09:50:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AAD8717C-E050-47C0-B8C9-119C8F51B47D@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 9:44 AM, Mikhail Malygin wrote:
> Thanks for the feedback, we’ll submit and updated version of the series.
> 
> The only question is regarding uapi: should we add a separate opcodes
> for read/write or use existing opcodes with the flag in the
> io_uring_sqe.rw_flags field?
> 
> The flag was discussed in the another submission, where it was
> considered to be a better approach over opcodes:
> https://patchwork.kernel.org/project/linux-block/patch/20200226083719.4389-2-bob.liu@oracle.com/

Separate opcodes is, at least to me, definitely the way to go. Just
looking at the code needing to tap into weird spots for PI is enough to
make that call. On top of that, it also allows you to cleanly define
this command and (hopefully?) avoid that weirdness with implied PI in
the last iovec.

-- 
Jens Axboe

