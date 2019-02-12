Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A8C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1872186A
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBLIIm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:08:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:43550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfBLIIm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 03:08:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04042B116;
        Tue, 12 Feb 2019 08:08:40 +0000 (UTC)
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online
 read-only
To:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
References: <20190208233831.31377-1-martin.petersen@oracle.com>
 <20190212080319.GA10547@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6121a378-d92f-3acb-8932-433c777205c3@suse.de>
Date:   Tue, 12 Feb 2019 09:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190212080319.GA10547@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 9:03 AM, Christoph Hellwig wrote:
> On Fri, Feb 08, 2019 at 06:38:31PM -0500, Martin K. Petersen wrote:
>> Some devices come online in write protected state and switch to
>> read-write once they are ready to process I/O requests.
> 
> That is really weird.  What kind of devices are these?
> 
No, not really.
Some arrays (HP IIRC) use a similar mechanism for volume copy or snapshots.

>> Note that per-partition ro settings are lost on revalidate. This has
>> been broken for at least a decade and it will require major surgery to
>> fix. To my knowledge nobody has complained about being unable to make
>> partition read-only settings stick through a revalidate. So hopefully
>> this patch will suffice as a simple fix for stable.
> 
> Should we warn when we lost these settings on a revalidate?
> 
> I have to say I don't like the tristate too much - it seems to allow
> setting a hardware write protected device writable again by user
> interfaction, right?
> 
> Should we just have a hardware and a user policy field that are separate
> instead?
> 
Problem is how the mechanism should work.
Thing is, once a device goes read-only we pretty much stop accessing it 
(as it will send any filesystem down onto the recovery path).
And once we stop sending I/O to it we'll lose the ability to figure out 
that the device switched back to R/W mode.

(Always assuming that we'll be getting a sense code in the first place).

But overall I have to agree with Christoph.
Read-only devices and the handling of which is pretty much 
array-specific, so I doubt we can generalize much here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
