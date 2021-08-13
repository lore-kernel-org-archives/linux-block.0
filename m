Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB4C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A06460EB2
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhHMQ3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhHMQ3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 12:29:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2BC061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 09:29:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w14so16025652pjh.5
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=981c++31h9aesWwD/srk9/ifGKIkjjhoKMVzdVL8juA=;
        b=Vh2kT26FwlSB5AxFvO27FqqhSuXplfamhh+pHFmahiv5ilRi/NWOBHXFR65u2vECYj
         DCgEhseFX3QT+r212b5BFZWi/4yLDQVNS0zAmE5nPP/1GR1HI9w6DiRXtMh9U36E+3mz
         3B473m5GvLd+WY6bPhQiDyhVawu73tG2UzWHNlzPOX71LFWqmmGGu+GMuk/89EO6jgpX
         lr1lEugnfE0NXa2YeuzTXKF4gELBmwQBBdzZ0g/Gud5f66YRbUDfxx/syhjoRS8r5XpC
         q9nxaOGcihVUTkYr7gzaPqrZI0DWLuh+cqOBDvYR2Rq1RlxLi3TnhqDzAaAaF0DhYypB
         56tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=981c++31h9aesWwD/srk9/ifGKIkjjhoKMVzdVL8juA=;
        b=A2KpVoxmckQ0dSLBATAxb16OLbW8Qyel14ekXs7aXp+9bppP5kijNkWNgU8iLOL6wj
         I4VMe2BYlKhf4RhYXkyHqJQk3qTbbBhdewFQBI+EdPpdqA3TOKtF4AZT6P7IZYCXXEvi
         6DD0WwuucdxWHISBmQaDJVHK2A1/N5ripuml7YjJC1maiL9vaaarmNLDgaiJJTgPawg/
         YcoHjd37sAmJoGwjNVGUbXW4gJ1yX24LaYuyi1UJAuwFt3i7YCfUT1V0mm9zyoqGKHzh
         g60AQ2vjMrzzWCTFI/McI/7yRgV+29Vrm5LdCCQhc9kK1EZfOTQkLZZT6tfb88jAaTX5
         TnzA==
X-Gm-Message-State: AOAM533UDO0TLye4id5UBysWEDUJ1dfXovUE/gMnQs7wxUhorvp7nJAK
        ujS4HCV29BwjXSoqMIFSszY=
X-Google-Smtp-Source: ABdhPJzRCXEnPCUGG0FCtoIaT/0bAzGbPdNUyszNn7flDSG8PRHvr6S8+SljJ+0zLcWazAN4X2srfg==
X-Received: by 2002:a17:902:e74c:b0:12d:93b2:25f2 with SMTP id p12-20020a170902e74c00b0012d93b225f2mr2761884plf.8.1628872163508;
        Fri, 13 Aug 2021 09:29:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e44d])
        by smtp.gmail.com with ESMTPSA id c26sm3269732pgl.10.2021.08.13.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:29:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Aug 2021 06:29:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRad3tQaZfR8v7lb@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
 <YRV1JkkxozEb4YO6@mtj.duckdns.org>
 <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Damien.

On Fri, Aug 13, 2021 at 02:18:04AM +0000, Damien Le Moal wrote:
> Command duration limits (CDL) and Sequestered commands features are being
> drafted in SPC/SBC and ACS to give the device better hints than just a on/off
> high priority bit. I am currently prototyping these features and I am reusing
> the ioprio interface for that. Here is how this works:

And I think ioprio would be the right interface for it, combined with
some mechanism which can limit which class can take up how many of the
available command slots. Without that, it'd be really easy for anyone
to saturate the command queues and expressing priorities inside the
device won't do much.

> CDL can completely replace the existing binary on/off NCQ priority in a more
> flexible manner as the user can set different duration limits for high vs low
> priority. E.g. high priority is equivalent to a very short limit while low
> priority is equivalent to longer or no limits.

The problem with complex optional hardware features is often the
accompanying variability in terms of availability, reliability and
behavior. The track record has been pretty sad. That isn't to say this
won't be useful for anybody but it'd need careful coordination in
terms of picking hardware vendor and model and ensuring vendor
support, which kinda severely limits the usefulness.

Thanks.

-- 
tejun
