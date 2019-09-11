Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C1C49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21672054F
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 22:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jsY9OKgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfIKWBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:01:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfIKWBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 18:01:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id j191so1686397pgd.3
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8POwdSLkTxkHw3P45coj3u0+LKAWGfZxNTr61kDQCFU=;
        b=jsY9OKgLofPa+bRlH+ErgYotFJB1blj+NIM7OZXX2aZqu1hyXVoL+OHHx7QvmhEOvL
         Ra18DkUGWxebDYSyB8UNXd0vO2tySyDfQjR3s2yz1xbHB3MNWVqEXXGZeis2FYh9QnWI
         1Qomk1x9BjsPqJ9gHASGRPzvBDb/cgZNGJUK27BFNuQPI4aqUgkSCBLAqWXZ3ObdVzM/
         HPQS81Qj7MsoRCgtTLhV89KsdCj0dQ2crTOAiEeGJRo6aI07ieJJJyWc3CZ74grIm8sH
         Zq5kcwCilN6y5cmwMR5wx6404RfuNgqLml7Xpc/+SyIrXRh0BSqDNK58VII5DIuZx4ut
         vX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8POwdSLkTxkHw3P45coj3u0+LKAWGfZxNTr61kDQCFU=;
        b=Syv51S/jluJAUWVl/HT71FJEe7xdU/HF2xF4dNoMq4C9Cj5Yo60ZTpkpASOS7lL9/V
         dH1J2V5G+eybCp9dMFpYchLvYNYRFIUHltpLpk7NIoC6+/GQJzdyfSR4UMjw1LqysBKJ
         P/a4Q8j3Y6AHn9c03ceEgZSCbPgiN/PcR46CS4YZyHPKrOSwCoM3gLa/yJ9yIhhW3Pwk
         DzEt7nVpV9Cu8WGTScKF5l+5L5et1RjrwG0tO45noMRYtA4IMBwOELheewu9X8V0MRNW
         FRE5K9qFtAodMM9/Qzyja3ZWkVaufWSE65bwEM9uvU539x9SiBqLqtUJ2dUgybOLBfzB
         ykYQ==
X-Gm-Message-State: APjAAAXwtAiq94CfNk+H6IXjJ2q+OT9O7D4+RkjTgaiysnoND2ykJw9w
        SKuEY4vV4+HzLJDskN3aGIRsKQ==
X-Google-Smtp-Source: APXvYqxsgVjjxWVy5YHoqS5cMvuPNwIad8I8+9Fc9CcEozQWPycpOcSoC7AiiS/jG1w8A0Tg+YMdtQ==
X-Received: by 2002:a63:5626:: with SMTP id k38mr3709697pgb.134.1568239275630;
        Wed, 11 Sep 2019 15:01:15 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id z13sm34469328pfq.121.2019.09.11.15.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 15:01:14 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] block: centralize PI remapping logic to the block
 layer
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1568215397-15496-1-git-send-email-maxg@mellanox.com>
 <1568215397-15496-2-git-send-email-maxg@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <380932df-2119-ad86-8bb2-3eccb005c949@kernel.dk>
Date:   Wed, 11 Sep 2019 16:01:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568215397-15496-2-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/19 9:23 AM, Max Gurtovoy wrote:
> @@ -1405,6 +1406,11 @@ bool blk_update_request(struct request *req, blk_status_t error,
>   	if (!req->bio)
>   		return false;
>   
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		req->q->integrity.profile->complete_fn(req, nr_bytes);
> +
> +
>   	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>   		     !(req->rq_flags & RQF_QUIET)))
>   		print_req_error(req, error, __func__);
> @@ -693,6 +694,10 @@ void blk_mq_start_request(struct request *rq)
>   		 */
>   		rq->nr_phys_segments++;
>   	}
> +
> +	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
> +		rq->q->integrity.profile->prepare_fn(rq);
> +
>   }
>   EXPORT_SYMBOL(blk_mq_start_request);

While I like the idea of centralizing stuff like this, I'm also not
happy with adding checks like this to the fast path. But I guess it's
still better than stuff it in drivers.

You have an extra line after both of these above hunks for some reason.
Can you clean that up?

And the blk-mq.c hunk, we have 'q' in that function, use that instead of
rq->q.

-- 
Jens Axboe

