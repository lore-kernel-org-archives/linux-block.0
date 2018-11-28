Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED8C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0821104
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0e03pQAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeK2ANO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:13:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36245 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2ANN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:13:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so4899437plo.3
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2RBIXokMg1XrEC/sms+m69vQ9XO7rRtcp2xqL9XioiY=;
        b=0e03pQAkUW0Y8T6WOg+8Mk4XYVFW5GySuadOqmaz0Y/xnj5QX6fAwy9/qO5VLLoPin
         oTIpX2CcSMtJsIii078mpUaWNMGI2Ru67f8sJCZQ/bhTzT/6RM8t3OQ6MoQM9AXVole3
         eScijQDdhSoAceS0/MWBlEVkPt7I4sCYGQpfcIRbNrQ+1msUkDU5xfme3As3DTeqkdiw
         eZRB7x12NKXxcU0cP3U3rXj9IdECZ0FnH/2pdDFV4qvIOG5ceF2PCbpgh9JxLdrmdVBg
         qEoUCk1XInqPZuhZ/KyJW9hl3337Z1ri6AlbIX3DP6AhyngMRE+sO82YovKJC5podgge
         4cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RBIXokMg1XrEC/sms+m69vQ9XO7rRtcp2xqL9XioiY=;
        b=rBqOycFw51A4hRJ/Z4M8oxALNprcqH6VMVT5tbU5OKvarYvI3fqyYe6I1aG8KpHrUV
         N8cCvfTqky4bNxeCgdjCspD5kUB0g0ejnrZHuX3FNXpXNDMyCSip+Nof8YIbe7Q+aE/s
         CXYWFybE59tJu8R4QHydSleOqo2eO0k9YtZ0nS5y34omgI28m/M3s7zl9I2d/jebpXgH
         I3xlPkxqm4ArVXFTM1MPWces8duyCA2qSkiiqYhFtQ0k+RG65UJKjT1xqgreb7nSkRqp
         ugXuzBGlefh49D784KGhJPD+ZEJAiQgNyBtL1Dm7TFXEBHPMwnTFDUBQPhH7O1mqcfx4
         QuJw==
X-Gm-Message-State: AA+aEWZ/pBrgco60LVpruCPIDInLn9JqQOp0DeEyb078SHNAYy6DyN9M
        hv2LnboUIQDr2LaGC8+xodCyOWLoZs8=
X-Google-Smtp-Source: AFSGD/WKJ3QVu5OT7dsj5zeohnfsBFOFy7WhBm5LtAzVbsHfRhfTMKDvaR4He7gpk/FKujl6GylAsQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr36106423plb.166.1543410695762;
        Wed, 28 Nov 2018 05:11:35 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n186sm9250487pfn.137.2018.11.28.05.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:11:34 -0800 (PST)
Subject: Re: [PATCH 8/8] blk-mq: add plug case for devices that implement
 ->commits_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-9-axboe@kernel.dk>
 <20181128072655.GE11774@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3976c13f-4a64-38cc-24a0-645842618b0b@kernel.dk>
Date:   Wed, 28 Nov 2018 06:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128072655.GE11774@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 12:26 AM, Christoph Hellwig wrote:
>> +	} else if (plug && q->mq_ops->commit_rqs) {
>> +		/*
>> +		 * If we have a ->commit_rqs(), then we know the driver can
>> +		 * batch submission doorbell updates. Add rq to plug list,
>> +		 * and flush if we exceed the plug count only.
>> +		 */
>> +		blk_mq_bio_to_request(rq, bio);
>> +		blk_mq_put_ctx(data.ctx);
>> +
>> +		/*
>> +		 * If we have requests for more than one queue here, we
>> +		 * should sort the list when it's flushed.
>> +		 */
>> +		if (!plug->do_sort && !list_empty(&plug->mq_list)) {
>> +			same_queue_rq = list_first_entry(&plug->mq_list,
>> +						struct request, queuelist);
>> +			if (same_queue_rq->q != q)
>> +				plug->do_sort = true;
>> +		}
>> +
>> +		list_add_tail(&rq->queuelist, &plug->mq_list);
>> +		plug->rq_count++;
>> +		if (plug->rq_count >= BLK_MAX_REQUEST_COUNT) {
>> +			blk_flush_plug_list(plug, false);
>> +			trace_block_plug(q);
>> +		}
> 
> This seems like a slight variation of the the single queue plug
> case.  Can we share the code instead of having slightly differing
> logic?

I'll see if I can fold them.

> Also that should this respect blk_queue_nomerges?

It doesn't do any merging at all, it's just batching for the list
inserts. In terms of plug merging, if nomerges isn't true, then we would
have done that further up.

-- 
Jens Axboe

