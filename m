Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A8C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52D208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xR+RlGby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725759AbeKOBXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:23:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44454 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOBXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:23:52 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so6439009iod.11
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jQgGvSINzICdkBBdVxMUaSEpCBzx0qk7qfjfOn0I1AI=;
        b=xR+RlGbyhu2csz3wsAa5DLEAHzbzGZoVxsEil+Iu+VkhTHxhS5vkXa+z4CBkLMYpKm
         1BEqURwgsBQfb7OEtoNKQ05E4DvojesDiTso39sY4xdH8UMdVadcPx2PXQ77xUOwsDn2
         t3144KQEo5XTo2PRbIGMolHpxYwdYMh05Lu//7QPpzfwk6Sza56SXbG7PGm971SmTmA5
         AevyrT+UbFLpYTs2SMumzSWSdPbHbGOp4orh8hjd7S58mx3xiUb+tyiM9Q4voZBhzRm5
         vh1AtEOB77PuDWUcYV9/hznmocvp9aGAB4SeYOEdDZid5AjZoP9aqZt0DfsZOU/4T/A2
         DqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQgGvSINzICdkBBdVxMUaSEpCBzx0qk7qfjfOn0I1AI=;
        b=BYg6GX5q4A00ULFInWHuZAL+3cPDdFg0l8cQOfBom7u8aec3F2cgheQiKDy5bfSMap
         Q+KkHCohBce82YFUfCQoJ/P/RGQLEEb4IJRnloIuxbYHXmVSN0sfXqqKOqtfUfo0vTyk
         iavf39wWWFqefJ/uxMPH5KpaqBP/uBkKNfSBIHXz+FVnMBKI9TcENHINU7qoDJDg6V8R
         5NBbThpLP27hA1XMDzi4fJEBqA4C6pFjO1+9n6B79i3+jagbsa5WYV/EB/G7yuf62tBn
         H625OsHq4BhSC1tls89ri7VCmq/V1rsd0QoEeMncLy+thOCpicRYs6NPFlBTANLp0UKc
         Cg+Q==
X-Gm-Message-State: AGRZ1gIu45tuyTPZHm54GZJm3c4gZ+6eo1qpMthg+Ep2aExr+qW8Htcz
        1a6Q8/ZT/nHkXHMJ2En5Y2fqOw==
X-Google-Smtp-Source: AFSGD/U32o4FW0u5SgEEAFEKzRRJ/gZCvWfi5jxhn2G9oO8ZQW7xv6A9lOY9Jd9dBJ6vCgvcOoDrqA==
X-Received: by 2002:a5e:8908:: with SMTP id k8mr473350ioj.300.1542208812507;
        Wed, 14 Nov 2018 07:20:12 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u2-v6sm7639491iof.45.2018.11.14.07.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:20:11 -0800 (PST)
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
References: <20181114082551.12141-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63c063ad-7d74-4268-bfd4-2de89908949e@kernel.dk>
Date:   Wed, 14 Nov 2018 08:20:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114082551.12141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 1:25 AM, Ming Lei wrote:
> c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
> already fixed this race, however the implied synchronize_rcu()
> in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
> performance regression.
> 
> Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> tried to quiesce queue for avoiding unnecessary synchronize_rcu()
> only when queue initialization is done, because it is usual to see
> lots of inexistent LUNs which need to be probed.
> 
> However, turns out it isn't safe to quiesce queue only when queue
> initialization is done. Because when one SCSI command is completed,
> the user of sending command can be waken up immediately, then the
> scsi device may be removed, meantime the run queue in scsi_end_request()
> is still in-progress, so kernel panic can be caused.
> 
> In Red Hat QE lab, there are several reports about this kind of kernel
> panic triggered during kernel booting.
> 
> This patch tries to address the issue by grabing one queue usage
> counter during freeing one request and the following run queue.

Thanks applied, this bug was elusive but ever present in recent
testing that we did internally, it's been a huge pain in the butt.
The symptoms were usually a crash in blk_mq_get_driver_tag() with
hctx->tags == NULL, or a crash inside deadline request insert off
requeue.

-- 
Jens Axboe

