Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316FC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F22A222ED
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSBn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:43:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33701 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSBn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 20:43:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so21877269wrr.0
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 17:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/rkDjn/1gGzkg9uVfMR4uDddpNXolTiDd83cfXEc8E=;
        b=UTdHVAjJMZQu3p7949kgI+2o+tmawoXqutiE0PGuYRZ1vSENbdDPmZccz04SFuFlgh
         xPyXbD7Zeoykj9UOC72O/caLVFF/69fM+RF3Cgq4d1jwvUYRGm8sVF0r9rf/3bEZ61D8
         25m36F9/UwGz3YXzYJjPK9iG7ne2pYSq5tSAQo7xjuqfQXFE4P7291bZbzF9x1sHg3/2
         xjBjQagsSW1VYU8GocRyEIYfEME1fmBOXRGAEKcOwat51UPCugetRTwoDwBaS2CEpn+H
         +t7Cag0h2Zpl4b20O/zIPBCCx1UBT0uXLgy69vQQwI3kxm+zKEUKXGJe6yGz+GM2PMnf
         hfZg==
X-Gm-Message-State: APjAAAXudMEyni7qDf2CKRbtMVASTtpmHQJ7z7TRci64TvQHCErJuUNg
        YhIrWDdpHUG8tC8jkcCH8dM=
X-Google-Smtp-Source: APXvYqzWIpTvyfkqRjcxqWlG/w/0JPDMIGwWb0GvTK0Thn7HtXph0DJt65qBwqX0cs6KD1vwGXxuOw==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr32384686wrw.395.1574127837391;
        Mon, 18 Nov 2019 17:43:57 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id j2sm25535546wrt.61.2019.11.18.17.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 17:43:56 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
 <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bde9741b-ee3d-7ba7-1fe9-04c919960412@grimberg.me>
Date:   Mon, 18 Nov 2019 17:43:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119003437.GA1950@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I'm starting to think we maybe need to get the connect out of the block
>> layer execution if its such a big problem... Its a real shame if that is
>> the case...
> 
> We still need timeout handling for connect commands, so bypassing the
> block layer will need to figure out some other way to handle that.

Which is why I said it'd be a shame :)
