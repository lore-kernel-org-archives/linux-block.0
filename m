Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F15C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 21:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8896C218A5
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 21:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfCUVlH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:41:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCUVlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 17:41:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so185925wrn.6
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 14:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jplgh4vEgfc/R/UaPu12ZHrOgb8efl0u9uCDO0C0Buk=;
        b=AeihcSsgQJAaYrZXhAZVNJhtY1R80BZNKo2zyHS/ncwoiawFEnhWUKofBIeJ+WLePi
         qj6FdxY77QEWW0JsT76VohAUlCNuj5vqZ+HetByQYqPSUWVOj6vitjT0RjJXRkdWsjmr
         x8jVk4Re0590EQ4cHigAqviGoa4TvUMlXOgdIC/xegZXj+vqM+NWD9fSZngFKEfLEuNi
         lvg+n7KGuhKg1WDLLXUGKYfA9j8CAlsElfC7h0CrAybLUOnH3iEvbyV/jtErd7gRG8ZK
         vlubR18cxApoT2tT7uuH959bH+IefqA2W1BiKDLY0O+W3C3Z/8GSYBGlTaQ8NCpiuRRa
         7fzw==
X-Gm-Message-State: APjAAAUts7buPNGJa67JEYWnZYYMSuvy9ssm8riuvQWS5dif98EVPAp5
        c6sYJcjD5X9nVOJri4q40TY=
X-Google-Smtp-Source: APXvYqwBqiXlluevloMuDwuVx+rGRdUhY1Y542L95pxyGvKolARNRomUtDSYf0BxigIWrzGxWM0tTg==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr4256276wrp.298.1553204465940;
        Thu, 21 Mar 2019 14:41:05 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id c17sm4144284wrs.17.2019.03.21.14.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:41:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
 <20190321013908.GA15115@ming.t460p>
 <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me>
 <20190321023235.GB15115@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>
Date:   Thu, 21 Mar 2019 14:40:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321023235.GB15115@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> For example,
> 
> nvme_rdma_complete_rq
> 	->nvme_rdma_unmap_data
> 		->ib_mr_pool_put
> 
> But the ib queue pair may has been destroyed by nvme_rdma_destroy_io_queues()
> before request's remote completion.
> 
> nvme_rdma_teardown_io_queues:
>          nvme_stop_queues(&ctrl->ctrl);
>          nvme_rdma_stop_io_queues(ctrl);
>          blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
>                          &ctrl->ctrl);
>          if (remove)
>                  nvme_start_queues(&ctrl->ctrl);
>          nvme_rdma_destroy_io_queues(ctrl, remove);
> 

Yea, you're right. I'm fine with this patchset.
