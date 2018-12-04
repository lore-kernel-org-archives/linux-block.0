Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA2C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75884206B7
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J7Jol119"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75884206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLDQ0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:26:40 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42773 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQ0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 11:26:40 -0500
Received: by mail-yb1-f196.google.com with SMTP id s8so4924188ybe.9
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4f0ckBxeTBmWK7vKY6mNN0e+WCWQtGG1P4BwHZ1mDWs=;
        b=J7Jol119ZqZWtriAriOv00G274sfxm35ASienaNXw0h1WSkW6aTyIkVHQ0GGbbIdtq
         /Vaf2YNb5mO9oIZPeb6MFLY3zHQKmh8ga+ApT0Mti/mv7jcBop6MIhbLzfwZMKhjuPIq
         XIPEX7myUc7lAh9z3hRMebzvHCkNX0wl+pPd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4f0ckBxeTBmWK7vKY6mNN0e+WCWQtGG1P4BwHZ1mDWs=;
        b=kzbhlkGMPYBlMO9D2wJ4g9xdIOoDu5NbkhG31eWJpaP+V+2QF9c7dYnDLgYm8lNx18
         jQFRZe1m1xQUcpoY6eqCwZb/TlAOulmCKaxylqwLhT+cWuhHPBGyqu+nZsc0hqGh7yYl
         viDTL08XeKQ4I+FnV3NagI3wHeIJlecltMEOeuvx3ol480ooaE8iTs3KUXQc3BO1EXoa
         BpNBESAOaITDV2heItrTBnw1oUL3Ch9FE/tMD8J/bq4hYVYCvmzu525cMegabFefIWa6
         ddUkzppd+4qNffzXC1jTaqk4CTuLfNw53aGaSalqI8p6fL/sck/KnEJnP6jMJCV/CaPe
         vC9A==
X-Gm-Message-State: AA+aEWYFHUbyLo3d505nLKS8y5qXwMI381UTxR3CnOWKN2CiFPeDUmar
        Cj2PNvXZJ90HWcFlGx7/VQ4QEHaBBAQ=
X-Google-Smtp-Source: AFSGD/W41/gtFMbG9pnwOxhHx/O5jxeh74iqTWKECvFYN7Ro7OWJgR/mxbY8njBycrkeJ6C75jkKzg==
X-Received: by 2002:a25:7e01:: with SMTP id z1-v6mr19848548ybc.368.1543940799081;
        Tue, 04 Dec 2018 08:26:39 -0800 (PST)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id z74sm8647697ywz.51.2018.12.04.08.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:26:38 -0800 (PST)
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
From:   James Smart <james.smart@broadcom.com>
Message-ID: <5af6dfb3-c471-1377-2d1d-b2a4b15eef43@broadcom.com>
Date:   Tue, 4 Dec 2018 08:26:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204154559.GJ14775@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/2018 7:46 AM, Keith Busch wrote:
> On Mon, Dec 03, 2018 at 05:33:06PM -0800, Sagi Grimberg wrote:
>>> Yes, I'm very much in favour of this, too.
>>> We always have this IMO slightly weird notion of stopping the queue, set
>>> some error flags in the driver, then _restarting_ the queue, just so
>>> that the driver then sees the error flag and terminates the requests.
>>> Which I always found quite counter-intuitive.
>> What about requests that come in after the iteration runs? how are those
>> terminated?
> If we've reached a dead state, I think you'd want to start a queue freeze
> before running the terminating iterator.

For the requests that come in after the iterator, the nvmf_check_ready() 
routine, which validates controller state, will catch and bounce them.

Keith states why we froze it in the past.  Whatever the itterator is, 
I'd prefer we not get abort calls on io that has yet to be successfully 
started.

-- james

