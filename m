Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C88C3526A
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F8723124
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 17:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440474AbgLNR3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 12:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440472AbgLNR3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 12:29:38 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1DC0613D3;
        Mon, 14 Dec 2020 09:28:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t16so17248281wra.3;
        Mon, 14 Dec 2020 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjqOsBm0T2267qBkF0+4Cq11tMxRrd4IKFD1JljKqow=;
        b=ET/aMlXbQcEIoiEfeR0Kr+pg1TYXEKY+bGcA/d5eHW4EzWfkrwE+2OPRs0vrJCiG+M
         xiR/LH0TZ4ln+TjYwY7gCGA7Y041gPnejE1GnkTaqMhkLXxlwAKTfV74eyZDXkg6QUZr
         TM8wzFfW1PRocED7O8oX54QcAQ5aj6Hduz4Ns45uuVahfRMvZjbPOc4l3JObsVOPjUaA
         qbeAfirCyV32JXcs+I+ekZlhcoOM1sJQWYIH9vLkE9/Ea3iOyvR9BB9ACXeteHkKT/id
         inNCiPEwNFuXFfUFAjR6CWz76fL0HAmIh0fxjAB0ipemmRvVBs235sC2QRQ3+RNDXvY5
         Q1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BjqOsBm0T2267qBkF0+4Cq11tMxRrd4IKFD1JljKqow=;
        b=C4MCXMiu4Rh/K52uM3HIs5vi+fVB6W7eyfchAy+eamCAtar1lrhIwU3P6RMqUsxNBK
         5i0eHNMgTugUXA57c+hoPxJgCLkfDjQcRy8aZinLwzZWQiBlPlVq0/+jPczRTzK0s594
         W2U72ZWoq3VKqaVLKqs3VGhKXLag5OeBIlAEbGR+ylr61B6Fjy7ee86J6tCSQZVE5wM6
         VwZ/NOH1RtvIXrQuZO6IHGXF7a7VEcuOACV6omLo6qOl5KTES68qRv+mYvaw7xkLG10h
         LCCwSwlgkb/u6R+OaiZjALot0yWvFjitjxgoWUQuM0pOoQK7sPqTYb6qwz2yxxyZF2vj
         7IQw==
X-Gm-Message-State: AOAM531yYnDnZk6IEZBZ8U6+tVOuodpLkpweKGdpFkV0zMI/0andFcMC
        fXaQPtx/+z5AcGmqSwgtTNm0PAsdcWrpyw==
X-Google-Smtp-Source: ABdhPJzNqF9rPRyBqXNfK6L9jUzUYGuQoSMNjHL4HIRmlS4wjwEQ6PGh2htT34PRfVqAPOigq1Nq1w==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr30474965wrq.19.1607966936140;
        Mon, 14 Dec 2020 09:28:56 -0800 (PST)
Received: from [192.168.8.128] ([85.255.232.163])
        by smtp.gmail.com with ESMTPSA id h9sm31472192wre.24.2020.12.14.09.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:28:55 -0800 (PST)
To:     David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1605799583.git.asml.silence@gmail.com>
 <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
 <20201119170340.GA6179@infradead.org>
 <ce79f47e-2ec0-ba29-a991-c537a8990dee@gmail.com>
 <20201211020100.GB107834@ZenIV.linux.org.uk>
 <857a3161-fbd5-5ff8-d733-ca57923302b5@gmail.com>
 <b0e01a4dc3fc4afeb95b7be826ff2375@AcuMS.aculab.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 2/2] iov_iter: optimise iter type checking
Message-ID: <5b65de70-19db-4572-d122-df65191ab098@gmail.com>
Date:   Mon, 14 Dec 2020 17:25:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b0e01a4dc3fc4afeb95b7be826ff2375@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/12/2020 10:28, David Laight wrote:
> From: Pavel Begunkov
>> Sent: 13 December 2020 22:33
>>
>> On 11/12/2020 02:01, Al Viro wrote:
>>> On Thu, Nov 19, 2020 at 05:12:44PM +0000, Pavel Begunkov wrote:
>>>> On 19/11/2020 17:03, Christoph Hellwig wrote:
>>>>> On Thu, Nov 19, 2020 at 03:29:43PM +0000, Pavel Begunkov wrote:
>>>>>> The problem here is that iov_iter_is_*() helpers check types for
>>>>>> equality, but all iterate_* helpers do bitwise ands. This confuses
>>>>>> a compiler, so even if some cases were handled separately with
>>>>>> iov_iter_is_*(), it can't eliminate and skip unreachable branches in
>>>>>> following iterate*().
>>>>>
>>>>> I think we need to kill the iov_iter_is_* helpers, renumber to not do
>>>>> the pointless bitmask and just check for equality (might turn into a
>>>>> bunch of nice switch statements actually).
>>>>
>>>> There are uses like below though, and that would also add some overhead
>>>> on iov_iter_type(), so it's not apparent to me which version would be
>>>> cleaner/faster in the end. But yeah, we can experiment after landing
>>>> this patch.
>>>>
>>>> if (type & (ITER_BVEC|ITER_KVEC))
>>>
>>> There are exactly 3 such places, and all of them would've been just as well
>>> with case ITER_BVEC: case ITER_KVEC: ... in a switch.
>>>
>>> Hmm...  I wonder which would work better:
>>>
>>> enum iter_type {
>>>         ITER_IOVEC = 0,
>>>         ITER_KVEC = 2,
>>>         ITER_BVEC = 4,
>>>         ITER_PIPE = 6,
>>>         ITER_DISCARD = 8,
>>> };
>>> iov_iter_type(iter)	(((iter)->type) & ~1)
>>> iov_iter_rw(iter)	(((iter)->type) & 1)
>>>
>>> or
>>>
>>> enum iter_type {
>>>         ITER_IOVEC,
>>>         ITER_KVEC,
>>>         ITER_BVEC,
>>>         ITER_PIPE,
>>>         ITER_DISCARD,
>>> };
>>> iov_iter_type(iter)	(((iter)->type) & (~0U>>1))
>>> // callers of iov_iter_rw() are almost all comparing with explicit READ or WRITE
>>> iov_iter_rw(iter)	(((iter)->type) & ~(~0U>>1) ? WRITE : READ)
>>> with places like iov_iter_kvec() doing
>>> 	i->type = ITER_KVEC | ((direction == WRITE) ? BIT(31) : 0);
>>>
>>> Preferences?
>>
>> For the bitmask version (with this patch) we have most of
>> iov_iter_type() completely optimised out. E.g. identical
>>
>> iov_iter_type(i) & ITER_IOVEC <=> iter->type & ITER_IOVEC
>>
>> It's also nice to have iov_iter_rw() to be just
>> (type & 1), operations with which can be optimised in a handful of ways.
>>
>> Unless the compiler would be able to heavily optimise switches,
>> e.g. to out-of-memory/calculation-based jump tables, that I doubt,
>> I'd personally leave it be. Though, not like it should matter much.
> 
> The advantage of the bit-masks is that the 'usual' options can
> be tested for together. So the code can be (for example):

Well, you can do that for the non-bitwise case as well.
In a simpler form but should be enough.

enum { ITER_IOVEC = 1, ITER_BVEC = 2, ... }
if (type <= ITER_BVEC) {
	if (iovec) ...
	if (bvec) ...
} else { ... }


> 	if (likely(iter->type & (ITER_IOVEC | ITER_PIPE) {
> 		if (likely((iter->type & ITER_IOVEC)) {
> 			... code for iovec
> 		} else [
> 			... code for pipe
> 		}
> 	} else if (iter->type & ITER_BVEC) {
> 		... code for bvec
> 	} else if (iter->type & ITER_KVEC) {
> 		.. code for kvec
> 	} else {
> 		.. must be discard
> 	}

-- 
Pavel Begunkov
