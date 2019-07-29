Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C7C433FF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D820679
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfG2UYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:24:06 -0400
Received: from len.romanrm.net ([91.121.75.85]:43038 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbfG2UYG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:24:06 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 16:24:05 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 3D8BE202D3;
        Mon, 29 Jul 2019 20:18:50 +0000 (UTC)
Date:   Tue, 30 Jul 2019 01:18:50 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
Message-ID: <20190730011850.2f19e140@natsu>
In-Reply-To: <20190729193359.11040-1-gpiccoli@canonical.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 29 Jul 2019 16:33:59 -0300
"Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> Currently md/raid0 is not provided with any mechanism to validate if
> an array member got removed or failed. The driver keeps sending BIOs
> regardless of the state of array members. This leads to the following
> situation: if a raid0 array member is removed and the array is mounted,
> some user writing to this array won't realize that errors are happening
> unless they check kernel log or perform one fsync per written file.
> 
> In other words, no -EIO is returned and writes (except direct ones) appear
> normal. Meaning the user might think the wrote data is correctly stored in
> the array, but instead garbage was written given that raid0 does stripping
> (and so, it requires all its members to be working in order to not corrupt
> data).

If that's correct, then this seems to be a critical weak point in cases when
we have a RAID0 as a member device in RAID1/5/6/10 arrays.

-- 
With respect,
Roman
