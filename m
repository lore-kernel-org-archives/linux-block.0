Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094AC43444
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C025320859
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AQjO+up9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAIUtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:49:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39423 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbfAIUtE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 15:49:04 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so13106735itl.4
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jfiAVzCJdieZUM0VyXbKk6sflFmsIoMHTLabyhRVgiU=;
        b=AQjO+up9sIXB+a7ADFuybFlJgKNh8vdiWl+HPWv3UvJfG2gnQ0+VpKf+6CdI0esYo/
         2kT49FfTmTWlg/WdENZfJ/y9b0gkW4Y+3Mow4Aw+J0+bwAO1UjY9nYS72XAXDo9S/aeb
         k9oS0WoBKSH+LDoqOl7fn4ZWEPkkyWx3DrobxoLMtzvs4xX7nyneL5iwrev/Ls1IBUUX
         7nAwGxKLuyJnVh//K9Wld2Fad89QZIKWF/jUDZqLSihsUuAdkLPhaVR90bXT/ouKbEX1
         D9rSeyPqZpO0FgC6rcSPHOvoyK/SVmeS+K+qkK8UdwJv+aeysB+hVIW/FDpQiCb4gXcg
         nMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfiAVzCJdieZUM0VyXbKk6sflFmsIoMHTLabyhRVgiU=;
        b=SK+wlhOyX5LhCQRzD5dyqVYdLx07AjA5Hai6IyucoNvzeQUhD7stKmGZP0WfloXEuv
         GXDwE+q4aEhObbwK+9Kr+VwgP+yPG6jy4id78hNpnDzAh/Ys3boCjVrroq696o/26OOO
         6GxiVZsi6KQtug84Dl3bJz5HhA11SpErpPYbddPilmag0OCGVPv7NqTqpou7HLqqFP59
         OR7BDpkZQG8vm0sF3E1R9PFz5f0i0txLmKaTEiOaXG+qnAtDrwcyKCOvjFiwN/eee1/x
         pqKd29pDiwBT/q6bWEYk//Mlbr7lmzVmyXZxigp0H2AJwv1qS9w6eNprDPjVKhpb3Glk
         wRfw==
X-Gm-Message-State: AJcUukfhQs3K7xNRQ8vziVu49yU1u9MPdS5G7AC0xD/emnbg0YJQgHEX
        QaXTw+0PCoeXxJfVPvuSVy9Iow==
X-Google-Smtp-Source: ALg8bN7Ze9wrtJWMdNXOTFoAHPaZX2Zl+5CemZxccMQZVqfAddNr17Z7NclHpFdnHvu1ARIGR2Rh5g==
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr2853685itl.146.1547066943448;
        Wed, 09 Jan 2019 12:49:03 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r21sm8266439ita.27.2019.01.09.12.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:49:02 -0800 (PST)
Subject: Re: [PATCH 14/16] io_uring: support kernel side submission
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-15-axboe@kernel.dk> <20190109190638.GB22645@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <205e9c21-e524-f56d-3684-26db6e87b54e@kernel.dk>
Date:   Wed, 9 Jan 2019 13:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109190638.GB22645@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 12:06 PM, Christoph Hellwig wrote:
>> +struct iocb_submit {
>> +	const struct io_uring_iocb *iocb;
>> +	unsigned int index;
>> +};
>> +
>> +struct io_work {
>> +	struct work_struct work;
>> +	struct io_ring_ctx *ctx;
>> +	struct io_uring_iocb iocb;
>> +	unsigned iocb_index;
>> +};
> 
> I think we should use struct iocb_submit everywhere where we pass
> an iocb + index, including in the io_work structure.  Here is how
> I did that to my old tree:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/65929ed6f143a1c996305a10a15fd7f64d32595f

I like that unification.

> Btw, I think we can also remove the separate io_work allocation,
> just do the io_get_req in the submission context, and overlay
> the io_work onto the iocb in a union of some sort.  This avoids
> a whole memory allocation.

I'll take a look at that.

-- 
Jens Axboe

