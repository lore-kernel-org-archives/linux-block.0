Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D345CC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40F6218C3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCUArL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:47:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43274 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCUArL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 20:47:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so3372658oif.10
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 17:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mSokY1Je2WYD5CWQpJeZsSLYFE3PxgSkGyLzhE0/1k=;
        b=LVCKxjQYyMguiGoTjMDafqlWIUCL7PRk+w/fb55UQAnZmFFAV01G1e3IO0QVjrcxnF
         CCv1R8Y19OTMQCGjljwGkgptP9r8a2yCJq7vTcagN1hrPcHOuTgcbv7Rn5Ipk4LR4TbN
         46Awm5NsMik40xmsb4WEfIMugEuL5pocNLYuyHL6ItP4E0kLncwbfoSzZNNywgdk6AA3
         VJ1zmGUSnq9NGPaKbSVjbl8APmpiFq8kLKW7Bl7Dwxes2gkgSLLGd5aBkFw6Ttt28y/q
         uwAbd+8Izj5Eq4/OBjwoJKzXoriwK47PAKogqZtpvMIzNKFsUY5NljbL1eK9HV+nfaWb
         zoHw==
X-Gm-Message-State: APjAAAViE2HjAsbEnDjvaAS8TLItJkRN+YuizkrnyPMfgBBr9iXW0tGA
        erbav6gPLorqda8fIyI6OOfjfxbt
X-Google-Smtp-Source: APXvYqyEmBH1gytDa8J5X+jzeXyQhQGMP4uRCkPqyzO6+cAZ3UuxZ6JlzY92UymVTT7Ru4u0/VaGkg==
X-Received: by 2002:aca:5387:: with SMTP id h129mr545694oib.52.1553129230474;
        Wed, 20 Mar 2019 17:47:10 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id n9sm1433238otk.72.2019.03.20.17.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:47:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
Date:   Wed, 20 Mar 2019 17:47:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552924164.152266.21.camel@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Ming,
> 
> Just like the NVMeOF initiator driver, the SRP initiator driver uses an
> RDMA RC connection for all of its communication over the network. If
> communication between initiator and target fails the target driver will
> close the connection or one of the work requests that was posted by the
> initiator driver will complete with an error status (wc->status !=
> IB_WC_SUCCESS). In the latter case the function srp_handle_qp_err() will
> try to reestablish the connection between initiator and target after a
> certain delay:
> 
> 	if (delay > 0)
> 		queue_delayed_work(system_long_wq, &rport->reconnect_work,
> 				   1UL * delay * HZ);
> 
> SCSI timeouts may kick the SCSI error handler. That results in calls of
> the srp_reset_device() and/or srp_reset_host() functions. srp_reset_host()
> terminates all outstanding requests after having disconnected the RDMA RC
> connection. Disconnecting the RC connection first guarantees that there
> are no concurrent request completion calls from the regular completion
> path and from the error handler.

Hi Bart,

If I understand the race correctly, its not between the requests
completion and the queue pairs removal nor the timeout handler
necessarily, but rather it is between the async requests completion and
the tagset deallocation.

Think of surprise removal (or disconnect) during I/O, drivers
usually stop/quiesce/freeze the queues, terminate/abort inflight
I/Os and then teardown the hw queues and the tagset.

IIRC, the same race holds for srp if this happens during I/O:
1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() 
-> __rport_fail_io_fast()

2. complete all I/Os (async remotely via smp)

Then continue..

3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()

What is preventing (3) from happening before (2) if its async? I would
think that scsi drivers need the exact same thing...
