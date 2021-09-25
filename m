Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B2C433F5
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C006161151
	for <linux-block@archiver.kernel.org>; Sat, 25 Sep 2021 02:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbhIYDBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 23:01:00 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:56125 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbhIYDA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 23:00:58 -0400
Received: by mail-pj1-f41.google.com with SMTP id t20so8277322pju.5
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 19:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkFXxG1/B7HUImua1LRzQp1SzwFli69GeT83Hh7pQtc=;
        b=71WQU7T6KHLd8oK9pG4q5owcrZmfKPTl3f0ZiLLs1NfMeEy4mHyIlDojVl0MxorMR5
         zU1OAtY9wnR41/vnoYn5SsLx2SyytjpMtUwUtGx5DjSb9/vgcmqRu6uSnY8XBlF7/45l
         9Y4K+vYwP5gHVedwryMT4oaQpMdqHv9FuKbX9yZ2Zl8ME4nnPARq6F2NrEBSHF0TZBW+
         LUi/xV+f17kF8aNaoOGbRavVaLf6G/3+fHCq4/6fAA5nHYWooLfwB0Z2YECvYB4Um4ES
         ZRKc0/8Fb6oQ4mxI5gnSPY9v5l+K/RSViDT+qav3r/NW73+QhEY2QYWrNjtAYKqseO6F
         C5zg==
X-Gm-Message-State: AOAM533LZSmvPfEG/Lkhu/ZgSp/6v8koJqlSxvkSF6kUdNyWGqCcj6Ng
        URB4wV10lguAH9UHxyU+E9AMBpIsqzc=
X-Google-Smtp-Source: ABdhPJznLpO94LoGqcoceAdmDSpEVyCdLa0FwpoYqhQp0RUjrNCznPWdF6gKiD72BePdH5wxkYMXBg==
X-Received: by 2002:a17:902:bd05:b0:13d:e7cf:3b57 with SMTP id p5-20020a170902bd0500b0013de7cf3b57mr5770602pls.49.1632538764537;
        Fri, 24 Sep 2021 19:59:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:92db:e1f6:6924:bfce? ([2601:647:4000:d7:92db:e1f6:6924:bfce])
        by smtp.gmail.com with ESMTPSA id p18sm11025042pgk.28.2021.09.24.19.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 19:59:23 -0700 (PDT)
Message-ID: <81cd7cea-6060-4500-8af3-cd324aef61de@acm.org>
Date:   Fri, 24 Sep 2021 19:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Content-Language: en-US
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-3-bvanassche@acm.org>
 <DM6PR04MB7081B7096944F8115A8BE2B6E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB7081B7096944F8115A8BE2B6E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/21 03:58, Damien Le Moal wrote:
> On 2021/09/24 8:27, Bart Van Assche wrote:
>> -/* I/O statistics for all I/O priorities (enum dd_prio). */
>> -struct io_stats {
>> -	struct io_stats_per_prio stats[DD_PRIO_COUNT];
>> +	uint32_t inserted;
>> +	uint32_t merged;
>> +	uint32_t dispatched;
>> +	atomic_t completed;
> 
> Why not use 64-bits types (regular unsigned long long and atomic64_t) ?

Even 64-bit counters can overflow. Using 32-bit counters makes it easier to
trigger an overflow of these counters.

Thanks,

Bart.
