Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC7C54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAIXVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjAIXVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:21:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD438BC
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:20:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9so11278363pll.9
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqYz45EARRjzJJEjYZ8dZsErTB4Lvn4JUpbGv66HBJE=;
        b=zAnDMQ3ZtF/6xafhir3nA5wE/K5QPmkVBBVoIfJumu/4+eSrm2ZdBxHyLTemgNIWei
         f0NRhwp5IBmagvnzyzrwzuHVysecaYt/wr8bJIWAa36CjwhD3plUO8Sj9GRswNKaE43l
         m+xqcG9EDafPJHRyKW/Zfviop1D+O/NPRutbyQGJvCOfT2P/+SNIppux6LrMFcDTW7SC
         7jUqt2XovBYg2qvnmt5CMSbdDBJBv0MRk3h/0WlPqBqsmsHsrh63NUnwCrOV5SawqNiF
         s2UVaT7eG7rIJWlVhsodBa2xjWQCIIp81XF1oSQVpS3WV7sFNW0ECA7MpyeDroZKF3zs
         P2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqYz45EARRjzJJEjYZ8dZsErTB4Lvn4JUpbGv66HBJE=;
        b=Rrv1V1qWmTQ08rQjzif+rvRBAnJUMpMW/+aD/dPBVH0u9BSC4SyL0NkvwbE2sFLUNM
         BVkRU9KJE+TomrrZ8Z1dm23Or8OYzQoMfzb3QGNI1C7J/dRSi+X1BHB+XwmNndquaIp5
         oMk0K6XGwhKR9s5QPD+h02pyWYDoK2G49ZV/FSUzjLzG4zWPwsI4W/CEkCXWMIIxao5o
         yS/5sQCStXib55cLs11A9SJhiHMzdG9ifxKYxyHU6iTBnzWIxfoOyBt22t/kmZ8AmpEm
         5wd1aBsfncjH7jD5SXS5ffpcPyLXeFJVqlPkyP/SShHZ9wAcU03oOJyo6CvmvJYePL4k
         8r6Q==
X-Gm-Message-State: AFqh2krC0Pf98tdSzJdgL2ouYYM7oyjXTCzVaqRyzaIiIqah69YlX84r
        u6Fijqmhmxkas1sTaUI/Z6DL+g==
X-Google-Smtp-Source: AMrXdXs02P6x2QYEmQ2WoEwvvvZYgv9+eFIFEbHWOPNZtGBYVK7UghnUVqvsxEWKvSacO+NOJPY2fg==
X-Received: by 2002:a17:903:32c6:b0:189:df3c:1ba1 with SMTP id i6-20020a17090332c600b00189df3c1ba1mr91632445plr.38.1673306458631;
        Mon, 09 Jan 2023 15:20:58 -0800 (PST)
Received: from smtpclient.apple ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00191292875desm6598989plf.279.2023.01.09.15.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:20:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
Date:   Mon, 9 Jan 2023 15:20:46 -0800
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: 7bit
Message-Id: <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
> 
>>> My point here that we could summarize:
>>> (1) what features already implemented and supported,
>>> (2) what features are under implementation and what is progress,
>>> (3) what features need to be implemented yet.
>>> 
>>> Have we implemented everything already? :)
>> 
>> Standards are full of features that are not useful in a general purpose
>> system. So we likely never will implement everything. We never did for
>> SCSI and ATA and never will either.
> Indeed, and that's a very important point. Some people read specs and
> find things that aren't in the Linux driver (any spec, not a specific
> one), and think they need to be added. No. We only add them if they make
> sense, both in terms of use cases, but also as long as they can get
> implemented cleanly. Parts of basically any spec is garbage and don't
> necessarily fit within the given subsystem either.
> 
> The above would make me worried about patches coming from anyone with
> that mindset.
> 

OK. We already have discussion about garbage in spec. :)
So, what would we like finally implement and what never makes sense to do?
Should we identify really important stuff for implementation?

Thanks,
Slava.



