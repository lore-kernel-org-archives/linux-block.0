Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20DEC32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D1A2229C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbfHGQRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:17:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbfHGQRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 12:17:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so91957436wrr.5
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 09:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rimRfJuK8em3IqAQSX92nJpilfNEDReWvsTTczdkS5I=;
        b=SNqTbTuSSwmDyng5cxNuLuhB8kSHSFn+k3odhqBeNUJCc1Gy54FQbS7OObeCbtmdSd
         1J4+YhGo3rLFz46rXjKsNhv+ylocmGWC4KweciMa/XLHK1b6dGdlm+g6BjGaZgIqd6Hz
         4qdJMFYXUp9IspX45w6Jpozz3xp4Z7h5ts5WhGasV91MkzxBM+ndjrhK7EO6dd0rKa2P
         NiTIdkS/JBcozgmjB5+l1dtRz7ZUcakFA4H+Lu8tDpC85+odpTCRaiMZm+o3yPgKBfgH
         I9lau7CgMaO376cWfOuaGf8OcpFo4ebR/rnOdByHhsQ9rO7eLlgK2D9FFTEgNLUxaIyQ
         XG9Q==
X-Gm-Message-State: APjAAAXgxc/FiSRqq7afWQYd9cF9/f/WnKZS8VnVwsJxZ/ZtGNzh525i
        uHgQID1CpfZBKXOyRhNuojJAvg==
X-Google-Smtp-Source: APXvYqzazjaE77Dv6t5Ci6gVHioOlkD24Kr5pc/9tKvr9Hj/6DlaId/9yHdHHf/uwryHMeAikdLuZA==
X-Received: by 2002:a5d:6606:: with SMTP id n6mr4280889wru.346.1565194635282;
        Wed, 07 Aug 2019 09:17:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f10sm79635116wrs.22.2019.08.07.09.17.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:17:14 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: core: regression fixes for request batching
To:     Steffen Maier <maier@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-next@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190807144948.28265-1-maier@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <700f3175-561a-c577-0cb7-3f9ae4d82db0@redhat.com>
Date:   Wed, 7 Aug 2019 18:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807144948.28265-1-maier@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/08/19 16:49, Steffen Maier wrote:
> Hi James, Martin, Paolo, Ming,
> 
> multipathing with linux-next is broken since 20190723 in our CI.
> The patches fix a memleak and a severe dh/multipath functional regression.
> It would be nice if we could get them to 5.4/scsi-queue and also next.
> 
> I would have preferred if such a new feature had used its own
> new copy scsi_mq_ops_batching instead of changing the use case and
> semantics of the existing scsi_mq_ops, because this would likely
> cause less regressions for all the other users not using the new feature.
> 
> Steffen Maier (2):
>   scsi: core: fix missing .cleanup_rq for SCSI hosts without request
>     batching
>   scsi: core: fix dh and multipathing for SCSI hosts without request
>     batching
> 
>  drivers/scsi/scsi_lib.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
