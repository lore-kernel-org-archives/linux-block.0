Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F2C7EE2A
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjEWJ0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjEWJ0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:26:37 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 02:26:34 PDT
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC36E6
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:26:34 -0700 (PDT)
Message-ID: <fa09601f-178c-a320-63b7-655855e02002@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684833655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjnvJEfJ5MpD8BhuRT59HXiy/DlUPDNzKoe0K5z+3Lc=;
        b=h9+xD0K8VjLVC4asziukFnWAWo51m+pWoAga7IA2vd0gAX1gbBRe8WAOKZXbD7W/aqlbCr
        CKm+5ruEIHSDIPX90vvjsmYkd0xHYMlWPe1mTWPO4NCY54l2A4Bqa4AM9xnhwC1/fVzT+z
        ZVHSg064SjSqP+Qxb5FVVhDs4AYtKwo=
Date:   Tue, 23 May 2023 17:20:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] block/rnbd: change device's name
Content-Language: en-US
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
 <20230523075331.32250-11-guoqing.jiang@linux.dev>
 <CAMGffEnUrM+FndkGL5GznbmGjkf=uMm7LHBq0qdaWL68zeV1Cw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAMGffEnUrM+FndkGL5GznbmGjkf=uMm7LHBq0qdaWL68zeV1Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/23/23 17:18, Jinpu Wang wrote:
> On Tue, May 23, 2023 at 9:53 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Both rnbd-srv and rnbd-clt set it with 'clt', which is not
>> clear, let's change them to 'clt' and 'srv' accordingly.
> The "ctl" means "control" here, it contains some writable knobs..
>
> And this change will break user space tools, so NAK for this one,
> others looks good, will reply separately.
>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> NAK, please drop it.

Sure, thanks for explanation!

Guoqing
