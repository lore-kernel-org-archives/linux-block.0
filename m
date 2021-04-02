Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599AAC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 14:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F138610A5
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 14:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDBO2T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhDBO2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 10:28:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59499C0613E6;
        Fri,  2 Apr 2021 07:28:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so2445146wmf.5;
        Fri, 02 Apr 2021 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDS6Ofi8HlO/kuVs4wy+DHP2fVO6iZWa4u6i61WgoWE=;
        b=YTCbvnyy95pqp7lsI4JJowFG8eVonXDygHAmEfn9lbqUU5W4cIzwmvcBz3boLznRNR
         8BC3JKy28WtL/qtUrSX7/P0ffvzuC8TT4UxPy2sBXogzPxtTlhra7udxGrsxwQCv/hD9
         VHtMTZBmWhTAwA3b0hp8L5kLgmONOIRnm5imkHJTk/Q3Hy40k7VDHY/aoMWvft9a9Vtl
         faKEHO6VBaGTTvjoBNF4mDDSFbF9eHhDJ+1b/0fj8Q02nBTl7yaweNJJUJlzUhBxW3Mg
         5o9v7rNm45/QX4qIKN0CgJJZeryxT3hBiSTh5iitNWmBu02mJTqZNbH61lAuqAX+0qlX
         UATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDS6Ofi8HlO/kuVs4wy+DHP2fVO6iZWa4u6i61WgoWE=;
        b=sxiFwYbQyRHHt6803UC2G9/LGzW3rfcTfYNtZbBFmZmFQMhKitzXM0VJ3wmD7UMqvl
         p1Xh8hHqY51gkuOXOc60u5W7yJiAwJ2rRLM5EP9UJcc00zNMaKfSAgQqZA3byJAYpTjp
         ZQksqT1++9ugCnbZE7Klta8pyIKUE/nB5WOrrPpaPNXknTBXKuHg8R4bqNf2/mHbIPMA
         +7KIL88qR1u9PF1W/6I8gJ7jDO3F1L9ll4zRY78DFvLgMvk88WIbcH0xFCb25l1Tz6r+
         om/1XFV7DvRfgxqb4VxARYYdIh9+INfcqqIbfTqvfhGRDePljrSqLSv23JOvVoL1w7MB
         Tb3Q==
X-Gm-Message-State: AOAM530dyh+r7EHs9CVaN+6WG6zCx8tCGa8PrNG/b5TimkQ82YbdPj0p
        YQHqaIZhLeZ/3z+nN8GL0wq/BScvhmN19g==
X-Google-Smtp-Source: ABdhPJz94m3oGxcG5CkEx/RWESy1H6z3Yw0N8foQF6pS+HiZdAMtiw8dMp8wEtxyCMxVIDoKWmn1qw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr13080211wmc.51.1617373695892;
        Fri, 02 Apr 2021 07:28:15 -0700 (PDT)
Received: from [192.168.8.131] ([148.252.129.229])
        by smtp.gmail.com with ESMTPSA id h8sm14793564wrt.94.2021.04.02.07.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 07:28:15 -0700 (PDT)
Subject: Re: [PATCH] block: don't ignore REQ_NOWAIT for direct IO
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <546c66d26ae71abc151aa2074c3dd75ff5efb529.1605892141.git.asml.silence@gmail.com>
 <389a12f6-729e-327f-bef9-e3691ef4f78a@kernel.dk>
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
Message-ID: <f94b2905-7356-ca9e-6669-ffb98ae3be19@gmail.com>
Date:   Fri, 2 Apr 2021 15:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <389a12f6-729e-327f-bef9-e3691ef4f78a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/11/2020 19:13, Jens Axboe wrote:
> On 11/20/20 10:10 AM, Pavel Begunkov wrote:
>> io_uring's direct nowait requests end up waiting on io_schedule() in
>> sbitmap, that's seems to be so because blkdev_direct_IO() fails to
>> propagate IOCB_NOWAIT to a bio and hence to blk-mq.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  fs/block_dev.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9e84b1928b94..e7e860c78d93 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -263,6 +263,8 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  		bio.bi_opf = dio_bio_write_op(iocb);
>>  		task_io_account_write(ret);
>>  	}
>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>> +		bio.bi_opf |= REQ_NOWAIT;
>>  	if (iocb->ki_flags & IOCB_HIPRI)
>>  		bio_set_polled(&bio, iocb);
> 
> Was thinking this wasn't needed, but I guess that users could do sync && NOWAIT
> and get -EAGAIN if using preadv2/pwritev2.
> 
>> @@ -416,6 +418,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  			bio->bi_opf = dio_bio_write_op(iocb);
>>  			task_io_account_write(bio->bi_iter.bi_size);
>>  		}
>> +		if (iocb->ki_flags & IOCB_NOWAIT)
>> +			bio->bi_opf |= REQ_NOWAIT;
>>  
>>  		dio->size += bio->bi_iter.bi_size;
>>  		pos += bio->bi_iter.bi_size;
> 
> Looks fine to me, we definitely should not be waiting on tags for IOCB_NOWAIT
> IO. Will run some shakedown and test for 5.11.
> 

up

-- 
Pavel Begunkov
