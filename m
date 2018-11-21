Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4137C43610
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3421479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 00:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeKUKmP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:42:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41416 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeKUKmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 05:42:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so3088729oii.8;
        Tue, 20 Nov 2018 16:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWBogCIj7vCrNxiemetaU1b+n7gMyq4m5qzelDQ6dLY=;
        b=ZnzQ7F0veEuLoI0A6lGRb+6LPybHhljUhYprT1XyyrpuliqU/tH9PpDHwQFr6gP41/
         03Ng1S+Kte0ahF57+dR7Rs2PHSsKRsNoVCq7ySDAyy+74S6qngmX1C+WJns+aSuwkgEZ
         2+8NYdKcu0qfyrn19VlQCVBClJtTTVeS6FaZLuq7KB4V9c1gCOBWI4fXo6vcHeD/eazq
         0jMqyFeNSRBzOAemtQ227UdzStjigTtsIH2ZwNeXOKT5cKok4v2TNDNhnLIU5MTBVZMI
         5J7FN4Vv/NhGzabcxmWoGYYEMqDvu5ivj2cFexn49ae5eDFFVT+kaYMdNJ62nc8weKVi
         rhHA==
X-Gm-Message-State: AGRZ1gIrSWCnYiqHh2nHH6a0rGLOmMI0XTnDFFYh+nuRPXKPekN/JslP
        jGSNtf01zyEGpP8XL5+1zLU=
X-Google-Smtp-Source: AJdET5fkUZJBJAOh6F7NJ8fKkXDWWp+WAAo1LuFAV8NlIsnaneQOjbDlnINMIc5T3tALeJcdF51Xfw==
X-Received: by 2002:aca:31cb:: with SMTP id x194mr2227234oix.213.1542759024194;
        Tue, 20 Nov 2018 16:10:24 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l18sm40640763otb.68.2018.11.20.16.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 16:10:23 -0800 (PST)
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
To:     Narayan Ayalasomayajula 
        <narayan.ayalasomayajula@kazan-networks.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
 <MWHPR08MB2685DD0299C66EE7CD853B3DC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2a620e3a-f08c-6251-7dbb-46e843118bf4@grimberg.me>
Date:   Tue, 20 Nov 2018 16:10:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <MWHPR08MB2685DD0299C66EE7CD853B3DC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi,
> 
>> +       icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
>> +       icreq->maxr2t = cpu_to_le16(1); /* single inflight r2t supported */
>> +       icreq->hpda = 0; /* no alignment constraint */
> 
> The NVMe-TCP spec indicates that MAXR2T is a 0's-based value. To support a single inflight R2T as indicated in the comment above, icreq->maxr2t should be set to 0, right?

Correct, will fix in the next spin.

Thanks
