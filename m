Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA164C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A59206B7
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A59206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLDRXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:23:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37153 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDRXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:23:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so8549740pfb.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Btx2A7+k2AKpMHbKhoWR2bR0s9EkI2THiq0p++TOBA=;
        b=EUzJct+kWj1Sr3ESCKmDvgd0aPwIV5IuzfBLLApa3aEqQNBrji9OBDzbzYeRo+x19S
         VjC7HNB8gOS3f+BCKNUI9RjVj8W8Lxw16F6zygARN8KWX07pdcmrPbDWZgjcMsm6gSQL
         /YLM4OJV9WM/wUA+VdgCkl07247QegwXZn6w5WowFEVzEOMWGXE4SkVRJTezW4Phzz54
         ikQ2LMsnyNHioYDFqzYa4vZACvFlDmIg+1DyO2HgYRT8gtjO6bua6M3cH7BUIdMq5GGv
         3r6sFbgix3eYp/P0UxFoxncw5FdRejHhdNjGB9qo4MWMcLWtevzIOMq8wNElQv3OZ9yn
         balA==
X-Gm-Message-State: AA+aEWacZB8gncRQ43K/0nXFA6OFlS3AcFpsQPB9JVOFMduEET3bKydH
        AoOdKsi0qb0SiYKPlDOaYnE=
X-Google-Smtp-Source: AFSGD/Ui+7NLxtSAnD94kXxxFSkOmo1GLH8KGUhtd02NHfdn4R2aMma+B+g9nfXha7uH3zfAsLOmrw==
X-Received: by 2002:a63:6782:: with SMTP id b124mr17719839pgc.151.1543944194193;
        Tue, 04 Dec 2018 09:23:14 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id d3sm19645039pgl.64.2018.12.04.09.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:23:12 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     James Smart <james.smart@broadcom.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <5af6dfb3-c471-1377-2d1d-b2a4b15eef43@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19b3821e-02fa-bd09-1b90-0dd8904e8a57@grimberg.me>
Date:   Tue, 4 Dec 2018 09:23:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5af6dfb3-c471-1377-2d1d-b2a4b15eef43@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Yes, I'm very much in favour of this, too.
>>>> We always have this IMO slightly weird notion of stopping the queue, 
>>>> set
>>>> some error flags in the driver, then _restarting_ the queue, just so
>>>> that the driver then sees the error flag and terminates the requests.
>>>> Which I always found quite counter-intuitive.
>>> What about requests that come in after the iteration runs? how are those
>>> terminated?
>> If we've reached a dead state, I think you'd want to start a queue freeze
>> before running the terminating iterator.
> 
> For the requests that come in after the iterator, the nvmf_check_ready() 
> routine, which validates controller state, will catch and bounce them.

The point of this patch was to omit the check in queue_rq like Keith
did in patch #2.
