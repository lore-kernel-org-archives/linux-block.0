Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2DDC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D607120838
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RXM3cA8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D607120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGOku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:40:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35094 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGOku (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 09:40:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1940933plo.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 06:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t5uWgEcBSX83NAnGjcCOhJhYCIFYRMs8bU69Us4U+ow=;
        b=RXM3cA8fCNbuGif2hYEC+WtG4bxcQZK49shiy2iiuJqLdnU1pYagRnSDR3SnNtO8Iy
         807WndcCDYphlB7GL++MSPKq3IaGcvPyRI6il0ToobRlEULK5t/6JAO/jCUYMAK1mSJp
         ITfO6+j2slu4h2VlR5QnTOLXVn6GRYc+cIoZXgP9MDPWGuuKuNLcq1xKomEkdMkkkMII
         /eY/v1KBgPXDO1zeFwu5x6HdjBwSqURp5tRADogPQnS82FXa5xQwvjqWzkUGUL4++8+d
         tp8T86e95TrxNHhlcXPR0PQIcHAiWvkPFYulCxZuaKj61WsKs6hfBcL/2u5ek8b3j3lM
         dr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t5uWgEcBSX83NAnGjcCOhJhYCIFYRMs8bU69Us4U+ow=;
        b=pK8RUtWh32hi7bvkEa/oM6zIord12jTNHHaNfNJkryAMdE0E/zF5bmCNSfinZ4n46r
         qHkfefJMUPvDvmwiht7VxbDVFBDNGmn3QDUJejTM+3cvVN2/7rkD6yF+i38zbSn1kgqQ
         CSVAPq4TWAZ4O6vJp5ANtJQzcmJcqxXl1ogfGzKosbQ2jDg6K/q3cYhfc67Giq3buKTR
         EktdAL8DoSLk4FybR8I6vASVODiu5Ho7O7JetLDfHA/3LsR8n9bPp5bZVvE/efp+Ax52
         j1PeNtkV+NVvt0Yc6TlEddxHk0TabT3ztk4cpfGgUgL0DWFrKjuaMJVjAUgaqHP1+SXP
         EJhg==
X-Gm-Message-State: AA+aEWb41GbcO2so7x2hhAx3fHR/MeUoD7xVN6cA/whknFtsUl8PxWPM
        cR0CRdFDP7imruWrDlUco24r9g==
X-Google-Smtp-Source: AFSGD/XwchrFS1nOZSGNQeg/I3xIR2o9IyeX/KrdAfq+dyam/IciioKi3OvXN+t/9Nai4jUNfSd3sA==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr2269354pla.47.1544193649445;
        Fri, 07 Dec 2018 06:40:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g26sm4654481pfh.61.2018.12.07.06.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:40:48 -0800 (PST)
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
References: <20181206181819.11148-1-paolo.valente@linaro.org>
 <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
 <8753C347-2BFD-40D4-A97E-DA955BC0207C@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16d4065e-c0d1-7a85-3d9a-242bfd92923e@kernel.dk>
Date:   Fri, 7 Dec 2018 07:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8753C347-2BFD-40D4-A97E-DA955BC0207C@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 3:01 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 7 dic 2018, alle ore 03:23, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 12/6/18 11:18 AM, Paolo Valente wrote:
>>> Hi Jens,
>>> the first patch in this series fixes an error in the decrementing of
>>> the counter of the number of groups with pending I/O. This wrong
>>> decrement caused loss of throughput or, less likely, of control on
>>> I/O. The second patch is a fix of some wrong comments, which somehow
>>> contributed to making the above bug more difficult to find.
>>
>> Are you fine with this going into 4.21? I can't quite tell what your
>> intent is. The first patch has a Fixes for something
> 
> yep, that fixes a serious error.
> 
>> that went into
>> this series, but then patch 2 is a comment update that would not
>> normally be something to be applied at this stage.
>>
> 
> and yes, only comments changed by the second one
> 
> May it make sense to apply them in two steps, one in the 4.20 and the other one in the 4.21?

I think so, I'll do that.

-- 
Jens Axboe

