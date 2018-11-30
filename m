Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F0C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5852146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CAasi1KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5852146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLAHql (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:46:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35932 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeLAHql (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:46:41 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so5615169ioh.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AiCE9ybwgaybJ3FxxjW1P1n+S0dhX33JJkgIGJ/EOJo=;
        b=CAasi1KDC6JWoC71sZ0Cj4axaxtxIMWbsAQYCawlFu1gZhp5MJZGysUQ5nEh0fgowS
         RmaYLHbqtS+SUFfCofwZFrmNwzjI9+DbZD4NYzFvyfc5ABOsqzOMZ77DKawERvUlB2Av
         CHcSGNAq3f+t0gl7vqqTk5wWEW3kPL4quM86XkfE5VJn+aTz1q3fjqaXfIDdnhiDXpZ5
         xGiH7QBcsIsy3CdXL0UuyBfzXM6N6wxLmOWnb08NRvAdABzdFYI5EH3Nr3rEB8O3Anhg
         oTiI6MR5UNuyGO+VcInGW2NK5ZZ/tTiI7ydzYyBRZML7Rjxw3PTbO0uQIE9uIkzDo/yV
         Afcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AiCE9ybwgaybJ3FxxjW1P1n+S0dhX33JJkgIGJ/EOJo=;
        b=i1cIrZXeG6C9ktPC3FmqH8V8TWaq6ojz36hWdCEQUhTUicSR5vwh37KsPpvpSnLsXo
         aVe1jcU5+gRRxCmrYLcDC9Liv+VLHRfu6M0mjX4AbwBe1habKpK/OtD1Gh1oID2KyDCz
         3V5Al2eBnG3uACIDIbv17R0GlNabHLL3d3NGm4gajo3xPS41FFvD+DNFhWruXPnKO0ak
         672W3zO58I+2dbBc2YySjC3zmn9Bt8nBINmap6ZA4JXFqA7EAcflMnxawfNYY97TcqSR
         JfUnd1L7NkpMPev8zWjb2G/scJrXlLrQGa1NyN2YXhEypXsD67A77sqrqv7pQS3kOE+x
         UMCw==
X-Gm-Message-State: AA+aEWaHk5uBiVfhjChHjdrOBUEMsHGUS2POvH2KmOUEOTvBXvBCpolP
        tqsUjm6Mfwt5Ktd+M6nVqRqcbq9bYpQ=
X-Google-Smtp-Source: AFSGD/W/f29lN80F9RHgDrI1+g6PxuE3KspIMsKuoX2JfuO6prX1Z4GpdLpZZ7zq+sYtSgPfu5Zdig==
X-Received: by 2002:a6b:900b:: with SMTP id s11mr6099661iod.159.1543610171034;
        Fri, 30 Nov 2018 12:36:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g12sm2321105iok.38.2018.11.30.12.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:36:10 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181130202635.11145-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
Date:   Fri, 30 Nov 2018 13:36:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130202635.11145-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 1:26 PM, Keith Busch wrote:
> A driver may wish to iterate every tagged request, not just ones that
> satisfy blk_mq_request_started(). The intended use is so a driver may
> terminate entered requests on quiesced queues.

How about we just move the started check into the handler passed in for
those that care about it? Much saner to make the interface iterate
everything, and leave whatever state check to the callback.

-- 
Jens Axboe

