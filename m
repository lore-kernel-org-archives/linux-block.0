Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21DC3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4E02077B
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="voEl1xim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfICTWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:22:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44228 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfICTWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 15:22:02 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so38509465iog.11
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29dtAFPf34LxGH/UUfzYlaG1O5dS7BXSw9jlWp67F8c=;
        b=voEl1ximKls/CHflGcztyqprJBz4GJWnF0D9iQrARetjSUY5FM8m65i3q5k3tbQWQ7
         Yj2s+fKyQle47M78dVTd4avxZcIGVNxEZvlfKUPf/zbvuro4G3mTEfJNXHeG0wF1VXrI
         RjEtncz1zhWQwN3m1ah3oWfp67udechQZOV9XX4AxpvTvLrd8uaAyQD+gCHpJkRPDjRf
         xn+ptBl2YqBWF8COlppdc2taHxz3dT6K4ZVvVSmSHqZ+ZhwhPQbT/YMePjt2IcLrmmoy
         MiAlNNV2jg1Hm9ZXhDMH1xfRC0JV8/YLBqKlYAU99/nk1Xt9TE5w8hWTV+rLv1idTxgH
         aoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29dtAFPf34LxGH/UUfzYlaG1O5dS7BXSw9jlWp67F8c=;
        b=UirhuLjxKDhODfdRT3+p1pVaqNnQUb8rVT8yr+Ul/ojvxPc30J1rcQZtiQAmhWYRlF
         1T7hN1x9F3HuXDt4Igu1GkTkCxF0EInUPLEeKmJf8jkDJM0C91NpdJy7LR1TwPD+A/k5
         apEP02HN4piTd6JVSTkqLA76fI0ki2V7GDrs7Cg8X2wJ5C0pVbTSHJ0D7F3ZdGuxVZ8N
         hA+zxxQMDR5So2g5s0ktbZ7lcR9N9XJwTI3xHRDCkUdgR8YlsSMMZh+mkNO2kmob5UIC
         I94ZlLG26c4XQ5WNqbqujD/TPMHWsLTx+e6GMTAveFpGOwJne30EPdzsa7ATFeeJtC6C
         RWKA==
X-Gm-Message-State: APjAAAV39IXQ53SRPdwlQtX6fmfOvPqr1w9H3Ty8yf4QjMEV198oD7MU
        GcpIqrwRYpiFN05zeHKPvTXKcsvPOCz9HA==
X-Google-Smtp-Source: APXvYqzBMtMZ2ZLDWbSZL0p1Rzk8Q6xurNani/F3mC7VqI3TC/2Wga/K5TZsESkUAb0XIIkxdMiP7g==
X-Received: by 2002:a02:ab90:: with SMTP id t16mr4273892jan.110.1567538521476;
        Tue, 03 Sep 2019 12:22:01 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i62sm13973375ioa.4.2019.09.03.12.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:22:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
Date:   Tue, 3 Sep 2019 13:21:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/19 1:11 PM, Sagi Grimberg wrote:
> 
>> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
>> +	    error == BLK_STS_OK)
>> +		t10_pi_complete(req,
>> +				nr_bytes / queue_logical_block_size(req->q));
>> +
> 
> div in this path? better to use  >> ilog2(block_size).
> 
> Also, would be better to have a wrapper in place like:
> 
> static inline unsigned short blk_integrity_interval(struct request *rq)
> {
> 	return queue_logical_block_size(rq->q);
> }

If it's a hot path thing that matters, I'd strongly suggest to add
a queue block size shift instead.

-- 
Jens Axboe

