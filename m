Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB44C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 04:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiESEkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiESEkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 00:40:45 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F39ADA;
        Wed, 18 May 2022 21:40:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id fd25so5520337edb.3;
        Wed, 18 May 2022 21:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gJpugRid5rPt6TxVqL25aUNgN6RjYO2hhneZw/oa1YE=;
        b=fg7Ym5UW8w707cRxQ5thfonzH1Y177+xUzN9pbPDATWjwtj90asQWoEJuiXDdu/VUk
         FtGkT/Yb6VtWeTXuo6tReQYW3eS2BGx4icDuxCv6YS+l89fSdIbohfXj8/6hhL0sT8Fl
         tGRXVvXvVU9D+PKn60nzRkgNX/wNWpnd4EiIgOt+lKlqJga9iadl17O8KyxIzGE9knV+
         GljuRoIchCRE8/S+JIho1jfrY3kCM0r1SBGmCAOijdlFW5KFwaU9ydk1m6QxgremYaPh
         zWdZNm0E8hpd+80iuhN1jMKxi8+kKsai787oMf+HsyU6IDoumAdFZYLfZ5/QCOVJcVD4
         fRDw==
X-Gm-Message-State: AOAM532r6j7sD4VxaiBLm4ebC/xzZZcXHzJjhzhzZ1ZplRpwIha630AS
        hGSLejB3QDjLPhBybQCvDTA=
X-Google-Smtp-Source: ABdhPJzMVd6V+6dPgGlnuHVA0Zwht1ML3Ao8TREzj1ndYR5sK6Bmq6nlszpuDmOEVjaK8+HeoNGGHw==
X-Received: by 2002:aa7:d619:0:b0:42a:af7b:eda7 with SMTP id c25-20020aa7d619000000b0042aaf7beda7mr3239231edr.235.1652935241859;
        Wed, 18 May 2022 21:40:41 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id z18-20020a17090674d200b006f3ef214e42sm1703223ejl.168.2022.05.18.21.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 21:40:41 -0700 (PDT)
Message-ID: <ec944a31-3edb-37fa-135e-bfcd970d8231@acm.org>
Date:   Thu, 19 May 2022 06:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com> <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 05:27, Eric Biggers wrote:
> But the DMA alignment can be much lower, like 8 bytes (see nvme_set_queue_limits()).

There are block drivers that support byte alignment of block layer data 
buffers. From the iSCSI over TCP driver:

	blk_queue_dma_alignment(sdev->request_queue, 0);

Thanks,

Bart.
