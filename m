Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3032CC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DF121670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoSzjyAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfD3Kwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34110 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfD3Kwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so7836653qka.1;
        Tue, 30 Apr 2019 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LnKYy8jFj+JVpVc0C/UzgZXSpL4E0hdFTQaCn24mwco=;
        b=ZoSzjyAFUIkT/IJEHAragzsBdlhhXZzJTUJVioDNkVtECy/vvUL0m8oBhzUu+irnqG
         OkN4BD3T9QdnGO7JhpIvWx3ufxUQST4hhDUljQiTj5W9n7aM+a1ZaQx35XSwQneiwz9R
         ZfwuvPcaSOEcH9oMkTtq2YbB/0hWzmP4qAlKhF/2HhOqniJRShrkgJboNt0yK+0vks48
         /lNukNAOpB241V+d0DDTcM5aQBXRfvAEhWgnET/BS4JvN9iodjsmHIUeMD0G9fzbPJPe
         ddROflj3IUdU+gmVAYmnEsg6sfmsePB1ZPudkwyMJvJQojxZpIOuKbYdozVTLoCqlae5
         5LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LnKYy8jFj+JVpVc0C/UzgZXSpL4E0hdFTQaCn24mwco=;
        b=iPwAt18yxPHA9pA3RfCyeIvsrbhNfV7zUAJ47XwNVAM5CyxEsjVNFWswzGJZFz/rXW
         pjtwog6Fj+yKcW2yOTDlm5lj/o1TqVvG1uPOBVDOne1Wn4G8EfGyVeP1PEQtOjvIZF0T
         6oNSuxhO4fkZmiBMF5oENyG/TSg/uMATdNV9cM+UMekENMZ8taXaoB7Jhz/ZFC8s8sw6
         /bqURkwgCqM/bpZ/fwlsfWB3EzUBLEla6+p1UDuFOB3PcVQwszzY26FpUQzU1d9GsC1s
         aQGjWl8v3ue1K/YYhIKyNhwIJHj2LCinw8vPJlUnlhZzFoD5O6db4v5xAqOYAGsseuiH
         Hvbg==
X-Gm-Message-State: APjAAAWzjpHd41ZVkAFbVuLgyjZCwDcH2waWobXUbT2+xEhvNgvq7P6N
        lOlTRY6IW8JjAnLcDiVR2H0=
X-Google-Smtp-Source: APXvYqyEp/ZdUavjs8KgOwRCEG3lYrIV4mo1aOsdTDyV2iNrHd2FUdrlCSxBq31I546BoDKGayR3PQ==
X-Received: by 2002:a37:2c06:: with SMTP id s6mr48810567qkh.142.1556621557170;
        Tue, 30 Apr 2019 03:52:37 -0700 (PDT)
Received: from laptop (189.26.185.89.dynamic.adsl.gvt.net.br. [189.26.185.89])
        by smtp.gmail.com with ESMTPSA id w58sm19627363qtw.93.2019.04.30.03.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 03:52:35 -0700 (PDT)
Date:   Tue, 30 Apr 2019 07:52:15 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Edwards <gedwards@ddn.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
Message-ID: <20190430105212.GA1642767@laptop>
References: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
 <20190430013205.1561708-2-marcos.souza.org@gmail.com>
 <yq1bm0ow6iv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bm0ow6iv.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 10:50:32PM -0400, Martin K. Petersen wrote:
> 
> Hi Marco,
> 
> > +static inline sector_t size_to_sectors(long long size)
> > +{
> > +	return size >> SECTOR_SHIFT;
> > +}
> > +
> 
> FWIW, in SCSI we have:
> 
> 	logical_to_sectors()
>         logical_to_bytes()
>         bytes_to_logical()
>         sectors_to_logical()
> 
> I'm not attached to "bytes" in any way but it would be nice to be
> consistent.
> 

Thanks for the suggestion. I will send a new version using "bytes_to_sectors"
instead.

> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
Thanks,
Marcos
