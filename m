Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868FC282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE552083B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfBEP2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:28:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:33032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729032AbfBEP2r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 10:28:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A2A2B0BB;
        Tue,  5 Feb 2019 15:28:46 +0000 (UTC)
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
From:   Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM TOPIC] Handling of managed IRQs when hotplugging CPUs
Message-ID: <99dc311f-16b6-9b0d-e309-198dcc9dcde7@suse.de>
Date:   Tue, 5 Feb 2019 16:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this came up during discussion on the mailing list (cf thread "Question 
on handling managed IRQs when hotplugging CPUs").
The problem is that with managed IRQs and block-mq I/O will be routed to 
individual CPUs, and the response will be send to the IRQ assigned to 
that CPU.

If now a CPU hotplug event occurs when I/O is still in-flight the IRQ 
will _still_ be assigned to the CPU, causing any pending interrupt to be 
lost.
Hence the driver will never notice that an interrupt has happened, and 
an I/O timeout occurs.

One proposal was to quiesce the device when a CPU hotplug event occurs, 
and only allow for CPU hotplugging once it's fully quiesced.

While this would be working, it will be introducing quite some system 
stall, and it actually a rather big impact in the system.
Another possiblity would be to have the driver abort the requests 
itself, but this requires specific callbacks into the driver, and, of 
course, the driver having the ability to actually do so.

I would like to discuss at LSF/MM how these issues can be addressed best.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
