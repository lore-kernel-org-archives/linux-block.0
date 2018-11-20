Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E78C41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C359204FD
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1dmlJaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C359204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeKUC6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33428 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeKUC6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so3241674qko.0;
        Tue, 20 Nov 2018 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pLLM1p+5cDN52i8L+l5I/RKjfgAuOq/8xc6t5eHQeA=;
        b=Q1dmlJaqef4PhMUe8KijF7vIIIQS/5OPUDZ76zqN9VTRe3/eXoy3K4ifcH/33T68vy
         ydDsdzCnml+hVBgexIcWmYgG5c19ZDDCoW+8WPcss4AhjWlpuO4AZDw5CDgrQ9vinafm
         QYyzS2Ddi8K9t4Uqk4ZMZmMBRhaxeGJQDBiZtlo+9xDem/jc5cFPoyRQKMUlHGGvQmeW
         0is3bdkuDj/ZhDl/9jTEOdjhwbfCrZ9LG5iZjounIfuwVo3XqGWSf6w9KG5BSOJfUxFo
         04pPI4WxX0FmPvvEcltUAJtrmcvXDpJAlWx9juT3oINlVeRaIbVnoF6PGQm4cAdiQbQB
         tbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pLLM1p+5cDN52i8L+l5I/RKjfgAuOq/8xc6t5eHQeA=;
        b=KEU0/uk02N5liAR1gz9NW7EHEFFUbq8uv4f4oZSOHTLlpROg0VsTD8rtmzuOuDWMEz
         CD72qL+h4hkZsX6GRcHi+l9s55CPeMp2yFrnrNrSMqf+VUiA36/a4Oi6TMcUTp9O+IiW
         bQvv6Rlw9Vu0gBoxs+ibalFUX3vHkVarkVa7z7XJhhXeBWb2cO8xONimFS+xPHTTvxIu
         nUKSbXGrxZROBl48IGDowmGl1olpUHjMCnrOkRTIuh8tpLOnAsAuzSPANFOZVIIv1B5F
         TbQ18Yz5MPIdS0S4x/QjoxXDB/wU5PojewnS6S6rq40gWkyABuPFP/9dgB6lISi/pd7I
         UZRw==
X-Gm-Message-State: AA+aEWYcuif5mKnQH7oExXGJe6cLZmRvX2q46UGQ7vEtKuj/xWPZejO+
        EEoltxHSBILWhDXx4RienZE=
X-Google-Smtp-Source: AFSGD/W6OC/zC6WUidHtw2jYLzMq/iMNXmGM/O8tXzXhxNVWg5GECEtRq5t+S/KUiJW/TPmY5/sP4w==
X-Received: by 2002:ae9:e102:: with SMTP id g2mr2195104qkm.343.1542731298599;
        Tue, 20 Nov 2018 08:28:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id n8sm24250696qtk.91.2018.11.20.08.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:28:17 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:28:16 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
Message-ID: <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Mon, Nov 19, 2018 at 11:34:14AM +0100, Paolo Valente wrote:
> - if all entities produce the same output, the this common output is
>  shown only once;
> - if the outputs differ, then every per-entity output is shown,
>  followed by the name of the entity that produced that output.

So, this doesn't make sense to me.  One set of numbers is meaningful,
the other not and the user doesn't have a way to tell which one is.
It makes no sense to present both numbers.

Thanks.

-- 
tejun
