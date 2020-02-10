Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85EC352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFA20733
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBJWXk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:23:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54774 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 17:23:40 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so389691pjb.4
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 14:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsGB8F3xHfM4IlY8o9jnMJL51w8BzAmC+My1FC7CpQ8=;
        b=BoEb5+Be6HMUC1CNkAES5pXZDu0Y1JvK2XyQpLu75OeENuU6DUgTwsIlORVX3kHFcz
         8aNt/UMfTvHoS3pZOCmyx9Q5imQ1frLtxvlOkbqlGPgB/pNg1jpYMW1fBW9UcNZmDbbT
         zZM0sGbEQZnEljNB+/wu2W1L5lkBN0aHxNrOks1eVXxoLsAsdQjRC6gWBTDm3XewcX3b
         zJIIEXkNIoxjPc1mY/IjpizXFote/QxJGAm1UvZMZGoFbrqYO+msfVDGiMeVHH5TTtEm
         r5e3wra7HDRqpcc65cq21a0MG5upp6+/zWn5QWBX89+xq1bys1gZYmWdayU35R4OcGAO
         ou4g==
X-Gm-Message-State: APjAAAXcQBdVLUw/I9VDNlZiKNR0j+pSsvhBl709r5Fp+BuK1To9HFb1
        Quj+wKvUBOLu/6pSVvGT8XbEhcpv
X-Google-Smtp-Source: APXvYqy8pK3DUVmo7vWSfj9XdgdxYyjUVd0K0d+L7OgSGOq74BzDdiZDrNM8OrbZxagm7tdR0lYNYA==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr65668ply.303.1581373419137;
        Mon, 10 Feb 2020 14:23:39 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d22sm1313553pfo.187.2020.02.10.14.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 14:23:38 -0800 (PST)
Subject: Re: [PATCH] block: support arbitrary zone size
To:     Alexey Dobriyan <adobriyan@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, damien.lemoal@wdc.com
References: <20200210220816.GA7769@avx2>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <db1b4fee-dbd1-1b0f-9ea8-b00de1d30063@acm.org>
Date:   Mon, 10 Feb 2020 14:23:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200210220816.GA7769@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/20 2:08 PM, Alexey Dobriyan wrote:
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +	return div64_u64(get_capacity(disk) + zone_sectors - 1, zone_sectors);

This kind of change impacts the performance negatively of ZNS devices 
for which the zone size is a power of two. I don't think it's fair to 
make others pay a price for a feature that is only needed for one single 
device.

Bart.
