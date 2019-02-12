Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF2C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8E320863
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HpG4HgQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfBLCvb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:51:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfBLCvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 21:51:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so521700pfh.13
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 18:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Pnxc4sYTkSQRfOA8nDVkGq77zV6G2IaOi20cBUGGEM=;
        b=HpG4HgQvr6xIRU9ij9fQ5laMnzeR9rM3QYGyeyBBmh68Ar0BSDxpuY6XjfojR06SUe
         VNyF0AM1AtQ2t+6sN/qK6DTEFuRRj34vLevgnOR/eWxPPjrtBVBjDRlYylA5H8iNE/WR
         10k/6xMzqn+ip33Ve103YQjk4MlRXZiH5G7a72x/r4How5sr+aC3r/1UMF1taW7xjgxJ
         HyiHJ/Epwnss6Gpe1HZNI0ng0dZq9q/yP9wpEDe3q2qU13Gshi2y5+cVEgxz7iiL58vw
         7RWtejXiwQdoOmlTnaqZ9V1UnSlOKnvAIhEIZcRHTRQ0PKyALwqeZaYusX7hnibI/nfJ
         PKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Pnxc4sYTkSQRfOA8nDVkGq77zV6G2IaOi20cBUGGEM=;
        b=t0QLpIuMcyOtP5uXDEPT2cBgxaJtUBtNYeRHtfJoi6EXOl5MI21lxz3WeL9bJOl53S
         ik2Qdq93Ze1M0vZ+KPncETKbk5nGUXdmn6OH7GGhhH96fHsl3dSh1V7Lx1NKxK4btWc1
         VPyDTSlEt3XnIkFpijfbQd85LPBWWgcSksUpzGducn520LkmUE13y/0U1IQSNy/1bvOR
         CRuwSMjF3iBu+aruoGXXqDn+jYhWKl4ZLQMVYLvHw+9UikFtP67+reMXTCtIbMKkGP3I
         4CGyRUds0Nob0WIdxUI0FgGqWXn2zqABq+LPUk25Y4erVqKna266uc+lxs9cyHlvsnMt
         0Qdw==
X-Gm-Message-State: AHQUAuaJwQbHGL+KpoA1AlneCuDNClyTflizuieT1jkR9wEJhfw6S7VZ
        +GmNU50dci+JYQ0Ifiq22RVeLw==
X-Google-Smtp-Source: AHgI3IYqi7EoCKWAWGKQC1aHu0vX+GoWusduQVU8zOYN4CuMosaT6KgLS6bhB43Hv4FPlAu44CRUjg==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr1497632pgc.165.1549939890496;
        Mon, 11 Feb 2019 18:51:30 -0800 (PST)
Received: from ?IPv6:2600:380:4a5b:8858:a8b3:edff:f3de:ccc1? ([2600:380:4a5b:8858:a8b3:edff:f3de:ccc1])
        by smtp.gmail.com with ESMTPSA id q75sm18837797pfa.38.2019.02.11.18.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:51:29 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <077964ab-0502-49ab-132d-657d32df7461@kernel.dk>
Date:   Mon, 11 Feb 2019 19:51:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 6:56 PM, Jianchao Wang wrote:
> When requeue, if RQF_DONTPREP, rq has contained some driver
> specific data, so insert it to hctx dispatch list to avoid any
> merge. Take scsi as example, here is the trace event log (no
> io scheduler, because RQF_STARTED would prevent merging),
> 
>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
> 
> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
> the sdb only contained the part of (32768 + 8), then only that part
> was completed. The lucky thing was that scsi_io_completion detected
> it and requeued the remaining part. So we didn't get corrupted data.
> However, the requeue of (32776 + 8) is not expected.

Looks good to me, I'll add this for 5.0.

-- 
Jens Axboe

