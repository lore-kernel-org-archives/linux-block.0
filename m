Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbcJENMU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Oct 2016 09:12:20 -0400
Date: Wed, 5 Oct 2016 09:12:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161005131218.GB17339@redhat.com>
References: <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Oct 05, 2016 at 02:37:00PM +0200, Paolo Valente wrote:

[..]
> Anyway, to avoid going on with trying speculations and arguments, let
> me retry with a practical proposal.  BFQ is out there, free.  Let's
> just test, measure and check whether we have already a solution to
> the problems you/we are still trying to solve in Linux.

Hi Paolo,

Does BFQ implementaiton scale for fast storage devices using blk-mq
interface. We will want to make sure that locking and other overhead of
BFQ is very minimal so that overall throughput does not suffer.

Vivek

