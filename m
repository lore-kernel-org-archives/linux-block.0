Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92727C433FF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A09020693
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfG2Ug6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:36:58 -0400
Received: from len.romanrm.net ([91.121.75.85]:44078 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfG2Ug6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:36:58 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 04387202D3;
        Mon, 29 Jul 2019 20:36:55 +0000 (UTC)
Date:   Tue, 30 Jul 2019 01:36:55 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
Message-ID: <20190730013655.229020ea@natsu>
In-Reply-To: <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
        <20190730011850.2f19e140@natsu>
        <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 29 Jul 2019 17:27:15 -0300
"Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> Hi Roman, I don't think this is usual setup. I understand that there are
> RAID10 (also known as RAID 0+1) in which we can have like 4 devices, and
> they pair in 2 sets of two disks using stripping, then these sets are
> paired using mirroring. This is handled by raid10 driver however, so it
> won't suffer for this issue.
> 
> I don't think it's common or even makes sense to back a raid1 with 2
> pure raid0 devices.

It might be not a usual setup, but it is a nice possibility that you get with
MD. If for the moment you don't have drives of the needed size, but have
smaller drives. E.g.:

- had a 2x1TB RAID1;
- one disk fails;
- no 1TB disks at hand;
- but lots of 500GB disks;
- let's make a 2x500GB RAID0 and have that stand in for the missing 1TB
member for the time being;

Or here's for a detailed rationale of a more permanent scenario:
https://louwrentius.com/building-a-raid-6-array-of-mixed-drives.html

-- 
With respect,
Roman
