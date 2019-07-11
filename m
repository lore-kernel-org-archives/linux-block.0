Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA8C74A36
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 01:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B3C20844
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 01:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgPpxHNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfGKBR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:17:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGKBRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 21:17:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so4374568wrm.2;
        Wed, 10 Jul 2019 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFkC/Uucw0aZjkYFDU2AiSEc++d077HkZhSnsHwuQJA=;
        b=LgPpxHNXNGjpkdVJSGF/lZR7UiSRyDpu9LdwPOPohD7wDA0OkqnrzC51ekJs+BKA+5
         N0/s6+z21lkTCdn73Z/AkGV7tJD59VyjMg5AYl6J6Tz6zUvsAZYAyY2Bap/UVKAXOIku
         YbovaWTII/e8T4iviNJ6LCWfvQrgiobBtLfCC+feKRrJKNpOjt1MnzqJXIA2oRX2LnQp
         jJr4OCnavCx4l0tVWwtfSlUymHPScLQlrUho3aSByx1HPGnC6Xo1EudtE8uuRJUPmRUE
         bdbDqlw1l3oqX3+6F/ngujHL3Q3DrIZu9qI4fsFLUTCEIpe0QcmH3Eci1qUzYM7Mh3k8
         9/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EFkC/Uucw0aZjkYFDU2AiSEc++d077HkZhSnsHwuQJA=;
        b=KK8w+ZCxdVjxThYupe5tA3DqP08VDlRN2TxHEGunIaZoS24KNXWU2l5IfL9HCaucKA
         YSLHYn1bErjgC4/hKuVdO2mQFSCGUyMdGMBArkUuI5r5k8r2sSbVvMK0xfO75zkUQz1u
         LPoBDEKExualcIPAmhP5SBTx/qmAInagKJdfDbG5kktmgFSct4hGRIJg7gXtosjpp2VP
         ma00p2QUuVN3XSwZCafppKnQ1bPQmbI5CCJ8TvVj1QQmVk/dZJlWaykyWqptzg2d3AtR
         FzihyGF1Wu9GQMNuNKBLZrmCruWCr9xgj8Fy7sylrzH6Gkcw4OfcBadfbQA2n7UB13U5
         pTKw==
X-Gm-Message-State: APjAAAV50a+S9t+dtF3kTjqajKz47FjN36M0zJ0AaMYRxMAXS+fEiEtY
        Celh8SGs1PpI7vW1JyTOuEA=
X-Google-Smtp-Source: APXvYqzN/Q+dDgqoOO0srwJykdx28KV9Ue3b8amCBEmXaz4Q9uFOeMh1bbMNhkS1BQeCv7YwL63ikQ==
X-Received: by 2002:adf:f851:: with SMTP id d17mr515509wrq.77.1562807872544;
        Wed, 10 Jul 2019 18:17:52 -0700 (PDT)
Received: from [192.168.43.145] ([109.126.142.165])
        by smtp.gmail.com with ESMTPSA id s25sm3496915wmc.21.2019.07.10.18.17.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:17:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dennis@kernel.org
References: <cover.1560510935.git.asml.silence@gmail.com>
 <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
 <054f3ab6-0a03-ff0e-ac46-5d0fba012cf0@gmail.com>
 <226043f8-4dc6-1ad3-7c66-8d85312f4cae@gmail.com>
Openpgp: preference=signencrypt
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
Message-ID: <ac0700a1-0984-417b-d5d8-35c4ba56f6f6@gmail.com>
Date:   Thu, 11 Jul 2019 04:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <226043f8-4dc6-1ad3-7c66-8d85312f4cae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Any thoughts? Is there something wrong with the patchset?


On 29/06/2019 18:37, Pavel Begunkov wrote:
> Ping?
> 
> On 20/06/2019 10:18, Pavel Begunkov wrote:
>> Hi,
>>
>> Josef, thanks for taking a look.
>>
>>
>> Although, there is nothing critical yet -- just a not working / disabled
>> optimisation, but changes in stats could sublty break it. E.g. grouping
>> @batch and @mean into a union will increase estimated average by several
>> orders of magnitude.
>>
>> Jens, what do you think?
>>
>>
>>
>> On 14/06/2019 16:40, Josef Bacik wrote:
>>> On Fri, Jun 14, 2019 at 02:44:11PM +0300, Pavel Begunkov (Silence) wrote:
>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>
>>>> There are implicit assumptions about struct blk_rq_stats, which make
>>>> it's very easy to misuse. The first patch fixes consequences, and the
>>>> second employs type-system to prevent recurrences.
>>>>
>>>>
>>>> Pavel Begunkov (2):
>>>>   blk-iolatency: Fix zero mean in previous stats
>>>>   blk-stats: Introduce explicit stat staging buffers
>>>>
>>>
>>> I don't have a problem with this, but it's up to Jens I suppose
>>>
>>> Acked-by: Josef Bacik <josef@toxicpanda.com>
>>>
>>> Thanks,
>>>
>>> Josef
>>>
>>
> 

-- 
Yours sincerely,
Pavel Begunkov
