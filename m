Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7BCC433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 20:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093F320658
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 20:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHTUap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:30:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33249 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgHTUam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 16:30:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so1698751pgf.0
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 13:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00Y9jPgKO+93yZFGZekXhGpKvHJIdGjSZDSojYICQXQ=;
        b=FfkFtOv8Tvo2L3iQn0cZRly+sTXetIZQ3K58Vbzurp+2dkN9hqNFg+LZXCaZ06oxrN
         vvytdByn8sw56+svPJ3I20YxXuRn7QmeyzBcVd27mEIdzdDoed1lGP70wDGxDZm5edCq
         +EGTKY0tg/BoBgA33Idi+OgYH3ljxY+a6ljCell7TAF7c9D3srHIiTQo102gLub8r0KK
         3beo7PHshgGHehY2zQ7i9eRN9hFvAaP1l9ga/UqG+zYhFzqCW67jmJEICcDx076r2h5x
         YFzsvHfjlZQPGwt8a0APeW1A3NQ7z/MArikIAXlRBeFOcbyYm3BMU/UKlwqaRZDfuTGk
         O5jA==
X-Gm-Message-State: AOAM5306Y8XGd+jkHJJL9ek+rEzjkVHt/MZSxkgy9GJ+o/Gi6oJ7k6wZ
        5q4FpOVs784n2aNwErnOC8M=
X-Google-Smtp-Source: ABdhPJxs07O+GwN4toyMmWoUIul2bIA3vhF4fyqzm/+p6IZKuno2Bo/SIKCdSAjtFahUHeffPz9/AQ==
X-Received: by 2002:a65:669a:: with SMTP id b26mr359660pgw.418.1597955441078;
        Thu, 20 Aug 2020 13:30:41 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c4sm3772907pfo.163.2020.08.20.13.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 13:30:39 -0700 (PDT)
Subject: Re: [PATCH 0/5] blk-mq: fix use-after-free on stale request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
Date:   Thu, 20 Aug 2020 13:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/20 11:03 AM, Ming Lei wrote:
> We can't run allocating driver tag and updating tags->rqs[tag] atomically,
> so stale request may be retrieved from tags->rqs[tag]. More seriously, the
> stale request may have been freed via updating nr_requests or switching
> elevator or other use cases.
> 
> It is one long-term issue, and Jianchao previous worked towards using
> static_rqs[] for iterating request, one problem is that it can be hard
> to use when iterating over tagset.
> 
> This patchset takes another different approach for fixing the issue: cache
> freed rqs pages and release them until all tags->rqs[] references on these
> pages are gone.

Hi Ming,

Is this the only possible solution? Would it e.g. be possible to protect the
code that iterates over all tags with rcu_read_lock() / rcu_read_unlock() and
to free pages that contain request pointers only after an RCU grace period has
expired? Would that perhaps result in a simpler solution?

Thanks,

Bart.
