Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8627FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 08:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B302166E
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 08:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Cj/5mRQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgFRI1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgFRI1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 04:27:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D521C0613ED
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:27:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g21so262935wmg.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zE4oI/xjk4gPn+qKQVZsXwzGGdGfMEP73737Hdz+jyM=;
        b=Cj/5mRQVF5EPtKV73CeRrVMQAnPUOaupFkki1CVBBIZx0MCP5TxMZOABRWfLgMiKx5
         OrvSylExR0QnjfxyulmGMFOmZ50JLI7Y2dhI7mEAANxOhD7OYltwyqPY8MyoLq6Jtoi/
         XPyfWDiJPghNpSFfnB51GYw3ZxKlDGIn+dl2geBSCCc9twmRhl8k3NBf98cnG+Cr7/ZN
         H00YxlfJyrRH0AD89VWqfIUpmpoZI//X+cpY448HsuY0jNb4cKG3cse5gkt9h5kq7ZOK
         kFhfUa3vrzFsZ2JAbG2FYifin3cYU8Xvd4Y/BITy+rGZ+qgN3RwEz0LTovGyW1s9VniT
         0NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zE4oI/xjk4gPn+qKQVZsXwzGGdGfMEP73737Hdz+jyM=;
        b=DUCapdsoYigm8dE2lzndSDn9NtwxE1KW0NRMRSS/lz6s7RGI6c9cqDk4BuiTUx4cFO
         FxyGk8LiB8+IUGR7Ibi5K1o52tux36MlZ9ASF4o2EdvDiz8FIGItzbhGe7pflejJlyBt
         9T9rsJRiOQJvyhJ6ltIGozC+O8wQOIfIKjpQEgTfxoXVVjb7C3fBQl6vk/gd/HXNdQ0N
         3SXmvlVKKor7uFQmuzKQl8xVR/FLzpMIj+skuQ9N1V7hZ8p2mct/JN2TAYGd0R0AvATa
         MvHh6rRx1/K7K24UbQLTis43dhfIpw0ZV/A/2Rmqto9j31LgjbVuPOqlqY86bOBr601G
         +5Kg==
X-Gm-Message-State: AOAM530piYoqxX9MNEYQn9zfCWEr26bAHkIgx7+DslJzkEPjmid36ieQ
        9cPDy9MZmCNFYFVt8Sn86Oqjy1IATh2Vju1W
X-Google-Smtp-Source: ABdhPJzkiRDfED3V6pOmykpfjJbJipeCADa+NhvfgJkz15HsHexnwxQbYOhGefGNDFZWUU3aNLZWVw==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr1176878wmm.50.1592468862890;
        Thu, 18 Jun 2020 01:27:42 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id c6sm2627442wma.15.2020.06.18.01.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:27:42 -0700 (PDT)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Thu, 18 Jun 2020 10:27:40 +0200
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
Message-ID: <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.06.2020 10:04, Matias Bjørling wrote:
>On 17/06/2020 19.23, Kanchan Joshi wrote:
>>This patchset enables issuing zone-append using aio and io-uring direct-io interface.
>>
>>For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application uses start LBA
>>of the zone to issue append. On completion 'res2' field is used to return
>>zone-relative offset.
>>
>>For io-uring, this introduces three opcodes: IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>>Since io_uring does not have aio-like res2, cqe->flags are repurposed to return zone-relative offset
>
>Please provide a pointers to applications that are updated and ready 
>to take advantage of zone append.

Good point. We are posting a RFC with fio support for append. We wanted
to start the conversation here before.

We can post a fork for improve the reviews in V2.

>
>I do not believe it's beneficial at this point to change the libaio 
>API, applications that would want to use this API, should anyway 
>switch to use io_uring.

I can see why you say this, but isn't it too restrictive to directly
drop libaio support? We can split the patches and merge uring first- no
proble,.

>
>Please also note that applications and libraries that want to take 
>advantage of zone append, can already use the zonefs file-system, as 
>it will use the zone append command when applicable.

Sure. There are different paths available already, which is great. We
have use cases for uring and would like to enable them too.

Thanks,
Javier
