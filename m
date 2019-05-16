Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B0C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B3205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPOHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:07:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfEPOHq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:07:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BC81AF2A;
        Thu, 16 May 2019 14:07:44 +0000 (UTC)
Subject: Re: Block device naming
To:     Alibek Amaev <alibek.a@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
 <e81e675e-e084-197a-fc13-101985bde590@suse.de>
 <CA+TYKz1E3mJ0hDQcv19QAFgeWVA-ADLoHtGQ5hy8SFxHOfuqfQ@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <680c9440-f1c9-68d1-cc5a-17aa9071fcc1@suse.de>
Date:   Thu, 16 May 2019 16:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+TYKz1E3mJ0hDQcv19QAFgeWVA-ADLoHtGQ5hy8SFxHOfuqfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 3:49 PM, Alibek Amaev wrote:
> I have more example from IRL:
> In Aug 2018 I was start server with attached storages by FC from ZS3
> and ZS5 (it is Oracle ZFS Storage Appliance, not NetApp and also
> export space as LUN) server use one LUN from ZS5. And recently on
> server stopped all IO on this exported LUN  and io-wait is grow, in
> dmesg no any errors or any changes about FC, no errors in
> /var/log/kern.log* /var/log/syslog.log*, no throttling, no edac errors
> or other.
> But before reboot I saw:
> wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdc
> I try to run partprobe or try to copy from this block device some data
> to /dev/null by dd - operations wasn't finished IO is blocked
> And after reboot i seen:
> wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdd
> And server is run ok.
> 
> Also I have LUN exported from storage in shared mode and it accesible
> for all servers by FC. Currently this LUN not need, but now I doubt it
> is possible to safely remove it...
> 
It's all a bit conjecture at this point.
'sdc' could be show up as 'sdd' after the next reboot, with no 
side-effects whatsoever.
At the same time, 'sdc' could have been blocked by a host of reasons, 
none of which are related to the additional device being exported.

It doesn't really look like an issue with device naming; you would need 
to do proper investigation on your server to figure out why I/O stopped.
Device renaming is typically the least likely cause here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
