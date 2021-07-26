Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52DC4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EA260527
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhGZKkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:40:52 -0400
Received: from p-impout002aa.msg.pkvw.co.charter.net ([47.43.26.133]:41212
        "EHLO p-impout002.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233143AbhGZKkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 06:40:52 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 06:40:52 EDT
Received: from [172.16.10.100] ([68.205.28.126])
        by cmsmtp with ESMTP
        id 7yc2mK3ZpyiH37yc3mVBs4; Mon, 26 Jul 2021 11:17:35 +0000
X-Authority-Analysis: v=2.4 cv=LNGj/La9 c=1 sm=1 tr=0 ts=60fe99cf
 a=gmNTOe8/cTguWXMaQW2Lwg==:117 a=gmNTOe8/cTguWXMaQW2Lwg==:17
 a=IkcTkHD0fZMA:10 a=DJYEtOCsc2xbjrOxKMoA:9 a=QEXdDO2ut3YA:10
Reply-To: dmarkh@cfl.rr.com
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     Denis Efremov <efremov@linux.com>, markh@compro.net,
        linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
From:   Mark Hounschell <dmarkh@cfl.rr.com>
Message-ID: <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
Date:   Mon, 26 Jul 2021 07:17:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFqcPdPd/Q4azIZ5BD/K4NarJcsQuVL13QWNkFVcE+38LPl+jWnIITNnEKjbXLBwKiY3xep/dzgmc1v7bXNBwFIHKKS0SU++rujeulg+g8pDw/OnUGcN
 jybrJlD6IDCNxIbHgZhlZ7qpLPXVazMoT7F8YWLtPDdW7cvxrouuOPcjuaBod6IRj2wdWPHXU4L1SZwxQOSKekHkfTQXcgKaRATTAFk3aW/BRikPnAUC9ysM
 RE2QKXTmtlg19UJzG3ApoS9VxtuN5HXVy2LKV5468Y07Ka408SPHLYA13j1S2tRYbUKzXjNdlSIkIUuxzI98+3vLf742DDJL6cEE/L9lTTq/pf0B+0MrFtLV
 7dAwP+wM
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 3:57 AM, Denis Efremov wrote:
> Hi,
> 
> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>
>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
> 
> Thank you for the report, I'm looking into this.
> 
>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
> 
> If it's a project with open sources could you please give a link?
> 
> Regards,
> Denis
> 
This is immaterial but fdutils and libdsk both use rely on this flag. Who 
can know who else does. The point is it should NOT have been changed.

Mark
