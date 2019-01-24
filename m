Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19281C282C0
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D159C21872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mvd9KdmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAXARt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:17:49 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41475 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAXARt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 19:17:49 -0500
Received: by mail-pl1-f170.google.com with SMTP id u6so1991550plm.8
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 16:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7LpOWY2zwJUJvdSQmKYT/X+eM4Haag5ezBb6ntXRY0=;
        b=Mvd9KdmVVi4AHA8wGDLLFaeLKdoRDgetMWVoL1mQ4yZYhUytZkn7d5cnH0bexZKMet
         E5QNhqLWmetWbAwntbWsWTSDhlks444lcwOu1+3KPz0HmQLAS1oRxKN9sqxfdLNdXMXp
         LKt9TqaQhNqe///sPk0OPyNKYswqF6Mgcrpt7Co+kgqdsbxLGnQ3UsM3E2OVyi9/7PaO
         pgKCy/p+2GkIoTxTWVuIvo01ouvmFrb1VZOT85YawDttfj3Vo1N9KoaPu/O6t72DJJW3
         UUIBnkh+eJ4JkKol2A2nYpquUKNc6PENMDXNtpo+ViT6KsCHF2EtDWvlXHH84ql7Ic32
         z7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7LpOWY2zwJUJvdSQmKYT/X+eM4Haag5ezBb6ntXRY0=;
        b=OsmVtGCw/WK7ENzdMrDs4eCYijXL+o+Czom1xkT358Pw8mw2e4xcl4hA7+Jco6eTMn
         xDbQzsU70GjqmgjUUBxmJVfiBuDvTcwfyO0SmdhR4RaoCQqYBv8oUuZEXIGH0RmxPjcZ
         Tz6SeOSdI/g40op2XHaESXTDtpO4mTOo+VkTFrLtmz2fOL19/kcZutbQw3Z6D9uV7k6v
         QHnU4qDi0uN5UOEbrXP5CN44XISFQTAcBj8FwT4v5SGAVXcL3EcX5D/wZlpKdoKFrcce
         4bYg1LmHNL9OFM1lPEDRopuh5XbWS2HGUwBV4VljhgzNw1+8I6IbSgR76vxEGgHSMZin
         9sbA==
X-Gm-Message-State: AJcUukfRUDF63FjvMF6OSDuJ/1AoaheYQ1qiv3jJ3cpGKtghDGWkWIe/
        kkRenav2EIeAtcHogZ50y7Ko0rmXcKuD1g==
X-Google-Smtp-Source: ALg8bN7+hzkyoiFzl0aaejf/lpNntCUKIQqPcpm63TLFlvpe+wP0PGoYDXpjGb2DKyDFMEntdH1mCQ==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr4491280pla.228.1548289068450;
        Wed, 23 Jan 2019 16:17:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z62sm29252165pfi.4.2019.01.23.16.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 16:17:47 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.0-rc4
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190123214252.27491-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6379865-7f4a-5609-d051-f6421660b796@kernel.dk>
Date:   Wed, 23 Jan 2019 17:17:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123214252.27491-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/19 2:42 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Couple of nvme fixes for the next rc round.
> 
> - Fix nvme-rdma and nvme-tcp timeout handlers racing with queue
>   disconnections and initial connect failuers
> - fix nvme-rdma regression in queue maps assignment introduced
>   in read/write queue map separation
> - fix nvmet-rdma null dereference when we run out of rsps under
>   heavy load
> - fix multipath ana log underallocation when static group ids are used
> 
> The following changes since commit eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:
> 
>   nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0

This is still forward of my existing branch, so I just hand
applied these. After my next pull, I'll fast forward the
branch for next time.

-- 
Jens Axboe

