Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC6C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B1E20700
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oqwmfpK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B1E20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLFPTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:19:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38991 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFPTa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:19:30 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so1958253itl.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NMb8x1M1yA6S+t3bU8+fBaScmnvLKxY2xxKbeilHybg=;
        b=oqwmfpK6JK+lCqLoOUOAFcAXi7fiJamImbWbktdrqcrs1iuV8hl9TyK/OjCiNNPV/K
         dU82sxg49w63uVMuLrJEF5pYnUy5r0y+Yn2s83U9xommKd3sPXDmmL31lgC6pHSDi6la
         vrGOAJHEdQ41dNJ+VKsxcqD51np84O7ElRYzPSW57LyCSIUjn4gVy544UAklyvlUY6Jq
         Adsjogis+WFvRZqDRlIqh9z6Tc7u2pkhrw0JtKZHMOe5VUZ6PZ6Pv6C3iRW5ysxjcPgS
         UP/bVKUhI9SdIpTymbNd17rjkd5x2vUQZxUWqvhxx9ijgLhPQ7F2QL47I/T0i9DPlLLa
         2QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NMb8x1M1yA6S+t3bU8+fBaScmnvLKxY2xxKbeilHybg=;
        b=Hs/wDJiiZ1ygKwYQjYsQQf3JTXqJvGcxl+wjWEK5uCpjkcOhKOK/xi/zdSzsSxUTzD
         tDkqBXRspkmYv3rAUUFS4Vd2WGum5jzxOyKkp07gdIjNGPTyrPqQgNMEGR9zYI0iwYm1
         SfiLBJteLxCScH12rhEsaPspNhmAC0WRiw0GDxm160bdWdRWsiTdNvFfIKo5vFWE1MiQ
         Av5KY1+awF5vHcJDrAu0CjJTOr6y3pCszn5dqi40RDxPSZvvFW1EBGRQ6nmvh8wZF35A
         Jn9yc/2Qzn6ClR2z4aitYgbqjo5e1K3wmwEILHIDJ6WjlfEojfiE4boYEuGkcPilV7Xa
         V2MA==
X-Gm-Message-State: AA+aEWbFvjutBjOp1E/Nes7uH+oqd0qRw5KTbODbhNRLsoTJcbdf3ToN
        TRnCK7Kb2vCwICzgu+MBp6947g==
X-Google-Smtp-Source: AFSGD/XHkbjLGRg+iYEe9blfvmuXAu/w9tNrBJ9x90n528cCgj65lG5jQZHXC+ZUCFCdhszzp3ojRA==
X-Received: by 2002:a24:2f82:: with SMTP id j124mr17888969itj.166.1544109569480;
        Thu, 06 Dec 2018 07:19:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f13sm245100iol.82.2018.12.06.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:19:27 -0800 (PST)
Subject: Re: [PATCH V10 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
 <1544067160-20564-4-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <840accff-5050-744d-9c95-febce5433ab2@kernel.dk>
Date:   Thu, 6 Dec 2018 08:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544067160-20564-4-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 8:32 PM, Jianchao Wang wrote:
> It is not necessary to issue request directly with bypass 'true'
> in blk_mq_sched_insert_requests and handle the non-issued requests
> itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
> handle them totally. Remove the blk_rq_can_direct_dispatch check,
> because blk_mq_try_issue_directly can handle it well.
> 
> With respect to commit_rqs hook, we only need to care about the last
> request's result. If it is inserted, invoke commit_rqs.

I don't think there's anything wrong, functionally, with this patch,
but I question the logic of continuing to attempt direct dispatch
if we fail one. If we get busy on one, for instance, we should just
insert that one to the dispatch list, and insert the rest of the list
normally.


-- 
Jens Axboe

