Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9BC43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0EF20859
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 07:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbfAGHRr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:17:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:35600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfAGHRr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jan 2019 02:17:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A49DABCB;
        Mon,  7 Jan 2019 07:17:46 +0000 (UTC)
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Sitsofe Wheeler <sitsofe@gmail.com>,
        Laurence Oberman <loberman@redhat.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
 <1546548458.24199.2.camel@redhat.com>
 <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
 <1546555220.2666.1.camel@redhat.com>
 <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4c231a3e-1ae3-c872-f6f8-06b19ddfd20b@suse.de>
Date:   Mon, 7 Jan 2019 08:17:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/19 8:33 AM, Sitsofe Wheeler wrote:
> Blimey Laurence - you're really pushing the boat out on this one!
> 
[ .. ]
> I've yet to attach the disk directly to the mobo. It's a bit fiddly as
> the most accessible port is meant for the DVD drive and I think it's
> speed is slower than the others.
> 
> The speed of the ATA ports is lower than you might expect (this
> machine is fairly old):
> 
[ .. ]
> [    3.242623] ata2.00: FORCE: horkage modified (noncq)
> [    3.242683] ata2.00: supports DRM functions and may not be fully accessible
> [    3.242686] ata2.00: ATA-11: Samsung SSD 860 EVO 500GB, RVT01B6Q,
> max UDMA/133
> [    3.242689] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (not used)
> [    3.245518] ata2.00: supports DRM functions and may not be fully accessible
> [    3.247611] ata2.00: configured for UDMA/133

'slower' is an understatement.
That adapter can't do NCQ, hence 'WRITE FPDMA QUEUED' (which _is_ an NCQ 
command) will never be issued.
So I'd be _very_ surprised if you still see this problem there ...

Do you?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
