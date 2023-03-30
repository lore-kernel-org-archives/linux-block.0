Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D360C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjC3TCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjC3TCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:02:39 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 12:02:37 PDT
Received: from p3plwbeout21-03.prod.phx3.secureserver.net (p3plsmtp21-03-2.prod.phx3.secureserver.net [68.178.252.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7975BBA
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:02:37 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id hxV0pdL5vgeUxhxV1pYfLy; Thu, 30 Mar 2023 11:59:51 -0700
X-CMAE-Analysis: v=2.4 cv=XftMcK15 c=1 sm=1 tr=0 ts=6425dc27
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10
 a=fXDZResCRXV_fHafLlgA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  hxV0pdL5vgeUx
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp06.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1phxV0-0001hu-Vo; Thu, 30 Mar 2023 19:59:51 +0100
Message-ID: <4753802a-685f-ab56-fed2-22d6eb4cfccd@squashfs.org.uk>
Date:   Thu, 30 Mar 2023 19:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
 <ZCXNDQ6Eslhj+9g5@moria.home.lan>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <ZCXNDQ6Eslhj+9g5@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfOs7Iu6xfpM/pFGmkLS8h2Cj8WBORvfygUBgJoFg9ZqyhrEutyhJUo3OsKGPwi9vdz8Yadu0mV84YfpZEpivZ1qwkhcq48I/d+zSYjvwOZWUxfXdtNHD
 opO29Myveu/KARyJuwdFpUVnBNMBWUI3ckxluZ2DxpYHhIAGwpDBwyFM6ovc9iKOI8S3YhsmyWxpfacuYff23pAqwsDGv45QVyPMMdqQzskFK4Yq7bkzWfRK
 u4M1ymZSdktn2dfZy12akA==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/03/2023 18:55, Kent Overstreet wrote:
> On Wed, Mar 29, 2023 at 05:50:27PM +0100, Phillip Lougher wrote:
>> There is a problem with the above code, on testing I get the following
>> results:
>>
>> Index 78018785329, offset 49, bvec.bv_len 1024: In same bio, metadata length
>> 32780
> 
> Could you share how you're doing your testing? I set up a basic test
> (created images using every compression type, tested reading them) and
> so far I'm not able to reproduce this.

I use a very large Squashfs file that triggers the edge case.

That is too big to post, and so I'll see if I can artifically generate
a small Squashfs filesystem that triggers the edge case.

Phillip


