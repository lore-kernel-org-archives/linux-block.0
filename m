Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F613C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 19:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2129217FB
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bZ7pztzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeLPTMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:12:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45541 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLPTMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 14:12:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so5011123pgc.12
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jv0h4hkrvp9CsYAz8jFhzLLetSrqtoBeab/sIJPcPeo=;
        b=bZ7pztzxBXlr1ri8McL82uPmaIjN8nmUFptcpRJaqPxdrios6cGMsMb86qIcWQldU7
         B7L4usl7ATxBdOLZwJcxoBjxz82UCY5yqBmiFT2p+/ysWO20URIBpS8dpl4yuKr02j59
         G0UqV5E/TLkxf76eBveeCpfq9QolG8GWOR/vaHRPs1qnO8kcQ93GjxJ9xHEzQwRyIovA
         Fhdy5RJn/Bv1XKeXoKn6P1RPVVh/xDkSQxbjJ3qYO25WevnPyCgYbbD8s3CnL/Fxpwny
         JdN4nLbaTF7mlTbbpsW5O047GRlt5QVt7Mc6HVBBR1ACNqIZ3trCVzRuVtvrQkkbBuvo
         /1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jv0h4hkrvp9CsYAz8jFhzLLetSrqtoBeab/sIJPcPeo=;
        b=jsppJLxE0SQcWo7jc2FqrBQO//hEl05bg7oKoGvXr4HNi4Ke+lR9jCFsns5MbV9AWA
         lylmgAZZ3qKNM03qV2Gs2V16hET5KhUZAOanNk3S/Hq5MPWoT1QzQ9js5cDeyxpr5tIY
         ncmYG5JaPf0kh45Jz1d6SirvOVhSSr0s1VtkNvyAJgGy2WXm8xihl51E1dQ3O2m3WS8F
         aIoiQTlGwoyGPnEJgbFUOl6l3yWyc2ro31aYe302OC19r246gCcfyswcgyuKc7XmMZB2
         ENKxl1CsUXaSzQJMobjx0oRajIN7Mt/+wWPm/2UmgWbQX3NSCvZKpI0fXGWvyEkYTct0
         mctg==
X-Gm-Message-State: AA+aEWaCVxjg4NtwXQOK+xU1l7K5SgE8nH3FBSbcYgA8fs9kie39ud2f
        Fp4yN90xoIsO6DwrN19tVS6QNQ==
X-Google-Smtp-Source: AFSGD/UYLTzLWH9yA5MLrIghZEhGhm8LXiqPsE7GvSYdJPejgo3bK2r+lpTnZTyQaNG7t+N4EOlTqA==
X-Received: by 2002:a63:5761:: with SMTP id h33mr9689598pgm.283.1544987541702;
        Sun, 16 Dec 2018 11:12:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a73sm17354532pfa.7.2018.12.16.11.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 11:12:20 -0800 (PST)
Subject: Re: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-4-ming.lei@redhat.com> <20181216161650.GD9957@lst.de>
 <20181216183937.GA25476@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c410c10e-f992-5a67-0dce-1ba6bc428de5@kernel.dk>
Date:   Sun, 16 Dec 2018 12:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216183937.GA25476@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 11:39 AM, Mike Snitzer wrote:
> On Sun, Dec 16 2018 at 11:16am -0500,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Sun, Dec 16, 2018 at 10:25:16AM +0800, Ming Lei wrote:
>>> This patch sets map->nr_queues as zero explictly if there is zero
>>> queues for such queue type, then blk_mq_map_swqueue() can become
>>> more robust to deal with shared mappings.
>>
>> This looks a lot more clumsy than what we had before, can you explain
>> what additional robustnes it buys us?
> 
> It enables nvme IO to complete on my testbed with for-4.21/block
> changes, this NUMA layout is what triggered Ming's work:
> 
> # numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 2 4 6 8 10 12 14
> node 0 size: 128605 MB
> node 0 free: 128092 MB
> node 1 cpus: 1 3 5 7 9 11 13 15
> node 1 size: 128997 MB
> node 1 free: 128529 MB
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> 
> Without the aggregate changes from this patchset (1-3 anyway) I get IO
> hangs in blkdev_fsync().

Still puzzled. I'm not against the change, but the commit message has
NOTHING in the way of justification. "Make X more robust" doesn't
mean anything. Your followup brings no extra info to the table in
terms of what the bug is here. What exact bug is it fixing? Why is
fsync currently hanging?


-- 
Jens Axboe

