Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA93C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DAD2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EsBy+vTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfA2BbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:31:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35654 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA2BbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:31:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so8872902pfi.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDbvhqKG6xawZLpcpUonVZcTUvNf9md7tj+ZxNzeaTw=;
        b=EsBy+vTrgpznW4t+DbushGfSDymOylqK5gUeyw9G/xqFhYlp1rv+hgagpcA4p/T44X
         kA8lnPOoI8iKVXIl5HXQPo0pIBjArIGKu1JANbFpN+ZBX/Yq/hYNsQpnVrxkZIsQoX//
         e5JzssdZg4qjqFbNpDXUQK6ZV3+wxbLtW30N/7CIbQ93PZXUxoP2COQONTcrw1XFzeJ4
         mT+z5Xoc0qOzUDZnxNoOB1L5ePR/0qsIrxM/MwH7N3eqiBxJ+vwJH5vZmysifrWFZ7ZF
         ppNOXaZQ5jZErCxAQwnce+YxgyLaCPpunnu2uAZkfO12S8NqSsjyTlBJ7NsaBDLMbZKr
         Aqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDbvhqKG6xawZLpcpUonVZcTUvNf9md7tj+ZxNzeaTw=;
        b=sOyYBsVB25kFSGVKMJ3+2B8CSTVQ2T6JazJc4baMQlDKjfmrcFTdI06GRE/dCFZIuD
         M0eQFs6bM+B0Vv+zBy8WIfqCoYZmkgi3vAzbutOoAzqI2ld0fMDJAynzTjkach2/bQHC
         Pq4sLJxqm6Ip28jkzGubAl91JGnqdJ2MjxQeRQdVImIrwx4Dj512nyiSC8XB/BLrFHLy
         T8MnmI1d6/RozNv9FIELu0gY3ePS8TyO9EzKSIJrpVLs5YihnI5QoJC/wqzqyqdCq6QH
         RU9R271kIVAmqVPJnDI2SQV7lDDbH/bqokvjNTza2lLG+iSiw3iXWUDc0IvgMRCuMs1g
         rCzQ==
X-Gm-Message-State: AJcUukdG7lodwMTrzqWa+wMKXR301GKvGGRapKD4BIMkTq+8YXCiwpIN
        q+gTDeDeVv67N1w7EffB9kpzWg==
X-Google-Smtp-Source: ALg8bN4a36gk8YTe9rEvSrYkrDjzouArySeIWsZ1JjuHmDFYWppIHeI3VHPeN1FN5onacoSi5xvU9w==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr22283040pgj.17.1548725466795;
        Mon, 28 Jan 2019 17:31:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j6sm58663043pfg.126.2019.01.28.17.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:31:05 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez2gvgBUKNihnjEWeBv1WZiXWwfxcA2Wf90n8GHLket2Mg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9170f97f-bea3-04b9-71db-a0f250d1f610@kernel.dk>
Date:   Mon, 28 Jan 2019 18:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2gvgBUKNihnjEWeBv1WZiXWwfxcA2Wf90n8GHLket2Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 6:29 PM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
> [...]
>> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
>> +{
>> +       struct io_kiocb *req;
>> +
>> +       /* safe to use the non tryget, as we're inside ring ref already */
>> +       percpu_ref_get(&ctx->refs);
> 
> Is that true? In the path io_sq_thread() -> io_submit_sqes() ->
> io_submit_sqe() -> io_get_req(), I don't see anything that's already
> holding a reference for you. Is the worker thread holding a reference
> somewhere that I'm missing?

If the thread is alive, then the ctx is alive. Before we drop the last
ref to the ctx (and kill it), we wait for the thread to exit.

-- 
Jens Axboe

