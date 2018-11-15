Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A083C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2DB2133D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lLieOH5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2DB2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeKPFXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:23:33 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:39163 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeKPFXd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 00:23:33 -0500
Received: by mail-io1-f47.google.com with SMTP id j18-v6so3185625iog.6
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vq8/STd6YbRJmC6NfS56gff1pB+s7JMpOezVQaBLX3E=;
        b=lLieOH5Lbwe2GRXy0RXDxMNRW8EQA1zKcCYkDQjghJiL7WoeqysGW1d1wo1Q0ROjhc
         OFgzneLuBpMjrV9dnyhKPQGwC8hH+gsXwlMzW2kUuGUxqFyMZgq699/jLvquhsHa1IQT
         Tlbfpb63wNhz4yLNSg3MQAW0OQrnbK5xh6c+ipd0jlUqF9YDASF5XZ/8ML9uIppH7NIU
         svFlD4WzqbyV5BmrCTe+vsZHsGf+Eg27U0W4ManMpxZfoPCCSU2xnfq/jB56v5Jz4PVC
         J6WTFjhnsUBw5YfPTpBlZzSBEPZMvx4v8xhfg7Shq5Mno4xCfuEX0OA8v1DlFsJ8Vkdn
         dWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vq8/STd6YbRJmC6NfS56gff1pB+s7JMpOezVQaBLX3E=;
        b=T4+47S9b+0po5ePANpARWEvnv3D67YX1ZGUtHF3LyAnInBnQluXAIzahQKYt6aOXnl
         wxFrgBrpLblfWDXpjcIU2+bdydlsONCfX9ZyQRLnnxc5UBMGUEfjxa+3X5ti0NFnb8zf
         uEDkIDkTZa19A4XG82hGFancczHA7Xu0f8F9YAZkM3+aWRT5HU5ytoOUGvwXeQPKMpFv
         mCKXym3mPlWF17R0Q3aLleQKr+FfiC05WI1k/DTm2ent0/H3y4U+EGec960fdrmE99jt
         73XVnSMA0ojkg2l4wd+3gn/Shod7H4j+ZvnAPLRjbDYCPbqtfxyXOwQvogkorfkzdZAI
         u2Ew==
X-Gm-Message-State: AA+aEWaafQt+QuOFvX8jqSkg2yYkZ4R7Yqg1l+D2AShakXdZvV5SkxFo
        rJ6k+5NACXnjrIvir3lFnPD9wQ==
X-Google-Smtp-Source: AJdET5dUm2qp8xUpwqWqZr+E4Y6n0VKXwpSQK53PPyiKDr7aCwbNGwExeM/+og2hr5F7Mms+Q3/EOw==
X-Received: by 2002:a6b:928a:: with SMTP id u132-v6mr5453095iod.97.1542309270549;
        Thu, 15 Nov 2018 11:14:30 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id u129-v6sm9756043ita.13.2018.11.15.11.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:14:29 -0800 (PST)
Subject: Re: remove more legacy request leftover
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Date:   Thu, 15 Nov 2018 12:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 9:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes another bunch of legacy request leftovers,
> including the pointer indirection for the queue_lock.

Applied, with the subname part removed as mentioned in #13.

> Note that we have very few queue_lock users left, I wonder if
> we should get rid of it entirely and have separate locks for
> the cgroup and I/O scheduler code, which are the only heavy
> users?

Probably not worth it...

-- 
Jens Axboe

