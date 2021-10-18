Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE40C433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E693B60FD9
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhJROgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJROgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:36:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AFC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:34:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so16451918ioa.13
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tE8jmwZbXHSe1lfo+vg3pkJIkDY0r2Wj+hHtkO0tB60=;
        b=WQpJdmx6muygahRG9z/8hNuAeGSrs5alV355bFGyK/c30aiiDXX6ZoFqOEeuxAx32s
         we2SGAohNAK1p7J1FVRNxIq71nZhaTxThOLX20If3CmIeR6APeyZmC6v1GwFRV6rOBX5
         95f/xKyFTBQ9E0HjwUMXWdS0j3qttwPHVSpLN6jpB+QI21f74atek4SqNFcCEuFHwzc7
         pnwr7TPCizYk/u2ljqYPghtFf6s1llj/ygkuyDf7GGUypanyOXlPQME6gOt0wjuo2nQN
         IbdsJqMQ5Io2Rsf0w+UuSxusXE0m94EEpVUsN7xbMMewinheU3bTzIJrb890/r0EGIAH
         +Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tE8jmwZbXHSe1lfo+vg3pkJIkDY0r2Wj+hHtkO0tB60=;
        b=FXO33F2S62oPy9LdWx7MnbgsZCJJcSr9OJbXZZzMVLVLbb4+AeeupRmNtQiw5tryq0
         ES9s1ZgQ5+QtlcRpeGICC82OfgJTYJPqjbmR7k62Tvp2FKgztavKZR7v4n3Jtyr+EX3r
         5tJHJpcPldVM72ypR9HJcQz7LWXtJEX5+dLMvOo3vJFQ4G+cSQKzhHVp0hAOd5Bw3sWw
         BrdwEQZIazYyONxR3eJyEXK7qo0gNvs4pAVMVPHavmF1wv4hlnQObsoYgvCTX+8PaKrp
         8sizs6XJVDdxcQxXA+uDZU3gnYZae4ehC26Fi1kpOohntUJ3MVNsVc0IFaxVfuqlq16p
         TrXg==
X-Gm-Message-State: AOAM5334Ih8Q/jhNd/CNj9+D9m5xYYML1ZMdC+XFGS35q2+haoNT2zLj
        Tc5i+jKxKfQ1GohdZ0XHhP0v75BBSeC1fQ==
X-Google-Smtp-Source: ABdhPJwCZwX0TL1nLz4UMw5kBlEDyJ2MQR8BGe/kGPMeo4M3l2D3A+MAuLVUETYB8Hw1uhdX0aR+pg==
X-Received: by 2002:a05:6602:29c6:: with SMTP id z6mr14477883ioq.215.1634567674153;
        Mon, 18 Oct 2021 07:34:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o1sm6937885ilj.41.2021.10.18.07.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:34:33 -0700 (PDT)
Subject: Re: [PATCH 06/14] block: store elevator state in request
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-7-axboe@kernel.dk> <YW03PQZa5WYWoYlE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b125578-0564-0bac-a45e-126ed991133d@kernel.dk>
Date:   Mon, 18 Oct 2021 08:34:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW03PQZa5WYWoYlE@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 2:58 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 07:37:40PM -0600, Jens Axboe wrote:
>>  
>>  static inline void blk_mq_sched_requeue_request(struct request *rq)
>>  {
>> +	if (rq->rq_flags & RQF_ELV) {
>> +		struct request_queue *q = rq->q;
>> +		struct elevator_queue *e = q->elevator;
>>  
>> +		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
>> +			e->type->ops.requeue_request(rq);
>> +	}
> 
> I think we can just kill of RQF_ELVPRIV now.  It is equivalent to
> RQF_ELV for !op_is_flush requests.

I'd prefer not to for this round, as ELV could be set without PRIV depending
on the scheduler.

-- 
Jens Axboe

