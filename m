Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93229C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EBF218FE
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 18:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfCVSz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:55:27 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41708 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfCVSz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 14:55:27 -0400
Received: by mail-ot1-f47.google.com with SMTP id 64so2829203otb.8
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 11:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffBzdEOG4/+ZtSGoHrElRQVZMnIZOKstBsuKDHHkpjg=;
        b=YoRYdmN6SYagBT+XDPnrWmWLsaty5rcEYnflNDpqghLCXfI/WnPKMEdINEe0cq5WNe
         VDz6GYSX9LMODty/d/hf1H9akSfvh5J31ccxeKLeeeGbMeXliaYGc9UN2wyLxTa1CQgS
         VSw3WGZ+k1ZRFo/4N6HtwbNCj/INTZ6f7aqfOKfLg5d9u4603Qq9/cM1xmbamtyyKuq3
         YmXa5yp8WkRs1OVor1QDnDa2rFqiSTuI4AIrgmHHDPBO651d2zVQHKp+xNSbdVyKfesi
         U/j7hZxSYXBYH3Hz+kZ/W/67uLsmX5l3qRWE83kFzTxRLzRSpyVJq8euvE00FSkawhCN
         BM3A==
X-Gm-Message-State: APjAAAU3mHYziRrgFotOQ25oXe3HF1MxJQArCvg6YqQN0iUCzle2IYpg
        63nUy9ta+dD4JvbBvAxslYM=
X-Google-Smtp-Source: APXvYqyT4QeVXTgmyiAdhayrPyOG/6wSzt3cv+E1x2TpP6BKK9LV6c0VH6f+zVdqaiiFDnFft1aw3A==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr7772302otp.234.1553280926612;
        Fri, 22 Mar 2019 11:55:26 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id m11sm3308033oif.50.2019.03.22.11.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 11:55:25 -0700 (PDT)
Subject: Re: [RFC] optimize nvme single segment I/O
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20190321231037.25104-1-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c7c95931-2e6c-60c6-b9ab-606a7a166410@grimberg.me>
Date:   Fri, 22 Mar 2019 11:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi all,
> 
> with all the discussion on small I/O performance lately I thought
> it was time off to dust my old idea to optimize this path a bit
> by avoiding to build a scatterlist.  I've only done very basic
> testing because I've been a bit busy, but I thought it might be
> worthwhile to get it out for feedback.

This looks good Christoph! for the series,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
