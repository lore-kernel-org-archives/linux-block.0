Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2CC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4838A208E7
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 12:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4838A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeLMMEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:04:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728733AbeLMMEt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 07:04:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC45EADED;
        Thu, 13 Dec 2018 12:04:47 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] implement nvmf read/write queue maps
To:     Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
Date:   Thu, 13 Dec 2018 13:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/18 6:58 PM, Sagi Grimberg wrote:
> 
>> Sagi,
>>
>> What other wins are there for this split ?
>>
>> I'm considering whether its worthwhile for fc as well, but the hol 
>> issue doesn't exist with fc. What else is being resolved ?
> 
> I've pondered it myself, which is why I didn't add it to fc as well
> (would have been easy enough I think). I guess that with this the
> user can limit writes compared to read by assigning less queues as
> jens suggested in his patches...
 >
Weelll ... isn't that what blkcg is for?
I do understand if one would want to implement something like this if 
there's a real benefit from the _hardware_ side, but if there isn't we 
should try to keep it in the upper layers where it belongs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
