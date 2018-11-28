Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D4C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBEF20851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBEF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK1M7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:59:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40272 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeK1M7n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:59:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so22106849oth.7
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 17:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ltUXX8PdK6KHB4L8vgCCAVw0Tmt5Q7KdbRqezmVfoIRgocABTAWNsc5H2lv/Yfo4pG
         i+TxTPdKjrFLiAmlYuLXDA6CC8Y1we8XlTsTF8QmLwTkRbLt4e9xmFWylcoG4UziEeuE
         A7ga689MuF7O4tic/EAVN1N6YWLf1dgGNdVqMzBSrYNUiOzzDWTF/Lvvns2EYvY95Wjo
         iB5xkueC0lN+9CqEEoPxJAd9tULSmI/fmheH47/Gil4U5+bdEfdNgd6Ldyrf0moV+1G+
         jbAR08Ga1FyhoBESq5BrQK+lRdmGoRO0lSEkWP9xBu6hpk7EEaDB7z+0WAABWgqMuZ9z
         3V2g==
X-Gm-Message-State: AA+aEWbZuAUW3T9G8mE34ddBa/uwChgoZ0VQxKQIeOMJ7kbjToOtQJZ0
        NqleZBo+KYOO24C+t8n9CWc=
X-Google-Smtp-Source: AFSGD/XlBsCp2VOUE2bLeEgBhjeUn35A4oBIKOG4mI4k+TiqR/S18QVq8wfHMW9o/9Vt4CH017bk/w==
X-Received: by 2002:a9d:7d10:: with SMTP id v16mr18735177otn.114.1543370391298;
        Tue, 27 Nov 2018 17:59:51 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s13sm2275368otc.40.2018.11.27.17.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:59:50 -0800 (PST)
Subject: Re: [PATCH 1/2] block: move holder tracking from struct block_device
 to hd_struct
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Cc:     linux-block@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ff2b6b5d-0e99-1cfb-ec85-7039ec690e43@grimberg.me>
Date:   Tue, 27 Nov 2018 17:59:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116130805.16225-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
