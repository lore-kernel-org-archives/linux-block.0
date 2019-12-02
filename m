Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85AC432C0
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FA620717
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ffM5D4u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLBSqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:46:38 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33280 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBSqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Dec 2019 13:46:38 -0500
Received: by mail-il1-f196.google.com with SMTP id r81so679861ilk.0
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2019 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKizjYLSvTMYMHSkIi8Qm3rCT1sNcnCR3DA69I697kw=;
        b=ffM5D4u9vm3bshrBzJS/iqDuRXFEbeud0UbQpjCyvfq6mfWEW8RL06zpQlYdNYjn5S
         1aYMiPkUg+HJb0Kri1UjLk5xrlfRN1dvf/39m+GIlH+kzrsLu5Oi4cI5RzWoK7UtQy86
         9ted56IVSb5kriOtjOOXG7CD5eaa/bAcPCB+eW4uKDKS3QnNzL3Sk5g0Uz5RrG6MzYiQ
         H8larox6z/ZODQDT2CwyNhZUS0XggmJv8SIF84aC3ErIgRW/hw07AxEbPmqoBBr5PObp
         mk2Nk+vXj0YcUZvAVT60kaFil37PWKV6q25rbD2JERyE4mGAmC/ZtiwBThjN9NwVw4QX
         0poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKizjYLSvTMYMHSkIi8Qm3rCT1sNcnCR3DA69I697kw=;
        b=CihFZKxCtDEKOVT9MC6NumY9uEUav9xaZ6CmDLcEkCpDQsQjAnoT7aJHDPta732Jp9
         VNH+51TueRdWLpX5qTNKo/JDP43dBoopCUIn1NCZa3N9JKwhpKlaea3tAqRiIpbQd0lo
         JiqEEqsISJlRWt1sJP5IFhKwCI6nOHw2CduoQ8XN8pONawMPAsBBfNn/12+LUltxhteb
         aj5NGsnVPP34HZ8mnTSt3aDi566nwEssgiKXsGxqq3teyUdtxmpBNSA/gTF7Tzk7VLiN
         JJvDub35MblQCbg1iLWU8KkhbBkTDLI+AGaCq2YHB7RXhQQTysqk5PqfYO3BvV6vI6hc
         0oew==
X-Gm-Message-State: APjAAAW7kix0StOixXT3DkFgH0YzuWusEQnGTHFAPDrO4rsrKwdj4WCs
        iLqJ/hG1J6YblZf+6/IGRNVKg6ZtRCfTnQ==
X-Google-Smtp-Source: APXvYqxXvltn9VpX0MUnlfRau4X3JChuJfFSZRcWc9jtzyH6itPA4Uu6Z3iTT+cI1z3YhXohx8hzQw==
X-Received: by 2002:a92:d581:: with SMTP id a1mr190128iln.218.1575312396242;
        Mon, 02 Dec 2019 10:46:36 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x2sm55614ilk.76.2019.12.02.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 10:46:35 -0800 (PST)
Subject: Re: [PATCH] block: don't send uevent for empty disk when not
 invalidating
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <20191202182134.4004-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0e3e498-553f-d05c-c37d-5d8088cf20d2@kernel.dk>
Date:   Mon, 2 Dec 2019 11:46:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202182134.4004-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/19 10:21 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 6917d0689993 ("block: merge invalidate_partitions into
> rescan_partitions") caused a regression where systemd-udevd spins
> forever using max CPU starting at boot time.
> 
> It's caused by a behavior change where a KOBJ_CHANGE uevent is now sent
> in a case where previously it wasn't.
> 
> Restore the old behavior.

Applied, thanks.

-- 
Jens Axboe

