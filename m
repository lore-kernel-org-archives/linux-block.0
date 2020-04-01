Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA6C43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61F320719
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgDATLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:11:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38629 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgDATLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Apr 2020 15:11:13 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so462225pje.3
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2020 12:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ekGkD2IlLQBhkQzaSBHBTkrc7NdLrPJO/D7tB34FXs=;
        b=qQFVTGEKIjOIC8VWVMPsDTnaMUFJGOpSrJ954KPKSRtdWEZrrC3JSOKslgMvN+0ap/
         3WYlHudOEI0/dymYSv4AJixQhvjZT9j8HG6cS9ImnG/xbn7vN8ROQy61SwlzDwE4nWb9
         gKVzhyaOMtzOhuiCNx4oeyv2sE1ZVspDGSLLOljy9XwAABhZR38mYeEfj9xrhEcVpkVU
         UrUZIvuKvxVVryLRtqgJ5rhuN8Wa/c1jmYDHImIlnUs7VhiMt1H76pRLXXhCJ9eLFXDC
         W5ZbIwTwbc3PGRdL5f3yDDdJ0DkV/ozzNfGt8CHbbHpSSZ+75T4vQQ4LBqMSduiOfmpi
         rHCA==
X-Gm-Message-State: AGi0PuYVfT0iPUB8drB8W2ZhUdbu8+kHf/sVUBDE4QVGMIl9fVLTTS9Q
        1sFyqfkkb+QTxwlGjuzaJma/6CGE
X-Google-Smtp-Source: APiQypJFHGU29tvohQudGh4GCyv/2BvNJT90yAH5ccNA203n7VNqQTA251XzdLQ1XASA3Ycl6T3m8A==
X-Received: by 2002:a17:90b:8c:: with SMTP id bb12mr6408096pjb.59.1585768272007;
        Wed, 01 Apr 2020 12:11:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c? ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
        by smtp.gmail.com with ESMTPSA id r186sm2119474pfc.181.2020.04.01.12.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 12:11:10 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: inherit stable pages constraint in the mpath
 stack device
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200401060625.10293-1-sagi@grimberg.me>
 <20200401090542.GB31980@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
Date:   Wed, 1 Apr 2020 12:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200401090542.GB31980@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> @@ -1907,6 +1907,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>   	if (ns->head->disk) {
>>   		nvme_update_disk_info(ns->head->disk, ns, id);
>>   		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
>> +		if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
>> +			struct backing_dev_info *info =
>> +				ns->head->disk->queue->backing_dev_info;
>> +
>> +                        info->capabilities |= BDI_CAP_STABLE_WRITES;
>> +		}
> 
> I think this needs to go into blk_queue_stack_limits instead, otherwise
> we have the same problem with other stacking drivers.

I thought about this, but the stack_limits has different variants 
(blk_stack_limits, bdev_stack_limits) but only the first takes a
request_queue...

I see that dm-table does roughly the same thing, drbd ignores it.
In general, dm is doing a whole bunch of stacking limits/capabilities
related stuff that are not involved in blk_stack_limits...

I could theoretically add a flag to queue_limits to mirror this, is
that what you are suggesting?
