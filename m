Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB963C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8416D218D4
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCUCPn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:15:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40950 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 22:15:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so3149361pgo.7
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 19:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zirb1fOuI+iM5GEvrbJ2/M7r3IOviIC/scVrpsENPno=;
        b=k4fkuZ6tCKKaHR+fJ5bGDBRKHg5zsTvez6ewElnbn/ShLxN2n6oEyYkRk2Casma8M8
         M6RDgO9MgU4r1d4kBCpj7boRTYl/YfIQgNyIhFr5s0W1620BcM7Z91isTMbIH9RfVi4x
         l6jcsJapjKBuInksA679xtuKZNc87Q5IYsW6TLwAPWbZH3s9nXhHtCucQ99Okk3tob73
         wpQ/+XCtlk+SQt5u6FE3vqz2njJWflAh0k05C8crGMqRAYkUXQEXesT8jdIoEKP6EJ09
         mmFTHzVyTJXV28XAxh1E4TsJm3PXMHqpsLH2GGsHOoyW4klxtXHnnbUVxKV5C2lEywOi
         iR0w==
X-Gm-Message-State: APjAAAXDG8nxiFF+edmSRIQoXFwgyPHSffsZ5DSPNwY6kndM8ChJs4K4
        R2pWFY1RB8LdYbk6EJ6a1bk=
X-Google-Smtp-Source: APXvYqxoh5G4bbuk0Y2U0RDnNxk2UVZgDczeTE3RHYspc4y8VRS7cIxa1Jb81iBCBMlC2RHkxbsJXA==
X-Received: by 2002:a62:170c:: with SMTP id 12mr995514pfx.104.1553134542094;
        Wed, 20 Mar 2019 19:15:42 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id 4sm4044290pfo.110.2019.03.20.19.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 19:15:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9cfac3d9-17ea-1e8e-dfa8-dc0e07bb26cd@acm.org>
Date:   Wed, 20 Mar 2019 19:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 5:47 PM, Sagi Grimberg wrote:
> If I understand the race correctly, its not between the requests
> completion and the queue pairs removal nor the timeout handler
> necessarily, but rather it is between the async requests completion and
> the tagset deallocation.
> 
> Think of surprise removal (or disconnect) during I/O, drivers
> usually stop/quiesce/freeze the queues, terminate/abort inflight
> I/Os and then teardown the hw queues and the tagset.
> 
> IIRC, the same race holds for srp if this happens during I/O:
> 1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() 
> -> __rport_fail_io_fast()
> 
> 2. complete all I/Os (async remotely via smp)
> 
> Then continue..
> 
> 3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()
> 
> What is preventing (3) from happening before (2) if its async? I would
> think that scsi drivers need the exact same thing...

Hi Sagi,

As Ming already replied, I don't think that (3) can happen before (2) in 
case of the SRP driver. If you have a look at srp_remove_target() you 
will see that it calls scsi_remove_host(). That function only returns 
after blk_cleanup_queue() has been called for all associated request 
queues. As you know that function waits until all outstanding requests 
have completed.

Bart.


