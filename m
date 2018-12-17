Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F380C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AFD2146E
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gMUxH25b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbeLQQJF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:09:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54412 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQQJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 11:09:05 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so19304244ita.4
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BiDli7F0txU5ick/R2/Q+rEuWA8agdQj9UBE5AUcla4=;
        b=gMUxH25b/TACB7yGz5SXD6wx3k6GTCTt9raDAcc7w6WQ6yHpqh5at20LdcVO6VGdbF
         Q5RPTPPuMVIFxTfc+3UMNs9XyoVT9nSRR6RNd7rrdenQ4C/CRbAd5nTfLPMArd15fqeu
         XhgFlUrABIUwFhUwszTHhs2peFvTiOnjx+rL/SNyqE8XXmqkEnhdk+2Sd9Sox44USXhj
         v/RUTTZqfUVxd1bNEeuO3bhgGZirCoqUoUmRTSBfaPpfnWDH1jRJrivjZ2l30kwOgwXv
         LcmF4k5sMYA4wbkDC6FJ2v6xjVCk/0B8nlUgStL/+Ip2SwvM6sHwI5x3BtCx2QotBnqQ
         +bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BiDli7F0txU5ick/R2/Q+rEuWA8agdQj9UBE5AUcla4=;
        b=cAv9gK6erXAmkjdznlWIyEM+ZRb+LtviqdZHGeVegzuEK4vcL5oH4VPFjkktWnfGKv
         E/psEHTRurV56CZNH9EZ2fJ4bvscPGJWVdvQRfnnooF/kzJsz0SFIaAdWfWYT4Mhl/6W
         lT0iuoD+rFiH9mbCx5s7j7MAXG0RiQwKOqk/LBVn/Ua4G1e1KYys+TVkb95QTQr5rcO9
         UM/TtAXHG4D7NIIm/aRYbxfgcSIkeqL/4HkhxkcGI2IUtWikCFj6WK2nH3LF0KUA/wb6
         iXMB5pzF0I9xTdgfunlOxv5OPIaamhKHQVNydqBi/WJ5W8bRjgLY8dfbn/TsDPQPX8Gh
         u8sA==
X-Gm-Message-State: AA+aEWYpYUqhz0F7odGHN/xM23xSS4qYaoL6VCdE7xgqWTkoacSZgI2p
        Qpd3Tnir9S1i0yZh5W/fM/VK5g==
X-Google-Smtp-Source: AFSGD/VpFKfnzkDWMvsXGHCrNzuDEbt552qBW4JnQgIVmitlz6K/Ci01WeFUibDfGWXnI6OYLLizHw==
X-Received: by 2002:a24:69cd:: with SMTP id e196mr13240660itc.161.1545062943888;
        Mon, 17 Dec 2018 08:09:03 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v19sm7387840itb.0.2018.12.17.08.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 08:09:03 -0800 (PST)
Subject: Re: [PATCH v3] block: fix blk-iolatency accounting underflow
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181217160351.27903-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd74dbe2-0f96-a2aa-043a-6f570c4ffb12@kernel.dk>
Date:   Mon, 17 Dec 2018 09:09:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217160351.27903-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 9:03 AM, Dennis Zhou wrote:
> The blk-iolatency controller measures the time from rq_qos_throttle() to
> rq_qos_done_bio() and attributes this time to the first bio that needs
> to create the request. This means if a bio is plug-mergeable or
> bio-mergeable, it gets to bypass the blk-iolatency controller.
> 
> The recent series [1], to tag all bios w/ blkgs undermined how iolatency
> was determining which bios it was charging and should process in
> rq_qos_done_bio(). Because all bios are being tagged, this caused the
> atomic_t for the struct rq_wait inflight count to underflow and result
> in a stall.
> 
> This patch adds a new flag BIO_TRACKED to let controllers know that a
> bio is going through the rq_qos path. blk-iolatency now checks if this
> flag is set to see if it should process the bio in rq_qos_done_bio().
> 
> Overloading BLK_QUEUE_ENTERED works, but makes the flag rules confusing.
> BIO_THROTTLED was another candidate, but the flag is set for all bios
> that have gone through blk-throttle code. Overloading a flag comes with
> the burden of making sure that when either implementation changes, a
> change in setting rules for one doesn't cause a bug in the other. So
> here, we unfortunately opt for adding a new flag.

I think this is better than (ab)using QUEUE_ENTERED, but this is an area
that needs some love and cleanup in the future.

-- 
Jens Axboe

