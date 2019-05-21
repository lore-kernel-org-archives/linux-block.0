Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD7C04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED252173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oOis17Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEUBVB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 21:21:01 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35923 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEUBVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 21:21:01 -0400
Received: by mail-pg1-f181.google.com with SMTP id a3so7656460pgb.3
        for <linux-block@vger.kernel.org>; Mon, 20 May 2019 18:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9+4NStbf1HDnv3PiLqkwFGMF1Wz/02cr0U3DUkhAHs=;
        b=oOis17FtdRa1jzZkPNOUHBe/XDV1YS+C9+gJQVUBdKwTUm5pMED/WsUgtg69MFKp+m
         IeJWn2pp/82C/ZyOw574cyfrHI5yBoH3XF8+E/O4xYl12H5MJYCMvzQOLKVYqN9KQegK
         PVM2bVP5TdDyTdf4trKxKp1xldJDzfrEOY7rqunbwPU4rxz2dod9jKS5eUkbzy3TEXTk
         IG7D6wgQnNXKyN6ObnCUP7tk1NLVS2cCl2/YD0nVort8o6MDda8LG3gQ1Vz4myiTME4z
         PHnqGbaavgslDbk5WjAI+BDI1FwJQj8w6RMALnWqtbb8m5jN9xCzp8VXcmVxA2Ubj9nQ
         kwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9+4NStbf1HDnv3PiLqkwFGMF1Wz/02cr0U3DUkhAHs=;
        b=WcQ/TTp6cUbecbLfMDGNcF0SM3+6tZb0F5Ln2IzeXNrZ5MTSkhaQzeIWjPSei0oqgD
         mnrgBEXbMar3K9dVjvxAxw3r8Sldci0eRTFLIjLAjbBz9Cto/B5rulWJ7bRhJf0C3vt0
         Q12CnBkdR6tRoFQQ/JtczAqKz37+A/8Jm5T8eIKzac9/6WFtVkdcrQa6Mr95D/y5/yyk
         BOTD9myvkRl8/ALSNvfu7N2jPObr325EGu9yIbp2qKFSVUvVUSDOv5WbbaDp9eKHnzen
         /U9Si+ZQhrr7tFJFphBO1vmg8b5gCFWTkXIrp6VA9iFA1hZ0l+DgCUnYbSXOwnC2mBC+
         rW3Q==
X-Gm-Message-State: APjAAAXHaPIxoRcrrEQ2UATz93UFtVSWKUxcR7/Q5lvgJjhRXrRv+0H+
        fTnSFbQn2p6NNe22oiFdIjTYxHw9dVg=
X-Google-Smtp-Source: APXvYqxw0ggQyGoO7CxIto1AMx7e4pcypxfN3GsgWRTmMgSY7iH5gFXkKKC5vsqtazIXci4Biso6tw==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr83273333pfr.62.1558401659862;
        Mon, 20 May 2019 18:20:59 -0700 (PDT)
Received: from ?IPv6:2600:380:b47a:98dd:4c8d:4b8b:78f8:398f? ([2600:380:b47a:98dd:4c8d:4b8b:78f8:398f])
        by smtp.gmail.com with ESMTPSA id s28sm29377545pgl.88.2019.05.20.18.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 18:20:58 -0700 (PDT)
Subject: Re: fix nr_phys_segments vs iterators accounting v2
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190516084058.20678-1-hch@lst.de> <20190520111714.GA5369@lst.de>
 <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com>
 <20190521011700.GC14268@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5a08ee7-5bbf-3285-5f02-4f6544770340@kernel.dk>
Date:   Mon, 20 May 2019 19:20:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521011700.GC14268@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/19 7:17 PM, Ming Lei wrote:
> On Tue, May 21, 2019 at 01:09:39AM +0000, Jens Axboe wrote:
>> On 5/20/19 5:17 AM, Christoph Hellwig wrote:
>>> Jens,
>>>
>>> is this ok for 5.2?  If not we need to hack around the sector
>>> accounting in nvme, and possibly virtio.
>>
>> I'd rather do it right in 5.2, especially if we can get something
>> acceptable cobbled together this week.
> 
> If this patchset will be merged to 5.2, please remove the following
> two lines from patch 1:
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> 
> 
> Because the patch 1 doesn't fix them actually.

I don't want to merge something unless you are happy with it as well.
Are you fine with going this route?

-- 
Jens Axboe

