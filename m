Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F1C77B6C
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 01:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjDCBYZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Apr 2023 21:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjDCBYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Apr 2023 21:24:22 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625D10F5
        for <linux-block@vger.kernel.org>; Sun,  2 Apr 2023 18:24:21 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id m5so19738633uae.11
        for <linux-block@vger.kernel.org>; Sun, 02 Apr 2023 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680485060; x=1683077060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kULG8pOF6j41wBUUG8M7GoBq42bx2nu3Fa8BgwSuDdU=;
        b=w6QYMAq5WfJF34MdtpGxNWUC0NcVfmexz/ogm+B3xa+j/KT53oyCFtSwoAFqy75O8S
         SLkSX7yO5hceO65ypFmlIim/+63eK270bPnUCKvIvUMYAsQZRj9cg98h9n3H15HS0JmO
         5e6P1GFjDF9FrC16/pt4gdCwXLRpI8sCIzrUuOqi62nWV1dXY7U4xpnFlSUA6G9gzWvE
         EvN/O48F8MC9Y8TpzJzIDNep8JmJI0vYiP6zPePW9/ZyK7kOnzewmx1ZjnINP/Dp1Br7
         8M6lRi93gZRIC8a/NoHuWdsrC4kYI4CETrXKWAf62b7sXw8Cl6eReqYri85Vr+1fzlbo
         6AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680485060; x=1683077060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kULG8pOF6j41wBUUG8M7GoBq42bx2nu3Fa8BgwSuDdU=;
        b=qjpIdIs57cc+gAdES1pop00xgAvjZtGXhSQKYp61tPUeqMxRFqBEEnwOf2APMuBbv9
         Q3LKJCv4wajCvVK7yJvrS2ZS89p/fge39Xd0Li9nNklOXrdDyD5FDlEgYqmSIpKx0kKm
         +TstsrYPvi01VQYqwazM189kjYtJAF15efR/pPBAQaRIHCBpJTelXwXZpVZOI39StvGd
         qA1EsdfXF3dza+FiK2zc9m6uQmi9NWYuPvj6NJ8pxiUAhNOjUbTE52igtskhpWCgfLmz
         13mkbJACrybfncFz+4H6tOguQZ4nWBY+X99bZmg7nmDwco+KmmwBk7ogus1rE0TjDuJD
         rWOg==
X-Gm-Message-State: AAQBX9ca96D3OvIQrjaIHD+k2kFb8KfNbDj/DDZriMrRJARZYJd0iyKw
        NnhyEtRfqub8Yg6Tvx7GT7rjNQ==
X-Google-Smtp-Source: AKy350Y8HDkSQ9k8o6/USFC6zFiQL0UZiO5UVSROZXiQHuHAECMHgp7tYuYe5YFVf+tnoKC2scpQ0A==
X-Received: by 2002:a05:6122:169f:b0:436:1d1c:ebe6 with SMTP id 31-20020a056122169f00b004361d1cebe6mr13820021vkl.1.1680485060276;
        Sun, 02 Apr 2023 18:24:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g7-20020ab01047000000b0068e4f0409eesm1625369uab.23.2023.04.02.18.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 18:24:19 -0700 (PDT)
Message-ID: <d696eb70-9dac-9334-7aec-1b5af62442e3@kernel.dk>
Date:   Sun, 2 Apr 2023 19:24:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 00/17] io_uring/ublk: add generic IORING_OP_FUSED_CMD
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
 <ZConr0f8e/mEL0Cl@ovpn-8-18.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZConr0f8e/mEL0Cl@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/23 7:11?PM, Ming Lei wrote:
> On Thu, Mar 30, 2023 at 07:36:13PM +0800, Ming Lei wrote:
>> Hello Jens and Guys,
>>
>> Add generic fused command, which can include one primary command and multiple
>> secondary requests. This command provides one safe way to share resource between
>> primary command and secondary requests, and primary command is always
>> completed after all secondary requests are done, and resource lifetime
>> is bound with primary command.
>>
>> With this way, it is easy to support zero copy for ublk/fuse device, and
>> there could be more potential use cases, such as offloading complicated logic
>> into userspace, or decouple kernel subsystems.
>>
>> Follows ublksrv code, which implements zero copy for loop, nbd and
>> qcow2 targets with fused command:
>>
>> https://github.com/ming1/ubdsrv/tree/fused-cmd-zc-for-v6
>>
>> All three(loop, nbd and qcow2) ublk targets have supported zero copy by passing:
>>
>> 	ublk add -t [loop|nbd|qcow2] -z .... 
>>
>> Also add liburing test case for covering fused command based on miniublk
>> of blktest.
>>
>> https://github.com/ming1/liburing/tree/fused_cmd_miniublk_for_v6
>>
>> Performance improvement is obvious on memory bandwidth related workloads,
>> such as, 1~2X improvement on 64K/512K BS IO test on loop with ramfs backing file.
>> ublk-null shows 5X IOPS improvement on big BS test when the copy is avoided.
>>
>> Please review and consider for v6.4.
>>
>> V6:
>> 	- re-design fused command, and make it more generic, moving sharing buffer
>> 	as one plugin of fused command, so in future we can implement more plugins
>> 	- document potential other use cases of fused command
>> 	- drop support for builtin secondary sqe in SQE128, so all secondary
>> 	  requests has standalone SQE
>> 	- make fused command as one feature
>> 	- cleanup & improve naming
> 
> Hi Jens,
> 
> Can you apply ublk cleanup patches 7~11 on for-6.4? For others, we may
> delay to 6.5, and I am looking at other approach too.

Done - and yes, we're probably looking at 6.5 for the rest. But that's
fine, I'd rather end up with the right interface than try and rush one.

-- 
Jens Axboe

