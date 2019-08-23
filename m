Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82614C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6037921726
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390587AbfHWQgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:36:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436780AbfHWQgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 12:36:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so6050269pgi.6
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 09:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hzIhsVkI8VDtHuuhTs1hOxkgfepOawlsHgvxrs8lFrE=;
        b=mxGOK/uwfoAbIqdlGjFpmCHNUu06JhDtzndaLV0g4zSEwy7A60s7DyfesJc7VFwFdE
         us6cmk0orM9rasXNlc5he5vOC3BkMfeUNuBViFzTlAMLAnHMbEYF/qh6nsmdBemGJ+iO
         ChDWoHFluiWB7a1UPnEgCm0zQ6rMuxclQdwbHtrFaPfT2FYsMRcJgXJ+LOWA4ncRCXn/
         KzPaZWvnn8NBwByD7mS5Li00TWR32ntWIdPz1OtG0ILSU/czPgbC4dzFjLaubhw7OijV
         MdvXzJCwc64LQYt2wc3TpwpwPjRm53+EQ116fNj1CHK78Z4kgWgr+kIVgJ7aqKADlv9w
         j4Sw==
X-Gm-Message-State: APjAAAVF5YeRL9NJH1N/m2bXd+xm6xSiE42v3QXYXD3lK6EGxVioh/62
        0c0IstL1YkD4MM1SFhZq9/U=
X-Google-Smtp-Source: APXvYqyZQpZb9FHAvYjEl2GVaMw0McEZFwzd1B99ToswcM9McfrtFgTFlaorOrR/l6cx100MSUmE8g==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr6161497pju.117.1566578182667;
        Fri, 23 Aug 2019 09:36:22 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id y8sm3237460pfr.140.2019.08.23.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 09:36:21 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
 <6d97a960-52b5-5134-5382-dff73be00722@acm.org>
 <20190822012839.GB28635@ming.t460p>
 <04b567f5-df49-3d44-1707-14fe8445843e@acm.org>
 <20190823010804.GA16810@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <eaeec312-a8d0-09c7-2e05-2804a04433f3@acm.org>
Date:   Fri, 23 Aug 2019 09:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823010804.GA16810@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/22/19 6:08 PM, Ming Lei wrote:
> On Thu, Aug 22, 2019 at 12:52:54PM -0700, Bart Van Assche wrote:
>> Shouldn't blk_register_queue() and blk_unregister_queue() be serialized
>> against blk_mq_update_nr_hw_queues()? Allowing these calls to proceed
> 
> It can be easy to say than done. We depends on users for sync
> between blk_register_queue() and blk_unregister_queue(), also
> there are several locks involved in blk_mq_update_nr_hw_queues().
> 
> Now, the sync is done via .sysfs_lock, and so far not see issues in this
> area. This patch just converts the .sysfs_lock into .sysfs_dir_lock for
> same purpose.
> 
> If you have simple and workable patch to serialize blk_register_queue() and
> blk_unregister_queue() against blk_mq_update_nr_hw_queues(), I am happy to
> review. Otherwise please consider to do it in future, and it shouldn't a
> blocker for fixing this deadlock, should it?

Since what I requested would result in serialization across request 
queues of I/O scheduler changes, let's keep this for a later time.

Bart.
