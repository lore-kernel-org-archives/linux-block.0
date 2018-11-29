Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D99C43610
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2020868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bBnjfBfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeK3D6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:58:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40845 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbeK3D6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 22:58:55 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so2117956ioh.7
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdnwTFBcOgnKSR+WxYnZDzJnNKlYlo8mZHgb54crOdo=;
        b=bBnjfBfxKLaW/hewNfhFq+g3aOz1dipdS9l4SUwV6ToC3NvBR1gEH9MJK5UnqS3kjo
         9nPnzGsGo/BPOpLx8/L83coinSPlMFia0C7of6Vuz9ktebuuIdSwWDmY8hzV1XFIkL7B
         BmGlSTQinQeXe5OTXqrF22y/ePvT42Pf67MkBf4Y/1747mErwEggCvb9b45DHYGfTkhs
         MltgF6LNousSyhaFdwurGacdGmkrj+RV5+9AMt52BETUX3+XoTPAUK/7n3eUSJiPQ/GW
         P1fQ8CS93W66o8CJ62f5LMXikGDo6iELfaKn+J6d7AczWXJ/Q5fkLqLlj9XXcjv6xIHN
         hheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdnwTFBcOgnKSR+WxYnZDzJnNKlYlo8mZHgb54crOdo=;
        b=UwD4wFVpsUZzks9g+hbRCWHfYKr9lo5IdzVIXz5WcqBYayCAZI22bM1QCV4vrK1Pjn
         DgCIjmtxozBpCoAJcC/GXujf2YQzaZoBVbwguFM+AKsvkgX9SuvY0zxKykkgLi/YfpdR
         6Ls9pZXcUQYP3JxphYX+zA42WARxRSR8Wz3NDs9BmmvuQpALYiMq5lm6aiWCteNSxq8E
         spxuSDCQyOkp7yhvLlo320xvpm7NvO7YUI+LJiWJg016VrNwuyySbAS0g8Zl2faCYYWZ
         hipUqyrWCeyB+RbUgD0beJwwXx1IJirHgtDdb+vvEmNkn14okvZhgCiMfBWA20rmuVAI
         Tp7Q==
X-Gm-Message-State: AA+aEWavs7LsPNyOPcLjOP6XlJ/yVY/y9DKcEobMeHozoHq/xXD3WqcC
        9DC13kl+/w+SrtprcqNjCoxqdQ==
X-Google-Smtp-Source: AFSGD/WYuGcw6zhB+NAQfm/DxB6XXUsOh0EotySbatGpAn4REamkXjj1cW2fifG8B9uBYAhOP668Vw==
X-Received: by 2002:a6b:6507:: with SMTP id z7mr1750406iob.285.1543510373957;
        Thu, 29 Nov 2018 08:52:53 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n124sm1340363itn.4.2018.11.29.08.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:52:52 -0800 (PST)
Subject: Re: [PATCH 2/7] blk-mq: add mq_ops->commit_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-3-axboe@kernel.dk>
 <20181129154546.GB7234@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4ee9225-f26b-e460-a579-af518123ad72@kernel.dk>
Date:   Thu, 29 Nov 2018 09:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129154546.GB7234@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 8:45 AM, Christoph Hellwig wrote:
> On Wed, Nov 28, 2018 at 06:35:33AM -0700, Jens Axboe wrote:
>> blk-mq passes information to the hardware about any given request being
>> the last that we will issue in this sequence. The point is that hardware
>> can defer costly doorbell type writes to the last request. But if we run
>> into errors issuing a sequence of requests, we may never send the request
>> with bd->last == true set. For that case, we need a hook that tells the
>> hardware that nothing else is coming right now.
>>
>> For failures returned by the drivers ->queue_rq() hook, the driver is
>> responsible for flushing pending requests, if it uses bd->last to
>> optimize that part. This works like before, no changes there.
>>
>> Reviewed-by: Omar Sandoval <osandov@fb.com>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I don't think I actually reviewed it before in this form.
> 
> But now that I took a look it does indeed look fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Only change is moving those two hunks from the later patch into this
one, so it isn't an empty declaration.

-- 
Jens Axboe

