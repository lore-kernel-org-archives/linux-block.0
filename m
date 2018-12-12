Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF11C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DF20851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UQApDHJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51DF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeLLRYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:24:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41703 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeLLRYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 12:24:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so8895227plm.8
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHrAdWhl/OvJmdT7q4IH0hFWZc/yixCWfkRY0Xy2EMw=;
        b=UQApDHJ1G1a8OHYOMO6K8UaWPXbEyjINDqkZwDBEV8uUJz1Akpo0n4yb4Zj7vBc+cc
         Q5/gUK4y8BV5XJNY53nQ+pWdJbD/IMbWqOwhavG/wI/IExvtMCeECMo5InSuU0vPNbpF
         BrHWxWgIs7z/T891NHcdwP3CRxI+SYnR1wyGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZHrAdWhl/OvJmdT7q4IH0hFWZc/yixCWfkRY0Xy2EMw=;
        b=lbPeJ9WRCkctODknVbGIiayIlsslMBnh3kpa/ZOzPL6Rt3NRplYkWmB6KeP5d/v7x1
         msaCxDJ8A42IA1AXnLv3Vcyie0igOj05ct3aSYTOR2RCWna9lzwF2muj9wc5O6U9YiTp
         NEVUMfntwnDc5fahh7ZrG887c4sDOQspBip+c+mdEJnwa8Wo5C+9BKb+Uz//gdX88E02
         3hnFkBO8xJsfwNfxfbJiYIJ2W5kmS2s44mqIbVACWfyn+7LBSoLc+jh5hwDEXByBsiw3
         1CmDXW9GQJJxlPQMqm3Gbpw3hMO+Dbj+tHCYULsQcHG3D0S3bS8CQAlRtZSM0eCY9B1M
         +1ZQ==
X-Gm-Message-State: AA+aEWYj9I7UYuAkKGIB/cW1EkVSac48DH5VhGFowgoyiovxbj9fSTm1
        cpTFB33UYki+937S3O5xjAzwGw==
X-Google-Smtp-Source: AFSGD/VWG6jlhUO4/j6UO47NqNjUIucKJIQbnNKlj/ltR5kbgDhZKOiE4XsJGKlTqu731TrrmgCyQA==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr21161984plp.9.1544635439384;
        Wed, 12 Dec 2018 09:23:59 -0800 (PST)
Received: from [10.69.52.190] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z8sm24525565pgg.62.2018.12.12.09.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:23:58 -0800 (PST)
Subject: Re: [PATCH v2 0/5] implement nvmf read/write queue maps
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
Date:   Wed, 12 Dec 2018 09:23:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/11/2018 3:35 PM, Sagi Grimberg wrote:
> This set implements read/write queue maps to nvmf (implemented in tcp
> and rdma). We basically allow the users to pass in nr_write_queues
> argument that will basically maps a separate set of queues to host
> write I/O (or more correctly non-read I/O) and a set of queues to
> hold read I/O (which is now controlled by the known nr_io_queues).
>
> A patchset that restores nvme-rdma polling is in the pipe.
> The polling is less trivial because:
> 1. we can find non I/O completions in the cq (i.e. memreg)
> 2. we need to start with non-polling for a sane connect and
>     then switch to polling which is not trivial behind the
>     cq API we use.
>
> Note that read/write separation for rdma but especially tcp this can be
> very clear win as we minimize the risk for head-of-queue blocking for
> mixed workloads over a single tcp byte stream.

Sagi,

What other wins are there for this split ?

I'm considering whether its worthwhile for fc as well, but the hol issue 
doesn't exist with fc. What else is being resolved ?

-- james

