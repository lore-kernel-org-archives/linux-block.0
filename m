Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC8FC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643F52082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GaL8a7zH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643F52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLDWJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:09:47 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:43040 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:09:46 -0500
Received: by mail-yb1-f182.google.com with SMTP id x144so3386536ybg.10
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vpbJ3hhIEl9WIDdcymDJ5sWJ3DT9zjevC40rzXSSSwA=;
        b=GaL8a7zHmNUp2CmXuXEKFZGjXSlj/+IIhuktl8iNaZFNEgPzVuoHtnlQG+voQdW0+m
         H8W7v92zyNaZbbiI80Gali8m/mnTkrKh+itC+SEu8QKQLLby7jiDzw/wZkO0Pfb+vGnO
         n7Tq6ib2zf9KiL+IO8ehKCE9p8rxGotY5fdIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vpbJ3hhIEl9WIDdcymDJ5sWJ3DT9zjevC40rzXSSSwA=;
        b=am9CmlDfaD6i2ynZ5eAngtmi/UNekc+TkKCc+JGgxJsmKcg5eBZ6g7WusXaK2tIRhs
         iNRtIYt+Msa8yt0Q63koHG3gdrDJiEZ0p9TvfpXFeR82KegqMiBwhy/H45eREMV95Q8W
         swKTGwLhWhrz7XkqDg4to82Cr+suAOi73gzYv0bHnGpSd62VTAtn/tvQEZj5h2oKFcl4
         ENpdrI4dtXo01vk9dybKPPd6pFDLwli01J7kTMMJIITL7WVKKnEdneVvSFgsMa5IJg+F
         Zv+8mxDQnaeWllbinRye6lnlmI4PqmO3TrAVoPjJ4tAzSVy2CG//JPRrSguV7TpJmB9J
         yjFg==
X-Gm-Message-State: AA+aEWax0XL6PeLnY+l+uaE4kIAIuyYEftSGeSpySSN6Bz2PQsYYOL7T
        u200/T67zvzek6mQIlBWHtyM1Q==
X-Google-Smtp-Source: AFSGD/VPicUWAjwpPKiLPnblfWPtfXJAg6Z36bpD9vtOs+ypFZ82ZYm7CY62cpjcEttJh1AUcYrzEA==
X-Received: by 2002:a25:1383:: with SMTP id 125-v6mr22364106ybt.394.1543961385537;
        Tue, 04 Dec 2018 14:09:45 -0800 (PST)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id n16sm7372244ywn.31.2018.12.04.14.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:09:44 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Keith Busch <keith.busch@intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
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
 <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
 <20181204212117.GC16751@localhost.localdomain>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <975230d1-01b4-64a7-f906-ca1a6893f846@broadcom.com>
Date:   Tue, 4 Dec 2018 14:09:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204212117.GC16751@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/4/2018 1:21 PM, Keith Busch wrote:
> On Tue, Dec 04, 2018 at 11:33:33AM -0800, James Smart wrote:
>> I disagree.  The cases I've run into are on the admin queue - where we are
>> sending io to initialize the controller when another error/reset occurs, and
>> the checks are required to identify/reject the "old" initialization
>> commands, with another state check allowing them to proceed on the "new"
>> initialization commands.  And there are also cases for ioctls and other
>> things that occur during the middle of those initialization steps that need
>> to be weeded out.   The Admin queue has to be kept live to allow the
>> initialization commands on the new controller.
>>
>> state checks are also needed for those namespace validation cases....
>>
>>> Once quiesced, the proposed iterator can handle the final termination
>>> of the request, perform failover, or some other lld specific action
>>> depending on your situation.
>> I don't believe they can remain frozen, definitely not for the admin queue.
>> -- james
> Quiesced and frozen carry different semantics.
>
> My understanding of the nvme-fc implementation is that it returns
> BLK_STS_RESOURCE in the scenario you've described where the admin
> command can't be executed at the moment. That just has the block layer
> requeue it for later resubmission 3 milliseconds later, which will
> continue to return the same status code until you're really ready for
> it.

BLK_STS_RESOURCE is correct - but for "normal" io, which comes from the 
filesystem, etc and are mostly on the io queues.

But if the io originated from other sources, like the core layer via 
nvme_alloc_request() - used by lots of service routines for the 
transport to initialize the controller, core routines to talk to the 
controller, and ioctls from user space - then they are failed with a 
PATHING ERROR status.  The status doesn't mean much to these other 
places which mainly care if they succeed or not, and if not, they fail 
and unwind.  It's pretty critical for these paths to get that error 
status as many of those threads do synchronous io.  And this is not just 
for nvme-fc. Any transport initializing the controller and getting half 
way through it when an error occurs that kills the association will 
depend on this behavior.  PCI is a large exception as interaction with a 
pci function is very different from sending packets over a network and 
detecting network errors.

Io requests, on the io queues, that are flagged as multipath, also are 
failed this way rather than requeued.  We would need some iterator here 
to classify the type of io (one valid to go down another path) and move 
it to another path (but the transport doesn't want to know about other 
paths).


>
> What I'm proposing is that instead of using that return code, you may
> have nvme-fc control when to dispatch those queued requests by utilizing
> the blk-mq quiesce on/off states. Is there a reason that wouldn't work?

and quiesce on/off isn't sufficient to do this.

-- james


