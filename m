Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D44C48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1C2214DA
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="g4myPHik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfFYKc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:32:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33781 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFYKc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 06:32:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so12270222lfe.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=g4myPHik/VDVtLYpxVZL5RmDDlI748sNxEFtnxOyRqNQdNghngq96pMu24m6LN4TWz
         GonPpoTK5itnyXQQyE83fhudsB690BoHPguK4Lwx5RXl27eKbV+MeR76wLmrRnxb2y4x
         uV1Z52olMUY95shBxscd0ndg3Il8MB9Tm0mU/CY4lBWvA4EQMYZ5cRyiJ7tkY/CekrtW
         AwqyWRnOilwi85lJcX5SQe2EE8h44SvQ+ffNpyt5G1VfPbTco3XQLlOArMc1BU87OYP3
         2bZvaAPuKqcN8V4Ivv5uTZJ1wQyEoniDqYNwbkfkXLpg2IXhOR9Rja/D39MIOKpiLOnr
         ljCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=th2KU3gSB8Y7084kardB4MOmN43ykdt1edhob3WeuVEpURK3ZdLCvF6yM5AqL3E6aM
         A7lVwJ4c5xgvEY3CMOf0CjXFa4GKEr2SVXIK0mfhoCns/GwDb1ufTyr8FBLokKeH/gQe
         hVKmx0OtIphmzKHggFtMXk9zz/lo76O6mMeAVgtTVjLfXM8JNeLUrMIirmTBv/UqU+ka
         CvJgNKqmetPMCtJZ1sz8vSFn0T3u8EN9lVF7CTP3hvTwo3hm6T9D+JwUeLNsfDYg4E80
         sZvsW6Fzo3h9k8uZe23tAMsMxUb1YhlRbuvn9os3GvHUruJYyXCkGXDi2xUVvWsiK62x
         +FQA==
X-Gm-Message-State: APjAAAWvmeOpVv+5tzT1QXtLOuhemvLepxjt15YmGhUnRq8DMvzQ9Ihg
        BM4kWklZ1yiK7ANLXQfsRwhlRA==
X-Google-Smtp-Source: APXvYqzBmDbBn4uaSRgOejv0dCMXCDPGoGCJEE71DIMwwmCQk8qQYYktGIfIGht24KxyuAfH1v5KOw==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr21659830lfd.27.1561458746106;
        Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d15sm1867200lfq.76.2019.06.25.03.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:32:25 -0700 (PDT)
Subject: Re: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@fb.com, hch@lst.de,
        damien.lemoal@wdc.com, chaitanya.kulkarni@wdc.com,
        dmitry.fomichev@wdc.com, ajay.joshi@wdc.com,
        aravind.ramesh@wdc.com, martin.petersen@oracle.com,
        James.Bottomley@HansenPartnership.com, agk@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-4-mb@lightnvm.io>
 <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <62457020-b543-e08d-54fe-e8dc92d94e47@lightnvm.io>
Date:   Tue, 25 Jun 2019 12:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 9:46 PM, Bart Van Assche wrote:
> On 6/21/19 6:07 AM, Matias Bjørling wrote:
>> + * @op: Operation to be performed
> 
> This description could be more clear.
> 
> Thanks,
> 
> Bart.

Thanks Bart. I'll update it.
