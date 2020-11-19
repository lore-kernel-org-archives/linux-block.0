Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F2C63697
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265BB246CA
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy+N7YqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgKSSFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgKSSFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 13:05:55 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FF3C0613CF;
        Thu, 19 Nov 2020 10:05:54 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so9200960ejb.8;
        Thu, 19 Nov 2020 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I8YlP6nreAvmL8MScldYhcGN/Q30XtBz1qlt4mVpB4M=;
        b=Yy+N7YqBCCmrYk62BRCet2pmVmRKtnyWHowU/37J+xKAbxg+7XB/U9rtdCIZrUiLjj
         5rbHOHSkUnkS8iHwUBenvx6hRYftWdPKBgeQJsgUORpu0+h83aNwUP2SMtdoFhYL3skH
         04xLYJU+JDMOOG/F9fVbRXH2K0EIwZst4Qic8h9emSN3DzE+BpBZ6DjcdKgq/NIZf48X
         KnyUybrtfuukdTvd5VxCkKYpIYcKDbbPGTMUZzSnhlsYGwAokWZbEgH+wpDL1T7/OBiM
         jCkLbqgWN3CJShRZe/svs7XjVLSfMI12zXIaJVNdG2V9xx0MirAejVgNlSF4tDqEqtMQ
         3+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I8YlP6nreAvmL8MScldYhcGN/Q30XtBz1qlt4mVpB4M=;
        b=PHJrXPNO09a6C3uAxoTX0OOOH2bGmCsc7I9FT2CGHOipvKDjZFlJhv8+luxm7k10bm
         zyykE+7RPVBwFKlTSsdkJLLNW51w7QCXEI+llb8ma5BzZqcCpcD99cderDA0+mRauc9B
         RiLbK54icKPTCndypNNe5XOVyQFOlnWWEfJtY7O6XlttocYLc0llZN5WNfld4xgWeTst
         fXVRrgm8113XfEBosrXL23iAXz2gLOqB+XilOA56aiwlsOG0ERXAdatF2NLdfrkEQcIK
         xLBZ9nlaPESii7ssxfccfFovf/HvTBFyXBldupKC8xUsvCSjMW3jl6LUOJR6p3Uk4JZw
         uHpA==
X-Gm-Message-State: AOAM532jv/VOzQNqlROZZ+nCNffk+TqJixKgMnw9PVtpzhDuM0ZTP7Io
        AnediSv4cw7TlOq4b0HBWqq4Bjom+n6l9w==
X-Google-Smtp-Source: ABdhPJxzJv2Z8L5pVHCU4o74ZkY49anYM/C4aEGIKdJoyhu33XIdha0pSaaENUUwsdw0Cf3XJmANgg==
X-Received: by 2002:a17:906:86cf:: with SMTP id j15mr29951334ejy.260.1605809153230;
        Thu, 19 Nov 2020 10:05:53 -0800 (PST)
Received: from [192.168.1.23] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id u15sm114889edt.24.2020.11.19.10.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:05:52 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
 <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
 <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
 <72a1df1a-810b-5bf1-39bd-b702188a875b@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Message-ID: <bbaaf6fe-d456-a3b1-9f95-005e182eadfd@gmail.com>
Date:   Thu, 19 Nov 2020 18:02:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <72a1df1a-810b-5bf1-39bd-b702188a875b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/11/2020 17:20, Jens Axboe wrote:
> On 11/19/20 10:14 AM, Pavel Begunkov wrote:
>> On 19/11/2020 16:46, Jens Axboe wrote:
>>> On 11/19/20 8:29 AM, Pavel Begunkov wrote:
>>>> The first patch optimises iov_iter_npages() for the bvec case, and the
>>>> second helps code generation to kill unreachable code.
>>>>
>>>> Pavel Begunkov (2):
>>>>   iov_iter: optimise iov_iter_npages for bvec
>>>>   iov_iter: optimise iter type checking
>>>>
>>>>  include/linux/uio.h | 10 +++++-----
>>>>  lib/iov_iter.c      | 10 +++++-----
>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> Nice! Tested this and confirmed both the better code generation,
>>> and reduction in overhead in iov_iter_npages().
>>
>> Thanks! Did you find t-put/etc. boost with your setup?
> 
> Yeah, for this kind of test, if we shave 1% off the stack overhead,
> that directly yields an increase in peak IOPS. My numbers were close
> to yours, dropped about 1% of system overhead.

That's great. I was guessing how much of it can be due
to not cached bvec and was just tossed to somewhere else.

-- 
Pavel Begunkov
