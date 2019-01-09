Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F3C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05AD20661
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dSNTWJRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfAIUHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:07:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54047 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIUHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 15:07:34 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so13589584ita.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4E46kAY3H5qyhjrpM73hxbwYDWqbzq3BlyVO4e1hOA=;
        b=dSNTWJRtXOjABG3+WRvLfLLz4acEWZJifCzzHKyuT7wEuHUBaRHszPjm7lVkecrZir
         8ZwOWnudTnY6aeO+cNuKiiltq8r++wnLAOnFunJ3ppyN6IopXqOhqs0z+bW7di6OkKUk
         myx+oelHt1vNeUs282ASlodxAEGOvmPcPI3o9hgXriOg5b1nIGfbPE6gpA/rHoIu4s36
         4W8JVTL1f6+vCb3mgJB+NuX3MYrZqVbBG6LHbAYnWdDMlH7KI/BdwZu6cYI0dTjGPAnt
         ACt0WJrayJGz2g4paxZZAFzUCdAuXsTh1eEwoLWAeOc7Kov/c+mlAIH4oT+qZWx2Dt7j
         0aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4E46kAY3H5qyhjrpM73hxbwYDWqbzq3BlyVO4e1hOA=;
        b=mNDVSReETyfYJi1w8u7xiro7+u8Snwi9s4ilB+TcikDiFPynYhWOIq90bLyBA+CeBS
         6gmx0if6ALS131PjXspXcIutxMeZbMfrPh+Y6g3iIFWb6BEQNFEb0ut53YYPh+A6BLCR
         1kiQO73gLVLucuYwx1PEatWzFIPdA02+IetZ4RMhnvVmhVgfD/cGXDeSgsdQPn37Z7kb
         x/rrUwG5aywYM3Uq3ua02W9Yjy1/NqfngYAPXwZM3fWE/JFHbJTc5VI4ov2osmi/FSdX
         +S7SknpK6Haw8oTbkD0s+SFGJNNynQ3PKK7Gr139slkaB3wiMUxYyyAzOe0SCVi0yolf
         0VGA==
X-Gm-Message-State: AJcUukdt9weTGrM77dUGzbXyMWiiSZE45oOK2+DPT4Pd+iMmAhCVUvN2
        qlI1uxmF5VFurCIb12UUTBJ7zA==
X-Google-Smtp-Source: ALg8bN61CN8RhTcEbFz529VVeCIApNnzM7Wzm3sJwdnEem10plvLUDohAaaVpP19m8VtEC9d3jevSA==
X-Received: by 2002:a02:6:: with SMTP id 6mr4808648jaa.19.1547064453579;
        Wed, 09 Jan 2019 12:07:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b14sm19049544ioj.26.2019.01.09.12.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:07:32 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de>
 <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
 <20190109183059.GA21824@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <762caadb-1deb-19c4-705b-c11abd8c1abf@kernel.dk>
Date:   Wed, 9 Jan 2019 13:07:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109183059.GA21824@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 11:30 AM, Christoph Hellwig wrote:
> On Wed, Jan 09, 2019 at 08:53:31AM -0700, Jens Axboe wrote:
>>>> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
>>>> +		       struct iovec **iovec, struct iov_iter *iter)
>>>> +{
>>>> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>>>> +	size_t ret;
>>>> +
>>>> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>>>> +	*iovec = NULL;
>>>> +	return ret;
>>>> +}
>>>
>>> Is there any point in supporting non-vectored operations here?
>>
>> Not sure I follow?
> 
> This version only supports non-vectored read and write, that is
> the equivalent of pread/pwrite.  Many AIO users really need vectored
> operations, that is preadv/pwritev semantics indirecting through
> a struct iovec array.  The non-vectored version can be trivially
> emulated using a vector of 1, which is what we do in the kernel
> I/O stack everywhere.  So I think we should just support the vectored
> version here, and not the non-vectored one.  See my io_uring branch
> for the sketeched implementation.

OK, I see what you mean, so only supported the vectored version.
Probably makes more sense, I'll make the change.

-- 
Jens Axboe

