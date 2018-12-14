Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0EAC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA75208E7
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA75208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeLNJoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:44:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:47076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNJoM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 04:44:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D89DAACBC;
        Fri, 14 Dec 2018 09:44:10 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de> <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
 <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>
 <20181214085606.GD5321@calabresa>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <97a032f0-5e10-2b9c-6f8d-d405e9f2cd2a@suse.de>
Date:   Fri, 14 Dec 2018 10:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214085606.GD5321@calabresa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 9:56 AM, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Dec 14, 2018 at 08:47:20AM +0100, Hannes Reinecke wrote:
>> On 12/13/18 4:25 PM, Thadeu Lima de Souza Cascardo wrote:
>>> On Thu, Dec 13, 2018 at 03:32:18PM +0100, Christoph Hellwig wrote:
>>>> On Thu, Dec 13, 2018 at 10:18:40AM +0100, Hannes Reinecke wrote:
>>>>> Welll ... this is not just 'lsblk', but more importantly this will force
>>>>> udev to create _block_ device nodes for the hidden devices, essentially
>>>>> 'unhide' them.
>>>>>
>>>>> Is this what we want?
>>>>> Christoph?
>>>>> I thought the entire _point_ of having hidden devices is that the are ...
>>>>> well ... hidden ...
>>>>
>>>> Yes, that is why I really don't like the last two patches.
>>>>
>>>> And I've checked back - lsblk actually works just fine at the moment.
>>>> But it turns out once we create the slave links it stops working,
>>>> which is a really good argument against the first two patches, which
>>>> would otherwise seem nice..
>>>
>>> Which is why I have sent the "paths/" patchset in the first place. Because I
>>> did some homework and read the previous discussion about this, and how lsblk
>>> failure to behave with slave links led to the revert of the slaves/holders
>>> patch by Dr. Hannes.
>>>
>> But you haven't answered my question:
>>
>> Why can't we patch 'lsblk' to provide the required information even with the
>> current sysfs layout?
>>
> 
> I think we could, but with my Ubuntu hat on, after the kernel fix for
> initramfs-tools, that is, slaves/holders links, the user will get an updated
> kernel that breaks the current lsblk on Bionic (Ubuntu 18.04). That will
> require that we backport the lsblk fix, which is not only more work, but there
> may be users who only update from -security, which is where kernel updates end
> regularly, but not this lsblk fix.
> 
> And that kernel update is a regression against that old lsblk version.
> 
Now you get me confused.
Which kernel update you are referring to?
We do _not_ provide any 'slave' link with the current upstream, so I 
somewhat fail to see which breakage you are referring to ...

Confused,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
