Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C6BC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 23:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8FA2082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 23:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="HIeaeNcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBDXHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:07:01 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33356 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBDXHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 18:07:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 4E67FAACEB;
        Tue,  5 Feb 2019 00:06:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549321617; i=@fjfi.cvut.cz;
        bh=HRtgANYo8iO2hMhqsrIuP2dsjh0HZ43C5arsPs/8LHc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=HIeaeNcj/aaQFVjzjbIIt2QjpK6U5Akp8Fa0ZCtWE85WEDogth1AMdMzVonI/fxtn
         IM4T8TU5vAjzeUxy/muOiuGc09sEe2YwMdT1EVgu6VUBRgKnISBkkkx8lAY2F23bkl
         04gCh1LH/nZ6Rq6cN+vC0HQZzdsGEfv3n2WYcsZY=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id o02uqQrWiKsx; Tue,  5 Feb 2019 00:06:54 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 6F845AAF06;
        Tue,  5 Feb 2019 00:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 6F845AAF06
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 4351D6004E; Tue,  5 Feb 2019 00:06:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 2F0526004D;
        Tue,  5 Feb 2019 00:06:54 +0100 (CET)
Date:   Tue, 5 Feb 2019 00:06:54 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
In-Reply-To: <20190204150415.GO31132@infradead.org>
Message-ID: <alpine.LRH.2.21.1902042344420.10661@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190204150415.GO31132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

> On Fri, Feb 01, 2019 at 09:50:07PM +0100, David Kozub wrote:
>> This patch series extends SED OPAL support: it adds IOCTL for setting the shadow
>> MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
>> IOCTL for writing to the shadow MBR. Also included are some minor fixes and
>> improvements.
>
> Actually most of it is really useful cleanups and small fixes for the
> existing OPAL code.  Any chance you could resend just those bits as
> a first series ASAP?  I'll try to spend some time to to review the
> actual feature additions in the meantime.

OK, I'll try to separate these into two sets.

This will unfortunately trigger some changes (conflict resolving - e.g. if 
I move the last two patches in the current series forward, in front of the 
patches with new functionality). What is the proper procedure w.r.t. 
Reviewed-by tags which were already given? Common sense would make me keep 
them for trivial changes and remove them if the patch should be 
re-reviewed. Is that correct?

>> There is a fork of sed-opal-temp that can use these new IOCTLs.[2] I tested
>> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.
>
> Which brings up another question:  how do we get a properly maintained
> version of the sed-opal tool up ASAP?  It's been a bit bitrotting
> unfortunately, and the documentation and error handling hasn't been all
> that great to start with.  Are we going to find a good home for it?
> Util-linux for example?

FWIW I also hacked together a tool to cover my usecase: 
https://gitlab.com/zub2/opalctl

The selling point is that it can handle passwords the same way that 
sedutil (https://github.com/Drive-Trust-Alliance/sedutil) does.

Best regards,
David
