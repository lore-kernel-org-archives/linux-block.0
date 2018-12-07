Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD45C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF320989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2J+rL/tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCF320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLGBS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:18:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46103 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLGBS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:18:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so1045080pfe.13
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9YXCB5urI/dW9wENhRy9IS0IgUsBt68fh08QEVt3RKw=;
        b=2J+rL/tkld49d+T3xPLh/31UxdRG4FGzey3pVTu0Yv0EM1d6/naRsKub5uHFpjRHE0
         g5uNgYciUDxnBI20dEnneS1elsFlaseoxIDLv+BVvyKu0XwGKad0Y7rgkr+Gt9zI9mam
         IMcjujnLpMhQIMsETEi6zHI4NTAEB3QAYLVDfKtaYA+1ESk5mVBn8F4o/s3iMTVV92uf
         nw7WIdkq40hk3MyBKDGsS/N+KDPDWFilRlbXbQzE5+CcY56O96qAaWLRm13fAjZfwLBW
         3caOTJZu1pcZRtiVop9YlqhOAmtcPaLH82CtMu2kc+f7LBQALvnzydZ6VH5fsDNuf2xt
         Lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9YXCB5urI/dW9wENhRy9IS0IgUsBt68fh08QEVt3RKw=;
        b=CjYCLfU4eKipGsvF6hMe/+N+oCag1D0Zk2rUWE8YN9Uy4F5jq7AH09ztsaovs54p6y
         5MoC+2CkYQZDzJtsaAMIppC6MzMoXMntrym5RQORrPKDCgsm242UNbGugaoNmjZgNRjl
         /8CONU+HmE/UhZjHZZRoMq8uVsJoPuCXpx+3YX1LLZs/Bd6bd1M18grvzvysGQ4lqih+
         mwRC1Yapp2LO8yhGrWPgARGdNndYzYLgMRKg7ikqj2FI9xGcWAO60i4cBHmVYbnJEJcL
         jUK42j0OS5J5dKnjV+A8ZayxE4r6VVEscPixtZPAhhM8qZZksgns3pH4LZbTo7CBVnMf
         VAEw==
X-Gm-Message-State: AA+aEWZeovICsbxpzMciXzmmBj811mJfXxcXKHgm5Gh/+EILaTq15PkZ
        5sU1I+J3tVlMv1xDc3LQl4zWchAdmjA=
X-Google-Smtp-Source: AFSGD/WGCcyPQVaDX/zQNStYuFoZYGaCKdaQl0QtU7VnJKiOd2TPkuAbS4n8NOmcbjTV9Cy7by4/MQ==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr218803pgi.244.1544145536712;
        Thu, 06 Dec 2018 17:18:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 84sm3456173pfk.134.2018.12.06.17.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 17:18:55 -0800 (PST)
Subject: Re: [PATCH V10 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
 <1544067160-20564-4-git-send-email-jianchao.w.wang@oracle.com>
 <840accff-5050-744d-9c95-febce5433ab2@kernel.dk>
 <eedc417a-3ad2-e586-2ef2-a051a403228e@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c4d6425-6ffe-f306-a7d3-6da2fe791838@kernel.dk>
Date:   Thu, 6 Dec 2018 18:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eedc417a-3ad2-e586-2ef2-a051a403228e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 6:16 PM, jianchao.wang wrote:
> 
> 
> On 12/6/18 11:19 PM, Jens Axboe wrote:
>> On 12/5/18 8:32 PM, Jianchao Wang wrote:
>>> It is not necessary to issue request directly with bypass 'true'
>>> in blk_mq_sched_insert_requests and handle the non-issued requests
>>> itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
>>> handle them totally. Remove the blk_rq_can_direct_dispatch check,
>>> because blk_mq_try_issue_directly can handle it well.
>>>
>>> With respect to commit_rqs hook, we only need to care about the last
>>> request's result. If it is inserted, invoke commit_rqs.
>>
>> I don't think there's anything wrong, functionally, with this patch,
>> but I question the logic of continuing to attempt direct dispatch
>> if we fail one. If we get busy on one, for instance, we should just
>> insert that one to the dispatch list, and insert the rest of the list
>> normally.
>>
>>
> It is OK for me to stop to attempt direct dispatch and insert all of the
> rest when meet the non-ok case.

Great, let's do that then, I think that makes more sense. The usual case
of not being able to dispatch is resource limited, and for that case
we'd just be wasting our time continuing to attempt direct dispatch.

-- 
Jens Axboe

