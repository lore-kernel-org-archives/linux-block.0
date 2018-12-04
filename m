Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC8FC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CBB206B7
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UJjYRHrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CBB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLDTdh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:33:37 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:46458 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 14:33:37 -0500
Received: by mail-yb1-f175.google.com with SMTP id l126so3393412ybf.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Iwdipn8mV+PFGWbTHjKp+Lk2ierRZsqbwHZkbqpQrZU=;
        b=UJjYRHrSiFLZMppxKuYqObv7PpOYSx+duImyntoh1TRPuN1ijJ4rbVUjAkJPcNnB7H
         lYg4wWX9wIoZ389gVvl+qra0iiYfmcDAvRbHvUOOvPZGSDXOItS42kwz8+kaXqT3SKln
         jSk4ChXvF7lWtjaB0GiC5J6TK9Ae+hULxOlaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Iwdipn8mV+PFGWbTHjKp+Lk2ierRZsqbwHZkbqpQrZU=;
        b=ewz8NU11JguPal1U3zXdX6OJrr8kBERGr9c9NjK+DGX67STjp1rXL2tKybyAdM3Ndg
         /u1bAjQc+b2u7W2GDGQRZXq+Pkd+rUeeJjG1Dg2vtlGR4AbadGPBRx7qvFvw5O+4f5kj
         vWEhKT8I7t+IBFJICd/2d8Ec0G8rRqCb5AAMQkGgD6aTIeLq4CrT0uBtnXwG40ilnnQz
         creCFwNbAqbml8v/ySLInkju2l7oMOzbyIf2dYsnrJ6MC2RW95PfsRUI0mUf7auZ+Rvx
         55TFkcZS8nC2FZcMm+YgzAxnd8cf2eod7d5HbV33mgQhjfSZLsYLTvOLXyk3dCfjKJwT
         UiLA==
X-Gm-Message-State: AA+aEWb0exhrqVy4nidPtRnNwmTCt5el695JubcxrBSxBKk+usxN+wDo
        echVL4HlN2EC0lxPIpvKUAh7mQ==
X-Google-Smtp-Source: AFSGD/XZxHIajk7/5k1ZaHPMoULEQURPmgRgpuPAz/Cz+xZ66uvOXFJin8p5RcIcq1p+/KHj2E9ucw==
X-Received: by 2002:a25:1585:: with SMTP id 127-v6mr20864204ybv.208.1543952016147;
        Tue, 04 Dec 2018 11:33:36 -0800 (PST)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id j6sm6012304ywi.110.2018.12.04.11.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:33:35 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
 <20181204174806.GA16751@localhost.localdomain>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
Date:   Tue, 4 Dec 2018 11:33:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204174806.GA16751@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/4/2018 9:48 AM, Keith Busch wrote:
> On Tue, Dec 04, 2018 at 09:38:29AM -0800, Sagi Grimberg wrote:
>>>>> Yes, I'm very much in favour of this, too.
>>>>> We always have this IMO slightly weird notion of stopping the queue, set
>>>>> some error flags in the driver, then _restarting_ the queue, just so
>>>>> that the driver then sees the error flag and terminates the requests.
>>>>> Which I always found quite counter-intuitive.
>>>> What about requests that come in after the iteration runs? how are those
>>>> terminated?
>>> If we've reached a dead state, I think you'd want to start a queue freeze
>>> before running the terminating iterator.
>> Its not necessarily dead, in fabrics we need to handle disconnections
>> that last for a while before we are able to reconnect (for a variety of
>> reasons) and we need a way to fail I/O for failover (or requeue, or
>> block its up to the upper layer). Its less of a "last resort" action
>> like in the pci case.
>>
>> Does this guarantee that after freeze+iter we won't get queued with any
>> other request? If not then we still need to unfreeze and fail at
>> queue_rq.
> It sounds like there are different scenarios to consider.
>
> For the dead controller, we call blk_cleanup_queue() at the end which
> ends callers who blocked on entering.
>
> If you're doing a failover, you'd replace the freeze with a current path
> update in order to prevent new requests from entering.
and if you're not multipath ?    I assume you want the io queues to be 
frozen so they queue there - which can block threads such as ns 
verification. It's good to have them live, as todays checks bounce the 
io, letting the thread terminate as its in a reset/reconnect state, 
which allows those threads to exit out or finish before a new reconnect 
kicks them off again. We've already been fighting deadlocks with the 
reset/delete/rescan paths and these io paths. suspending the queues 
completely over the reconnect will likely create more issues in this area.


> In either case, you don't need checks in queue_rq. The queue_rq check
> is redundant with the quiesce state that blk-mq already provides.

I disagree.  The cases I've run into are on the admin queue - where we 
are sending io to initialize the controller when another error/reset 
occurs, and the checks are required to identify/reject the "old" 
initialization commands, with another state check allowing them to 
proceed on the "new" initialization commands.  And there are also cases 
for ioctls and other things that occur during the middle of those 
initialization steps that need to be weeded out.   The Admin queue has 
to be kept live to allow the initialization commands on the new controller.

state checks are also needed for those namespace validation cases....

>
> Once quiesced, the proposed iterator can handle the final termination
> of the request, perform failover, or some other lld specific action
> depending on your situation.

I don't believe they can remain frozen, definitely not for the admin queue.
-- james

