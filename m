Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 20:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiC2UJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiC2UJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 16:09:02 -0400
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 13:07:18 PDT
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A842013FF;
        Tue, 29 Mar 2022 13:07:17 -0700 (PDT)
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4KSgRg1YJXzRhSp;
        Tue, 29 Mar 2022 22:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
        t=1648584063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJC4NSVW4gwhBSN+CvduaIYW64z7cizjcVpdotN7+JE=;
        b=THIpnCV+y28ayxUrv+11JJqMnliscPyGxRKyzgpbPVCDBb/utAkyPtxlIo+OUMQzvd4UCn
        C6phrnBP9ytO23TwrdT/COf13trWKEKpBiMCwO4u4qqNPpM1Gv18eyfH6JwvHObcq/KaCL
        TMQx14d9qrn6TqjSCGphbxD7BxRqYZyUlmZmgk8CDL0h71q/inRKzlutsPTs8K3HmPO1XU
        ot902kmJthbbRWXJH4qio2HV831Zpd4480ew/1yhsLP8Bk/kbPluZub6/SxNsI+6zimLX2
        grL/qqLI1bq7cOU8ujGmwZvwUgJCI2cvW85L7FVSdrFX9Jiba8D1QK7DaN35ww==
MIME-Version: 1.0
Date:   Tue, 29 Mar 2022 22:01:15 +0200
From:   Wolfgang Walter <linux@stwm.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
In-Reply-To: <20220329073254.GA20691@lst.de>
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
Message-ID: <ff5bc3eb8fa27845cefa2f96e5241972@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studentenwerk_M=C3=BCnchen?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 2022-03-29 09:32, schrieb Christoph Hellwig:
> On Tue, Mar 29, 2022 at 09:22:26AM +0200, Philipp Reisner wrote:
>> Hi Christoph,
>> 
>> what do you expect for the DRBD changes? Usually, they fall into the
>> category: yes, obviously. When you are changing the block layer in 
>> this
>> way, then that is necessary for the in-tree DRBD code.
>> 
>> Regarding users: Yes, there are users of the in-tree DRBD code. Very 
>> big
>> corporations. And, yes, we see pressure building up that we get our 
>> act
>> together and re-sync the in-tree DRBD with the out-of tree DRBD.
> 
> The complete lack of bug reports and maintainer interaction usually
> suggests low to no use and heavy bitrot.  If that is not the case
> here that's fine, just asking..
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> https://lists.linbit.com/mailman/listinfo/drbd-dev

We use the in-tree DRBD with LTS (actually 5.15.32 and 5.4.188) and 
depend on it. It just works. We never had any issues in the last 5 
years.

Regards
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
