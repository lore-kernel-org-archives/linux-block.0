Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2237AC677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjAPQK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjAPQJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 11:09:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D958227B1
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:06:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so31474757pjj.4
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9gM8x3cA80HqU3e2luPT3SBWdSZm60Sxg3tlhcnbas=;
        b=YVvQ/VNmlxI9+70G9+L+xZiF8Yt9U7zV43DBl9Rt9ZB+aiOkNsGX8xmxrxdl4od2I3
         23+PVRwUalnF5kxsnwMH6teOhr2HB4Mhv+kex3/o2repuRxP6Vfs3z38VZonsnsEuCQL
         cWJvQF7JXvJpbUrV/dozhhy9/6HFVpvHDCdXRMbDXE1SbYQB5A6WDl82X6+MSvRCGkDB
         urJyNNnyo2cXGnxm59yt3r30pnid+dmJNOjAxo383FJTGnILsCTrnq5JRoyEPd2klpMK
         Io68eE1qrnWlBX92es8RJmKDcOC+twlvIhU0WtXP8yyx0box2wBOSUtXn5Xf/9psurpU
         tHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gM8x3cA80HqU3e2luPT3SBWdSZm60Sxg3tlhcnbas=;
        b=OkYLBu3PpTjQSN8dM4qgMYGjPeAYPir8yFxi0088wLpzFy+zef/6Gfgrvp+aFnoxRE
         rrgDkOErdcnZzZtuytzmuHBTK0KrT4IkZDUAv2EoFTtgeFcP0sM3w2ky3AV0Pw3Zw4S4
         kVd9gyWCs0xT3kfjJsl6jHXbmoWCET34Pg3ndHrQmP2ZwHe9jNF3KUp0KN0uhUOhbX/2
         sstZC2soXzoFxj0lmGHg314Pg4sBi4sYFvcojT0K2HYGTnrG3hJhPNiai0W/0RiRKrIk
         06Rc/rOYqGRDHRq3fS/SrsEdfAu1ngbaBGcWxjEND53YJZrLtl5GZLogimrmlx/lRMBr
         XNxg==
X-Gm-Message-State: AFqh2kqAoAaN27erOIqOtPCaYSRk/XoHzBCq2qxfyAgSPcfvmlozWSg+
        SeG3wT9KmC3AMt4Uii4Cva5jTQ==
X-Google-Smtp-Source: AMrXdXsLh8uS3Aoxku3KEh1nP9y/QeKTnjERWbT/UnhUamaax19+qcuq1F44NN6vFG4lX2YX1a8sgA==
X-Received: by 2002:a17:902:7041:b0:194:5b98:4342 with SMTP id h1-20020a170902704100b001945b984342mr57781plt.5.1673885189855;
        Mon, 16 Jan 2023 08:06:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b0017f72a430adsm19677815plg.71.2023.01.16.08.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:06:29 -0800 (PST)
Message-ID: <70e4869e-1ab8-9838-5af8-8cd41a536f2b@kernel.dk>
Date:   Mon, 16 Jan 2023 09:06:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Is there a reason why REQ_OP_READ has to be 0?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2117829.1673884910@warthog.procyon.org.uk>
 <Y8V1n4e/eeOd4n8/@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8V1n4e/eeOd4n8/@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 9:04?AM, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 04:01:50PM +0000, David Howells wrote:
>> Hi Jens, Christoph,
>>
>> Do you know if there's a reason why REQ_OP_READ has to be 0?  I'm seeing a
>> circumstance where a direct I/O write on a blockdev is BUG'ing in my modified
>> iov_iter code because the iterator says it's a source iterator (correct), but
>> the bio->bi_opf == REQ_OP_READ (which should be wrong).
>>
>> I thought I'd move REQ_OP_READ to, say, 4 so that I could try and see if it's
>> just undefined but the kernel BUGs and then panics during boot.
> 
> There's all kind of assumptions of that from basically day 1 of
> Linux.  The most obvious one is in op_is_write, but I'm pretty sure
> there are more hidden somewhere.

I didn't get this original email...

I would not change this frivilously, as Christoph says we've used 0/1
for basic read/write data direction since basically forever. So for all
intents and purposes, yes that is basically hardwired.

-- 
Jens Axboe

