Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3BC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF721852
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PkxDqV/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLRPHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:07:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36283 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLRPHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 10:07:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so7946594pgm.3
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=msLHPr0X5cXeUVhFqrnCsr7X7atd6F0MPomF2nGUSEQ=;
        b=PkxDqV/TelrUgA86ATGFN1HPU9aQsggAKJFejOlJaveRatUNih6zFW5BnWlqgiXyqi
         +IFk7XRJe/lb4po7ej2DGg/NU3HR82xG8mlf7L8WXuJrx6egyyWRWz7hyVyBBnWWMaQr
         wiKlAKqbN5FL2WaBeDP0jWUaMzK7DoYry0ES4cs/aVMS+s9khROB8EoIsWP3WxqmWCZr
         y5ANXPQX1ddRY7YHTxeetN050H8NcRV5Z77hbewzlS+enNKEZ1wA+7nH3BbV8PM3ER12
         HsVMoMbSAQ4dHwKpnlsg/ItT1CU6bShdWiXOci74w++i9N+MrYAjSMjewO/dWy+qFQgc
         TcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msLHPr0X5cXeUVhFqrnCsr7X7atd6F0MPomF2nGUSEQ=;
        b=XHOpADMhyo2LbjKwgACaiQrIcn43xrEPzv/Dzl5KLBPz+93asZFWC9En1sIdjD+qyz
         zKqKnO5nl5r4JG0RozHN6nV4ahcPznvf68Z1d46DVS5Wf6AGH9vUpA2rSy5bunybLN41
         aPOrhP4vuOrVGTsual+tjRTFB8rI3by2ehxvd2x2vEDFJz/ND/80Mud6ZJRQXqMqigMg
         w1C8+jCh7XqNt3EE1A7QcejjVYJb7MFWkqDo+ZP13zCB+vDJjPrsDQ4vG/kdZKMNRyg3
         GrEfQe9SP0lcyLhJ6l2PynXrMVdOrW2F9mqQp50JwPiqFJ3cSihowejjKtOIHQB3Vjzj
         90Cg==
X-Gm-Message-State: AA+aEWZhK2jWV95LMvhC0kL59o8+kXY3LSpZiVY3ppGS7nrb7gtUvSJV
        kN+wlXwXdhBCHg+W80cTy3buAk8Mjg1WTw==
X-Google-Smtp-Source: AFSGD/UU1HM/pGSsSQ5u617s+goyIkESRDC//JV/w3JO0dj2ndQ/id1ngYeZkMvJBXnuy4fI04+3zA==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr15084641pgv.368.1545145650179;
        Tue, 18 Dec 2018 07:07:30 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m19sm39484680pgn.35.2018.12.18.07.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:07:29 -0800 (PST)
Subject: Re: [PATCH 14/26] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181213175645.22181-15-axboe@kernel.dk>
 <d0ad25816ccc6fcb388b34f5e0d42ea9105c9097.camel@scylladb.com>
 <7e207359-6ee2-bce2-3c17-be328a965333@kernel.dk>
 <adc0369578db4f119e48ef2367b46192704c1214.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ac00e65-d4c2-3f86-d553-f8d055012ed7@kernel.dk>
Date:   Tue, 18 Dec 2018 08:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <adc0369578db4f119e48ef2367b46192704c1214.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 7:54 AM, Benny Halevy wrote:
> On Tue, 2018-12-18 at 06:27 -0700, Jens Axboe wrote:
>> On 12/18/18 3:32 AM, Benny Halevy wrote:
>>> On Thu, 2018-12-13 at 10:56 -0700, Jens Axboe wrote:
>>>> Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
>>>> like their non-polled counterparts, except we expect to poll for
>>>> completion of them. The polling happens at io_getevent() time, and
>>>> works just like non-polled IO.
>>>>
>>>> To setup an io_context for polled IO, the application must call
>>>> io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
>>>> to mix and match polled and non-polled IO on an io_context.
>>>>
>>>> Polled IO doesn't support the user mapped completion ring. Events
>>>> must be reaped through the io_getevents() system call. For non-irq
>>>> driven poll devices, there's no way to support completion reaping
>>>> from userspace by just looking at the ring. The application itself
>>>> is the one that pulls completion entries.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>
>>> Looks good to me, thanks.
>>
>> Is that a reviewed-by?
>>
> 
> Yes.
> 
> Reviewed-by: Benny Halevy <bhalevy@scylladb.com>

Thanks Benny, added.

-- 
Jens Axboe

