Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38445C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE01C20883
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bind6z0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfAHVan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:30:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32960 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbfAHVan (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 16:30:43 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so4374252ioi.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTPRWlanFQfEpyiJDqi1SxvDYh4Pf0VcEum9gF01aaE=;
        b=bind6z0U3eNgDyDvJGBeGb9gkfHDVJBScwaPME18fn7Z9zmQ2rdIG5ue+V2PLBKbKi
         RSFYKnTy0rkCi37HUmihGE3/QUwhJ5tGTesphZxS4FoYcAp0knhXxZ+DOir0M1j0sQHo
         zXcB6ZYSGO4M6+xyhl3oCjdNrLPdvJLIE2htNIW4lXmEYP02po2HEjZwGjjXfDmN/kx2
         +mXL9NsITvFUf2B7TnnRspFO8wE4hjlXgG1XolQ8iJ9CUIIa298PytBAISuDjgpXh5yp
         ri65MNJV7whUzmEqy0HQNnfcRkFW2sr5lou+yoPM14bdTPon7kape1rb5eJiemkzuJHM
         jTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTPRWlanFQfEpyiJDqi1SxvDYh4Pf0VcEum9gF01aaE=;
        b=WEeZbRpYsKN5VpR/vJTdh84zHuTUB03eLYE88FfHKnxITdGLbn1gTgj9OnfN4fySRQ
         JDl90RNQWUG6am6dgsJXra0IUbfPAN92mTja94WtFBfZ6oJo08XpGeNu/uWN8F1aJcrz
         cYr9KxgpDFAJXRqjCwQLWSMY7k5WqSw6CBOQCIOJjj2YDZhy+gXcgSmXZAtej/QZrbX1
         NQIzKgDEG5UWeOdu6HMMh2LeDbNC4Jj1Ocy+XmIHXGOYLi7zJtJMDKdoldl+7/3ETtkR
         G5stQjFLfT6VvIGkuTNaWE3w8UIieQC/tUh94Vwaj7unu8KZOeGO9J3ihhbFOZvqcOQY
         4QLg==
X-Gm-Message-State: AJcUukfvbM9auwRFoZLKZ+FtiR1Sf9xzsox0vaT2JytLgLgSkcbs85X/
        8augHibnWvDmk4ZlVnnRZuG+OA==
X-Google-Smtp-Source: ALg8bN6WjVdCkRpWik/d77rdhn0+PeDhSG8oGaHkb1Qbz4bAe7VSe/6hEcWXQ5euDKaGVh6KZeBNDA==
X-Received: by 2002:a6b:5b12:: with SMTP id v18mr2282292ioh.157.1546983042201;
        Tue, 08 Jan 2019 13:30:42 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m7sm5133381itk.38.2019.01.08.13.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:30:41 -0800 (PST)
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling
 scsi_add_host()
To:     Logan Gunthorpe <logang@deltatee.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>
References: <20190108205043.3122-1-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d986fa7-b510-07d0-02bd-cf4da11fd84e@kernel.dk>
Date:   Tue, 8 Jan 2019 14:30:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108205043.3122-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/19 1:50 PM, Logan Gunthorpe wrote:
> scsi_mq_setup_tags(), which is called by scsi_add_host(), calculates
> the command size to allocate based on the prot_capabilities. In the
> isci driver, scsi_host_set_prot() is called after scsi_add_host()
> so the command size gets calculated to be smaller than it needs to be.
> Eventually, scsi_mq_init_request() locates the 'prot_sdb' after the command
> assuming it was sized correctly and a buffer overrun may occur.
> 
> However, seeing blk_mq_alloc_rqs() rounds up to the nearest cache line
> size, the mistake can go unnoticed.
> 
> The bug was noticed after the struct request size was reduced by
> commit 9d037ad707ed ("block: remove req->timeout_list")
> 
> Which likely reduced the allocated space for the request by an entire
> cache line, enough that the overflow could be hit and it caused a panic,
> on boot, at:
> 
>   RIP: 0010:t10_pi_complete+0x77/0x1c0
>   Call Trace:
>     <IRQ>
>     sd_done+0xf5/0x340
>     scsi_finish_command+0xc3/0x120
>     blk_done_softirq+0x83/0xb0
>     __do_softirq+0xa1/0x2e6
>     irq_exit+0xbc/0xd0
>     call_function_single_interrupt+0xf/0x20
>     </IRQ>
> 
> sd_done() would call scsi_prot_sg_count() which reads the number of
> entities in 'prot_sdb', but seeing 'prot_sdb' is located after the end of
> the allocated space it reads a garbage number and erroneously calls
> t10_pi_complete().
> 
> To prevent this, the calls to scsi_host_set_prot() are moved into
> isci_host_alloc() before the call to scsi_add_host(). Out of caution,
> also move the similar call to scsi_host_set_guard().

Nice work!

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

