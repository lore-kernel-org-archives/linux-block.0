Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D049AC432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A699820709
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 21:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mrbWt/Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNVDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:03:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40764 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKNVDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 16:03:01 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so8419280iod.7
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=riW/BlbibCVCmPZdN9adPm8zdJod8ErG59vLuOA9tfg=;
        b=mrbWt/VjnZVzv1C48GYpJgkluW6IecuUpgKcOTqVDbG2ZZ34seOvUVv3Ye5GNoML33
         l2zxZ2rTek9Lwl0QOTh6M1lb25fx08X6+Pt8BfeLbFshtr7g9v0ZOQfKCdZ10vvNE7xP
         BKojXKlExvZvtdw8UZve7U1z8vw3vrwqpmbs/Y+IRKwbS2lq/c825Or+efUZ8MymKYGD
         mtb9XcK3GboQfw7u5puCOUtsQErpBvX1iJFJIU6uToLEdwsLX7mbgwOBpPlq8c57A8mH
         /M828eCCJfMRaEQf7gC2YScYzFR+IbhEfJd1cOYLiroetCUJy/jWA+KTft9nxdBQ/Muw
         oDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riW/BlbibCVCmPZdN9adPm8zdJod8ErG59vLuOA9tfg=;
        b=CjBz+D9J2q/lU3Pm9w7Voj3RyBNY/pnGREGaxc5ChQdtOCcE5F82cxCml1jK8C2vK0
         DbUncMai7i+237s7RJ4fLk1VDl389ETiV8PPPzj/ynf5V7ybOXgVHGL4CMIc0ZfO0d+L
         G8zZjMASfD4IXaxMQGMbbyK1Syo5QJLbgbzH7uVpUPvv/ag8rMqEG7stIg7QLT9/j/J0
         XHM2aiPGFTnYYZJdVKWMBN+n6L19y2B4csOe83K8ZnzBYAZFF4AQkVHLq7CJXtiauo1/
         9AiZS/dAMfD+feG2sSyeMEvkj6ZiOD+VczXYvhj0bFdfGnLt1AQSFa6QFH69MKHdLSlN
         yAPg==
X-Gm-Message-State: APjAAAVFhiq59WcpLxT2Iwe+fBiPLt6TD2V72nYmUuCzDjz6kddP1NGU
        IOgiZmnH2vEOkxy+aazpaaBLkyQfbbI=
X-Google-Smtp-Source: APXvYqw5gkBg2nH3GqmsYK19cbRlIVGFZXLGo3krw1m0XwKE5pocMtkgLt2LxAv4L2UQNyx0fh28qA==
X-Received: by 2002:a5e:a70e:: with SMTP id b14mr10990209iod.166.1573765379997;
        Thu, 14 Nov 2019 13:02:59 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e67sm948284ill.42.2019.11.14.13.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:02:58 -0800 (PST)
Subject: Re: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
 <20191111211844.5922-3-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5816865D212AD49866689ADAE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5749AC2084CC7FBF7ABD551F86770@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c0494e04-7dc5-9515-e84c-8faedf8763e5@kernel.dk>
Date:   Thu, 14 Nov 2019 14:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749AC2084CC7FBF7ABD551F86770@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/19 8:53 PM, Chaitanya Kulkarni wrote:
> On 11/11/2019 04:04 PM, Damien Le Moal wrote:
>> On 2019/11/12 6:18, Chaitanya Kulkarni wrote:
>>> This patch is on the similar concept which is posted earlier:-
>>> https://marc.info/?l=linux-block&m=157321402002207&w=2.
>>
>> May be reference a commit ID here instead of an URL ?
>>
> With reference to the cover-letter  I couldn't find this commit in
> the repo (on for-next branch), waiting for Jens to respond if he wants
> me to bundle these patches with the original in one series.

It's not added yet, there was still discussion around it. Someone needs
to followup on that one.

But in general, don't make commit messages just a link, that's not
a good commit message.

-- 
Jens Axboe

