Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71621C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE52082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aK60bJN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeLDTNy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:13:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37003 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLDTNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 14:13:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so8697520pfb.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eBDQPbGS5Dj4tWunN8ujeBqj/BcNwt7XOyP7uon1nYk=;
        b=aK60bJN+PjcpI/SqQWRJjVJU3+IDkW10YnvhldKqGFCyHhOowWbEhJEuxCqf0TXiun
         /7ECo+f1zvoxjqzgvryDwXJV59oHrWu46S4APuPk5PGfFl18++HnMw2aHWdM84qc5dGf
         d0POVPkLKXiL1ziVY3HQicqmCEmKgz5gdeb84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eBDQPbGS5Dj4tWunN8ujeBqj/BcNwt7XOyP7uon1nYk=;
        b=nA4J3pxk7pb83BlSNnE/lkCxb1fWcj6GMOJDF11brely1tvVOQKjyjze3Ph7k4QLso
         r8k0RQ8A/SUl6JDc4ZPhHX/I2Qd8wlcAfzPU5OooJgUfttidPQ13Yd1Fa1V9wZwQlQF0
         TOnG61Wi7eoDwhSXtdYhrPtJBwPeRCH/HYX04BCSqv/bjOuDUzD5LYNCVbXspcAaujLO
         1IUs95NgQtSfS660kkSz1pIqk8bGjIgUny71eGxwO77sNQgDvXuyL3cYO8cjOKESLlTY
         gXXPCxoO07FcMaSDd11OhMN6HQlWxANny3VKzuag/u/sy0yxE2rjsUy5Lw0tytwdKA3a
         w/7w==
X-Gm-Message-State: AA+aEWb3Vw7+XzENiVTDBFiivf47jG/PAklFUgjbn60rPsxNROeZA0Us
        HXUp0xI896vG9obEO/L/dTJmFw==
X-Google-Smtp-Source: AFSGD/XrnDXnP2WoL8Fa1yaYrvhzAkjWjg2bNHlJ5MCgNmbon/B9vQG15HI6xHRlaNah481Lx+sruA==
X-Received: by 2002:a65:62da:: with SMTP id m26mr17842593pgv.278.1543950832403;
        Tue, 04 Dec 2018 11:13:52 -0800 (PST)
Received: from [10.75.249.89] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q1sm19070343pgs.14.2018.12.04.11.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:13:51 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Sagi Grimberg <sagi@grimberg.me>,
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
 <19b3821e-02fa-bd09-1b90-0dd8904e8a57@grimberg.me>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <2ba6570b-1684-6082-7b70-f51a4136b38a@broadcom.com>
Date:   Tue, 4 Dec 2018 11:13:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <19b3821e-02fa-bd09-1b90-0dd8904e8a57@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/4/2018 9:23 AM, Sagi Grimberg wrote:
>
>>>>> Yes, I'm very much in favour of this, too.
>>>>> We always have this IMO slightly weird notion of stopping the 
>>>>> queue, set
>>>>> some error flags in the driver, then _restarting_ the queue, just so
>>>>> that the driver then sees the error flag and terminates the requests.
>>>>> Which I always found quite counter-intuitive.
>>>> What about requests that come in after the iteration runs? how are 
>>>> those
>>>> terminated?
>>> If we've reached a dead state, I think you'd want to start a queue 
>>> freeze
>>> before running the terminating iterator.
>>
>> For the requests that come in after the iterator, the 
>> nvmf_check_ready() routine, which validates controller state, will 
>> catch and bounce them.
>
> The point of this patch was to omit the check in queue_rq like Keith
> did in patch #2.

well - I'm not sure that's possible. The fabrics will have different 
time constraints vs pci.

-- james

