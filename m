Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E93C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6651206BB
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6651206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbeKVJDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:03:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38959 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeKVJDh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 04:03:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so5903106oii.6;
        Wed, 21 Nov 2018 14:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLeg8UuXDEeZoXaUXYG2KSrINF8EWk9lwb8xlY9VDwc=;
        b=T5k72Ixyx8vDgbjf5Vh47J8atmGHhmd5WPekn9/8WjApN/OUdULAxiUHv4DNkKloP1
         eJNNDgBDEk5TImDTzLgEf4okufUGcGdyS7Q6EDObOV7gfjZ70u7j5MZ36yComWBhITbJ
         lL83ROH1WW/BpDpZ061hyIaUvsE3s3d/0dAdQe833CFaLGmWnuydaBDKQoiUCQT3aMU2
         rWbnbBKTXTMT3iV/CvS2VmGZ5CYCUADIb3N5WCzvYJmqOfwQIQJhsscXAap4LCyc2uMW
         HZ0oQi5dpKSLxokiz34w8HsyiIqm0o/eH8NSPdW+7jYtIY4U6GSH4w3RN9hPWAENJn5x
         vSkg==
X-Gm-Message-State: AGRZ1gIICJQrLqkxu0CiVKQWMxujscKolZaY5mTAZVHFj1aV/lEf863s
        zb1zxxf5L8uyBwgvgmKMI7g=
X-Google-Smtp-Source: AJdET5deta+ff1DM/SEUaflOjzBi1x0d2SexXBOLu/HJL57SPsBDVM3u7rt+WsZTYpY/bMBRF6WDhw==
X-Received: by 2002:aca:e78a:: with SMTP id e132-v6mr4881131oih.9.1542839239577;
        Wed, 21 Nov 2018 14:27:19 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r25sm3995983otb.27.2018.11.21.14.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:27:18 -0800 (PST)
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me> <20181121085645.GA29747@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <09c340a0-0b7f-ff9b-f196-7ba48a0ee234@grimberg.me>
Date:   Wed, 21 Nov 2018 14:27:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121085645.GA29747@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +struct nvme_tcp_send_ctx {
>> +	struct bio		*curr_bio;
>> +	struct iov_iter		iter;
>> +	size_t			offset;
>> +	size_t			data_sent;
>> +	enum nvme_tcp_send_state state;
>> +};
>> +
>> +struct nvme_tcp_recv_ctx {
>> +	struct iov_iter		iter;
>> +	struct bio		*curr_bio;
>> +};
> 
> I don't understand these structures.  There should only be
> a bio to be send or receive, not both.  Why do we need two
> curr_bio pointers?

We don't really need both...

> To me it seems like both structures should just go away and
> move into nvme_tcp_request ala:
> 
> 
> 	struct bio		*curr_bio;
> 
> 	/* send state */
> 	struct iov_iter		send_iter;
> 	size_t			send_offset;
> 	enum nvme_tcp_send_state send_state;
> 	size_t			data_sent;
> 
> 	/* receive state */
> 	struct iov_iter		recv_iter;
> 

Sure, will move this.
