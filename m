Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C2FC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F167C21872
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfCOOZi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:25:38 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:48745 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfCOOZh (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 15 Mar 2019 10:25:37 -0400
Received: from apollon.mittagstun.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 15 Mar 2019 08:25:30 -0600
Message-ID: <b4971cf31e301dd32a37c914090ce574823fcd06.camel@suse.com>
Subject: Reminder: [PATCH v2 0/5] block: skip media change event handling if
 unsupported
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Fri, 15 Mar 2019 15:25:26 +0100
In-Reply-To: <20190205113741.11267-1-mwilck@suse.com>
References: <20190205113741.11267-1-mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-02-05 at 12:37 +0100, Martin Wilck wrote:
> [...]
> 
> This series implements a slightly different approach to event
> handling and
> uevent suppression. The drivers are changed to set the events field
> again.
> Whether or not uevents should be generated is controlled by a
> separate flag
> bit, which is only set by the drivers that are known to generate
> proper
> uevents (sd and sr). Once this is done, devices that don't support
> any
> media change events can be clearly identified, and the whole events
> checking code path can be skipped. This simplifies handling of
> non-removable SCSI disks.
> 
> I have tested this with removable and non-removable SCSI disks, SCSI
> cdrom,
> and ide-cd.
> 
> This patch set targets the same problem as Hannes' late submission
> "sd:
> skip non-removable devices in sd_check_events()".

Gentle review reminder.

Regards
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)


