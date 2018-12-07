Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B7C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC972083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FzjKD22B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC972083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGDEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:04:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44691 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGDEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:04:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1040383pgr.11
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIBtSXDwVk1xLX/RFhr2CIyjYzNmIvpmGnmjQAvFlC8=;
        b=FzjKD22Bu6XZ2fIXGJCMxghCTc9qCo5OYlAfLzYeJi9H0CN9e2npUpiwrYhelIc2IJ
         jj53PBMSo+dr03Mxwa59wv/lZUkIy1Ng0bZUmlSklC3O1VwsDSWcjWn4m0+xgR6P/JnS
         GHw9bOMzMdK6gpq41Qrm/GCG0fpwuInPcWAyLtIX8aAVwADIQEj1sfEb8FR8/6HqTdSn
         1iBaTDSmzpuveCP35CMtMduN5RWQRw52Qqlvu1//PbcE6kEwYYRWPtYx8aha0qcwwC/g
         HfeqEUN5lbfc60ap4zOwXQZ/vK2zD9hgcNLqlHXHv4EjCc2zbY3h8GFJypGzyXQyALYx
         yczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIBtSXDwVk1xLX/RFhr2CIyjYzNmIvpmGnmjQAvFlC8=;
        b=g5Nod5nfofobP5ifXg3Eg/XCQ7zB4EALeIunTSO58TaK3v/g8Evn6/qrZkTzDG9yE3
         rE6v6v1++fpEV7vaOLf4WOExQpHA+nEp3RxefgsmT025Nv9E6GGjkYFfzc2c9vgFOGtv
         UV7t+Su4OCLGfE1yXLVJN0IE0PSV7YWshZi7+eW4seevUjggMYZiuj3stK2nCpQuPNrC
         XhjM/bFuTUas9s+TXcMmAqFasoNHBV4DFGmuZpXiVWmDNBtE/wZWiJTV2adv30PXoU40
         4TADoJkhQeNx3yOuhWGXPHjT2qI+e4NxbXJbPY/pB++tB9xCgBLen8j2DmcIfbxPeL/o
         eMMQ==
X-Gm-Message-State: AA+aEWbFEEUX/JUNKUMDzrUKKBgieqt7Oy7VrznVjlwbQfumCIlH3yaV
        6WNUxHn/j5IxBqi1lIqY87mPT3tYW/0=
X-Google-Smtp-Source: AFSGD/U7l/XhAMRswj6gKdLLduLTu8NTBiMs9zXTDFsky3AX5XA6ULmJeRhVZuIXZEjz6czLt0p5aA==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr496621pgm.126.1544151881980;
        Thu, 06 Dec 2018 19:04:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h128sm1864070pgc.15.2018.12.06.19.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:04:40 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
 <20181205022716.GE17845@ming.t460p>
 <227a40a3-6599-9fc0-ab58-674f063e9c3a@kernel.dk>
 <20181205025801.GF17845@ming.t460p> <20181205030300.GG17845@ming.t460p>
 <20181207024642.GA13460@thunk.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53b0a7dd-58dc-2be8-c085-754d02ec1414@kernel.dk>
Date:   Thu, 6 Dec 2018 20:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207024642.GA13460@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 7:46 PM, Theodore Y. Ts'o wrote:
> On Wed, Dec 05, 2018 at 11:03:01AM +0800, Ming Lei wrote:
>>
>> But at that time, there isn't io scheduler for MQ, so in theory the
>> issue should be there since v4.11, especially 945ffb60c11d ("mq-deadline:
>> add blk-mq adaptation of the deadline IO scheduler").
> 
> Hi Ming,
> 
> How were serious you about this issue being there (theoretically) an
> issue since 4.11?  Can you talk about how it might get triggered, and
> how we can test for it?  The reason why I ask is because we're trying
> to track down a mysterious file system corruption problem on a 4.14.x
> stable kernel.  The symptoms are *very* eerily similar to kernel
> bugzilla #201685.
> 
> The problem is that the problem is super-rare --- roughly once a week
> out of a popuation of about 2500 systems.  The workload is NFS
> serving.  Unfortunately, the problem is since 4.14.63, we can no
> longer disable blk-mq for the virtio-scsi driver, thanks to the commit
> b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic irq
> vector affinity") getting backported into 4.14.63 as commit
> 70b522f163bbb32.
> 
> We're considering reverting this patch in our 4.14 LTS kernel, and
> seeing whether it makes the problem go away.  Is there any thing else
> you might suggest?

We should just make SCSI do the right thing, which is to unprep if
it sees BUSY and prep next time again. Otherwise I fear the direct
dispatch isn't going to be super useful, if a failed direct dispatch
prevents future merging.

This would be a lot less error prone as well for other cases.

-- 
Jens Axboe

