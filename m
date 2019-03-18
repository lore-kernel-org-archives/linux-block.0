Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF448C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBFF20989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XnDqyQIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfCRRbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:31:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37819 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRRbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 13:31:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so11869198pgq.4
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+VrQH3cs+pQ9NWRQ08YnxQceXRyyvIn4lVuNrLgWMk8=;
        b=XnDqyQIgzkeI5Gy7jUo8E98YyRGDt6GBH951NGzLa/IBY3SLBaA8tJQqKa+MCeG4IS
         Z61jQBoBuYOPh+Az4BGjGNLYGQx8/IkR4i7q4WTpTlCY/IR3qUDNhGzLqdL+qpjYHW+s
         cXu4u4Ib8HeqU1BJkO1xkctCaKmtasmksA47U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+VrQH3cs+pQ9NWRQ08YnxQceXRyyvIn4lVuNrLgWMk8=;
        b=SZAZuwLrbSVGuA/R1S1bOt0GNOcsDQt2gQfhawbQyC+j6SQGtMCRDrADLanuuEh4Wn
         HaLAO1lbwszmO+lr+BbXYIjDmwEAEVgLO7n67gik9Ms3S8x+5W5+uyOhDA0sX5FUBYBg
         AOo9AAPrBnbFZEohTqVbDZEvmi4Y8m9ToXxfpwlNimxtRac1u6+7HJrowxcxwH2msLW8
         Q0Ixssfx/3ucXtzl5dwZ+Vu0QgCNjwklsCJk/a6trRXjhak0p1/I2CTOFahISvOgVJr9
         Pn0P3YWy/BltVW/TCJmv1H0GHfO8EMq4usYcBOODZh/MaikhlBsCsWooKRGxyMC3h4Hz
         cO8w==
X-Gm-Message-State: APjAAAVI3/hHOgp4mpJPe+Lfw3MQSR9oobpTukDmkMNj5YCdFreEBP8x
        d8kVy+2wZlXnuztx9z7ZhBVnE8QL6Nw=
X-Google-Smtp-Source: APXvYqysGQplly8c/Nv9usH9GYG/5edDjGMas2z5AOOnPMGYtntF2/xgtGSlcOWjg4/Kky4mFMB/GA==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr20941193plg.213.1552930259531;
        Mon, 18 Mar 2019 10:30:59 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u14sm16455374pfm.66.2019.03.18.10.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:30:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <c6a28972-d33f-6d65-2123-19875db0c07f@broadcom.com>
Date:   Mon, 18 Mar 2019 10:30:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/17/2019 9:09 PM, Bart Van Assche wrote:
> On 3/17/19 8:29 PM, Ming Lei wrote:
>> In NVMe's error handler, follows the typical steps for tearing down
>> hardware:
>>
>> 1) stop blk_mq hw queues
>> 2) stop the real hw queues
>> 3) cancel in-flight requests via
>>     blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>> cancel_request():
>>     mark the request as abort
>>     blk_mq_complete_request(req);
>> 4) destroy real hw queues
>>
>> However, there may be race between #3 and #4, because 
>> blk_mq_complete_request()
>> actually completes the request asynchronously.
>>
>> This patch introduces blk_mq_complete_request_sync() for fixing the
>> above race.
>
> Other block drivers wait until outstanding requests have completed by 
> calling blk_cleanup_queue() before hardware queues are destroyed. Why 
> can't the NVMe driver follow that approach?
>

speaking for the fabrics, not necessarily pci:

The intent of this looping, which happens immediately following an error 
being detected, is to cause the termination of the outstanding requests. 
Otherwise, the only recourse is to wait for the ios to finish, which 
they may never do, or have their upper-level timeout expire to cause 
their termination - thus a very long delay.   And one of the commands, 
on the admin queue - a different tag set but handled the same, doesn't 
have a timeout (the Async Event Reporting command) so it wouldn't 
necessarily clear without this looping.

-- james

