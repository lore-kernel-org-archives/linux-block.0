Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC22C677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjAPSRF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjAPSQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:16:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D101E28B
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:03:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so34602871pjk.3
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFRcO8WJe+2hhVpbSOzkxfGUtn5hg+4hKIQrsXrKsug=;
        b=UIesaXwW97VQRg1lRmbhb5q5e0BjJ98o0Wg3Wp7GpLqJ/7Ag2CwbgxePqIBX55H95I
         xn902UV29eXG0qeLFm9+vgpEdWVjIyx+d79P5zxU3Qm24JBLs6vT4N/163C17edMsMCu
         c7zlk8d6QiHXgj6rAIvEa2CDn1L819WRS22Cs+jbloJfUVpdYSHAubZrsd4jQ3YKsMVX
         R3v/NMfTTlaiQ2AWcR2jsaPgmFO0eoGIqXs8pDda1XEsf6fMuij08CaQYKVlnajdEgcj
         H5y/6d9SR3csFcNLwG2izHD44txhOmw8UuidSFA0lDTX6c2k0tMB72BiOq+CwkE5GC6x
         ha3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFRcO8WJe+2hhVpbSOzkxfGUtn5hg+4hKIQrsXrKsug=;
        b=ZNlXM5VEe0ePIfAEQX21QcfdOTu58tNIdPQg2s5cbK9/6k8zTFr7kIRHdVo1pLQpc7
         M5vU+OBnsZIP4XHL7dn1AI25bROTnlzYCe2dNVX5xAgPRmKG4rC8Pr+Guy0jz+ZsJaUf
         At3hqahMbe0KzyZCtP6NhEok0NMNWxEestsdgKCWrnPK+AaU/wJsdKK3qmKWCZTo37v2
         NEx88ck09ytXw+AFQwV6Q6LN+qnttNiPma7ukzDt/O528ssPAzVCm0BPmRzy5XA8Q2PW
         vGWQFNkw7/9AoWQf/HujIsRC93DoZ+qBfY3hkHCeFUuAkvJXYkWoPOyroieo0sER/lTk
         KWzg==
X-Gm-Message-State: AFqh2krtHFLJig9Hri+m0QuD+xBEC7RXiNLC+uZXiZm7op3E5JX50fsX
        ny7KpCUyKRyrlqiqJsQ4L0Xpuj7IHNhcUBDk
X-Google-Smtp-Source: AMrXdXtPcJ4Ouc3/lNN6nOU2wvkFU/6sRzEqQ3HTqcFaoTGwQDYk9jrr3LJtSDPZXqiZnVY3/+I+6w==
X-Received: by 2002:a17:902:9695:b0:194:9f80:8bed with SMTP id n21-20020a170902969500b001949f808bedmr149174plp.6.1673892199493;
        Mon, 16 Jan 2023 10:03:19 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ix15-20020a170902f80f00b00192b23b8451sm19708710plb.108.2023.01.16.10.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:03:19 -0800 (PST)
Message-ID: <ec218e9e-5433-c6b5-a6a6-85a64fd2ea7f@kernel.dk>
Date:   Mon, 16 Jan 2023 11:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
 <Y8WOuHQ21PP/W6Rv@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8WOuHQ21PP/W6Rv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 10:51 AM, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 09:01:37AM -0700, Jens Axboe wrote:
>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
> 
> Can we sort the NUL vs ERR_PTR thing there first?

Which thing?

>> +	/*
>> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
>> +	 * cannot guarantee that one of the sub bios will not fail getting
>> +	 * issued FOR NOWAIT as error results are coalesced across all of
>> +	 * them. Be safe and ask for a retry of this from blocking context.
>> +	 */
>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>> +		return -EAGAIN;
>>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
> 
> If the I/O is too a huge page we could easily end up with a single
> bio here.

True - we can push the decision making further down potentially, but
honestly not sure it's worth the effort.

-- 
Jens Axboe


