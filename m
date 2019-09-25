Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39210C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D3F21D7B
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfIYXkL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:40:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34789 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfIYXkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 19:40:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so547222pfa.1
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 16:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nNGAyRKF6AeH50MTgcOPtWcL5zSxdP/FZPqgic9gUeo=;
        b=c0bSGH50CtSedWlas1SGLp35cXjqtChNcXdBCMgZLtKZVxVQNC4pTUfiIJyZfjbx2J
         OcisiP3L4uNqaDY3B4ksHxYPjftQQEaGN6rc+HawH9+GiU+zn6z7zlH/wpylRWafchdH
         sgz/4ByxGb069p8rrZV9mFHMk8WPUKyy6UTwMiD5NjPd0LXxztk87xJsEt8WqMtWsGkZ
         ax48urzNldcFLi0MvUk9SRVUCJ/iXF8zTrzgqergJb4xW057UuqRLe/7KuwYAbF3XGM6
         zVw8rE7cmrW8QnRI/keoCmNiGYyfv33jxnfMWzGSnOFiDuXGDPvadwloAHW3KFRFZOnR
         3kpA==
X-Gm-Message-State: APjAAAVETd3yBmR5927xzgWV4dFZ6QJyoLi4B9/hhbe61uMq1O6NUELQ
        jMsrkWq8uHjNvY3VaAmA5Ms=
X-Google-Smtp-Source: APXvYqxXo18kG6f1Wrd6fOgzyES/amRf4sj4sMqfwHv/dF9T2UOBRc69zSKPbKYfYBShPut5i2bDNw==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr282044pje.57.1569454810702;
        Wed, 25 Sep 2019 16:40:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l62sm121843pfl.167.2019.09.25.16.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:40:09 -0700 (PDT)
Subject: Re: [PATCH] block: don't release queue's sysfs lock during switching
 elevator
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190923151209.7466-1-ming.lei@redhat.com>
 <bc5864cd-a62b-d6d5-2d69-6ec03983508b@acm.org>
 <20190925001333.GA29621@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <40f53e8f-4fd8-73a4-dc8d-4965f3d6c3c5@acm.org>
Date:   Wed, 25 Sep 2019 16:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925001333.GA29621@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 5:13 PM, Ming Lei wrote:
> On Tue, Sep 24, 2019 at 11:37:09AM -0700, Bart Van Assche wrote:
>> On 9/23/19 8:12 AM, Ming Lei wrote:
>>> @@ -523,11 +521,9 @@ void elv_unregister_queue(struct request_queue *q)
>>>    		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>>>    		kobject_del(&e->kobj);
>>> -		mutex_lock(&q->sysfs_lock);
>>>    		e->registered = 0;
>>>    		/* Re-enable throttling in case elevator disabled it */
>>>    		wbt_enable_default(q);
>>> -		mutex_unlock(&q->sysfs_lock);
>>>    	}
>>>    }
>>
>> Does this patch cause sysfs_lock to be held around kobject_del(&e->kobj)?
> 
> Yes.
> 
>> Since sysfs_lock is locked from inside elv_attr_show() and elv_attr_store(),
> 
> The request queue's sysfs_lock isn't required in elv_attr_show() and
> elv_attr_store(), and only elevator's sysfs_lock is needed in the two
> functions.
> 
>> does this mean that this patch reintroduces the lock inversion problem that
>> was fixed recently?
> 
> No.
> 
> The lock inversion issue only existed on kobjects of q->kobj & q->mq_obj,
> which was fixed already given the queue's sysfs_lock is required in
> .show/.store callback of these two kobjects' attributes.

I had confused e->kobj and eq->kobj, hence my comments. After having 
taken another look at your patch:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
