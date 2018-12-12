Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE971C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7320879
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF7320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLLHKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:10:19 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34268 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLLHKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:10:18 -0500
Received: by mail-pf1-f182.google.com with SMTP id h3so8444015pfg.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 23:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMAwW95y9B/kbQx0E4XwxMm2WhN04ngn/fu1qmDmZ2M=;
        b=Z1+oaSNkA1ipBv0bX+I9OmIbBF4yLc4DHCDhSxOkfIQ2RLH+0HmUgC1eI4VenbhP1y
         JQNa5gn1Dg5Chl8ATQuadg+tPILOUpzl7j3YhBS86CbaMmejkUz2V0v1i2a6cDm2fT4n
         8DTl+LIq/LFVbujKaoKcM0P7yf0B81V9CDAllNPB3dFxknRqino6RsRkkZydrD9o7wHe
         PT6QXvagjwE9WnFB6FU6sORTOLCdiIlILl9oBRIlc2Ns1cqrmMsPvw/Yi5HrG6/rZdDw
         xygZQC0+ntJQ9T7STCEJ3xd+9TnNcI3bSIrmuBxYnUibTc0x4Xcd4DuOSWzTa2wnvzT3
         TBWg==
X-Gm-Message-State: AA+aEWaaE8OdNkY/EJBYKnzXEnVwuvWNLsZW59Kc4yEIT4rpNE9R3OvT
        p1jYDXwmd4H9GduKzXu0VzspNoo5
X-Google-Smtp-Source: AFSGD/WTonRNkBOTRD0lGxfAdg34WUDyyj9YRSdIJrjmz/Foqqz2KXH3PLULx1EKL32uWCMk3mP9lA==
X-Received: by 2002:a62:ca9c:: with SMTP id y28mr19071431pfk.236.1544598617361;
        Tue, 11 Dec 2018 23:10:17 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id i4sm27133390pfj.82.2018.12.11.23.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 23:10:16 -0800 (PST)
Subject: Re: [PATCH v2 4/5] nvme-tcp: support separate queue maps for read and
 write
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <20181211233519.9350-5-sagi@grimberg.me> <20181212070510.GA28461@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c77a6399-7558-1ef9-63b4-dc8d9d29e13b@grimberg.me>
Date:   Tue, 11 Dec 2018 23:10:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212070510.GA28461@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> -	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
>> +	n = (qid ? qid - 1 : 0) % num_online_cpus();
>> +	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> 
> Nitpick: can you use an if/else here?  The ? : construct just looks
> like obsfucation.
> 
> If nothing else pops up I can fix that up when applying.

Actually I noticed that the NVMF_OPT_WRITE_QUEUES was added
to  NVMF_ALLOWED_OPTS instead of locally to the supporting drivers...

I'll send another quick revision tomorrow...
