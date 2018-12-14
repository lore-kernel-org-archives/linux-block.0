Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03773C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1F220811
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 07:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1F220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLNHrY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:47:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:33136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNHrX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 02:47:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E004AEEC;
        Fri, 14 Dec 2018 07:47:22 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de> <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>
Date:   Fri, 14 Dec 2018 08:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181213152532.GA5321@calabresa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 4:25 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Dec 13, 2018 at 03:32:18PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 13, 2018 at 10:18:40AM +0100, Hannes Reinecke wrote:
>>> Welll ... this is not just 'lsblk', but more importantly this will force
>>> udev to create _block_ device nodes for the hidden devices, essentially
>>> 'unhide' them.
>>>
>>> Is this what we want?
>>> Christoph?
>>> I thought the entire _point_ of having hidden devices is that the are ...
>>> well ... hidden ...
>>
>> Yes, that is why I really don't like the last two patches.
>>
>> And I've checked back - lsblk actually works just fine at the moment.
>> But it turns out once we create the slave links it stops working,
>> which is a really good argument against the first two patches, which
>> would otherwise seem nice..
> 
> Which is why I have sent the "paths/" patchset in the first place. Because I
> did some homework and read the previous discussion about this, and how lsblk
> failure to behave with slave links led to the revert of the slaves/holders
> patch by Dr. Hannes.
> 
But you haven't answered my question:

Why can't we patch 'lsblk' to provide the required information even with 
the current sysfs layout?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
