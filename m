Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B9C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8019320851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Atf6nmzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8019320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeKTFZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:25:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42671 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeKTFZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 00:25:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so10780429pga.9
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Cfi5q9yDGec5qeawIgot70BET7Be5rnEuO24vDNB4bk=;
        b=Atf6nmzdqrwEp+nH/7QUNQvOehplJNYUAstbCeDk0AZn4eg4Jke1TgeSgwu0UrbjSX
         2CuBRDCInn7aXcSv2yVXp07KIBKlOZpDb09gJ72tZzJrFsaRc68lDqzCKC3DaWRGwSak
         k9rs+9GJyc0405iAMlgSu5FKyzdnZH60ppnFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cfi5q9yDGec5qeawIgot70BET7Be5rnEuO24vDNB4bk=;
        b=W3O4TZslsr88Q5qzDF6TgSUjd4afYW8oqVBZ5j8Hk2ueYU5Gzxp9SNMbTR5XDptGYu
         V6OnoTJMpOxDYWexzSF+Eld+itPcOXbP1Cklk8isdZZI4wdoG3EyYjt49t38yLWVGyGL
         49WUm3OiTgDrMRldb9cgQfnLgNINuzKpfgtWPlyg9QTSR5wGKa5WQP23L9vMxRJN74gD
         RKjsk/opmGTnwEJNQvtC3ubS2eGduzI/xBasYOyuEm6MI/a2cFZ2br9Eul2Nh67Q5M89
         nHz58He1Ub9Zo+keZK9hsL2NojQDX6bYBr7a/a0vY15pNce6Rb0S86cIFfu9N8TXE5ED
         HnLQ==
X-Gm-Message-State: AGRZ1gLPK0pukBqhwNzy0Is+qqo13foWNR5n4aMJxsGmG4l77GbfXktO
        jGuOvKsqX1dR0pRj1Z/DMhG4Eg==
X-Google-Smtp-Source: AJdET5dkoCUnyDIZ9EElCvR8bQY9BD/Ofi0cHk4x24jSI2RYUlYfo3zwnBxNJiNYAobZN65lHm6DqA==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr24527860pfc.184.1542654027011;
        Mon, 19 Nov 2018 11:00:27 -0800 (PST)
Received: from [10.69.36.116] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm6480476pfg.126.2018.11.19.11.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:00:25 -0800 (PST)
Subject: Re: [PATCH 3/7] nvme-fc: remove unused poll implementation
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-4-axboe@kernel.dk> <20181119075904.GC9622@infradead.org>
 <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <b3a8a5a0-3788-b8ae-57d4-7550f56f0400@broadcom.com>
Date:   Mon, 19 Nov 2018 11:00:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/19/2018 7:19 AM, Jens Axboe wrote:
> On 11/19/18 12:59 AM, Christoph Hellwig wrote:
>> On Sat, Nov 17, 2018 at 02:43:50PM -0700, Jens Axboe wrote:
>>> This relies on the fc taget ops setting ->poll_queue, which
>>> nobody does. Otherwise it just checks if something has
>>> completed, which isn't very useful.
>> Please also remove the unused ->poll_queue method.
>>
>> Otherwise looks fine:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Sure, will do.
>

Looks fine on my end

Reviewed-by:  James Smart <jsmart2021@gmail.com>

