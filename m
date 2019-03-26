Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B1C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 03:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC622075C
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HCPTxa9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCZDKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:10:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32957 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCZDKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 23:10:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so921278plb.0
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dCI6smuj13mob3M++WeP1hjbr+EyfbTttuZ+FhBrR6o=;
        b=HCPTxa9e83EQhD4JmMEZ9fGJB6x34tnkkvFqSgQ8KGSSlGd+VUbsm6zDZUVnP46FBe
         +TZ9jhXKZW8EugUggYoNyPIGY7mF9w8EwNpFGLfGZdQ1V8i5hNXuYZAl6ey2zuHifnNp
         vEmabIhGKrrbsn8vCcLs1irbviCsxmDCJvN/xkfZN/h3s3M67JFSWS8pKZUvEgCcEcDD
         cgmCXP01pwMohK29bupYCw1hvxYgaXKBicrgbxkU/UsRl3auxtlAiYu7ilB8dmAzVP6n
         hmKKJd4P/fbEEvVBJn0P8+sOhzlQPzmL9K/qbvuGSK4IfqAB1Gs9DfZOA5h7SAXsjrok
         8o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dCI6smuj13mob3M++WeP1hjbr+EyfbTttuZ+FhBrR6o=;
        b=k43DiO45KHAuN74dZk6YB8S0pjIj+TI7kvnsfgXo3+8hp6/Tt2h3WMlD5bSGRijjyV
         6tAjVZyTHN+NOGoRY7fnxhCyAOTwTKGdhGy++4+aFWDUQnFel/z6Pg1B+T0uldDSkjkQ
         LxJPeqHPypF3yFa6v7XUPcb7Tn4+IReo/ijHfGt1A5Zfmdpk1w7kjMMIaS2ZrnaK+Iyq
         uONL3Uy1of1aqhbKTuVWqrC8alUkZXm20ANM8ScgN9qBKN+Wywl5zXiSpdHxcrWDUBmq
         cJA2+W2WMGnsTulUlZxOPC4SP7gAQjInBl5NYBvl/wV0omzTUrDOKUzXun2+bxDQX7XP
         RJjA==
X-Gm-Message-State: APjAAAV3y1at1yPGiz/5CoRSg6+MG7eSXRtTuzqOKVNaZTcmyqbXIWMS
        ifSl5FJNpqHxNQWLUf4eGzf0HhsWx/vmIw==
X-Google-Smtp-Source: APXvYqzCs8bMPMk6DmCSdp4r2okMykaspje9WfWYf8s5PQ0T/fdCiHW2aaOhj4Nkh79fCPn7P6MDBg==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr29479621plb.22.1553569811644;
        Mon, 25 Mar 2019 20:10:11 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o76sm39764852pfa.156.2019.03.25.20.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 20:10:10 -0700 (PDT)
Subject: Re: [PATCH V3] sbitmap: order READ/WRITE freed instance and setting
 clear bit
To:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
References: <20190322011351.4082-1-ming.lei@redhat.com>
 <20190325185217.GE5826@vader> <20190326013309.GB30669@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18a3dfdb-7d32-70fa-2160-585a26540905@kernel.dk>
Date:   Mon, 25 Mar 2019 21:10:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326013309.GB30669@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 7:33 PM, Ming Lei wrote:
> On Mon, Mar 25, 2019 at 11:52:17AM -0700, Omar Sandoval wrote:
>> On Fri, Mar 22, 2019 at 09:13:51AM +0800, Ming Lei wrote:
>>> Inside sbitmap_queue_clear(), once the clear bit is set, it will be
>>> visiable to allocation path immediately. Meantime READ/WRITE on old
>>> associated instance(such as request in case of blk-mq) may be
>>> out-of-order with the setting clear bit, so race with re-allocation
>>> may be triggered.
>>>
>>> Adds one memory barrier for ordering READ/WRITE of the freed associated
>>> instance with setting clear bit for avoiding race with re-allocation.
>>
>> Just to make sure I understand, the race is something like this?
>>
>> Thread 1			Thread 2
>> sbitmap_queue_get()
>> ...
>> write to request _____
>> sbitmap_queue_clear() \
>> 		       \	sbitmap_queue_get()
>> 		        \______ observes write
>>
>> If so, you can add
>>
>> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Yeah, it is one normal race between freeing and allocating.

Applied, thanks.

-- 
Jens Axboe

