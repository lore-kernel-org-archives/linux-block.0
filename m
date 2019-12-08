Return-Path: <SRS0=3zrn=Z6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F38FC3F68F
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2406F20706
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 07:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfLHHr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Dec 2019 02:47:28 -0500
Received: from mx.sdf.org ([205.166.94.20]:58762 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfLHHr1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Dec 2019 02:47:27 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 02:47:27 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id xB87gPvL016505
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sun, 8 Dec 2019 07:42:25 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id xB87gNOS011043;
        Sun, 8 Dec 2019 07:42:23 GMT
Date:   Sun, 8 Dec 2019 07:42:23 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201912080742.xB87gNOS011043@sdf.org>
To:     chenxiang66@hisilicon.com, ming.lei@redhat.com
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
Cc:     axboe@kernel.dk, john.garry@huawei.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linuxarm@huawei.com, lkml@sdf.org,
        tglx@linutronix.de
In-Reply-To: <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>,
    <20191119014204.GA391@ming.t460p>,
    <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Nov 2019 at 11:05:55 +0800, chenxiang (M)" <chenxiang66@hisilicon.com> wrote:
> Sorry, I can't access the link you provide, but I can provide those
> irqs' affinity in the attachment.  I also write a small testcase,
> and find id is 1, 2, 3, 0 after calling sort().
> 
> struct ex_s {
>     int id;
>     int cpus;
> };
> struct ex_s ex_total[4] = {
>     {0, 8},
>     {1, 8},
>     {2, 8},
>     {3, 8}
> };
> 
> static int cmp_func(const void *l, const void *r)
> {
>     const struct ex_s *ln = l;
>     const struct ex_s *rn = r;
> 
>     return ln->cpus - rn->cpus;
> }

Your cmp_func is the problem.  sort() in the Linux kernel, like
qsort() in the C library, has never been stable, meaning that if
cmp_func() returns 0, there is no guarantee what order *l and *r
will end up in.  Minor changes to the implementation can change the
result.  You're sorting on the cpus field, which is all 8, so your
cmp_func is saying "I don't care what order the results appear in".

(A web search on "stable sort" will produce decades of discussion
on the subject, but basically an unstable sort has numerous
implementation advantages, and problems can usually be solved by
adjusting the comparison function.)

If you want to sort by ->id if ->cpus is the same, then change the
cmp_func to say so:

static int cmp_func(const void *l, const void *r)
{
    const struct ex_s *ln = l;
    const struct ex_s *rn = r;

    if (ln->cpus != rn->cpus)
	return ln->cpus - rn->cpus;
    else
	return ln->id - rn->id;
}
(This simple subtract-based compare depends on the fact that "cpus"
and "id" are both guaranteed to fit into 31 bits.  If there's any chance
The true difference could exceed INT_MAX, you need to get a bit fancier.)
