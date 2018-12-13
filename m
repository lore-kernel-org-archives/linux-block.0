Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C6C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEED520892
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEED520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeLMUj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:39:26 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46994 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeLMUj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:39:26 -0500
Received: by mail-pf1-f171.google.com with SMTP id c73so1651707pfe.13
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4pENP7OpRVhwUGTMW18/2xzImdkWvexY3PibevFWJw=;
        b=FRqwLSb75RSMYZBjLa9bPGW8lRbXUKIL8/PM8Ai9fIupbvaox7GwOhFP0J189w4OHO
         lRzx84ax5rRdnitl0/Jb/KnLAN5FERII8TcXuHyPdYEnlxqVZkRRyVDmCjEyfdaGwcMD
         3IH9OoLdda698ILVT/1rPXcthQ3a7I9zAlhDO66tvtKp5Y1FcIOfM2jYkzk/VFUXw5kn
         c5FrcsVLKehTy+M1cdMC2++5Y8WAYqyvzqwbK0UPnDvC6WmdUnm+fqM/cye98vAbZoLy
         sQrVTT4YL3VaM70+K9nALcsH8HAumFLKeQeTA2Y/RjyJILIVF9bTqxTN8TyGioGHyOqa
         PIHQ==
X-Gm-Message-State: AA+aEWZ09MYKFSrFkNCiOYIQuHh1LPMng2/aIEm2YYbaK9m+DkXRsiBv
        gB+15Y+sl6rZn8TO+xzPFwE=
X-Google-Smtp-Source: AFSGD/XpRXusCthIoq+zqlDCfwnCoWzlokb49P5pu10JP6+DMpxEZj4UlI6Yc01I/3DJTtnsPtNjSg==
X-Received: by 2002:a62:4886:: with SMTP id q6mr280655pfi.182.1544733565630;
        Thu, 13 Dec 2018 12:39:25 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id l185sm4027399pfl.54.2018.12.13.12.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:39:24 -0800 (PST)
Subject: Re: [GIT PULL] second batch of nvme updates for 4.21
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181213195607.GA7751@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a753aff-21dc-99c4-1fec-0a610700ae22@grimberg.me>
Date:   Thu, 13 Dec 2018 12:39:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213195607.GA7751@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Jens,
> 
> here is the second large chunk of nvme updates for 4.21:
> 
>   - host and target support for NVMe over TCP (Sagi Grimberg,
> 	Roy Shterman, Solganik Alexander)
>   - error log page support in target (Chaitanya Kulkarni)

Worth mentioning that support for separate queue maps was added as well,
but we all already knew that, so just for the protocol...
