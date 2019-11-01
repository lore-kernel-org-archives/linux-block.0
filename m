Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B44CA9ECB
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53DA208E3
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 01:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oGHEeaRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfKABfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:35:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35284 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKABfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 21:35:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d13so5858283pfq.2
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2019 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/WjzctpxamR6+Oc0VOtlLoWY4mxY81ZqCy28sfRvW70=;
        b=oGHEeaRYR0xlJwwAbguu9Nrhinjgt2M2vRcZTj2r7uwx7iOYx90HUfT7jw/r/DAdBD
         WlIfCpkcFcJhHtjA0hm+rw9Idg2ymZLUD4gRqzKwGq+xZbKRxVz/VTqA0auocsbLxab0
         SNocT9T33EnGjScaqKQ40nhZEEZepQTkphOoDQ86lpvjgbd3Ouy+a/55BgxMw+iguSJ3
         59NwZQ31KPyvX8lZ8ME+D/vdcJpPxeFP8PtceTfaaZTKaJmJliWz8EyY20Z7YmWDnbR3
         Gpm5t3bgDQfJPCmuKKBJQiXZATIy3Zt5fltWtFtj9fa5r0zvzADTbczryC1DrdcvmSiE
         0Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WjzctpxamR6+Oc0VOtlLoWY4mxY81ZqCy28sfRvW70=;
        b=L2kjeVPZ2NzjTmAgLftqeraJL/5LART1tKybjCjVzGpPQXjYC4DM0UZscLqIM9CeWk
         dB6U69hDk63FGMPWdEpLEtjhbSMjk2+LKyILLR1hxM7sAbRcnl3fV03lfA34IvPz5mFy
         jbRPcvTuy/jPf6fFPjdR06OsClcjzvPpHSasKVnDEQgY3f083fxSQkxXYG8FvnFGQTEv
         TM2C0rf2HLEh6+LI3OBlmeNAJLxkIdgr/fgNBxZ9sDmWIhkkJBsTvqw1QVyssXw8xvTq
         B5qunqgqgAAHKKygASqzVxovTxsBT1evpKPpJWCnWBwMRMIDQvOV9u1k0MOPqqPXsQ3k
         Ll3w==
X-Gm-Message-State: APjAAAUzIqZvC3RREBOUQ6gE5H4iXi/O21c8d1sqrWW8cuuMuDUbTPuK
        SIh/5T1+XEHHE2VIeJAXPEKdjx8n5956pw==
X-Google-Smtp-Source: APXvYqyRNCLN54rjSKzQw8IiusFCqZALFITzqdUFH27JDG4FIVhnGtL9hxobtE6CRJPzVLD3SnG9zA==
X-Received: by 2002:a62:3896:: with SMTP id f144mr10598050pfa.254.1572572140881;
        Thu, 31 Oct 2019 18:35:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::1087? ([2620:10d:c090:180::5ea6])
        by smtp.gmail.com with ESMTPSA id b82sm4486746pfb.33.2019.10.31.18.35.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 18:35:39 -0700 (PDT)
Subject: Re: [PATCH] block: retry blk_rq_map_user_iov() on failure
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c8718f10-0442-de4f-edfc-ecc6fe28b768@kernel.dk>
 <fec5226c-d13b-a7ef-cb3a-217b26a1aa22@kernel.dk>
Message-ID: <306b4114-7509-bdad-d78e-8048615223da@kernel.dk>
Date:   Thu, 31 Oct 2019 19:35:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fec5226c-d13b-a7ef-cb3a-217b26a1aa22@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/19 1:30 PM, Jens Axboe wrote:
> On 10/31/19 1:26 PM, Jens Axboe wrote:
>> We ran into an issue in production where reading an NVMe drive log
>> randomly fails. The request is a big one, 1056K, and the application
>> (nvme-cli) nicely aligns the buffer. This means the kernel will attempt
>> to map the pages in for zero-copy DMA, but we ultimately fail adding
>> enough pages to the request to satisfy the size requirement as we ran
>> out of segments supported by the hardware.
>>
>> If we fail a user map that attempts to map pages in directly, retry with
>> copy == true set.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> I did actually add comments to this, but apparently sent out the version
> without comments... Current one below, only difference is the addition
> of the comment explaining why we retry.

Disregard this - I had a patch to make bio_copy_user_iov() handle strings
of bios that this would also need, it's not enough by itself.

-- 
Jens Axboe

