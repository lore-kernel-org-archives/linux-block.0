Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF75C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E8D2146F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HPQAw1kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDER7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:59:42 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54051 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDER7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 13:59:42 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so10835380itf.3
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XDfJotbVMoiW5ope76ksKwkqSMr67TpKxT+aX1WjESw=;
        b=HPQAw1knA7FTaW7tFZNg7Visr0mVxGy+a/YM2Lta9ut9xYSAdAEk4y1QBYe1ywlB6c
         3nMGhSHjGLRyUR9rTiGG69/n6QkC5bIM6FNgifvmgvNeeR8SmHpe98lDKwGRRgbyR3Ah
         jV/SeAvwA05jdeKdHFIoSgM+sqwju1mQ4/X6JXfOqFxPiEUKhvh8l3Ld40yWozkPofM7
         MN9jVWzjM6brHHlzeGeJY3pl4cpXrAAdw1PVQY/dfWrMv/ia1RNKosATEYQs9WXOH7ef
         9otVLizOZ9glWtfLIrrrO85+Pex/oC5aVO+MkA40d+cOBlURFvWapbdL1WcUbQAdTrJL
         lePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDfJotbVMoiW5ope76ksKwkqSMr67TpKxT+aX1WjESw=;
        b=R4nsd+cMwe0bm+A+VF+779cj3isPeTIuSoo+FgMDos1hnbrNBIGEex1tW+goorDisr
         xNiQUf0GTpWx6zj8utOCdkAmmIJyXfPu4yke3YvBHy98towl468kt14AN+OazGmoni7x
         hb6L17zrn4K0Oo6pAAJcWsBFlj2NzmJxUYR3RZzDIV1mEGgFyvIout0dyx92FcFAbq08
         bkHMPeqoeUW75I61oUURJzMuMq735NTTaZiWCvqLvkCUaoUu6xsUBw2laSbMErrjwKim
         lT+YsLtbilIMjd5/gxHZERGjEURKqbgPdRR56h/Kp61KfSYxOKkIFSu8PrrFCG4lit1T
         BWNQ==
X-Gm-Message-State: APjAAAVQ7zSNZLxiSAfYoVUL4QkPHx2MZG2aMwaJAE++g6FvjW5LGGa7
        yZYLGWZQNt4c2nCcF42GBQcEXQ==
X-Google-Smtp-Source: APXvYqw+icLdC7W6Gv/TCUBYCFaxSHMoBehkuM5omDrEad3PxF/yMUjvQ1/fqudmipRgY3seEAOhPA==
X-Received: by 2002:a02:8c59:: with SMTP id j25mr10666919jal.4.1554487181571;
        Fri, 05 Apr 2019 10:59:41 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l8sm1455959itl.26.2019.04.05.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 10:59:39 -0700 (PDT)
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
References: <20190404170843.83517-1-bvanassche@acm.org>
 <20190405060612.GA32144@lst.de>
 <fd4c63a9-6eaa-f104-6f33-0dfcd2dc6eba@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58149bc4-1ece-dd50-4bfb-4e55306bf870@kernel.dk>
Date:   Fri, 5 Apr 2019 11:59:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fd4c63a9-6eaa-f104-6f33-0dfcd2dc6eba@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 8:00 AM, Bart Van Assche wrote:
> On 4/4/19 11:06 PM, Christoph Hellwig wrote:
>> On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
>>> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests that
>>> have been queued. If that happens when blk_mq_try_issue_directly() is called
>>> by the dm-mpath driver then dm-mpath will try to resubmit a request that is
>>> already queued and a kernel crash follows. Since it is nontrivial to fix
>>> blk_mq_request_issue_directly(), revert the blk_mq_request_issue_directly()
>>> changes that went into kernel v5.0.
>>
>> And what are we going to do about 5.1+?
> 
> Hi Christoph,
> 
> This patch was developed and tested on my setup against Jens' for-next 
> branch. So this patch should apply fine on kernel v5.1-rc3.

I'm inclined to apply the bundled up version. It applies with a bit of
help and merges cleanly between the 5.1 and 5.2 branches.

-- 
Jens Axboe

