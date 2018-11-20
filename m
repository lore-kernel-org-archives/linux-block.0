Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCECFC4161D
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1B1208E3
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID497ezd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1B1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeKUDPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:15:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeKUDPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:15:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1139018pgp.7;
        Tue, 20 Nov 2018 08:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LAims/OHofY0nDv6m/rc/pUUPTbq9lMd1V61SuIstx8=;
        b=ID497ezdIfehKu+6Q7RZCARgVYJE1cHBS1Au5FEEyeLs3aE4E8samEKRzK48egoPkE
         myPZRaJrgeJjPZv0IbHgNd/qb8LK/tr/OoykyAw/w05J8hdqa2YVshVbmCYsBCF6+saR
         BVlaBBuYkQOxMQWF0nNW4zEJLqUlHo3eeAVLuMmLPeFa5P6MX6hjBlKmKZLGd/kfdbAX
         f7GZ/TgzV1ubb4rcuWa/YLQoRY2QmUNBzUFzjZhm6Ervoyvh7kY9IBuTKFoEZWzysnoa
         z2Oeip16FHAfQr4cfPfpXNItOrlF2qj6ONIQXMey2B3Qg4yCf3Dfyw/Y/Kb4P5qquGqP
         6TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LAims/OHofY0nDv6m/rc/pUUPTbq9lMd1V61SuIstx8=;
        b=Uf0jL2J5hyhJdTWMNHaX1UncSOVdC+VkGXvhjOqahaGTIFjMDCFpxmMJoS4CZt08mT
         MTBUn1UCPrmoZ7+D0jaNXxLbdNSTQmc5dWXZPKF5cn415qc4kHTXw8o2Wr1g8PoX6cn1
         B0kQUItye8Z1g5vJrqMHHd5KmWkNiD6/t4WqYufDcwZuU5CJSG9hbSLMZWBvKozIV3Wf
         GaIkxcTcjzvaqFG6BOvC632bI/BNS48WbhRi47s7roZs419i7EWqdcVsJj3HzmleVu3J
         0l4FcbNZhhs+mEWsOFjx8nIOp7cqtjetbsSHhT0r7D6kfsRAi0WFE1X6ynsDBuk7HO6I
         iHvw==
X-Gm-Message-State: AA+aEWaE1F+SADPDt8t6Y3XSM76FvtPVDyeAsOxHKTPQV5l6Ea1jIw4h
        mBMzCBGxpIN+6yssMpNn81U=
X-Google-Smtp-Source: AFSGD/Vf32SSjzekAyeHMgDZx0tkNzOm5OX0y4J+2NZDyA+/a94Zc+9COJW6c7n1XVswRYqeRVIPPw==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr2586960pgg.429.1542732312054;
        Tue, 20 Nov 2018 08:45:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186-v6sm50309279pfe.39.2018.11.20.08.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:45:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:45:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.21 V3] blk-mq: not embed .mq_kobj and ctx->kobj into
 queue instance
Message-ID: <20181120164509.GA32433@roeck-us.net>
References: <20181120014435.3339-1-ming.lei@redhat.com>
 <20181120075150.GF15276@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120075150.GF15276@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 08:51:50AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 20, 2018 at 09:44:35AM +0800, Ming Lei wrote:
> > Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
> > from block layer's view, actually they don't because userspace may
> > grab one kobject anytime via sysfs.
> > 
> > This patch fixes the issue by the following approach:
> > 
> > 1) introduce 'struct blk_mq_ctxs' for holding .mq_kobj and managing
> > all ctxs
> > 
> > 2) free all allocated ctxs and the 'blk_mq_ctxs' instance in release
> > handler of .mq_kobj
> > 
> > 3) grab one ref of .mq_kobj before initializing each ctx->kobj, so that
> > .mq_kobj is always released after all ctxs are freed.
> > 
> > This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
> > is enabled.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V3:
> > 	- keep to allocate q->queue_ctx via percpu allocator, so one extra
> > 	  pointer reference can be saved for getting ctx
> > V2:
> > 	- allocate 'blk_mq_ctx' inside blk_mq_init_allocated_queue()
> > 	- allocate q->mq_kobj directly 
> 
> Not tested, but seems sane from a kobject point-of-view:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

with v4.14.y and v4.19.y.

The patch is marked for v4.21. I would kindly suggest to not wait for v4.21
but apply it to v4.20. This would let us enable DEBUG_KOBJECT_RELEASE
with syzbot on upstream and stable kernels.

Greg, applying the patch to v4.14.y will require a backport due to a minor
context conflict. I'll send that to you after the patch is available in
mainline.

Thanks,
Guenter
