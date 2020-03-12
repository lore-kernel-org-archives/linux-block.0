Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F853C2BB1D
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCDE206BE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j2fLK1yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLNZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:25:11 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44110 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:25:11 -0400
Received: by mail-il1-f196.google.com with SMTP id j69so5420054ila.11
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ndnidSMgbYt+qzNKk/4/2bWrrY0w3HilPAmXJWDTL4Q=;
        b=j2fLK1yQ1ortgRcw1ToWl7Hgm1ON4eyInI1+OmtrgO45378Qr26uVfDVijiLCIANfe
         3m75de7r1G7OH1qDVA14pkMvjl4mrZXxCvjG7CBt8iq/PVpNUQSFHQTcM+cBbZC6t9fF
         XgPerNx+CEciaR6t/q/FHYxdqf/VQYgDYmOtcrnvVsHv5PXjVJr6+ELT2LxI15QiJXzp
         QgcEjU6zaKR6CpLxrVB6jXVV43ZzuVskpjdOB4THEnoDAdC4GQb5baSYVhByFlAMAAI6
         XpJP8oxV1khVe4gPOpmf6GL9TSOTgBWipleYxau/FURYUMWyiHTQVJj1f8Pk28evbWNQ
         h/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndnidSMgbYt+qzNKk/4/2bWrrY0w3HilPAmXJWDTL4Q=;
        b=GjU9Wr0OWdEQncCzhulERtJYT01UlJLJfxkOGTXSfKJwLak5Ytl3lYQzJnwaBT42ai
         uRqv2CrR/wu8tsCji9qdxeLdnTRW7vWT6EKeYDzyFWlpknibnoUd9/Tq4UAKp+XXmeKj
         Mc/+1ADdcjxfp98qmi5xNrGw5eWRQYrALk0WC6ASB+c0iAO8U5c25cvd2r484onHNcPB
         9KoCNhsXNir+oY9YqvNucto0n9zLxrJ1bKq1Fi1GOXecQWXfA7aysS8+uyAY+2Eypu8s
         ueURhstrWD0wJv79VmaTpR9NzM9ryZhJpz+AcezLRyiyNcbeQLI24eM0ksoNtirntpG6
         Tfyw==
X-Gm-Message-State: ANhLgQ2MIxbILMqgo7GF9iLJwlb4BW3ZiJ2SwvgLdknfwzAM60a8BDoI
        eyL75RHKlYg3299+ToOHieMWYw==
X-Google-Smtp-Source: ADFU+vt5nQOomXXOScFsa6s0vY6t1+4y/eXJEjAl2SpQxRch9HKvoVi3xB9ozUDslttbY15KnzmlQw==
X-Received: by 2002:a92:9642:: with SMTP id g63mr8726810ilh.223.1584019509797;
        Thu, 12 Mar 2020 06:25:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 27sm4909513ilv.75.2020.03.12.06.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:25:09 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix data corruption
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200312131715.72621-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd6a5017-7db4-3d66-c58d-40d8b0fda61c@kernel.dk>
Date:   Thu, 12 Mar 2020 07:25:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312131715.72621-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/20 7:17 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please find following patch that fixes a likely data corruption when using
> devices with thin provisioning support.
> As this is a severe issue I hope this will make it into RC6. If not, please
> let me know.

Applied for 5.6, thanks.

-- 
Jens Axboe

