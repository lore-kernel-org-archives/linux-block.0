Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A14C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C201F20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C201F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeLMPtr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:49:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41476 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeLMPtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:49:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so1241380plm.8;
        Thu, 13 Dec 2018 07:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIIre++nxeFj5OA4/x0qirZpXr5/Td9NIPvYCIc0mIA=;
        b=bQzgC2g8bd2rrzTygXXrCSnZXBKFHl0QLhorNztS2qRWrDaT50xCnYg48e6QhAoG7z
         m74+Do7jyaPNKaTX5EtR82MjwdlIF2RgdymclPdO2HeGQ2Lu8ogHKP/yGb+6uthE7rAM
         T1Ji/QSOoqHtKh6naByglJYkTtiPss1MlJzd16JZNhVLg/rQ+j9YTjjFYJMylMgPllSQ
         eXZkpMX2J+9EBVyfT1Mru2PdlRYcIbrJB3JqZ3d7JDOC/JUc6np/n1jScP40pKeXGMGj
         /InJ4QKutrRXsoCR9ex64qDeChzsRR2EAz9vbgAr02G8EupDVN+BjRkyVTSKZ+Vz+SoU
         NVmQ==
X-Gm-Message-State: AA+aEWZUotS3zWvmA9s78bR8crFIes8aUcfqi+CX2/xs4apUORlpLFIq
        AqHkD+dHmC+Nfa5VYWpWFCeRvZD6
X-Google-Smtp-Source: AFSGD/XdMb5fhyefjdOr0yvnYKks9hK9jQ6doifL3a6pWE8qVLOcOkl5FWG6QB2mJsndeUzTnb561g==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr23251071plk.196.1544716185941;
        Thu, 13 Dec 2018 07:49:45 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id r8sm2599831pgr.48.2018.12.13.07.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:49:45 -0800 (PST)
Subject: Re: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me>
Date:   Thu, 13 Dec 2018 07:49:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213083157.GD869@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		bio->bi_opf &= ~REQ_HIPRI;
> +

Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
avoid the extra atomic operation in the host path?

Would it make sense?
